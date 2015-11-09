library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vsyncr is
    Port ( clk 	: in std_logic;
           vcnt 	: in unsigned(9 downto 0);
			  --vcntd 	: out unsigned(9 downto 0);
           rstn 	: in std_logic;
           vsync 	: out std_logic);
end vsyncr;

architecture rtl of vsyncr is
  signal vsynci : std_logic;
begin
   process(rstn, clk)
	begin
		if (rstn = '0') then
			vsynci <= '1';
			--vcntd <= ( others => '0' );
		elsif (rising_edge(clk)) then
			if (vcnt > 489) and (vcnt < 492) then
				vsynci <= '0';
			else
				vsynci <= '1';
			end if;
			--vcntd <= vcnt;
		end if; 
   end process; 
   vsync <= vsynci;
end rtl;
