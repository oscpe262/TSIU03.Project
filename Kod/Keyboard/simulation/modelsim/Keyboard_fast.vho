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

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 12.1 Build 243 01/31/2013 Service Pack 1.33 SJ Full Version"

-- DATE "10/23/2015 11:03:06"

-- 
-- Device: Altera EP2C35F672C6 Package FBGA672
-- 

-- 
-- This VHDL file should be used for ModelSim (VHDL) only
-- 

LIBRARY CYCLONEII;
LIBRARY IEEE;
USE CYCLONEII.CYCLONEII_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	Keyboard IS
    PORT (
	rstn : IN std_logic;
	clk : IN std_logic;
	PS2_CLK : IN std_logic;
	PS2_DAT : IN std_logic;
	kb_input : OUT std_logic_vector(4 DOWNTO 0)
	);
END Keyboard;

-- Design Ports Information
-- kb_input[0]	=>  Location: PIN_G12,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- kb_input[1]	=>  Location: PIN_J11,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- kb_input[2]	=>  Location: PIN_F12,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- kb_input[3]	=>  Location: PIN_C11,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- kb_input[4]	=>  Location: PIN_J10,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- clk	=>  Location: PIN_P2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- rstn	=>  Location: PIN_P1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- PS2_CLK	=>  Location: PIN_C13,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- PS2_DAT	=>  Location: PIN_D13,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default


ARCHITECTURE structure OF Keyboard IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_rstn : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_PS2_CLK : std_logic;
SIGNAL ww_PS2_DAT : std_logic;
SIGNAL ww_kb_input : std_logic_vector(4 DOWNTO 0);
SIGNAL \clk~clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \rstn~clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \BREAKSET~regout\ : std_logic;
SIGNAL \Equal0~1_combout\ : std_logic;
SIGNAL \Equal0~2_combout\ : std_logic;
SIGNAL \shiftreg~8_combout\ : std_logic;
SIGNAL \BYTE_IN[7]~2_combout\ : std_logic;
SIGNAL \BYTE_IN[5]~4_combout\ : std_logic;
SIGNAL \BYTE_IN[1]~8_combout\ : std_logic;
SIGNAL \clk~combout\ : std_logic;
SIGNAL \clk~clkctrl_outclk\ : std_logic;
SIGNAL \shiftreg~1_combout\ : std_logic;
SIGNAL \rstn~combout\ : std_logic;
SIGNAL \rstn~clkctrl_outclk\ : std_logic;
SIGNAL \PS2_CLK~combout\ : std_logic;
SIGNAL \PS2_CLK2~regout\ : std_logic;
SIGNAL \PS2_CLK2_old~regout\ : std_logic;
SIGNAL \detected_fall~combout\ : std_logic;
SIGNAL \shiftreg~0_combout\ : std_logic;
SIGNAL \PS2_DAT~combout\ : std_logic;
SIGNAL \PS2_DAT2~feeder_combout\ : std_logic;
SIGNAL \PS2_DAT2~regout\ : std_logic;
SIGNAL \shiftreg~9_combout\ : std_logic;
SIGNAL \shiftreg~2_combout\ : std_logic;
SIGNAL \shiftreg~3_combout\ : std_logic;
SIGNAL \shiftreg~4_combout\ : std_logic;
SIGNAL \shiftreg~5_combout\ : std_logic;
SIGNAL \BYTE_IN[4]~5_combout\ : std_logic;
SIGNAL \BYTE_IN[7]~0_combout\ : std_logic;
SIGNAL \shiftreg~6_combout\ : std_logic;
SIGNAL \BYTE_IN[3]~6_combout\ : std_logic;
SIGNAL \shiftreg~7_combout\ : std_logic;
SIGNAL \BYTE_IN[2]~7_combout\ : std_logic;
SIGNAL \kb_reg[0]~4_combout\ : std_logic;
SIGNAL \BYTE_IN[0]~1_combout\ : std_logic;
SIGNAL \kb_reg[1]~6_combout\ : std_logic;
SIGNAL \kb_reg[3]~9_combout\ : std_logic;
SIGNAL \BYTE_IN[6]~3_combout\ : std_logic;
SIGNAL \kb_reg[4]~10_combout\ : std_logic;
SIGNAL \kb_reg[0]~2_combout\ : std_logic;
SIGNAL \kb_reg[0]~1_combout\ : std_logic;
SIGNAL \Equal0~0_combout\ : std_logic;
SIGNAL \kb_reg[0]~3_combout\ : std_logic;
SIGNAL \kb_reg[1]~7_combout\ : std_logic;
SIGNAL \kb_reg[2]~8_combout\ : std_logic;
SIGNAL \kb_reg[0]~0_combout\ : std_logic;
SIGNAL \kb_reg[0]~5_combout\ : std_logic;
SIGNAL shiftreg : std_logic_vector(9 DOWNTO 0);
SIGNAL kb_reg : std_logic_vector(4 DOWNTO 0);
SIGNAL BYTE_IN : std_logic_vector(7 DOWNTO 0);
SIGNAL \ALT_INV_rstn~clkctrl_outclk\ : std_logic;

