-- Author: 			Matteus Laurent
-- Last update: 	23 October 2015
-- Description:	Balance_Adjustment submodule (of module Vol_Bal) in the Grupp41 system.
--						Adjusts according to system balance level, resulting in a linear scaling
--						of the incoming amplitude. The stronger a channel bias, the more the signal 
--						reduction of the opposing channel. The affected channel loses 1/8 of the
--						amplitude per level of bias, down to a minimum of 3/8 of the original signal.
--
--						Balance level:
--						-5 -4  .  .  .  0  .  .  .  4  5
--					(LEFT bias)						 (RIGHT bias)
--				  (adjust RIGHT)	 (no adj)	 (adjust LEFT)

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Balance_Adjustment is
	port(clk, rstn					: in 	std_logic;
			lrsel, volume_done	: in	std_logic;
			mute						: in	std_logic;
			balance_level			: in 	signed(5 downto 0);
			Adj_LADC, Adj_RADC	: in	signed(15 downto 0);
			LDAC, RDAC				: out	signed(15 downto 0));
end entity;

architecture rtl of Balance_Adjustment is

	constant balance_fraction 	: signed(4 downto 0) := "01000";			
	constant balance_shift		: natural := 3;							-- 2^balance_shift = balance_fraction

	signal balance_value			: signed(5  downto 0);
	signal L_REG, R_REG			: signed(15 downto 0);

begin

	LDAC 	<= L_REG;
	RDAC	<= R_REG;
	
	-- Process to work out balance_value. Updates every clock cycle and changes condition every lrsel cycle.
	process(clk, rstn)
	begin
		if rstn = '0' then
			balance_value <= ( others => '0' );
		elsif rising_edge(clk) then
			if lrsel = '1' AND balance_level < 0 then						-- If we have left bias and are working with left sample...
				balance_value <= ( others => '0' );								-- ... balance_value = 0.
			elsif lrsel = '0' AND balance_level > 0 then					-- Similarly, if we have right bias during right sample...
				balance_value <= ( others => '0' );								-- ... balance_value = 0.
			else																		-- Else:
				balance_value <= abs(balance_level);							-- let absolute(balance_level) represent the balance_value
			end if;
		end if;
	end process;
	
	-- Process that updates outgoing registers according to the system balance level and lrsel.
	-- The volume_done signal lets us know that the state machine in Volume_Adjustment has finished
	--	it's initial work (volume_done is set high for one clock cycle after we've reached state_end)
	-- in the current lrsel cycle and that we are ready to write.
	process(clk, rstn)
	begin
		if rstn = '0' then
			L_REG <= ( others => '0' );
			R_REG <= ( others => '0' );
		elsif rising_edge(clk) and volume_done = '1' then
			if mute = '1' then										--	mute does the same as rstn, but is synchronized with "volume_done"
				L_REG <= ( others => '0' );
				R_REG <= ( others => '0' );
			elsif lrsel = '1' then									-- Left sample? Write the result of the function to L_REG
				L_REG <= resize( shift_right((balance_fraction - balance_value) * Adj_LADC , balance_shift), 16 );
			else															-- Right sample? Write the result of the function to R_REG
				R_REG <= resize( shift_right((balance_fraction - balance_value) * Adj_RADC , balance_shift), 16 );
			end if;
		end if;
	end process;
	
end architecture;