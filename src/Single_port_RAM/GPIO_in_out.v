module GPIO_in_out(
	input clk,
	input rst,
	input en,
	input [31:0]DataToOut,
	input [7:0]PORT_IN,
	output [7:0]PORT_OUT,
	output [31:0]DataFromIn
);
wire [31:0]ToOut;
assign PORT_OUT = ToOut[7:0];
Register #(.DATA_WIDTH(32)) InReg(
.D({{24{1'b0}},PORT_IN}),
.dafault_D(32'h0000_0000),
.rst(rst),
.en(1'b1),
.clk(clk),
.Q(DataFromIn)
);

Register #(.DATA_WIDTH(32)) OutReg(
.D(DataToOut),
.dafault_D(32'h0000_0000),
.rst(rst),
.en(en),
.clk(clk),
.Q(ToOut)
);

endmodule