library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Channel_Mod is
	port( clk, rstn 	: in std_logic;					-- System Clock and Reset on low
			men, sel		: in std_logic;					-- Master Enable and Selected (for SoundBus)
			SCCnt			: in unsigned(1 downto 0);		-- Sub Cycle Counter
			BitCnt		: in unsigned(4 downto 0);		-- Bit Counter
			adcdat		: in std_logic;					-- Serial bit port to Channel_Mod from ADC
			dacdat		: out std_logic;					-- Serial bit port from Channel_Mod to DAC
			ADC			: out signed(15 downto 0);		-- Sample value to Application via SoundBus
			DAC 			: in signed(15 downto 0));		-- Processed value from Application via SoundBus
end entity;

architecture rtl of Channel_Mod is
	signal RXReg, TXReg : signed(15 downto 0);
begin

	rx : process(clk, rstn)
	begin
		if rstn = '0' then
			RXReg <= (others => '0');
		elsif rising_edge(clk) then
			if sel = '0' AND men = '1' AND SCCnt = 1 AND BitCnt < 16 then	-- "Not selected for SoundBus, rising_edge(mclk) soon, SCCnt = "01", BitCnt is less than 16 (0 - 31)."
				RXReg <= RXReg(14 downto 0) & adcdat;									-- adcdat is shifted in serially into RXReg, MSB first. Note that this stops halfway into the 
			end if;																				-- sel = '0'-cycle since the compare with BitCnt signal is there to make sure we don't write over
		end if;																					-- our initial 16 bits in our 16-bit register (only the first 16 bits from adcdat is information).
	end process;

	tx : process(clk, rstn)
	begin
		if rstn = '0' then
			TXReg <= (others => '0');
		elsif rising_edge(clk) then
			if sel = '0' AND men = '1' AND SCCnt = 3 then 	-- "Not selected for SoundBus, rising_edge(mclk) soon, SCCnt = "11"."
				TXReg <= TXReg(14 downto 0) & '0';					-- TXReg shifts out its bits, MSB first - TXReg(15) is applied as dacdat outside of process (the bits shifted in are junkbits).
			elsif sel = '1' then										-- Selected for SoundBus 
				TXReg <= DAC;												-- load the value from DAC.
			end if;
		end if;
	end process;

	ADC <= RXReg;				-- RXReg is constantly available to the application over the SoundBus via Channel_Mod's output ADC.
	dacdat <= TXReg(15);		-- Channel_Mod's dacdat output is directly connected to the MSB in the TXReg register.
	
end rtl;