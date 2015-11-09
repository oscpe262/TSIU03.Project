onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {Control Signals}
add wave -noupdate /tb_vol_bal/DUT/clk
add wave -noupdate /tb_vol_bal/DUT/rstn
add wave -noupdate /tb_vol_bal/DUT/lrsel
add wave -noupdate /tb_vol_bal/DUT/kb_input
add wave -noupdate -divider {Step 1 - Incoming ADC}
add wave -noupdate -format Analog-Step -height 34 -max 32767.0 -min -32768.0 -radix decimal /tb_vol_bal/DUT/LADC
add wave -noupdate -format Analog-Step -height 34 -max 32767.0 -min -32768.0 -radix decimal /tb_vol_bal/DUT/RADC
add wave -noupdate -radix decimal /tb_vol_bal/DUT/b2v_inst1/ADC
add wave -noupdate -divider {Step 2 - Volume Outputs}
add wave -noupdate -divider {Step 3 - Finished Outputs}
add wave -noupdate -format Analog-Step -height 34 -max 32767.0 -min -32768.0 -radix decimal /tb_vol_bal/DUT/LDAC
add wave -noupdate -format Analog-Step -height 34 -max 32767.0 -min -32768.0 -radix decimal /tb_vol_bal/DUT/RDAC
add wave -noupdate -divider {System Level Outputs}
add wave -noupdate /tb_vol_bal/DUT/mute
add wave -noupdate -radix unsigned /tb_vol_bal/DUT/volume_level
add wave -noupdate -radix decimal /tb_vol_bal/DUT/balance_level
add wave -noupdate -divider internals
add wave -noupdate -radix unsigned /tb_vol_bal/DUT/b2v_inst/i_volume_lvl
add wave -noupdate -radix decimal /tb_vol_bal/DUT/b2v_inst/i_balance_lvl
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {976560 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 271
configure wave -valuecolwidth 153
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {971 us} {1001527 ns}
