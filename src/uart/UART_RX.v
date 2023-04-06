`timescale 1ns / 1ps
module UART_RX (
//Inputs: TX (8sw, 1 button), RX(1 GPIO)
	input clk,
	input rst,
	input rx,
//Outputs: TX(1 GPIO), RX(8 leds, 3 Displays, 1 parity led, 1 heard bit)
	output [7:0]rx_register,
	output enable_out_reg_w
	);

	
wire rst_sr_w, rst_bit_counter_w, rst_BR_w;
wire sample_bit_w;
wire end_bit_time_w, end_half_time_w;
wire bit_count_enable_w;
wire [3:0] count_bits_w;
wire [8:0] Q_SR_w /* synthesis keep */;
assign rst_sr_w = rst;
/////UART Receiver.________________________________________________________________________

Shift_Register_R_Param #(.width(9) ) shift_reg
    (.clk(clk), .rst(rst_sr_w), .enable(sample_bit_w),
     .d(rx), .Q(Q_SR_w) );

// Output Reg
Reg_Param  #(.width(8) ) rx_Data_Reg_i (.rst(rst), .D(Q_SR_w[7:0]), .clk(clk),
							   .enable(enable_out_reg_w), .Q(rx_register)     );	
 

// For a baud rate of 9600 baudios: bit time 104.2 us, half time 52.1 us
// For a clock frequency of 50 MHz bit time = 5210 T50MHz;

Bit_Rate_Pulse # (.delay_counts(5208) ) BR_pulse (.clk(clk), .rst(rst_BR_w), 
			   .enable(1'b1), .end_bit_time(end_bit_time_w), .end_half_time (end_half_time_w)    );
			   
FSM_UART_Rx FSM_Rx (.rx(rx), .clk(clk), .rst(rst), .end_half_time_i(end_half_time_w),
				.end_bit_time_i(end_bit_time_w), .Rx_bit_Count(count_bits_w), 
				.sample_o(sample_bit_w), .bit_count_enable(bit_count_enable_w), .rst_BR(rst_BR_w),
				.rst_bit_counter(rst_bit_counter_w), .enable_out_reg(enable_out_reg_w) );			   
		
Counter_Param # (.n(4) ) Counter_bits (.clk(clk), .rst(rst_bit_counter_w), .enable(bit_count_enable_w), .Q(count_bits_w)    );

											
endmodule