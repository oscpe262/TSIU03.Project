library ieee;
use ieee.std_logic_1164.all;
library work;

entity Lab2_KB_TB is
end entity;

architecture sim of Lab2_KB_TB is
  signal rstn, PS2_CLK, PS2_DAT : std_logic;
  signal clk : std_logic := '0';
  signal HEX0, HEX6, HEX7 : std_logic_vector (6 downto 0);
  
  signal LEDR : std_logic_vector (7 downto 0);
  
  component Lab2_KB is
    port(rstn,clk,PS2_CLK,PS2_DAT : in std_logic;
      HEX0,HEX6,HEX7 : out std_logic_vector (6 downto 0);
      LEDR : out std_logic_vector (7 downto 0));
  end component;
  
begin
    clk <= NOT clk AFTER 20 ns;
    rstn <= '0', '1' AFTER 100 ns;
    
    process
    
      constant keyn : std_logic_vector(1 to 11) := "01010010001";
    
    begin 
      PS2_CLK <= '1';
      PS2_DAT <= '1';
      
      WAIT FOR 200 ns;
      -- forloop bits
      for i in 1 to 11 loop
        PS2_DAT <= keyn(i);
        PS2_CLK <= '0' after 10 us, '1' after 35 us;
        WAIT FOR 100 us;
      end loop;
      
      assert HEX0 = "0011001" report
      "HEX0 failed" severity error;
      wait;
    end process;
    
    DUT : Lab2_KB
    port map (rstn => rstn, clk => clk, PS2_CLK => PS2_CLK, PS2_DAT => PS2_DAT,
              HEX0 => HEX0, HEX6 => HEX6, HEX7 => HEX7, LEDR => LEDR);
end architecture;             