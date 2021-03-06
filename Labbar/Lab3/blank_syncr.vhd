library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity blank_syncr is
	Port ( clk : in std_logic;
			rstn : in std_logic;
         blank1 : in std_logic;
         blank2 : out std_logic);
end blank_syncr;

architecture rtl of blank_syncr is
begin
	process(clk, rstn)
	begin
		if(rstn = '0') then
			blank2 <= '0';
		elsif rising_edge(clk) then
			blank2 <= blank1;
		end if;
	end process;
end rtl;
