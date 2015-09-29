onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Clocks
add wave -noupdate /tb_top/DUT/fpga_clk
add wave -noupdate /tb_top/DUT/vga_clk
add wave -noupdate -divider Reset
add wave -noupdate /tb_top/DUT/KEY0
add wave -noupdate /tb_top/DUT/rstn
add wave -noupdate -divider {Render Control}
add wave -noupdate -radix unsigned /tb_top/DUT/hcnt
add wave -noupdate -radix unsigned /tb_top/DUT/vcnt
add wave -noupdate /tb_top/DUT/hsync
add wave -noupdate /tb_top/DUT/vsync
add wave -noupdate /tb_top/DUT/blank1
add wave -noupdate /tb_top/DUT/blank2
add wave -noupdate /tb_top/DUT/vga_blank
add wave -noupdate -divider {Pixel Data}
add wave -noupdate /tb_top/DUT/up_lo_byte
add wave -noupdate /tb_top/DUT/pixrg
add wave -noupdate /tb_top/DUT/vga_b
add wave -noupdate /tb_top/DUT/vga_g
add wave -noupdate /tb_top/DUT/vga_r
add wave -noupdate -divider {RAM stuff}
add wave -noupdate /tb_top/DUT/sram_ce
add wave -noupdate /tb_top/DUT/sram_oe
add wave -noupdate /tb_top/DUT/sram_lb
add wave -noupdate /tb_top/DUT/sram_ub
add wave -noupdate /tb_top/DUT/sram_we
add wave -noupdate -divider {RAM Address}
add wave -noupdate -radix unsigned /tb_top/DUT/b2v_inst16/pixel_index
add wave -noupdate -radix unsigned /tb_top/DUT/sram_addr
add wave -noupdate -divider {RAM Data In}
add wave -noupdate /tb_top/DUT/sram_data
add wave -noupdate -divider Other
add wave -noupdate /tb_top/DUT/HEX6
add wave -noupdate /tb_top/DUT/HEX7
add wave -noupdate /tb_top/DUT/vga_sync
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {96740 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 210
configure wave -valuecolwidth 178
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
WaveRestoreZoom {80438 ns} {113934 ns}
