`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ITESO
// Engineer:  Edgar Barba & Jorge Velazquez
// Module: MUX_2to1
// Description: 
// Data Multiplexer. 
// If Sel == 1 then S = A
// Else S = B
//////////////////////////////////////////////////////////////////////////////////
module Mux_2to1 #(parameter InLength=32)(
input [InLength-1:0]A, B,
input Sel,
output [InLength-1:0]s
);

assign s = Sel==1'b0 ? A:B;

endmodule	