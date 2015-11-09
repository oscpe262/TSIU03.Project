library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity Channel_Mod is
	port(	clk, rstn, sel, men 	: in std_logic;
			SCCnt 					: in unsigned(1 downto 0);
			BitCnt					: in unsigned(4 downto 0);
			DAC						: in signed(15 downto 0);
			adcdat 					: in std_logic;
			ADC 						: out signed(15 downto 0);
			dacdat					: out std_logic );
end entity;



architecture Channel_Mod_Arch of Channel_Mod is
	signal RXReg, TXReg : signed(15 downto 0);
begin

	rx:process(clk) begin
			if rising_edge(clk) then
				if sel = '0' and SCCnt = "01" and men =  '1' and BitCnt < 16 then
					RXReg <= RXReg(14 downto 0) & adcdat;
				end if;
			end if;
	end process;
	ADC <= RXReg;

	tx:process(clk) begin
			if rising_edge(clk) then
				if sel = '0' and SCCnt = "11" and men = '1' then
					TXReg <= TXReg(14 downto 0) & '0'; 
				elsif sel = '1'  then 
					TXReg <= DAC;
				end if;
			end if;
	end process;
	dacdat <= TXReg(15);

end architecture;