BEGIN

ww_rstn <= rstn;
ww_clk <= clk;
ww_PS2_CLK <= PS2_CLK;
ww_PS2_DAT <= PS2_DAT;
kb_input <= ww_kb_input;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\clk~clkctrl_INCLK_bus\ <= (gnd & gnd & gnd & \clk~combout\);

\rstn~clkctrl_INCLK_bus\ <= (gnd & gnd & gnd & \rstn~combout\);
\ALT_INV_rstn~clkctrl_outclk\ <= NOT \rstn~clkctrl_outclk\;

-- Location: LCFF_X28_Y35_N3
\BYTE_IN[7]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \BYTE_IN[7]~2_combout\,
	ena => \BYTE_IN[7]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => BYTE_IN(7));

-- Location: LCFF_X28_Y35_N13
BREAKSET : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \Equal0~2_combout\,
	ena => \BYTE_IN[7]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \BREAKSET~regout\);

-- Location: LCFF_X28_Y35_N9
\BYTE_IN[5]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \BYTE_IN[5]~4_combout\,
	ena => \BYTE_IN[7]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => BYTE_IN(5));

-- Location: LCFF_X28_Y35_N31
\BYTE_IN[1]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \BYTE_IN[1]~8_combout\,
	ena => \BYTE_IN[7]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => BYTE_IN(1));

-- Location: LCCOMB_X28_Y35_N16
\Equal0~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \Equal0~1_combout\ = (BYTE_IN(6) & (BYTE_IN(7) & (BYTE_IN(5) & !BYTE_IN(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => BYTE_IN(6),
	datab => BYTE_IN(7),
	datac => BYTE_IN(5),
	datad => BYTE_IN(1),
	combout => \Equal0~1_combout\);

-- Location: LCCOMB_X28_Y35_N12
\Equal0~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \Equal0~2_combout\ = (\Equal0~1_combout\ & \Equal0~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \Equal0~1_combout\,
	datad => \Equal0~0_combout\,
	combout => \Equal0~2_combout\);

-- Location: LCFF_X27_Y35_N17
\shiftreg[2]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \shiftreg~8_combout\,
	aclr => \ALT_INV_rstn~clkctrl_outclk\,
	ena => \detected_fall~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => shiftreg(2));

-- Location: LCCOMB_X27_Y35_N16
\shiftreg~8\ : cycloneii_lcell_comb
-- Equation(s):
-- \shiftreg~8_combout\ = (!shiftreg(0) & shiftreg(3))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => shiftreg(0),
	datad => shiftreg(3),
	combout => \shiftreg~8_combout\);

-- Location: LCCOMB_X28_Y35_N2
\BYTE_IN[7]~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \BYTE_IN[7]~2_combout\ = !shiftreg(8)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => shiftreg(8),
	combout => \BYTE_IN[7]~2_combout\);

-- Location: LCCOMB_X28_Y35_N8
\BYTE_IN[5]~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \BYTE_IN[5]~4_combout\ = !shiftreg(6)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => shiftreg(6),
	combout => \BYTE_IN[5]~4_combout\);

-- Location: LCCOMB_X28_Y35_N30
\BYTE_IN[1]~8\ : cycloneii_lcell_comb
-- Equation(s):
-- \BYTE_IN[1]~8_combout\ = !shiftreg(2)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => shiftreg(2),
	combout => \BYTE_IN[1]~8_combout\);

-- Location: PIN_P2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\clk~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_clk,
	combout => \clk~combout\);

