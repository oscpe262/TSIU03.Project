-- Copyright (C) 1991-2012 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- PROGRAM		"Quartus II 64-Bit"
-- VERSION		"Version 12.1 Build 243 01/31/2013 Service Pack 1.33 SJ Full Version"
-- CREATED		"Tue Nov 03 14:08:14 2015"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;

LIBRARY work;

ENTITY Vol_Bal IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		rstn :  IN  STD_LOGIC;
		lrsel :  IN  STD_LOGIC;
		kb_input :  IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
		LADC :  IN  SIGNED(15 DOWNTO 0);
		RADC :  IN  SIGNED(15 DOWNTO 0);
		mute :  OUT  STD_LOGIC;
		balance_level :  OUT  SIGNED(5 DOWNTO 0);
		LDAC :  OUT  SIGNED(15 DOWNTO 0);
		RDAC :  OUT  SIGNED(15 DOWNTO 0);
		volume_level :  OUT  UNSIGNED(3 DOWNTO 0)
	);
END Vol_Bal;

ARCHITECTURE bdf_type OF Vol_Bal IS 

COMPONENT current_vol_bal
	PORT(clk : IN STD_LOGIC;
		 rstn : IN STD_LOGIC;
		 kb_input : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 mute : OUT STD_LOGIC;
		 balance_level : OUT SIGNED(5 DOWNTO 0);
		 volume_level : OUT UNSIGNED(3 DOWNTO 0)
	);
END COMPONENT;

COMPONENT volume_adjustment
	PORT(clk : IN STD_LOGIC;
		 rstn : IN STD_LOGIC;
		 lrsel : IN STD_LOGIC;
		 LADC : IN SIGNED(15 DOWNTO 0);
		 RADC : IN SIGNED(15 DOWNTO 0);
		 volume_level : IN UNSIGNED(3 DOWNTO 0);
		 volume_done : OUT STD_LOGIC;
		 Adj_LADC : OUT SIGNED(15 DOWNTO 0);
		 Adj_RADC : OUT SIGNED(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT balance_adjustment
	PORT(clk : IN STD_LOGIC;
		 rstn : IN STD_LOGIC;
		 lrsel : IN STD_LOGIC;
		 volume_done : IN STD_LOGIC;
		 mute : IN STD_LOGIC;
		 Adj_LADC : IN SIGNED(15 DOWNTO 0);
		 Adj_RADC : IN SIGNED(15 DOWNTO 0);
		 balance_level : IN SIGNED(5 DOWNTO 0);
		 LDAC : OUT SIGNED(15 DOWNTO 0);
		 RDAC : OUT SIGNED(15 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_0 :  UNSIGNED(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  SIGNED(15 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_4 :  SIGNED(15 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_5 :  SIGNED(5 DOWNTO 0);


BEGIN 
mute <= SYNTHESIZED_WIRE_2;
balance_level <= SYNTHESIZED_WIRE_5;
volume_level <= SYNTHESIZED_WIRE_0;



b2v_inst : current_vol_bal
PORT MAP(clk => clk,
		 rstn => rstn,
		 kb_input => kb_input,
		 mute => SYNTHESIZED_WIRE_2,
		 balance_level => SYNTHESIZED_WIRE_5,
		 volume_level => SYNTHESIZED_WIRE_0);


b2v_inst1 : volume_adjustment
PORT MAP(clk => clk,
		 rstn => rstn,
		 lrsel => lrsel,
		 LADC => LADC,
		 RADC => RADC,
		 volume_level => SYNTHESIZED_WIRE_0,
		 volume_done => SYNTHESIZED_WIRE_1,
		 Adj_LADC => SYNTHESIZED_WIRE_3,
		 Adj_RADC => SYNTHESIZED_WIRE_4);


b2v_inst2 : balance_adjustment
PORT MAP(clk => clk,
		 rstn => rstn,
		 lrsel => lrsel,
		 volume_done => SYNTHESIZED_WIRE_1,
		 mute => SYNTHESIZED_WIRE_2,
		 Adj_LADC => SYNTHESIZED_WIRE_3,
		 Adj_RADC => SYNTHESIZED_WIRE_4,
		 balance_level => SYNTHESIZED_WIRE_5,
		 LDAC => LDAC,
		 RDAC => RDAC);


END bdf_type;