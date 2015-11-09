library ieee;
use ieee.std_logic_1164.all;
library work;

entity Keyboard_TB is
end entity;

architecture sim of Keyboard_TB is
  signal rstn, PS2_CLK, PS2_DAT : std_logic;
  signal clk : std_logic := '0';
  signal kb_input : std_logic_vector (4 downto 0);
  
  component Keyboard is
    port(rstn,clk,PS2_CLK,PS2_DAT : in std_logic;
      kb_input : out std_logic_vector (4 downto 0));
    end component;
  
begin
    clk <= NOT clk AFTER 20 ns;
    rstn <= '0', '1' AFTER 100 ns;
    
    process
                                                                              --      + 0123 4567 p - + 0123 4567 p -
      constant keydw : std_logic_vector(1 to 22) := "0000011111000100111010"; --down  0 0000 1111 1 0 0 0100 1110 1 0
      constant keyup : std_logic_vector(1 to 22) := "0000011111001010111000"; --down  0 0000 1111 1 0 0 1010 1110 0 0
      constant keyone : std_logic_vector(1 to 32) := "11111111110000011111000110100000"; --down 0 0000 1111 1 0 0 0110 1000 0 0
      constant keydw2 : std_logic_vector(1 to 32) := "11111111110000011111000100111010"; 
      
    
    begin 
      PS2_CLK <= '1';
      PS2_DAT <= '1';
      
      WAIT FOR 200 ns;
      -- emulate downkey released
      for i in 1 to 22 loop
        WAIT FOR 100 us;
        PS2_DAT <= keydw(i);
        PS2_CLK <= '0' after 10 us, '1' after 35 us;
      end loop;
      
      --assert kb_input = "00100" report
      --"kb_down failed" severity error;
      
      WAIT FOR 200 ns;
      -- emulate upkey released
      for i in 1 to 22 loop
        WAIT FOR 100 us;
        PS2_DAT <= keyup(i);
        PS2_CLK <= '0' after 10 us, '1' after 35 us;
      end loop;      

      --assert kb_input = "00001" report
      --"kb_up failed" severity error;

      WAIT FOR 200 ns;
      -- emulate upkey released
      for i in 1 to 32 loop
        WAIT FOR 100 us;
        PS2_DAT <= keyone(i);
        PS2_CLK <= '0' after 10 us, '1' after 35 us;
      end loop;      

      assert kb_input = "00000" report
      "kb_one failed" severity error;

      WAIT FOR 200 ns;
      -- emulate offset and downkey released
      for i in 1 to 32 loop
        WAIT FOR 100 us;
        PS2_DAT <= keydw2(i);
        PS2_CLK <= '0' after 10 us, '1' after 35 us;
      end loop;      

      assert kb_input = "00100" report
      "kb_offset failed" severity error;
      wait;


    end process;
    
    DUT : Keyboard
    port map (rstn => rstn, clk => clk, PS2_CLK => PS2_CLK, PS2_DAT => PS2_DAT,
              kb_input => kb_input);
end architecture;             