-- Location: CLKCTRL_G3
\clk~clkctrl\ : cycloneii_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \clk~clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \clk~clkctrl_outclk\);

-- Location: LCCOMB_X27_Y35_N12
\shiftreg~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \shiftreg~1_combout\ = (shiftreg(2) & !shiftreg(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => shiftreg(2),
	datac => shiftreg(0),
	combout => \shiftreg~1_combout\);

-- Location: PIN_P1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\rstn~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_rstn,
	combout => \rstn~combout\);

-- Location: CLKCTRL_G1
\rstn~clkctrl\ : cycloneii_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \rstn~clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \rstn~clkctrl_outclk\);

-- Location: PIN_C13,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\PS2_CLK~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_PS2_CLK,
	combout => \PS2_CLK~combout\);

-- Location: LCFF_X28_Y35_N15
PS2_CLK2 : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	sdata => \PS2_CLK~combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \PS2_CLK2~regout\);

-- Location: LCFF_X28_Y35_N5
PS2_CLK2_old : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	sdata => \PS2_CLK2~regout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \PS2_CLK2_old~regout\);

-- Location: LCCOMB_X28_Y35_N14
detected_fall : cycloneii_lcell_comb
-- Equation(s):
-- \detected_fall~combout\ = (!\PS2_CLK2~regout\ & \PS2_CLK2_old~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \PS2_CLK2~regout\,
	datad => \PS2_CLK2_old~regout\,
	combout => \detected_fall~combout\);

-- Location: LCFF_X27_Y35_N13
\shiftreg[1]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \shiftreg~1_combout\,
	aclr => \ALT_INV_rstn~clkctrl_outclk\,
	ena => \detected_fall~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => shiftreg(1));

-- Location: LCCOMB_X27_Y35_N24
\shiftreg~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \shiftreg~0_combout\ = (!shiftreg(0) & shiftreg(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => shiftreg(0),
	datad => shiftreg(1),
	combout => \shiftreg~0_combout\);

-- Location: LCFF_X27_Y35_N25
\shiftreg[0]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \shiftreg~0_combout\,
	aclr => \ALT_INV_rstn~clkctrl_outclk\,
	ena => \detected_fall~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => shiftreg(0));

-- Location: PIN_D13,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\PS2_DAT~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_PS2_DAT,
	combout => \PS2_DAT~combout\);

-- Location: LCCOMB_X30_Y35_N4
\PS2_DAT2~feeder\ : cycloneii_lcell_comb
-- Equation(s):
-- \PS2_DAT2~feeder_combout\ = \PS2_DAT~combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \PS2_DAT~combout\,
	combout => \PS2_DAT2~feeder_combout\);

-- Location: LCFF_X30_Y35_N5
PS2_DAT2 : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \PS2_DAT2~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \PS2_DAT2~regout\);

-- Location: LCCOMB_X29_Y35_N0
\shiftreg~9\ : cycloneii_lcell_comb
-- Equation(s):
-- \shiftreg~9_combout\ = (!shiftreg(0) & !\PS2_DAT2~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => shiftreg(0),
	datad => \PS2_DAT2~regout\,
	combout => \shiftreg~9_combout\);

-- Location: LCFF_X29_Y35_N1
\shiftreg[9]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \shiftreg~9_combout\,
	aclr => \ALT_INV_rstn~clkctrl_outclk\,
	ena => \detected_fall~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => shiftreg(9));

-- Location: LCCOMB_X29_Y35_N12
\shiftreg~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \shiftreg~2_combout\ = (!shiftreg(0) & shiftreg(9))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => shiftreg(0),
	datad => shiftreg(9),
	combout => \shiftreg~2_combout\);

-- Location: LCFF_X29_Y35_N13
\shiftreg[8]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \shiftreg~2_combout\,
	aclr => \ALT_INV_rstn~clkctrl_outclk\,
	ena => \detected_fall~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => shiftreg(8));

-- Location: LCCOMB_X29_Y35_N30
\shiftreg~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \shiftreg~3_combout\ = (!shiftreg(0) & shiftreg(8))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => shiftreg(0),
	datad => shiftreg(8),
	combout => \shiftreg~3_combout\);

