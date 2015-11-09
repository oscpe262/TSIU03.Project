-- Author: Philip Johansson, Niklas Blomqvist
-- Date: October 22 2015 
-- Description: Application for analysing sound.
--	Group 41.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Analysis is
	port(clk,rstn		: in std_logic; 				--System signals
			lrsel 		: in std_logic; 				--Sound signal, left/right select
			LC, RC		: in signed(15 downto 0);		--Sound signal
			vsync 		: in std_logic;					--Timing signal
			lbar 		: out unsigned(7 downto 0);		--Outgoing signal to indicate how to draw the bar
			rbar		: out unsigned(7 downto 0));	-- -..-
end entity;

architecture analarch of Analysis is
	constant K 									: integer := 12;									--K value 
	signal lrsel_old, lrsel_change 				: std_logic := '0';									--Detect new sample
	signal ildac, irdac 						: signed(15 downto 0);								--Internal signals for left/right dac
	signal lafter, rafter, temp					: unsigned(29+K downto 0); 							 
	signal counter								: unsigned(5 downto 0) := to_unsigned(29+K, 6);		
	signal vsync_old, vsync_change 				: std_logic := '0';									
	signal channel 								: std_logic := '0';									
	type state_type is (s_idle, s_2, s_3);
	signal current_s: state_type := s_idle;
	
	begin
		-- Read sound signal, every 1024 clockcycle
		ildac <= LC;	
		irdac <= RC;

		process(clk, rstn) begin
			if rstn = '0' then
				lrsel_change <= '0';
				lrsel_old <= '0';
				current_s <= s_idle;
				lafter <= (others => '0');
				rafter <= (others => '0');
				temp <= (others => '0');
			elsif rising_edge(clk) then
				lrsel_old <= lrsel;			
				lrsel_change <= lrsel_old xor lrsel;
				vsync_old <= vsync;
				vsync_change <= vsync_old xor vsync;
				
				-- Detect if change has been, and if its on right or left. correct! 
				if lrsel_change = '1' and lrsel = '1' then -- Left
					if ildac = 0 and lafter < 4096 then
						if lafter > 0 then
							lafter <= lafter - 1;
						end if;
					else
						lafter <= lafter - lafter(lafter'left downto K) + unsigned(ildac * ildac); -- 12
					end if;
				elsif lrsel_change = '1' and lrsel = '0' then -- Right
					if irdac = 0 and rafter < 4096 then
						if rafter > 0 then
							rafter <= rafter - 1;
						end if;
					else
						rafter <= rafter - rafter(rafter'left downto K) + unsigned(irdac * irdac); -- 12 
					end if;
				end if;
				
				if vsync_change = '1' and vsync = '0' then
					channel <= lrsel;
					current_s <= s_2;
				end if;
				
				if current_s = s_idle then
					counter <= to_unsigned((29 + K), 6); 
				elsif current_s = s_2 then
					if channel = '1' then
						temp <= lafter;
					elsif channel = '0' then
						temp <= rafter;
					end if;
					
					current_s <= s_3;
				elsif current_s = s_3 then
					if temp(29 + K) /= '1' then
						counter <= counter - 1;
						temp <= temp((29 + K - 1) downto 0) & "1"; 
					else
						if channel = '1' then
							lbar <= counter & temp((29 + K - 1) downto (29 + K - 2)); 
						else
							rbar <= counter & temp((29 + K - 1) downto (29 + K - 2));
						end if;
						
						current_s <= s_idle;
					end if;
				end if;
			end if;
		end process;
end architecture;