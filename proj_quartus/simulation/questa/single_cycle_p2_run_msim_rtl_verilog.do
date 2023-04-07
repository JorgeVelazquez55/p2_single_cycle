transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/Documentos/Otros\ archivos/Cicuitos\ y\ Hardware/Verilog/MDE/RISCV_Single_Cycle/src/UART_Full_Duplex {E:/Documentos/Otros archivos/Cicuitos y Hardware/Verilog/MDE/RISCV_Single_Cycle/src/UART_Full_Duplex/UART_TX.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/Otros\ archivos/Cicuitos\ y\ Hardware/Verilog/MDE/RISCV_Single_Cycle/src/UART_Full_Duplex {E:/Documentos/Otros archivos/Cicuitos y Hardware/Verilog/MDE/RISCV_Single_Cycle/src/UART_Full_Duplex/UART_RX.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/Otros\ archivos/Cicuitos\ y\ Hardware/Verilog/MDE/RISCV_Single_Cycle/src/UART_Full_Duplex {E:/Documentos/Otros archivos/Cicuitos y Hardware/Verilog/MDE/RISCV_Single_Cycle/src/UART_Full_Duplex/TXshift_register.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/Otros\ archivos/Cicuitos\ y\ Hardware/Verilog/MDE/RISCV_Single_Cycle/src/UART_Full_Duplex {E:/Documentos/Otros archivos/Cicuitos y Hardware/Verilog/MDE/RISCV_Single_Cycle/src/UART_Full_Duplex/RXshift_register.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/Otros\ archivos/Cicuitos\ y\ Hardware/Verilog/MDE/RISCV_Single_Cycle/src/UART_Full_Duplex {E:/Documentos/Otros archivos/Cicuitos y Hardware/Verilog/MDE/RISCV_Single_Cycle/src/UART_Full_Duplex/FSM_UART_tx.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/Otros\ archivos/Cicuitos\ y\ Hardware/Verilog/MDE/RISCV_Single_Cycle/src/UART_Full_Duplex {E:/Documentos/Otros archivos/Cicuitos y Hardware/Verilog/MDE/RISCV_Single_Cycle/src/UART_Full_Duplex/FSM_UART_rx.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/Otros\ archivos/Cicuitos\ y\ Hardware/Verilog/MDE/RISCV_Single_Cycle/src/UART_Full_Duplex {E:/Documentos/Otros archivos/Cicuitos y Hardware/Verilog/MDE/RISCV_Single_Cycle/src/UART_Full_Duplex/FF_D_enable.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/Otros\ archivos/Cicuitos\ y\ Hardware/Verilog/MDE/RISCV_Single_Cycle/src/UART_Full_Duplex {E:/Documentos/Otros archivos/Cicuitos y Hardware/Verilog/MDE/RISCV_Single_Cycle/src/UART_Full_Duplex/FF_D_2enable.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/Otros\ archivos/Cicuitos\ y\ Hardware/Verilog/MDE/RISCV_Single_Cycle/src/UART_Full_Duplex {E:/Documentos/Otros archivos/Cicuitos y Hardware/Verilog/MDE/RISCV_Single_Cycle/src/UART_Full_Duplex/Counter_Param.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/Otros\ archivos/Cicuitos\ y\ Hardware/Verilog/MDE/RISCV_Single_Cycle/src/UART_Full_Duplex {E:/Documentos/Otros archivos/Cicuitos y Hardware/Verilog/MDE/RISCV_Single_Cycle/src/UART_Full_Duplex/Bit_Rate_Pulse.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/Otros\ archivos/Cicuitos\ y\ Hardware/Verilog/MDE/RISCV_Single_Cycle/src {E:/Documentos/Otros archivos/Cicuitos y Hardware/Verilog/MDE/RISCV_Single_Cycle/src/UART.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/Otros\ archivos/Cicuitos\ y\ Hardware/Verilog/MDE/RISCV_Single_Cycle/src {E:/Documentos/Otros archivos/Cicuitos y Hardware/Verilog/MDE/RISCV_Single_Cycle/src/MemController.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/Otros\ archivos/Cicuitos\ y\ Hardware/Verilog/MDE/RISCV_Single_Cycle/src {E:/Documentos/Otros archivos/Cicuitos y Hardware/Verilog/MDE/RISCV_Single_Cycle/src/single_cycle_p2.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/Otros\ archivos/Cicuitos\ y\ Hardware/Verilog/MDE/RISCV_Single_Cycle/src {E:/Documentos/Otros archivos/Cicuitos y Hardware/Verilog/MDE/RISCV_Single_Cycle/src/core_risc_v.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/Otros\ archivos/Cicuitos\ y\ Hardware/Verilog/MDE/RISCV_Single_Cycle/src/ALU {E:/Documentos/Otros archivos/Cicuitos y Hardware/Verilog/MDE/RISCV_Single_Cycle/src/ALU/ALU.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/Otros\ archivos/Cicuitos\ y\ Hardware/Verilog/MDE/RISCV_Single_Cycle/src/Single_port_RAM {E:/Documentos/Otros archivos/Cicuitos y Hardware/Verilog/MDE/RISCV_Single_Cycle/src/Single_port_RAM/single_port_ram.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/Otros\ archivos/Cicuitos\ y\ Hardware/Verilog/MDE/RISCV_Single_Cycle/src/Single_port_RAM {E:/Documentos/Otros archivos/Cicuitos y Hardware/Verilog/MDE/RISCV_Single_Cycle/src/Single_port_RAM/GPIO_in_out.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/Otros\ archivos/Cicuitos\ y\ Hardware/Verilog/MDE/RISCV_Single_Cycle/src/SignExtend {E:/Documentos/Otros archivos/Cicuitos y Hardware/Verilog/MDE/RISCV_Single_Cycle/src/SignExtend/imm.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/Otros\ archivos/Cicuitos\ y\ Hardware/Verilog/MDE/RISCV_Single_Cycle/src/RegisterFile {E:/Documentos/Otros archivos/Cicuitos y Hardware/Verilog/MDE/RISCV_Single_Cycle/src/RegisterFile/WriteControl.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/Otros\ archivos/Cicuitos\ y\ Hardware/Verilog/MDE/RISCV_Single_Cycle/src/RegisterFile {E:/Documentos/Otros archivos/Cicuitos y Hardware/Verilog/MDE/RISCV_Single_Cycle/src/RegisterFile/Registers.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/Otros\ archivos/Cicuitos\ y\ Hardware/Verilog/MDE/RISCV_Single_Cycle/src/RegisterFile {E:/Documentos/Otros archivos/Cicuitos y Hardware/Verilog/MDE/RISCV_Single_Cycle/src/RegisterFile/RegisterFile.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/Otros\ archivos/Cicuitos\ y\ Hardware/Verilog/MDE/RISCV_Single_Cycle/src/RegisterFile {E:/Documentos/Otros archivos/Cicuitos y Hardware/Verilog/MDE/RISCV_Single_Cycle/src/RegisterFile/Register.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/Otros\ archivos/Cicuitos\ y\ Hardware/Verilog/MDE/RISCV_Single_Cycle/src/RegisterFile {E:/Documentos/Otros archivos/Cicuitos y Hardware/Verilog/MDE/RISCV_Single_Cycle/src/RegisterFile/MUX32input.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/Otros\ archivos/Cicuitos\ y\ Hardware/Verilog/MDE/RISCV_Single_Cycle/src/Muxs {E:/Documentos/Otros archivos/Cicuitos y Hardware/Verilog/MDE/RISCV_Single_Cycle/src/Muxs/Mux_4to1.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/Otros\ archivos/Cicuitos\ y\ Hardware/Verilog/MDE/RISCV_Single_Cycle/src/Muxs {E:/Documentos/Otros archivos/Cicuitos y Hardware/Verilog/MDE/RISCV_Single_Cycle/src/Muxs/Mux_2to1.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/Otros\ archivos/Cicuitos\ y\ Hardware/Verilog/MDE/RISCV_Single_Cycle/src/FSM {E:/Documentos/Otros archivos/Cicuitos y Hardware/Verilog/MDE/RISCV_Single_Cycle/src/FSM/Control_unit_riscv.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/Otros\ archivos/Cicuitos\ y\ Hardware/Verilog/MDE/RISCV_Single_Cycle/src/FSM {E:/Documentos/Otros archivos/Cicuitos y Hardware/Verilog/MDE/RISCV_Single_Cycle/src/FSM/ALU_decoder.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/Otros\ archivos/Cicuitos\ y\ Hardware/Verilog/MDE/RISCV_Single_Cycle/src/ALU {E:/Documentos/Otros archivos/Cicuitos y Hardware/Verilog/MDE/RISCV_Single_Cycle/src/ALU/adder.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/Otros\ archivos/Cicuitos\ y\ Hardware/Verilog/MDE/RISCV_Single_Cycle/src/Single_port_ROM {E:/Documentos/Otros archivos/Cicuitos y Hardware/Verilog/MDE/RISCV_Single_Cycle/src/Single_port_ROM/memory_ROM.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/Otros\ archivos/Cicuitos\ y\ Hardware/Verilog/MDE/RISCV_Single_Cycle/src {E:/Documentos/Otros archivos/Cicuitos y Hardware/Verilog/MDE/RISCV_Single_Cycle/src/Control.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/Otros\ archivos/Cicuitos\ y\ Hardware/Verilog/MDE/RISCV_Single_Cycle/src {E:/Documentos/Otros archivos/Cicuitos y Hardware/Verilog/MDE/RISCV_Single_Cycle/src/MUXNInput.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/Otros\ archivos/Cicuitos\ y\ Hardware/Verilog/MDE/RISCV_Single_Cycle/src/Single_port_ROM {E:/Documentos/Otros archivos/Cicuitos y Hardware/Verilog/MDE/RISCV_Single_Cycle/src/Single_port_ROM/single_port_rom.v}

vlog -vlog01compat -work work +incdir+E:/Documentos/Otros\ archivos/Cicuitos\ y\ Hardware/Verilog/MDE/RISCV_Single_Cycle/proj_quartus/../src {E:/Documentos/Otros archivos/Cicuitos y Hardware/Verilog/MDE/RISCV_Single_Cycle/proj_quartus/../src/RISCV_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  RISCV_tb

add wave *
view structure
view signals
run -all
