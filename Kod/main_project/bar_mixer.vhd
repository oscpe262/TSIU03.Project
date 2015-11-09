-- Author: Erik Peyronson
-- Date: 2015-10-21
-- Description: Bar_mixer multiplexes the input from
-- vga_gen (render_bars = 0) and bar_tender (render_bars = 1) and provides colour information
-- to the vga-screen

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bar_mixer is
	port( vga_r :  		in unsigned(9 downto 0); -- colour information from vga_gen
			vga_g :  		in unsigned(9 downto 0);
			vga_b : 			in unsigned(9 downto 0);
			render_bars :	in std_logic;
			render_peak :	in std_logic;
			vga_r_new :		out unsigned(9 downto 0); -- colour information to be sent to adv-chip.
			vga_g_new :		out unsigned(9 downto 0);
			vga_b_new :		out unsigned(9 downto 0));
end entity;



architecture rtl of bar_mixer is

begin
process(render_bars, render_peak)
begin
	if(render_bars = '1') then
		vga_r_new <= (others => '0');
		vga_b_new <= (others => '0');
		vga_g_new <= (others => '0');	
	elsif (render_peak = '1') then
		vga_r_new <= (others => '1');
		vga_g_new <= (others => '1');
		vga_b_new <= (others => '1');
	else
		vga_r_new <= vga_r;
		vga_g_new <= vga_g;
		vga_b_new <= vga_b;
	end if;
end process;


--vga_r_new <= vga_r when render_bars = '0' else
--				(others => '1') when render_peak = '1'	
--					else (others => '0');
--					
--vga_g_new <= vga_g when render_bars = '0'
--				else (others => '0');
--				
--vga_b_new <= vga_b when render_bars = '0' else
--				(others => '1') when render_peak = '1'	
--				else (others => '0');


end architecture;