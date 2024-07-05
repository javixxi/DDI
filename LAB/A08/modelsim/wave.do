onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /segundero_tb/dut/clk
add wave -noupdate /segundero_tb/dut/nRst
add wave -noupdate /segundero_tb/dut/nreset
add wave -noupdate /segundero_tb/dut/ena
add wave -noupdate -radix hexadecimal /segundero_tb/dut/Q
add wave -noupdate /segundero_tb/dut/cnt_timer
add wave -noupdate /segundero_tb/dut/tic_1s
add wave -noupdate /segundero_tb/dut/ena_decenas
add wave -noupdate /segundero_tb/dut/fdc_timer
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1275964 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {39055879 ps} {40049691 ps}
