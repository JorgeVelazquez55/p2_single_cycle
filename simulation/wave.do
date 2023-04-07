onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /RISCV_tb/UARTRx
add wave -noupdate /RISCV_tb/UARTTx
add wave -noupdate /RISCV_tb/UUT/core/PCReg/Q
add wave -noupdate /RISCV_tb/UUT/core/Instr_out
add wave -noupdate /RISCV_tb/UUT/core/GenImm/Imm
add wave -noupdate /RISCV_tb/UUT/core/GenImm/Ins_type
add wave -noupdate /RISCV_tb/UUT/core/RegFile/Regs/Q1
add wave -noupdate /RISCV_tb/UUT/core/RegFile/Regs/Q2
add wave -noupdate /RISCV_tb/UUT/core/RegFile/Regs/Q5
add wave -noupdate /RISCV_tb/UUT/core/RegFile/Regs/Q8
add wave -noupdate /RISCV_tb/UUT/core/RegFile/Regs/Q9
add wave -noupdate /RISCV_tb/UUT/core/RegFile/Regs/Q10
add wave -noupdate /RISCV_tb/UUT/core/RegFile/Regs/Q18
add wave -noupdate /RISCV_tb/UUT/core/RegFile/Regs/Q19
add wave -noupdate /RISCV_tb/UUT/uart0/TxRegD
add wave -noupdate /RISCV_tb/UUT/uart0/RxRegD
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {22172 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 357
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
WaveRestoreZoom {0 ps} {26417152 ps}
