library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RAM_control is
	Port ( hcnt,vcnt   : in unsigned(9 downto 0);
         -- blank       : in std_logic; -- same pipeline stage as hcnt,vcnt. // Not used with this solution
         up_lo_byte  : out std_logic; -- '0' <=> read lo byte.
         -- RAM signals
         addr                    : out unsigned(17 downto 0);
         sram_ce,sram_oe,sram_we : out std_logic;
         sram_lb,sram_ub         : out std_logic);
end RAM_control;

architecture rtl of RAM_control is
	signal pixel_index : unsigned(18 downto 0); -- intermediate result
begin
	pixel_index <= SHIFT_LEFT(resize(vcnt, 19), 9) + SHIFT_LEFT(resize(vcnt, 19), 7) + hcnt; -- vcnt*(512+128) + hcnt
	up_lo_byte 	<= pixel_index(0);
	addr 			<= pixel_index(18 downto 1);
	sram_ce 		<= '0';	-- (x) Chip Enable
	sram_oe 		<= '0';	-- (x) Output Enable (read)
	sram_we 		<= '1';	-- ( ) Write Enable
	sram_lb 		<= '0';	-- (x) Lower Byte
	sram_ub 		<= '0';	-- (x) Upper Byte
end rtl;
