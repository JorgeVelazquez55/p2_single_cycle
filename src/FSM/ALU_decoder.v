`timescale 1ns / 1ps

module ALU_decoder(
	input mod, i_ex_ac,
	input [2:0]funct,
	input [1:0]ALUop,
	input [6:0] funct_mul,
	output reg [3:0]ALUcontrol
);

always @*
	begin
	  if (ALUop==2'b00)
	  	ALUcontrol=4'b0000;
	  else if (ALUop==2'b01)
	  	ALUcontrol=4'b1000;
	  else if (ALUop==2'b10)
	  begin
		if (funct_mul == 7'b0000001 && i_ex_ac == 1'b0)
			ALUcontrol= 4'b1100;
		else
			ALUcontrol={mod,funct};
		end	
	  else
	  	ALUcontrol=4'b0000;
	end	
endmodule