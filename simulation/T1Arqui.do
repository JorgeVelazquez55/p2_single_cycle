onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /RISCV_tb/clk
add wave -noupdate /RISCV_tb/UUT/core/PC
add wave -noupdate /RISCV_tb/UUT/core/ROM/instruction
add wave -noupdate /RISCV_tb/UUT/core/RegFile/Regs/Q9
add wave -noupdate /RISCV_tb/UUT/core/RegFile/Regs/Q18
add wave -noupdate /RISCV_tb/UUT/core/RegFile/Regs/Q19
add wave -noupdate /RISCV_tb/UUT/core/RegFile/Regs/Q20
add wave -noupdate /RISCV_tb/UUT/core/RegFile/Regs/Q21
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {108000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 235
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
configure wave -timelineunits ps
update
WaveRestoreZoom {105943 ps} {109683 ps}
