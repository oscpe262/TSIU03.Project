-- Author: 			Matteus Laurent
-- Last update: 	21 October 2015
-- Description:	Volume_Adjustment submodule (of module Vol_Bal) in the Grupp41 system.
--						Adjusts volume according to the volume_level input, decreasing amplitude
--						by up to -30 dB in 3 dB decrements.
--						
--						Volume level:
--						0 1 . . . . . . . . 10
--					(no adj)				  (-30 dB)
--
--
--	Code structure:
--						1. Outputs
--						2. Process for the lrsel_change signal (the 'go'-signal for the state machine)
--						3. State machine: Sequencing
--						4. State machine: State progression & outputs
--						5. Updating of out-registers


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Volume_Adjustment is
	port(clk, rstn					: in 	std_logic;
			lrsel						: in	std_logic;
			volume_level			: in 	unsigned(3 downto 0);
			LADC, RADC				: in 	signed(15 downto 0);
			volume_done				: out std_logic;
			Adj_LADC, Adj_RADC	: out signed(15 downto 0));
end entity;

architecture rtl of Volume_Adjustment is
	type stateFSM is (state_idle, state_odd, state_evens, state_end);
	signal state, next_state			: stateFSM := state_idle;
	
	signal lrsel_old, lrsel_change 	: std_logic := '0';
	signal update_enable					: std_logic := '0';
	signal vol_counter					: unsigned(3 downto 0);
	signal ADC, L_REG, R_REG			: signed(15 downto 0);
	
begin

	-- 1 -- Outputs connected to final registers of the submodule
	Adj_LADC 	<= L_REG;
	Adj_RADC 	<= R_REG;
	volume_done <= update_enable;
	

	-- 2 -- lrsel_change
	process(clk)
	begin
		if rising_edge(clk) then
			lrsel_old <= lrsel;
			lrsel_change <= lrsel_old XOR lrsel;
		end if;	
	end process;
	
	-- 3 -- Seqeuntial part of state machine
	process(clk, rstn)
	begin
		if rstn = '0' then
			state <= state_idle;
		elsif rising_edge(clk) then
			state <= next_state;
		end if;
	end process;
	
	-- 4 -- Combinational parts of state machine
	nextstate:process(state, lrsel_change)
	begin
		case state is
			-- STATE IDLE --
			when state_idle =>
				if lrsel_change = '1' then				-- lrsel flip means that {L/R}ADC is ready
					if lrsel = '1' then
						ADC <= LADC;								-- Left channel
					else
						ADC <= RADC;								-- Right channel
					end if;
					vol_counter <= volume_level;			-- Fetch system volume level
					next_state <= state_odd;				-- Go to state_odd!
				end if;
			-- STATE ODD --
			when state_odd =>
				if vol_counter(0) = '1' then			-- Check 0th bit for odd vol_counter value
					ADC <= resize( shift_right(ADC * 3, 2), 16 );	-- Perform ADC * 0.75 ( 0.75 is an approximation for the inverse square root of 2)
				end if;
				next_state <= state_evens;				-- Always go to state_evens
			-- STATE EVENS --								-- *** OKLARHET: *** räknas state <= next_state i seqeuntial-delen som en uppdateringen av state om state == next_state?
			when state_evens =>
				if vol_counter > 1 then					-- More shifts if vol_counter is 2 or more
					ADC <= ADC(15) & ADC(15 downto 1);		-- Shift: ADC = half the value of ADC
					vol_counter <= vol_counter - 2;		-- Decrease vol_counter accordingly 
				else											-- If shifting is done
					next_state <= state_end;				-- Go to state_end
				end if;
			-- STATE END --
			when state_end =>
				next_state <= state_idle;					-- Return to state_idle after one clock cycle;
		end case;
	end process;

	outenable:process(state, lrsel_change)
	begin
		case state is
			when state_idle|state_odd|state_evens =>
				update_enable <= '0';
			when state_end =>
				update_enable <= '1';
		end case;
	end process;
	
	-- 5 -- Adjusted output updating
	process(update_enable, rstn)
	begin
		if rstn = '0' then
			L_REG <= ( others => '0' );
			R_REG <= ( others => '0' );
		elsif rising_edge(update_enable) then
			if lrsel = '1' then
				L_REG <= ADC;
			else
				R_REG <= ADC;
			end if;
		end if;
	end process;

end architecture;

			