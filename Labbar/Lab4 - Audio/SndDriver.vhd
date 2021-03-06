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
-- CREATED		"Sun Sep 27 19:31:44 2015"

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

LIBRARY work;

ENTITY SndDriver IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		rstn :  IN  STD_LOGIC;
		adcdat :  IN  STD_LOGIC;
		LDAC :  IN  SIGNED(15 DOWNTO 0);
		RDAC :  IN  SIGNED(15 DOWNTO 0);
		dacdat :  OUT  STD_LOGIC;
		mclk :  OUT  STD_LOGIC;
		bclk :  OUT  STD_LOGIC;
		adclrc :  OUT  STD_LOGIC;
		daclrc :  OUT  STD_LOGIC;
		lrsel :  OUT  STD_LOGIC;
		LADC :  OUT  SIGNED(15 DOWNTO 0);
		RADC :  OUT  SIGNED(15 DOWNTO 0)
	);
END SndDriver;

ARCHITECTURE bdf_type OF SndDriver IS 

COMPONENT ctrl
	PORT(clk : IN STD_LOGIC;
		 rstn : IN STD_LOGIC;
		 mclk : OUT STD_LOGIC;
		 bclk : OUT STD_LOGIC;
		 adclrc : OUT STD_LOGIC;
		 daclrc : OUT STD_LOGIC;
		 men : OUT STD_LOGIC;
		 lrsel : OUT STD_LOGIC;
		 BitCnt : OUT UNSIGNED(4 DOWNTO 0);
		 SCCnt : OUT UNSIGNED(1 DOWNTO 0)
	);
END COMPONENT;

COMPONENT channel_mod
	PORT(clk : IN STD_LOGIC;
		 rstn : IN STD_LOGIC;
		 men : IN STD_LOGIC;
		 sel : IN STD_LOGIC;
		 adcdat : IN STD_LOGIC;
		 BitCnt : IN UNSIGNED(4 DOWNTO 0);
		 DAC : IN SIGNED(15 DOWNTO 0);
		 SCCnt : IN UNSIGNED(1 DOWNTO 0);
		 dacdat : OUT STD_LOGIC;
		 ADC : OUT SIGNED(15 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_16 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_17 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_18 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_19 :  UNSIGNED(4 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_20 :  UNSIGNED(1 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_13 :  STD_LOGIC;


BEGIN 
daclrc <= SYNTHESIZED_WIRE_16;
lrsel <= SYNTHESIZED_WIRE_18;



dacdat <= SYNTHESIZED_WIRE_0 OR SYNTHESIZED_WIRE_1;


SYNTHESIZED_WIRE_0 <= SYNTHESIZED_WIRE_2 AND SYNTHESIZED_WIRE_16;


SYNTHESIZED_WIRE_1 <= NOT(SYNTHESIZED_WIRE_4 OR SYNTHESIZED_WIRE_16);


SYNTHESIZED_WIRE_4 <= NOT(SYNTHESIZED_WIRE_6);



b2v_inst_ctrl : ctrl
PORT MAP(clk => clk,
		 rstn => rstn,
		 mclk => mclk,
		 bclk => bclk,
		 adclrc => adclrc,
		 daclrc => SYNTHESIZED_WIRE_16,
		 men => SYNTHESIZED_WIRE_17,
		 lrsel => SYNTHESIZED_WIRE_18,
		 BitCnt => SYNTHESIZED_WIRE_19,
		 SCCnt => SYNTHESIZED_WIRE_20);


b2v_inst_left : channel_mod
PORT MAP(clk => clk,
		 rstn => rstn,
		 men => SYNTHESIZED_WIRE_17,
		 sel => SYNTHESIZED_WIRE_18,
		 adcdat => adcdat,
		 BitCnt => SYNTHESIZED_WIRE_19,
		 DAC => LDAC,
		 SCCnt => SYNTHESIZED_WIRE_20,
		 dacdat => SYNTHESIZED_WIRE_2,
		 ADC => LADC);


SYNTHESIZED_WIRE_13 <= NOT(SYNTHESIZED_WIRE_18);



b2v_inst_right : channel_mod
PORT MAP(clk => clk,
		 rstn => rstn,
		 men => SYNTHESIZED_WIRE_17,
		 sel => SYNTHESIZED_WIRE_13,
		 adcdat => adcdat,
		 BitCnt => SYNTHESIZED_WIRE_19,
		 DAC => RDAC,
		 SCCnt => SYNTHESIZED_WIRE_20,
		 dacdat => SYNTHESIZED_WIRE_6,
		 ADC => RADC);


END bdf_type;