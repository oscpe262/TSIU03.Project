onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_analysis/DUT/clk
add wave -noupdate /tb_analysis/DUT/LC
add wave -noupdate /tb_analysis/DUT/RC
add wave -noupdate /tb_analysis/DUT/vsync
add wave -noupdate -radix unsigned /tb_analysis/DUT/lbar
add wave -noupdate -radix binary /tb_analysis/DUT/rbar
add wave -noupdate /tb_analysis/DUT/ildac
add wave -noupdate /tb_analysis/DUT/irdac
add wave -noupdate /tb_analysis/DUT/lafter
add wave -noupdate /tb_analysis/DUT/rafter
add wave -noupdate /tb_analysis/DUT/temp
add wave -noupdate -radix unsigned /tb_analysis/DUT/counter
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6697200 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 174
configure wave -valuecolwidth 265
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
WaveRestoreZoom {5634025 ns} {16902079 ns}
