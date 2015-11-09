library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RAM_control is
  Port ( clk,rstn   : in std_logic;
         hcnt,vcnt   : in unsigned(9 downto 0);
         blank       : in std_logic; -- same pipeline stage as hcnt,vcnt.
         up_lo_byte  : out std_logic; -- '0' <=> read lo byte.
         -- RAM signals
         addr                    : out unsigned(17 downto 0);
         sram_ce, sram_oe,sram_we : out std_logic;
         sram_lb,sram_ub         : out std_logic);
end RAM_control;

architecture rtl of RAM_control is
signal addri : unsigned(18 downto 0);
begin
sram_ce <='0'; 
sram_oe <='0';
sram_we <='1';
sram_lb <='0';
sram_ub <='0'; --ayylmao

  addri <= (vcnt & "000000000") + (vcnt & "0000000") + hcnt;      -- resize((vcnt*640+hcnt),19);
  addr <= addri(18 downto 1);   --resize(shift_right(addri,1),18);
  up_lo_byte <= hcnt(0); 

end rtl;
