onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /lab3_tb/clk
add wave -noupdate /lab3_tb/dut/fsm_clk
add wave -noupdate /lab3_tb/reset
add wave -noupdate /lab3_tb/cols
add wave -noupdate /lab3_tb/rows
add wave -noupdate /lab3_tb/segs
add wave -noupdate /lab3_tb/disp0
add wave -noupdate /lab3_tb/disp1
add wave -noupdate /lab3_tb/newNum
add wave -noupdate /lab3_tb/idle
add wave -noupdate /lab3_tb/pressed
add wave -noupdate /lab3_tb/outCols
add wave -noupdate /lab3_tb/dut/rows
add wave -noupdate /lab3_tb/dut/counter/clk
add wave -noupdate /lab3_tb/dut/counter/reset
add wave -noupdate /lab3_tb/dut/counter/clk_stb
add wave -noupdate -radix unsigned /lab3_tb/dut/counter/count
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {690 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 203
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
WaveRestoreZoom {0 ns} {710 ns}
