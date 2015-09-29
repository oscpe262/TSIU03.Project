library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Ctrl is
	port( clk, rstn		: in std_logic;					-- System Clock and Reset on low
			mclk, bclk 		: out std_logic; 					-- Master Clock and Bit Clock
			adclrc, daclrc : out std_logic;					-- ADC/DAC Left/Right Channel Control
			men, lrsel		: out std_logic; 					-- Master Enable and Left/Right Select (for SoundBus)
			SCCnt 			: out unsigned(1 downto 0);	-- Sub Cycle Counter
			BitCnt			: out unsigned(4 downto 0));	-- Bit Counter
end entity;

architecture rtl of Ctrl is
	signal counter			: unsigned(9 downto 0);
begin

	process(clk, rstn)
	begin
		if rstn = '0' then
			counter <= (others => '0');
		elsif rising_edge(clk) then
			counter <= counter + 1;
		end if;
	end process;
	
	mclk 		<= NOT counter(1);
	bclk 		<= counter(3);
	adclrc	<= NOT counter(9);
	daclrc	<= NOT counter(9);
	men 		<= counter(0) AND counter(1);
	lrsel		<= counter(9);
	SCCnt 	<= counter(3 downto 2);
	BitCnt 	<= counter(8 downto 4);
	
end rtl;