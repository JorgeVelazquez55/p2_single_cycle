`timescale 1ns / 1ps
module RISCV_tb;

reg clk, rst;
reg UARTRx;
wire UARTTx;

single_cycle_p2 UUT(
.clk_in(clk),
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
#1018 UARTRx = 1'b0;
#8333 UARTRx = 1'b1;
#8333 UARTRx = 1'b0;
#8333 UARTRx = 1'b1;
#8333 UARTRx = 1'b0;
#8333 UARTRx = 1'b0;
#8333 UARTRx = 1'b0;
#8333 UARTRx = 1'b0;
#8333 UARTRx = 1'b0;
#8333 UARTRx = 1'b1;

#10800 UARTRx = 1'b0;
#8333 UARTRx = 1'b1;
#8333 UARTRx = 1'b1;
#8333 UARTRx = 1'b0;
#8333 UARTRx = 1'b0;
#8333 UARTRx = 1'b0;
#8333 UARTRx = 1'b0;
#8333 UARTRx = 1'b0;
#8333 UARTRx = 1'b0;
#8333 UARTRx = 1'b1;


#18000 UARTRx = 1'b0;
#8333 UARTRx = 1'b0;
#8333 UARTRx = 1'b0;
#8333 UARTRx = 1'b1;
#8333 UARTRx = 1'b1;
#8333 UARTRx = 1'b0;
#8333 UARTRx = 1'b0;
#8333 UARTRx = 1'b0;
#8333 UARTRx = 1'b0;
#8333 UARTRx = 1'b1;
	end
always // Clock generator
  begin
    #1 clk = ~clk;
  end
endmodule