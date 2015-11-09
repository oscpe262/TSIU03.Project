onerror {resume}
radix fpoint 3
radix fpoint 5
quietly WaveActivateNextPane {} 0
add wave -noupdate -color Red -itemcolor Red -label rstn /keyboard_tb/DUT/rstn
add wave -noupdate -color Gray60 -itemcolor Gray60 -label clk /keyboard_tb/DUT/clk
add wave -noupdate -color {Cadet Blue} -itemcolor {Cadet Blue} -label PS2_CLK_old /keyboard_tb/DUT/PS2_CLK2_old
add wave -noupdate -itemcolor Green -label det.fall /keyboard_tb/DUT/detected_fall
add wave -noupdate -color Orange -itemcolor Orange -label PS2_DAT /keyboard_tb/DUT/PS2_DAT
add wave -noupdate -color Aquamarine -itemcolor Aquamarine -label BYTE_IN -radix hexadecimal /keyboard_tb/DUT/BYTE_IN
add wave -noupdate -color Yellow -itemcolor Yellow -label BREAKSET /keyboard_tb/DUT/BREAKSET
add wave -noupdate -label kb_input -radix hexadecimal -childformat {{/keyboard_tb/DUT/kb_input(4) -radix hexadecimal} {/keyboard_tb/DUT/kb_input(3) -radix hexadecimal} {/keyboard_tb/DUT/kb_input(2) -radix hexadecimal} {/keyboard_tb/DUT/kb_input(1) -radix hexadecimal} {/keyboard_tb/DUT/kb_input(0) -radix hexadecimal}} -expand -subitemconfig {/keyboard_tb/DUT/kb_input(4) {-radix hexadecimal} /keyboard_tb/DUT/kb_input(3) {-radix hexadecimal} /keyboard_tb/DUT/kb_input(2) {-radix hexadecimal} /keyboard_tb/DUT/kb_input(1) {-radix hexadecimal} /keyboard_tb/DUT/kb_input(0) {-radix hexadecimal}} /keyboard_tb/DUT/kb_input
add wave -noupdate -color Magenta -itemcolor Magenta -label shiftreg -radixenum numeric -expand -subitemconfig {/keyboard_tb/DUT/shiftreg(9) {-color {Blue Violet} -itemcolor {Blue Violet} -radixenum numeric} /keyboard_tb/DUT/shiftreg(8) {-color Violet -itemcolor Violet -radixenum numeric} /keyboard_tb/DUT/shiftreg(7) {-color Violet -itemcolor Violet -radixenum numeric} /keyboard_tb/DUT/shiftreg(6) {-color Violet -itemcolor Violet -radixenum numeric} /keyboard_tb/DUT/shiftreg(5) {-color Violet -itemcolor Violet -radixenum numeric} /keyboard_tb/DUT/shiftreg(4) {-color Pink -itemcolor Pink -radixenum numeric} /keyboard_tb/DUT/shiftreg(3) {-color Pink -itemcolor Pink -radixenum numeric} /keyboard_tb/DUT/shiftreg(2) {-color Pink -itemcolor Pink -radixenum numeric} /keyboard_tb/DUT/shiftreg(1) {-color Pink -itemcolor Pink -radixenum numeric} /keyboard_tb/DUT/shiftreg(0) {-color Magenta -itemcolor Magenta -radixenum numeric}} /keyboard_tb/DUT/shiftreg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5612613 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 109
configure wave -valuecolwidth 72
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
WaveRestoreZoom {0 ns} {11876877 ns}
