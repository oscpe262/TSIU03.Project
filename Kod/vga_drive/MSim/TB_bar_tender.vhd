library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

library work;

entity TB_bar_tender is
end entity;

architecture sim of TB_bar_tender is 
	signal          balance_input : signed(3 downto 0);-- -5 to 5
	signal		volume_input: unsigned(3 downto 0); -- 0 to 0
	signal		L_bar : unsigned(7 downto 0); -- 0 to 171
	signal		R_bar : unsigned(7 downto 0); --:--
	signal		L_new_bar : unsigned(7 downto 0); --:--
	signal		R_new_bar : unsigned(7 downto 0); --:--
	signal		hcnt : unsigned(9 downto 0);
	signal		vcnt : unsigned(9 downto 0);
	signal		mute : std_logic;
	signal		vsync : std_logic;
	signal		render_bars : std_logic;
	signal		render_peak : std_logic;
		
begin
  CUT: work.bar_tender port map(
  balance_input => balance_input,
  volume_input  => volume_input,
  L_bar 		=> L_bar, 
  R_bar			=> R_bar,  
  L_new_bar		=> L_new_bar,
  R_new_bar		=> R_new_bar,
  hcnt			=> hcnt, 
  vcnt			=> vcnt,
  mute			=> mute,
  vsync			=> vsync, 
  render_bars	=> render_bars,
  render_peak	=> render_peak); 
  
 balance_input <= 5;
 volume_input <= 10;
 L_bar <= 171;
 R_bar <= 171;
 L_new_bar <= 171;
 R_new_bar <= 171;
 mute <= 1;
 
 
 process
	for(i in asdasd loop)
		if(hcnt < 641) then
			hcnt <= hcnt + 1;
		else then
			hcnt <= '0';
		end if;
		
		if(vcnt < 481)
			vcnt <= vcnt + 1;	
		else then
			vcnt <= '0';
	end if;
end process;
	

end architecture; 
