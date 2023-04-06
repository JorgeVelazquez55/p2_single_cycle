`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ITESO
// Engineer:  Edgar Barba & Jorge Velazquez
// Module: Mux_4to1
// Description:
// Data Multiplexer. 
// If Sel == 00b then S = A
// If Sel == 01b then S = B
// If Sel == 10b then S = C
// If Sel == 11b then S = D
// 
//////////////////////////////////////////////////////////////////////////////////

module Mux_4to1 #(parameter InLength=32)(
	input [InLength-1:0]A, B, C, D,
	input [1:0]Sel,
	output reg[InLength-1:0]s
);
	
always @*
begin
	case (Sel)
		2'b00:s=A;
		2'b01:s=B;
		2'b10:s=C;
		2'b11:s=D;
	endcase
end
endmodule	