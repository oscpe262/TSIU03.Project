-- Author:        Matteus Laurent
-- Last update: 	 22 October 2015
-- Description:   Test Bench for the Vol_Bal module.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;

entity TB_Vol_Bal is
end entity;

architecture sim of TB_Vol_Bal is
    -- DUT signals:
    signal mute               : std_logic;            -- read this
    signal volume_level       : unsigned(3 downto 0); -- read this
    signal balance_level      : signed(5 downto 0);   -- read this
    signal LDAC_in, RDAC_in   : signed(15 downto 0);  -- read this
    signal clk, rstn          : std_logic := '1';     -- Initiations to avoid 'U'-state.
    signal lrsel              : std_logic := '1';
    signal kb_input           : std_logic_vector(4 downto 0);
    signal LADC_out, RADC_out : signed(15 downto 0);
    
    signal clk_counter        : unsigned(15 downto 0);
    
    -- signals for clock generation:
    signal done : boolean := false;
    
    -- declaration of DUT component:
    component Vol_Bal is
      port(clk, rstn    : in  std_logic;
		      lrsel         : in  std_logic;
		      kb_input      : in  std_logic_vector(4 downto 0);
		      LADC, RADC    : in  signed(15 downto 0);
		      mute          : out std_logic;
		      volume_level  : out unsigned(3 downto 0);
		      balance_level : out signed(5 downto 0); 		
        		LDAC, RDAC    : out signed(15 downto 0));
		end component;
		
begin
    -- ### Clock and lrsel generator ###
    clk <= not clk after 10 ns when not done;
    rstn <= '0', '1' after 50 ns;
    done <= false, true after 1 ms;
    lrsel <= clk_counter(9);
    
    process(clk,rstn)
    begin
        if rstn = '0' then
		        clk_counter <= (others => '0');
		    elsif rising_edge(clk) then
            clk_counter <= clk_counter + 1;
		    end if;
    end process;
    
    -- ### Simulation of samples from Keyboard module ###
    --    In 50k cycles, mute will turn on and off once respectively ;
    --    volume level will hit its roof (10), meaning lowest output ;
    --    balance level will hit its floor (-5), meaning full left bias ;
    process(clk_counter, rstn)
    begin
        if rstn = '0' then
            kb_input <= (others => '0');
        elsif rising_edge(clk_counter(14)) then
            kb_input <= "10000";
        elsif rising_edge(clk_counter(10)) then
            kb_input <= "01000";
        elsif rising_edge(clk_counter(9)) then
            kb_input <= "00100";
        else
            kb_input <= (others => '0');
        end if;
    end process;
    
    -- ### Generation of stimuli samples ###
    --    Simple square wave. Flip between min and max values (10..0 and 01..1)
    --    after every lrsel cycle.
    process(lrsel, rstn)
    begin
        if rstn = '0' then
            LADC_out <= (15 => '1', others => '0');
            RADC_out <= (15 => '1', others => '0');
        elsif falling_edge(lrsel) then
            for i in 0 to 15 loop
                LADC_out(i) <= NOT LADC_out(i);
                RADC_out(i) <= NOT RADC_out(i);
            end loop;
        end if;
    end process;

    -- ### Verification of Vol_Bal outputs ###

    -- process


    -- begin
        -- wait for 1 us; -- wait for stabalisation
        -- while not done loop
           -- if rising_edge(clk_counter(8))
           
        -- end loop;
    -- end process;


    -- mute
    -- volume_level
    -- balance_level
    -- LDAC_in
    -- RDAC_in

    -- ### DUT instantiation ###
    DUT : Vol_Bal port map(clk => clk,
                          rstn => rstn,
                          lrsel => lrsel,
		                      kb_input => kb_input,
		                      LADC => LADC_out,
		                      RADC => RADC_out,
    		                    mute => mute,
		                      volume_level => volume_level,
                  		      balance_level => balance_level,
          		              LDAC => LDAC_in,
        		                RDAC => RDAC_in);
end architecture;