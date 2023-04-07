`timescale 1ns / 1ps

module ALU_decoder(
	input [1:0]mod,
	input [2:0]funct,
	input [1:0]ALUop,
	output reg [4:0]ALUcontrol
);

always @*
	begin
	  if (ALUop==2'b00)
	  	ALUcontrol=5'b0000;
	  else if (ALUop==2'b01)
	  	ALUcontrol=5'b1000;
	  else if (ALUop==2'b10)
	  	ALUcontrol={mod,funct};	
	  else
	  	ALUcontrol=5'b0000;
	end	
endmodule