-- Location: LCFF_X29_Y35_N31
\shiftreg[7]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \shiftreg~3_combout\,
	aclr => \ALT_INV_rstn~clkctrl_outclk\,
	ena => \detected_fall~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => shiftreg(7));

-- Location: LCCOMB_X29_Y35_N4
\shiftreg~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \shiftreg~4_combout\ = (!shiftreg(0) & shiftreg(7))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => shiftreg(0),
	datad => shiftreg(7),
	combout => \shiftreg~4_combout\);

-- Location: LCFF_X29_Y35_N5
\shiftreg[6]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \shiftreg~4_combout\,
	aclr => \ALT_INV_rstn~clkctrl_outclk\,
	ena => \detected_fall~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => shiftreg(6));

-- Location: LCCOMB_X29_Y35_N6
\shiftreg~5\ : cycloneii_lcell_comb
-- Equation(s):
-- \shiftreg~5_combout\ = (!shiftreg(0) & shiftreg(6))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => shiftreg(0),
	datac => shiftreg(6),
	combout => \shiftreg~5_combout\);

-- Location: LCFF_X29_Y35_N7
\shiftreg[5]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \shiftreg~5_combout\,
	aclr => \ALT_INV_rstn~clkctrl_outclk\,
	ena => \detected_fall~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => shiftreg(5));

-- Location: LCCOMB_X27_Y35_N18
\BYTE_IN[4]~5\ : cycloneii_lcell_comb
-- Equation(s):
-- \BYTE_IN[4]~5_combout\ = !shiftreg(5)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => shiftreg(5),
	combout => \BYTE_IN[4]~5_combout\);

-- Location: LCCOMB_X27_Y35_N14
\BYTE_IN[7]~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \BYTE_IN[7]~0_combout\ = (shiftreg(0) & (\rstn~combout\ & (!\PS2_CLK2~regout\ & \PS2_CLK2_old~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => shiftreg(0),
	datab => \rstn~combout\,
	datac => \PS2_CLK2~regout\,
	datad => \PS2_CLK2_old~regout\,
	combout => \BYTE_IN[7]~0_combout\);

-- Location: LCFF_X27_Y35_N19
\BYTE_IN[4]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \BYTE_IN[4]~5_combout\,
	ena => \BYTE_IN[7]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => BYTE_IN(4));

-- Location: LCCOMB_X27_Y35_N8
\shiftreg~6\ : cycloneii_lcell_comb
-- Equation(s):
-- \shiftreg~6_combout\ = (!shiftreg(0) & shiftreg(5))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => shiftreg(0),
	datad => shiftreg(5),
	combout => \shiftreg~6_combout\);

-- Location: LCFF_X27_Y35_N9
\shiftreg[4]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \shiftreg~6_combout\,
	aclr => \ALT_INV_rstn~clkctrl_outclk\,
	ena => \detected_fall~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => shiftreg(4));

-- Location: LCCOMB_X27_Y35_N20
\BYTE_IN[3]~6\ : cycloneii_lcell_comb
-- Equation(s):
-- \BYTE_IN[3]~6_combout\ = !shiftreg(4)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => shiftreg(4),
	combout => \BYTE_IN[3]~6_combout\);

-- Location: LCFF_X27_Y35_N21
\BYTE_IN[3]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \BYTE_IN[3]~6_combout\,
	ena => \BYTE_IN[7]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => BYTE_IN(3));

-- Location: LCCOMB_X27_Y35_N30
\shiftreg~7\ : cycloneii_lcell_comb
-- Equation(s):
-- \shiftreg~7_combout\ = (shiftreg(4) & !shiftreg(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => shiftreg(4),
	datac => shiftreg(0),
	combout => \shiftreg~7_combout\);

-- Location: LCFF_X27_Y35_N31
\shiftreg[3]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \shiftreg~7_combout\,
	aclr => \ALT_INV_rstn~clkctrl_outclk\,
	ena => \detected_fall~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => shiftreg(3));

-- Location: LCCOMB_X27_Y35_N10
\BYTE_IN[2]~7\ : cycloneii_lcell_comb
-- Equation(s):
-- \BYTE_IN[2]~7_combout\ = !shiftreg(3)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => shiftreg(3),
	combout => \BYTE_IN[2]~7_combout\);

