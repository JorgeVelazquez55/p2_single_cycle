`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ITESO
// Engineer:  Edgar Barba & Jorge Velazquez
// Module: Control_Unit
// Description: 
// This modules beholds the main FSM for the arquitecture as well as the 
// ALU Control.
// 
//////////////////////////////////////////////////////////////////////////////////

module Control_Unit(
		input [31:0]PC,
		input clk,
		input rst,
		input uart_ready,
		input [5:0] op_inst,
		input [5:0] funct,
		output  IorD, MemWrite, IRWrite, PCSrc, PCWrite, RegWrite, MemToReg, RegDST, bbeq, bbne, 
		output ALUSrc_A,
		output ALUOutEn,
		output uart_send,
		output [1:0] ALUSrcB,
		output [1:0] ALUSrcA,
		output [2:0] ALUcontrol
);

wire [1:0]ALUop1; //Wire to interconect the FSM with the ALU controler.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// FSM module decalaration.
MIPS_FSM_ctrl_unit FSM(
.PC(PC),
.clk(clk),
.rst(rst),
.funct(funct),
.op_inst(op_inst),
.IorD(IorD), 
.MemWrite(MemWrite), 
.IRWrite(IRWrite), 
.PCSrc(PCSrc), 
.PCWrite(PCWrite),
.ALUSrc_A(ALUSrc_A), 
.ALUSrcA(ALUSrcA), 
.RegWrite(RegWrite), 
.MemToReg(MemToReg), 
.RegDST(RegDST), 
.ALU_en(ALUOutEn),
.ALUSrcB(ALUSrcB), 
.ALUop(ALUop1),
.uart_ready(uart_ready),
.uart_send(uart_send)
);
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ALU controler module decalaration.
ALU_decoder Decoder(
	.funct(funct),
	.Opt(op_inst),
	.ALUop(ALUop1),
	.ALUcontrol(ALUcontrol)
);


endmodule