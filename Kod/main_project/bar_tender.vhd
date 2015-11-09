-- Author: Erik Peyronson
-- Date: 2015-10-21
-- Description: Bar_tender is a submodule setting
-- render_bars high when bars need to be rendered.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bar_tender is
	port   (balance_input	: in signed(5 downto 0);   -- -8 to 8
			volume_input	: in unsigned(3 downto 0); -- 0 to 0
			L_bar			: in unsigned(7 downto 0); -- 0 to 171
			R_bar			: in unsigned(7 downto 0); --:--
			L_new_bar		: in unsigned(7 downto 0); --:--
			R_new_bar		: in unsigned(7 downto 0); --:--
			hcnt			: in unsigned(9 downto 0);
			vcnt			: in unsigned(9 downto 0);
			mute			: in std_logic;
			clk    	: in std_logic;
			-- vsync			: out std_logic;
			render_bars		: out std_logic;
			render_peak		: out std_logic;
			reset        : in  std_logic);
end bar_tender;

architecture rtl of bar_tender is
-- Constants that declare positions of bars on the screen
-- Start defines x,y position of the upper left corner
-- of the bar. end defines x,y coordinates for lower right
-- corner

-- upper left corner coordinates for left bar
constant l_bar_x 		: unsigned(7 downto 0) :=  to_unsigned(88,8);
constant l_bar_y		: unsigned(7 downto 0) := to_unsigned(80,8); -- 40 = bar width

-- upper left corner coordinates for left bar
constant r_bar_x		: unsigned(8 downto 0) := to_unsigned(182,9);
constant r_bar_y		: unsigned(7 downto 0) := to_unsigned(80,8); -- 40 = bar width

--Bar width
constant bar_width	: unsigned(7 downto 0) := to_unsigned(50,8);


--coordinates for the volume bar
constant vol_bar_x	: unsigned(8 downto 0) := to_unsigned(213,9);
constant vol_bar_y	: unsigned(8 downto 0) := to_unsigned(317,9);

-- volume and balance bar width
constant vol_height	: unsigned(5 downto 0) := to_unsigned(20, 6);
constant vol_width	: unsigned(7 downto 0) := to_unsigned(220,8);
constant vol_width_half : unsigned(7 downto 0) := to_unsigned(110,8);
constant box_width_bal	: unsigned(8 downto 0) := to_unsigned(13,9);
constant box_width_vol : unsigned(7 downto 0) := to_unsigned(22,8);


--coordinates for the mute indicator
constant mute_x		: unsigned(8 downto 0) := to_unsigned(30,9);
constant mute_y		: unsigned(8 downto 0) := to_unsigned(280,9);
constant mute_width	: unsigned(7 downto 0) := to_unsigned(85,8);
constant mute_height	: unsigned(7 downto 0) := to_unsigned(84,8);

--Peak level indicator s

--offset allows the same constants to be used for both
--before and after bars and the same constants for both
--volume and balance bars.
constant offset_x				: unsigned(9 downto 0) := to_unsigned(320,10); 		-- Offset x moves position for after bars
constant offset_y 			: unsigned(8 downto 0) := to_unsigned(85,9); 		-- Offset y moves position for balance bar 
constant peak_timer			: unsigned(21 downto 0) := to_unsigned(5000000,22); 	-- Constant that defines how many clock cycles needed for peak_max to drop one pixel
--constant freeze_timer		: unsigned(21 downto 0) := to_unsigned(6500000,22):
constant peak_thickness		: unsigned(6 downto 0) := to_unsigned(1,7);		-- Thickness of the peak level indicator bar 

--Signals
-- Internal signals for registers
signal render_barsi : 	std_logic := '0';
signal render_peaki :	std_logic := '0';

-- Signals needed for peak level indicator
signal counter	:			unsigned(21 downto 0) := (others => '0');
signal freeze_counter :	unsigned(21 downto 0) := (others => '0');

signal max_peak_r :		unsigned(7 downto 0) := (others => '0');
signal max_peak_l :		unsigned(7 downto 0) := (others => '0');

signal new_max_r	:		unsigned(7 downto 0) := (others => '0');
signal new_max_l  :		unsigned(7 downto 0) := (others => '0');

--signal current_peak_r :	unsigned(7 downto 0) := (others => '0');
--signal current_peak_l : unsigned(7 downto 0) := (others => '0');
--
--signal current_new_r  :	unsigned(7 downto 0) := (others => '0');
--signal current_new_l  :	unsigned(7 downto 0) := (others => '0');



signal bal_offset : unsigned(8 downto 0) := (others => '0'); 


begin

--Assigns the current signal level to current_peak
--	current_peak_r <= R_bar;		
--	current_peak_l <= L_bar;
--	current_new_r  <= R_new_bar;
--	current_new_l	<= L_new_bar;
	bal_offset <= resize(unsigned(balance_input + 8),9); --0-16

