//////////////////////////////////////////////////////////////////////////////////
// Company: ITESO
// Engineer:  Edgar Barba & Jorge Velazquez
// Module: WriteControl
// Desciption: 
// This module controls any writing at the registers inside the REgister File.
// It ensures that only one REgister is written at a time.
//
//////////////////////////////////////////////////////////////////////////////////
module WriteControl (
  input [4:0] sel,
  input en,
  output out0,
  output out1,
  output out2,
  output out3,
  output out4,
  output out5,
  output out6,
  output out7,
  output out8,
  output out9,
  output out10,
  output out11,
  output out12,
  output out13,
  output out14,
  output out15,
  output out16,
  output out17,
  output out18,
  output out19,
  output out20,
  output out21,
  output out22,
  output out23,
  output out24,
  output out25,
  output out26,
  output out27,
  output out28,
  output out29,
  output out30,
  output out31
);
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Assing all the outputs to its condition.
//Output will be asserted if the input sel correspond to its number.
assign out0 = ((sel == 5'd0)&&(en ==1'b1))? 1'b1: 1'b0;
assign out1 = ((sel == 5'd1)&&(en ==1'b1))? 1'b1: 1'b0;
assign out2 = ((sel == 5'd2)&&(en ==1'b1))? 1'b1: 1'b0;
assign out3 = ((sel == 5'd3)&&(en ==1'b1))? 1'b1: 1'b0;
assign out4 = ((sel == 5'd4)&&(en ==1'b1))? 1'b1: 1'b0;
assign out5 = ((sel == 5'd5)&&(en ==1'b1))? 1'b1: 1'b0;
assign out6 = ((sel == 5'd6)&&(en ==1'b1))? 1'b1: 1'b0;
assign out7 = ((sel == 5'd7)&&(en ==1'b1))? 1'b1: 1'b0;
assign out8 = ((sel == 5'd8)&&(en ==1'b1))? 1'b1: 1'b0;
assign out9 = ((sel == 5'd9)&&(en ==1'b1))? 1'b1: 1'b0;
assign out10 = ((sel == 5'd10)&&(en==1'b1))? 1'b1: 1'b0;
assign out11 = ((sel == 5'd11)&&(en==1'b1))? 1'b1: 1'b0;
assign out12 = ((sel == 5'd12)&&(en==1'b1))? 1'b1: 1'b0;
assign out13 = ((sel == 5'd13)&&(en==1'b1))? 1'b1: 1'b0;
assign out14 = ((sel == 5'd14)&&(en==1'b1))? 1'b1: 1'b0;
assign out15 = ((sel == 5'd15)&&(en==1'b1))? 1'b1: 1'b0;
assign out16 = ((sel == 5'd16)&&(en==1'b1))? 1'b1: 1'b0;
assign out17 = ((sel == 5'd17)&&(en==1'b1))? 1'b1: 1'b0;
assign out18 = ((sel == 5'd18)&&(en==1'b1))? 1'b1: 1'b0;
assign out19 = ((sel == 5'd19)&&(en==1'b1))? 1'b1: 1'b0;
assign out20 = ((sel == 5'd20)&&(en==1'b1))? 1'b1: 1'b0;
assign out21 = ((sel == 5'd21)&&(en==1'b1))? 1'b1: 1'b0;
assign out22 = ((sel == 5'd22)&&(en==1'b1))? 1'b1: 1'b0;
assign out23 = ((sel == 5'd23)&&(en==1'b1))? 1'b1: 1'b0;
assign out24 = ((sel == 5'd24)&&(en==1'b1))? 1'b1: 1'b0;
assign out25 = ((sel == 5'd25)&&(en==1'b1))? 1'b1: 1'b0;
assign out26 = ((sel == 5'd26)&&(en==1'b1))? 1'b1: 1'b0;
assign out27 = ((sel == 5'd27)&&(en==1'b1))? 1'b1: 1'b0;
assign out28 = ((sel == 5'd28)&&(en==1'b1))? 1'b1: 1'b0;
assign out29 = ((sel == 5'd29)&&(en==1'b1))? 1'b1: 1'b0;
assign out30 = ((sel == 5'd30)&&(en==1'b1))? 1'b1: 1'b0;
assign out31 = ((sel == 5'd31)&&(en==1'b1))? 1'b1: 1'b0;

endmodule