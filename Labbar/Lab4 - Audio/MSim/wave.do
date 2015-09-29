onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_audio/rstn
add wave -noupdate /tb_audio/clk
add wave -noupdate /tb_audio/mclk
add wave -noupdate /tb_audio/bclk
add wave -noupdate -label {Master Enable} /tb_audio/DUT/SYNTHESIZED_WIRE_12
add wave -noupdate -label BitCnt -radix unsigned /tb_audio/DUT/SYNTHESIZED_WIRE_14
add wave -noupdate -label SCCnt -radix unsigned /tb_audio/DUT/SYNTHESIZED_WIRE_15
add wave -noupdate /tb_audio/lrsel
add wave -noupdate -divider {ADC signals}
add wave -noupdate /tb_audio/adclrc
add wave -noupdate -color yellow /tb_audio/adcdat
add wave -noupdate -color Pink -radix decimal /tb_audio/ADC_stimuli_left
add wave -noupdate -color Pink -radix decimal /tb_audio/LADC_out
add wave -noupdate /tb_audio/DUT/LADC
add wave -noupdate -color {Sky Blue} -radix decimal /tb_audio/ADC_stimuli_right
add wave -noupdate -color {Sky Blue} -radix decimal /tb_audio/RADC_out
add wave -noupdate /tb_audio/DUT/RADC
add wave -noupdate -divider {DAC signals}
add wave -noupdate /tb_audio/daclrc
add wave -noupdate -color yellow /tb_audio/dacdat
add wave -noupdate -color Pink -radix decimal /tb_audio/DAC_result_left
add wave -noupdate -color Pink -radix decimal /tb_audio/LDAC_in
add wave -noupdate /tb_audio/DUT/LDAC
add wave -noupdate -color {Sky Blue} -radix decimal /tb_audio/DAC_result_right
add wave -noupdate -color Pink -radix decimal /tb_audio/RDAC_in
add wave -noupdate /tb_audio/DUT/RDAC
add wave -noupdate -divider {Misc signals}
add wave -noupdate -divider DUT
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {235560 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 243
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ns} {1103593 ns}