process(clk) -- Process that counts down peak max and updates max_peak if needed
begin
	if(rising_edge(clk)) then
		if(max_peak_r <= R_bar and R_bar < 171) then -- 
			max_peak_r <= R_bar;
			counter <= (others => '0');
		end if;
		
		if(max_peak_l <= L_bar and L_bar < 171) then -- same for bar 2
			max_peak_l <= L_bar;
			counter <= (others => '0');
		end if;
		
		if(new_max_r <= R_new_bar and R_new_bar < 171) then -- bar 3
			new_max_r <= R_new_bar;
			counter <= (others => '0');
		end if;
		
		if(new_max_l <= L_new_bar and L_new_bar < 171) then -- bar 4
			new_max_l <= L_new_bar;
			counter <= (others => '0');
		end if;
		
		if(counter = peak_timer) then -- decrement max_peak if timer is reached
			if max_peak_r > 1 then
				max_peak_r <= max_peak_r - 1;
			end if;
			
			if max_peak_l > 1 then
				max_peak_l <= max_peak_l - 1;
			end if;
			
			if new_max_r > 1 then
				new_max_r  <= new_max_r  - 1;
			end if;
			
			if new_max_l > 1 then
				new_max_l  <= new_max_l  - 1;	
			end if;
			--end if;
			counter <= (others => '0');
		else									--increment timer
			counter <= counter + 1; 
		end if;
	end if;
end process;

	process(clk) -- Register that checks if vcnt and hcnt is within a bar and sets render bars accordingly
	begin
		if(rising_edge(clk)) then
		  render_barsi <= '0';
		  render_peaki <= '0';
			-- Left bar
			if( (hcnt >= l_bar_x) and (hcnt < (l_bar_x + bar_width)) ) then 		-- Left bar x boundries
				if(vcnt >= l_bar_y and vcnt <= l_bar_y + 171 - L_bar) then -- Left bar y boundries
					
					if(vcnt >= l_bar_y + 171 - max_peak_l - peak_thickness and vcnt <= l_bar_y + 171 - max_peak_l) then -- Peak_level inbetween peak_max and (peak_max - peak_thickness)
						render_peaki <= '1';	
			   	else								-- Just bar						
						render_barsi <= '1';	
					end if;
			   end if;
			 end if;
			 
			-- Left new bar	
			if(hcnt >= l_bar_x + offset_x and hcnt < l_bar_x + offset_x + bar_width) then 	-- left new bar x boundries
				if(vcnt >= l_bar_y and vcnt <= l_bar_y + 171 - L_new_bar) then 							-- left new bar y boundries
	
					if(vcnt >= l_bar_y + 171 - new_max_l - peak_thickness and vcnt <= l_bar_y + 171 - new_max_l) then -- Peak_level inbetween peak_max and (peak_max - peak_thickness)
						render_peaki <= '1';	
					else								-- Just bar						
						render_barsi <= '1';	
					end if;
				end if;
			end if;
			
			-- Right bar
			if(hcnt >= r_bar_x and hcnt < r_bar_x + bar_width) then 		-- Right new bar x boundries
				if(vcnt >= r_bar_y and vcnt <= r_bar_y + 171 - R_bar) then		-- Right new bar y boundries				
					if(vcnt >= r_bar_y + 171 - max_peak_r - peak_thickness and vcnt <= r_bar_y + 171 - max_peak_r) then -- Peak_level inbetween peak_max and (peak_max - peak_thickness)
						render_peaki <= '1';	
					else								-- Just bar						
						render_barsi <= '1';	
					end if;
				end if;
			end if;
			
			-- Right new bar
			if(hcnt >= r_bar_x + offset_x and hcnt < r_bar_x + offset_x + bar_width) then 		-- Left new bar x boundries
				if(vcnt >= r_bar_y and vcnt <= r_bar_y + 171 - R_new_bar) then 								-- Left new bar y boundries
			
					if(vcnt >= r_bar_y + 171 - new_max_r - peak_thickness and vcnt <= l_bar_y + 171 - new_max_r) then -- Peak_level inbetween peak_max and (peak_max - peak_thickness)
						render_peaki <= '1';	
					else								-- Just bar						
						render_barsi <= '1';	
					end if;
				end if;		
			end if;	
				
			-- If statements for mute signal
			if(hcnt >= mute_x and hcnt <= mute_x + mute_width and vcnt >= mute_y and vcnt <= mute_y + mute_height and mute = '0') then -- x y boundries
				render_barsi <= '1';
			end if;
			
				-- If statements for volume 															
			if(hcnt >= vol_bar_x + vol_width - box_width_vol*volume_input and hcnt < vol_bar_x + vol_width) then -- x boundries
			  if(vcnt >= vol_bar_y and vcnt < vol_bar_y + vol_height) then -- y boundries
					render_barsi <= '1';
				end if;
			end if;
			
			-- If statements for balance
			  --if(hcnt >= vol_bar_x  and hcnt < vol_bar_x + 105 - bal_offset*box_width) then 
			if(bal_offset < 9) then --bal_offset <= resize(unsigned(balance_input + 8),8); --0-16 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
				if((hcnt >= vol_bar_x and hcnt < vol_bar_x + 104 -((8-bal_offset)*box_width_bal)) or ((hcnt>vol_bar_x + 114)and(hcnt<433))) then
					if(vcnt >= vol_bar_y + offset_y and vcnt < vol_bar_y + vol_height + offset_y) then
			        render_barsi <= '1';
					end if;
				end if;
				
			else -- if bal_offset < 8
				if((hcnt >= vol_bar_x + vol_width_half + 6 + box_width_bal*(bal_offset-8) and hcnt < 433) or (hcnt >= vol_bar_x and hcnt < vol_bar_x + 104)) then 
					if(vcnt >= vol_bar_y + offset_y and vcnt < vol_bar_y + vol_height + offset_y) then
						render_barsi <= '1';
					end if;
				end if;
			end if;	
		end if;
	end process;
	
	render_bars <= render_barsi;
	render_peak <= render_peaki;

end architecture;

	