-- Location: LCFF_X27_Y35_N11
\BYTE_IN[2]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \BYTE_IN[2]~7_combout\,
	ena => \BYTE_IN[7]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => BYTE_IN(2));

-- Location: LCCOMB_X28_Y35_N0
\kb_reg[0]~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \kb_reg[0]~4_combout\ = (!BYTE_IN(1) & (BYTE_IN(4) & (!BYTE_IN(3) & BYTE_IN(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => BYTE_IN(1),
	datab => BYTE_IN(4),
	datac => BYTE_IN(3),
	datad => BYTE_IN(2),
	combout => \kb_reg[0]~4_combout\);

-- Location: LCCOMB_X27_Y35_N4
\BYTE_IN[0]~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \BYTE_IN[0]~1_combout\ = !shiftreg(1)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => shiftreg(1),
	combout => \BYTE_IN[0]~1_combout\);

-- Location: LCFF_X27_Y35_N5
\BYTE_IN[0]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \BYTE_IN[0]~1_combout\,
	ena => \BYTE_IN[7]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => BYTE_IN(0));

-- Location: LCCOMB_X27_Y35_N26
\kb_reg[1]~6\ : cycloneii_lcell_comb
-- Equation(s):
-- \kb_reg[1]~6_combout\ = (BYTE_IN(3) & (!BYTE_IN(4) & (BYTE_IN(0) & !BYTE_IN(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => BYTE_IN(3),
	datab => BYTE_IN(4),
	datac => BYTE_IN(0),
	datad => BYTE_IN(2),
	combout => \kb_reg[1]~6_combout\);

-- Location: LCCOMB_X28_Y35_N28
\kb_reg[3]~9\ : cycloneii_lcell_comb
-- Equation(s):
-- \kb_reg[3]~9_combout\ = (!BYTE_IN(0) & (\kb_reg[0]~4_combout\ & (\kb_reg[0]~0_combout\ & \kb_reg[0]~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => BYTE_IN(0),
	datab => \kb_reg[0]~4_combout\,
	datac => \kb_reg[0]~0_combout\,
	datad => \kb_reg[0]~3_combout\,
	combout => \kb_reg[3]~9_combout\);

-- Location: LCFF_X28_Y35_N29
\kb_reg[3]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \kb_reg[3]~9_combout\,
	aclr => \ALT_INV_rstn~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => kb_reg(3));

-- Location: LCCOMB_X28_Y35_N20
\BYTE_IN[6]~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \BYTE_IN[6]~3_combout\ = !shiftreg(7)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => shiftreg(7),
	combout => \BYTE_IN[6]~3_combout\);

-- Location: LCFF_X28_Y35_N21
\BYTE_IN[6]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \BYTE_IN[6]~3_combout\,
	ena => \BYTE_IN[7]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => BYTE_IN(6));

-- Location: LCCOMB_X28_Y35_N22
\kb_reg[4]~10\ : cycloneii_lcell_comb
-- Equation(s):
-- \kb_reg[4]~10_combout\ = (!BYTE_IN(1) & (\kb_reg[1]~6_combout\ & (\kb_reg[0]~0_combout\ & \kb_reg[0]~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => BYTE_IN(1),
	datab => \kb_reg[1]~6_combout\,
	datac => \kb_reg[0]~0_combout\,
	datad => \kb_reg[0]~3_combout\,
	combout => \kb_reg[4]~10_combout\);

-- Location: LCFF_X28_Y35_N23
\kb_reg[4]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \kb_reg[4]~10_combout\,
	aclr => \ALT_INV_rstn~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => kb_reg(4));

-- Location: LCCOMB_X28_Y35_N18
\kb_reg[0]~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \kb_reg[0]~2_combout\ = (BYTE_IN(5) & (!kb_reg(3) & (BYTE_IN(6) & !kb_reg(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => BYTE_IN(5),
	datab => kb_reg(3),
	datac => BYTE_IN(6),
	datad => kb_reg(4),
	combout => \kb_reg[0]~2_combout\);

-- Location: LCCOMB_X28_Y35_N4
\kb_reg[0]~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \kb_reg[0]~1_combout\ = (\BREAKSET~regout\ & (!\PS2_CLK2~regout\ & (\PS2_CLK2_old~regout\ & shiftreg(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \BREAKSET~regout\,
	datab => \PS2_CLK2~regout\,
	datac => \PS2_CLK2_old~regout\,
	datad => shiftreg(0),
	combout => \kb_reg[0]~1_combout\);

-- Location: LCCOMB_X27_Y35_N28
\Equal0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Equal0~0_combout\ = (!BYTE_IN(2) & (!BYTE_IN(0) & (!BYTE_IN(3) & BYTE_IN(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => BYTE_IN(2),
	datab => BYTE_IN(0),
	datac => BYTE_IN(3),
	datad => BYTE_IN(4),
	combout => \Equal0~0_combout\);

-- Location: LCCOMB_X28_Y35_N26
\kb_reg[0]~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \kb_reg[0]~3_combout\ = (\kb_reg[0]~2_combout\ & (\kb_reg[0]~1_combout\ & ((!\Equal0~0_combout\) # (!\Equal0~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Equal0~1_combout\,
	datab => \kb_reg[0]~2_combout\,
	datac => \kb_reg[0]~1_combout\,
	datad => \Equal0~0_combout\,
	combout => \kb_reg[0]~3_combout\);

-- Location: LCCOMB_X28_Y35_N10
\kb_reg[1]~7\ : cycloneii_lcell_comb
-- Equation(s):
-- \kb_reg[1]~7_combout\ = (BYTE_IN(1) & (\kb_reg[1]~6_combout\ & (\kb_reg[0]~0_combout\ & \kb_reg[0]~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => BYTE_IN(1),
	datab => \kb_reg[1]~6_combout\,
	datac => \kb_reg[0]~0_combout\,
	datad => \kb_reg[0]~3_combout\,
	combout => \kb_reg[1]~7_combout\);

-- Location: LCFF_X28_Y35_N11
\kb_reg[1]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \kb_reg[1]~7_combout\,
	aclr => \ALT_INV_rstn~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => kb_reg(1));

-- Location: LCCOMB_X28_Y35_N6
\kb_reg[2]~8\ : cycloneii_lcell_comb
-- Equation(s):
-- \kb_reg[2]~8_combout\ = (BYTE_IN(1) & (\Equal0~0_combout\ & (\kb_reg[0]~0_combout\ & \kb_reg[0]~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => BYTE_IN(1),
	datab => \Equal0~0_combout\,
	datac => \kb_reg[0]~0_combout\,
	datad => \kb_reg[0]~3_combout\,
	combout => \kb_reg[2]~8_combout\);

-- Location: LCFF_X28_Y35_N7
\kb_reg[2]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \kb_reg[2]~8_combout\,
	aclr => \ALT_INV_rstn~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => kb_reg(2));

-- Location: LCCOMB_X27_Y35_N6
\kb_reg[0]~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \kb_reg[0]~0_combout\ = (!BYTE_IN(7) & (!kb_reg(0) & (!kb_reg(1) & !kb_reg(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => BYTE_IN(7),
	datab => kb_reg(0),
	datac => kb_reg(1),
	datad => kb_reg(2),
	combout => \kb_reg[0]~0_combout\);

-- Location: LCCOMB_X28_Y35_N24
\kb_reg[0]~5\ : cycloneii_lcell_comb
-- Equation(s):
-- \kb_reg[0]~5_combout\ = (BYTE_IN(0) & (\kb_reg[0]~4_combout\ & (\kb_reg[0]~0_combout\ & \kb_reg[0]~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => BYTE_IN(0),
	datab => \kb_reg[0]~4_combout\,
	datac => \kb_reg[0]~0_combout\,
	datad => \kb_reg[0]~3_combout\,
	combout => \kb_reg[0]~5_combout\);

-- Location: LCFF_X28_Y35_N25
\kb_reg[0]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \kb_reg[0]~5_combout\,
	aclr => \ALT_INV_rstn~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => kb_reg(0));

-- Location: PIN_G12,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\kb_input[0]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => kb_reg(0),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_kb_input(0));

-- Location: PIN_J11,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\kb_input[1]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => kb_reg(1),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_kb_input(1));

-- Location: PIN_F12,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\kb_input[2]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => kb_reg(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_kb_input(2));

-- Location: PIN_C11,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\kb_input[3]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => kb_reg(3),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_kb_input(3));

-- Location: PIN_J10,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\kb_input[4]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => kb_reg(4),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_kb_input(4));
END structure;


