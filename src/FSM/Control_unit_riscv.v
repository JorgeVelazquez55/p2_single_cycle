
`timescale 1ns / 1ps

module Control_unit_riscv(
		input clk,
		input rst,
		input en,
		input mod,
		input [6:0] opcode,
		input [2:0] funct3,
		input [6:0] funct7,
		output	IorD, MemWrite, IRWrite, PCSrc, PCWrite, RegWrite,  ALUOutEn, bbeq, bbne,
// pasar al otro modulo		output [2:0] ALU_control,
		output [1:0]	ALUSrcB1, ALUSrcA1, MemToReg,
		output [3:0] ALUcontrol,
		output reg [2:0] Ins_type
);

wire [1:0]ALUop1;
wire PCEn, mod1,i_ex_ac;
riscv_FSM FSM(
		.clk(clk),
		.rst(rst),
		.en(en),
		.funct3(funct3),
		.opcode(opcode),
		.IorD(IorD), 
		.MemWrite(MemWrite), 
		.IRWrite(IRWrite),
		.PCSrc(PCSrc), 
		.PCWrite(PCWrite), 
		.RegWrite(RegWrite), 
		.ALU_en(ALUOutEn),
		.bbeq(bbeq),
		.bbne(bbne),
		.i_ex_ac(i_ex_ac),
// pasar al otro modulo		output [2:0] ALU_control,
		.ALUSrcB1(ALUSrcB1), 
		.ALUSrcA1(ALUSrcA1), 
		.MemToReg(MemToReg),
		.ALUop(ALUop1)
);

ALU_decoder ALUControl(
	.funct(funct3),
	.funct_mul(funct7),
	.i_ex_ac(i_ex_ac),
	.mod(mod1),
	.ALUop(ALUop1),
	.ALUcontrol(ALUcontrol)
);
assign mod1 = (opcode == 3'b111)? mod: 1'b0;
always @ * begin
	if (opcode==7'b0000011 || opcode==7'b0010011)
	begin
		if(funct3==3'b001 || funct3==3'b101)
			Ins_type = 3'b001;	//I Type for shift.
		else
			Ins_type = 3'b000;	//I Type instruction.			
	end
	else if (opcode==7'b0100011)
		Ins_type = 3'b010;	//S Type instruction.
	else if (opcode==7'b1100011)
		Ins_type = 3'b011;	//B Type instruction.
	else if (opcode==7'b1101111)
		Ins_type = 3'b100;	//J Type instruction.
	else if (opcode==7'b0110111 || opcode==7'b0010111)
		Ins_type = 3'b101;	//U Type instruction.
	else
		Ins_type = 3'b111;	//R Type
end
endmodule