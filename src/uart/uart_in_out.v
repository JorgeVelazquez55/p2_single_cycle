module uart_in_out(
	input clk,
	input rst,
	input uart_tx_ini, uart_tx_data ,enable_out_reg_w, uart_rx_flag_rst,
	input [31:0]DataToOut,
	input [7:0]rx_register,
	output [31:0]flag_from, data_from, flag_to_uart, data_to_uart
);
reg reg_in_enable;
reg sel, sel2;
wire [31:0]rx_data_flag_v, rx_datas;
//wire [31:0]data_to_uart, flag_to_uart;
//assign tx_data = data_to_uart[31:24];
always @(posedge rst, posedge clk)
		begin
			if (rst)
			reg_in_enable <= 1'b0;
			else 
				if (enable_out_reg_w == 1'b1)begin
						reg_in_enable <= 1'b1;
						sel <= 1'b0;
						end
				else if (uart_rx_flag_rst == 1'b1)begin
						reg_in_enable <= 1'b1;
						sel <= 1'b1;
					end
				else begin
					reg_in_enable <= 1'b0;
					sel <= 1'b1;
					end
		end
				
//assign rx_data_flag_v = (enable_out_reg_w == 1'b1)?32'h0000_0001:32'h0000_0000;
Mux_2to1 #(.InLength(32))flags(
.A(32'h0000_0001), 
.B(32'h0000_0000),
.Sel(sel),
.s(rx_data_flag_v)
);

Mux_2to1 #(.InLength(32))datas(
.A({{24{1'b0}},rx_register}), 
.B(32'h0000_0000),
.Sel(sel),
.s(rx_datas)
);

Register #(.DATA_WIDTH(32)) rx_flag_reg(
.D(rx_data_flag_v),
.dafault_D(32'h0000_0000),
.rst(rst),
.en(reg_in_enable),
.clk(clk),
.Q(flag_from)
);

Register #(.DATA_WIDTH(32)) rx_data_reg(
.D(rx_datas),
.dafault_D(32'h0000_0000),
.rst(rst),
.en(reg_in_enable),
.clk(clk),
.Q(data_from)
);

Register #(.DATA_WIDTH(32)) tx_flag_reg(
.D(DataToOut),
.dafault_D(32'h0000_0000),
.rst(rst),
.en(uart_tx_ini),
.clk(clk),
.Q(flag_to_uart)
);

Register #(.DATA_WIDTH(32)) tx_data_reg(
.D(DataToOut),
.dafault_D(32'h0000_0000),
.rst(rst),
.en(uart_tx_data),
.clk(clk),
.Q(data_to_uart)
);
endmodule