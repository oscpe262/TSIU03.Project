library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Channel_Mod is
  port( clk, rstn 	: in std_logic;				-- System Clock and Reset on low
        men, sel	: in std_logic;				-- Master Enable and Selected (for SoundBus)
        SCCnt		: in unsigned(1 downto 0);		-- Sub Cycle Counter
        BitCnt		: in unsigned(4 downto 0);		-- Bit Counter
        adcdat		: in std_logic;				-- Serial bit port to Channel_Mod from ADC
        dacdat		: out std_logic;			-- Serial bit port from Channel_Mod to DAC
        ADC		: out signed(15 downto 0);		-- Sample value to Application via SoundBus
        DAC 		: in signed(15 downto 0));		-- Processed value from Application via SoundBus
end entity;

architecture rtl of Channel_Mod is
  signal RXReg, TXReg : signed(15 downto 0);
begin

  rx : process(clk, rstn)
  begin
    if rstn = '0' then
      RXReg <= (others => '0');
    elsif rising_edge(clk)
      
  end process;

  tx : process(clk, rstn)
  begin
  end process;

end rtl;
