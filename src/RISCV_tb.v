`timescale 1ns / 1ps
module RISCV_tb;

reg clk, rst;
reg UARTRx;
wire UARTTx;

single_cycle_p2 UUT(
.clk(clk),
.rst(rst),
.rx_line_uart(UARTRx),
.tx_line_uart(UARTTx)
);

initial 
	begin
	UARTRx = 1'b1;
	clk = 1'b1;
	rst = 1'b1;
#1 rst = 1'b0;
#118 UARTRx = 1'b0;
#120 UARTRx = 1'b1;
#120 UARTRx = 1'b0;
#120 UARTRx = 1'b1;
#120 UARTRx = 1'b0;
#120 UARTRx = 1'b0;
#120 UARTRx = 1'b0;
#120 UARTRx = 1'b0;
#120 UARTRx = 1'b0;
#120 UARTRx = 1'b1;

#1800 UARTRx = 1'b0;
#120 UARTRx = 1'b1;
#120 UARTRx = 1'b1;
#120 UARTRx = 1'b0;
#120 UARTRx = 1'b0;
#120 UARTRx = 1'b0;
#120 UARTRx = 1'b0;
#120 UARTRx = 1'b0;
#120 UARTRx = 1'b0;
#120 UARTRx = 1'b1;


#18000 UARTRx = 1'b0;
#120 UARTRx = 1'b0;
#120 UARTRx = 1'b0;
#120 UARTRx = 1'b1;
#120 UARTRx = 1'b1;
#120 UARTRx = 1'b0;
#120 UARTRx = 1'b0;
#120 UARTRx = 1'b0;
#120 UARTRx = 1'b0;
#120 UARTRx = 1'b1;
	end
always // Clock generator
  begin
    #5 clk = ~clk;
  end
endmodule