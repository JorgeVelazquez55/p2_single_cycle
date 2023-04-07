
`timescale 1ns / 1ps

module Control_unit_riscv(
		input [1:0] mod,
		input [6:0] opcode,
		input [2:0] funct3,
		output	Jump, 
					JumpR, 
					Branch, 
					MemRead, 
					MemWrite, 
					ALUsrc, 
					RegWrite, 
					PCSave,
					BNEinst, 
					BEQinst,
		output [1:0] MemToReg,
		output [4:0] ALUcontrol,
		output [2:0] InstType
);

wire [2:0] Inst_Type;
wire [1:0] mod2, ALUop;

assign BNEinst = (funct3 == 3'b001)? 1'b1: 1'b0;
assign BEQinst = (funct3 == 3'b000)? 1'b1: 1'b0;
assign InstType = Inst_Type;
assign mod2 = (Inst_Type ==  3'b111)? mod: 2'b0;

ALU_decoder ALUControl(
	.funct(funct3),
	.mod(mod2),
	.ALUop(ALUop),
	.ALUcontrol(ALUcontrol)
);

Control ControlModule(
	.op_inst(opcode),
	.InstType(Inst_Type),
	.Jump(Jump),
	.JumpR(JumpR),
	.Branch(Branch),
	.MemRead(MemRead),
	.MemWrite(MemWrite),
	.ALUsrc(ALUsrc),
	.RegWrite(RegWrite),
	.PCSave(PCSave),
	.ALU_Op(ALUop),
	.MemToReg(MemToReg)
);

endmodule