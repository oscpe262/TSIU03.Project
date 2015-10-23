-- Author: Erik Peyronson
-- Date: 2015-10-21
-- Description: Bar_tender is a submodule setting
-- render_bars high when bars need to be rendered.

library ieee;
use ieee.std_logic_1164.all;

entity bar_tender is
	port (balance_input	: in signed(3 downto 0);   -- -5 to 5
			volume_input	: in unsigned(3 downto 0); -- 0 to 0
			L_bar				: in unsigned(7 downto 0); -- 0 to 171
			R_bar				: in unsigned(7 downto 0); --:--
			L_new_bar		: in unsigned(7 downto 0); --:--
			R_new_bar		: in unsigned(7 downto 0); --:--
			hcnt				: in unsigned(9 downto 0);
			vcnt				: in unsigned(9 downto 0);
			mute				: in std_logic;
			vsync				: out std_logic;
			render_bars		: out std_logic;
			render_peak		: out std_logic);


end bar_tender;

architecture rtl of bar_tender is
-- Constants that declare positions of bars on the screen
-- Start defines x,y position of the upper left corner
-- of the bar. end defines x,y coordinates for lower right
-- corner

-- upper left corner coordinates for left bar
constant l_bar_x 		: integer := 88;
constant l_bar_y		: integer := 80; -- 40 = bar width

-- upper left corner coordinates for left bar
constant r_bar_x		: integer := 128;
constant r_bar_y		: integer := 80; -- 40 = bar width

--Bar width
constant bar_width	: integer := 50;


--coordinates for the volume bar
constant vol_bar_x	: integer := 213;
constant vol_bar_y	: integer := 317;

-- volume and balance bar width
constant vol_height	: integer := 20;
constant vol_width	: integer := 22;
constant vol_width_half : integer := 11;
constant box_width	: integer := 22;

--coordinates for the mute indicator
constant mute_x		: integer := 50;
constant mute_y		: integer := 55;
constant mute_width	: integer := 50;
constant mute_height	: integer := 55;

--Peak level indicator s

--offset allows the same constants to be used for both
--before and after bars and the same constants for both
--volume and balance bars.
constant offset_x				: integer := 30; 		-- Offset x moves position for after bars
constant offset_y 			: integer := 30; 		-- Offset y moves position for balance bar 
constant peak_timer			: integer := 1000; 	-- Constant that defines how many clock cycles needed for peak_max to drop one pixel
constant peak_thickness		: integer := 3;		-- Thickness of the peak level indicator bar 

--Signals
-- Internal signals for registers
signal render_barsi : 	std_logic;
signal render_peaki :	std_logic;

-- Signals needed for peak level indicator
signal counter	:			integer;

signal peak_max_r :		unsigned(9 downto 0);
signal peak_max_l :		unsigned(9 downto 0);

signal new_max_r	:		unsigned(9 downto 0);
signal new_max_l  :		unsigned(9 downto 0);

signal current_peak_r :	unsigned(9 downto 0);
signal current_peak_l : unsigned(9 downto 0);

signal current_new_r :	unsigned(9 downto 0);
signal current_new_l	:	unsigned(9 downto 0);


begin

--Assigns the current signal level to current_peak
	current_peak_r <= R_bar;		
	current_peak_l <= L_bar;
	current_new_r  <= R_new_bar;
	current_new_l	<= L_new_bar;
	

process(clk) -- Process that counts down peak max and updates max_peak if needed
begin	
	if(rising_edge) then
		if(max_peak_r < current_peak_r) then -- updates max_peak of current peak is bigger bar 1
			max_peak_r <= current_peak_r;
		end if;
		
		if(max_peak_l < current_peak_l) then -- same for bar 2
			max_peak_l <= current_peak_l;
		end if;
		
		if(new_max_r < current_new_r) then -- bar 3
			new_max_r <= current_new_r;
		end if;
		
		if(new_max_l < current_new_l) then -- bar 4
			new_max_l <= current_new_l;
		end if;
		
		if(counter = peak_timer) then -- decrement max_peak if timer is zero
			max_peak_r <= max_peak_r - 1;
			max_peak_l <= max_peak_l - 1;
			new_max_r  <= new_max_r  - 1;
			new_max_l  <= new_max_l  - 1;
			counter <= 0;
		else									--increment timer
			count <= counter + 1; 
		end if;
	end if;
end process;

process(clk) -- Register that checks if vcnt and hcnt is within a bar and sets render bars accordingly
begin
		if(rising_edge(clk)) then
			-- If statements for the four signal level bars
			if(hcnt > l_bar_x and hcnt < l_bar_x + bar_width) then 		-- Left bar x boundries
				if(vcnt > l_bar_y and vcnt < l_bar_y + 171 - L_bar) then -- Left bar y boundries
					
					if(vcnt < l_bar_y + 171 - peak_max_r - peak_thickness and vcnt > l_bar_y + 171 - peak_max_r) -- Peak_level inbetween peak_max and (peak_max - peak_thickness)
						render_peaki <= '1';	
					else								-- Just bar						
						render_barsi <= '1';	
					end if;
				end if;
				
			elsif(hcnt > l_bar_x + offset_x and hcnt < l_bar_x + offset_x + bar_width) then 	-- Left bar x boundries
				if(vcnt > l_bar_y and vcnt < l_bar_y + 171 - L_bar) then 							-- Left bar y boundries
	
					if(vcnt < r_bar_x + 171 - peak_max_l - peak_thickness and vcnt > l_bar_x + 171 - peak_max) -- Peak_level inbetween peak_max and peak_max - peak_thickness?
						render_peaki <= '1';	
					else								-- Just bar						
						render_barsi <= '1';	
					end if;
					
					render_barsi <= '1'; 
				end if;
			elsif(hcnt > r_bar_x and hcnt < r_bar_x + bar_width) then 		-- Right new bar x boundries
				if(vcnt > r_bar_y and vcnt < r_bar_y + 171 - R_bar) then		-- Right new bar y boundries
					render_barsi <= '1'; 
				end if;
			elsif(hcnt > r_bar_x + offset_x and hcnt < r_bar_x + offset_x + bar_width) then 		-- Left new bar x boundries
				if(vcnt > r_bar_y and vcnt < r_bar_y + 171 - R_bar) then 								-- Left new bar y boundries
					render_barsi <= '1'; 
				end if;
			-- If statements for mute signal
			elsif(hcnt > mute_x and hcnt < mute_x + mute_width and vcount > mute_y and vcount < mute_y + mute_height and mute = 0) then -- x y boundries
				render_barsi <= '1';
			-- If statements for volume
			elsif(vcnt > vol_bar_y and vcnt < vol_bar_y + vol_height) then 															-- y boundries
				if(hcnt > vol_bar_x + vold_bar_width - box_width*volume_input and hcnt < vol_bar_x + vol_bar_width) then -- x boundries
					render_barsi <= '1';
				end if;
			-- If statements for balance
			elsif(vcnt > vol_bar_y + offset_y and vcnt < vol_bal_y + vol_height) then 																					-- y boundries
				if( hcnt < vol_bar_x + vol_width_half + bal_input*box_width and hcnt < vol_bar_x + vol_bar_width - (5-volume_input)*box_width) then -- x boundries
					render_barsi <= 1;
				end if;
			-- Peak level indicator
			--elsif()
				
			
			else
				render_barsi <= '0';
			end if;	
			
		end if;	
end process;
render_bars <= render_barsi;

end architecture;

	