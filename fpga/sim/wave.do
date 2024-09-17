onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /key_scan_tb/clk
add wave -noupdate /key_scan_tb/reset
add wave -noupdate /key_scan_tb/cols
add wave -noupdate /key_scan_tb/rows
add wave -noupdate /key_scan_tb/newNum
add wave -noupdate /key_scan_tb/dut/state
add wave -noupdate /key_scan_tb/dut/nextstate
add wave -noupdate -radix unsigned /key_scan_tb/dut/counter
add wave -noupdate /key_scan_tb/dut/delayed
add wave -noupdate /key_scan_tb/dut/clearCounter
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {107 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 263
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
WaveRestoreZoom {0 ns} {323 ns}
