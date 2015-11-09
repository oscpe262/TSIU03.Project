-- Author: 			Matteus Laurent
-- Last update: 	2 November 2015
-- Description:	Current_Vol_Bal submodule (of module Vol_Bal)in the Grupp41 system.
--						Reads kb_input from the Keyboard module and updates registers
--						representing system levels of volume, balance and mute.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Current_Vol_Bal is
	port(clk, rstn			: in	std_logic;
			kb_input			: in 	std_logic_vector(4 downto 0);
			mute				: out	std_logic;
			volume_level	: out unsigned(3 downto 0);
			balance_level	: out signed(5 downto 0));
end entity;

architecture rtl of Current_Vol_Bal is
	signal i_volume_lvl	: unsigned(3 downto 0);
	signal i_balance_lvl	: signed(5 downto 0);
	signal i_mute			: std_logic					:= '0';
	signal i_kb				: std_logic_vector(4 downto 0);
	
	function sl2nat(x : std_logic) return natural is
	begin
		if x='1' then
			return 1;
		else
			return 0;
		end if;
	end function;
	
begin
	-- i_kb is the same as kb_input, with illegal requests filtered away.
	-- Since we are "one hot coded", we don't have any situations where we
	-- need to account for multiple register "updates" in the same clock cycle.
	-- Legal ranges for volume and balance:
	--		Volume: 	 0	to	10
	--		Balance: -8	to 8
	i_kb 							<= kb_input(4)
										& ( kb_input(3) AND NOT ( NOT i_balance_lvl(5) AND i_balance_lvl(3)) 																	)	-- ignore ++R bias if balance == 8
										& ( kb_input(2) AND NOT ( i_volume_lvl(3) AND i_volume_lvl(1)) 																	 		)	-- ignore dec Vol if volume 	== 10
										& ( kb_input(1) AND NOT ( i_balance_lvl(5) AND NOT i_balance_lvl(2) AND NOT i_balance_lvl(1) AND NOT i_balance_lvl(0))	) 	-- ignore ++L bias if balance == -8
										& ( kb_input(0) AND ( i_volume_lvl(3) OR i_volume_lvl(2) OR i_volume_lvl(1) OR i_volume_lvl(0)) 								);	-- ignore inc Vol if volume	== 0
	process(clk, rstn)
	begin
		if (rstn = '0') then
			-- Register reset
			i_volume_lvl 	<= ( others => '0' );			
			i_balance_lvl 	<=	( others => '0' );
			i_mute 			<=	'0';
		elsif rising_edge(clk) then
			-- Update registers according to kb_input													-- ***kb_input decoding***
			i_volume_lvl		<= i_volume_lvl - sl2nat(i_kb(0)) + sl2nat(i_kb(2)); 			-- "00001" Volume increase		"00100" Volume decrease
			i_balance_lvl 		<= i_balance_lvl - sl2nat(i_kb(1)) + sl2nat(i_kb(3));			-- "00010" L bias increase		"01000" R bias increase
			i_mute				<= i_mute XOR i_kb(4);													-- "10000" Change mute status
		end if;
	end process;

	volume_level 	<= i_volume_lvl;
	balance_level	<= i_balance_lvl;
	mute				<= i_mute;
end architecture;