module Memory_map
#(parameter DATA_WIDTH = 32, parameter ADDR_WIDTH = 32)(
	input WrtEn,
	input [(DATA_WIDTH-1):0] ram_out, GPIOData, rom_data_out, flag_from, data_from,
	input [(ADDR_WIDTH-1):0] ADDRIn,
	output RAM_En,
	output GPIO_En, uart_flag_en, uart_data_en, uart_rx_flag_rst,
	output reg [(ADDR_WIDTH-1):0] ADDROut,
	output [(DATA_WIDTH-1):0] data_o_map
);
reg [1:0]Sel;
reg  RAMen, GPIOen, ROMen, uar, uart_tx_ini, uart_tx_data, uart_rx_flag;
assign RAM_En = RAMen & WrtEn;
assign GPIO_En = GPIOen & WrtEn;
assign uart_flag_en = uart_tx_ini & WrtEn;
assign uart_data_en = uart_tx_data & WrtEn;
assign uart_rx_flag_rst = uart_rx_flag & WrtEn;
//assign ROM_En = ROMen & WrtEn;

always @ *
begin
	if(ADDRIn <= 32'h10010020 && ADDRIn >= 32'h10010000) begin //location of data memory
		RAMen = 1;
		GPIOen = 0;
		uart_tx_ini = 0;
		uart_tx_data = 0;
		uart_rx_flag = 0;
		ADDROut = ADDRIn - 32'h10010000;
		Sel = 2'b00;
	end
		else if(ADDRIn == 32'h1001002c) begin
		RAMen = 0;
		GPIOen = 0;
		uart_tx_ini = 0;
		uart_tx_data = 0;
		uart_rx_flag = 1;
		ADDROut = ADDRIn - 32'h1001002c;
		Sel = 2'b01;
	end
		else if(ADDRIn == 32'h10010030) begin
		RAMen = 0;
		GPIOen = 0;
		uart_tx_ini = 0;
		uart_tx_data = 0;
		uart_rx_flag = 0;
		ADDROut = ADDRIn - 32'h10010030;
		Sel = 2'b11;
	end
		else if(ADDRIn == 32'h10010034) begin
		RAMen = 0;
		GPIOen = 0;
		uart_tx_ini = 1;
		uart_tx_data = 0;
		uart_rx_flag = 0;
		ADDROut = ADDRIn - 32'h10010034;
//		Sel = 2'b11;
	end
		else if(ADDRIn == 32'h10010038) begin
		RAMen = 0;
		GPIOen = 0;
		uart_tx_ini = 0;
		uart_tx_data = 1;
		uart_rx_flag = 0;
		ADDROut = ADDRIn - 32'h10010038;
//		Sel = 2'b11;
	end
	else if(ADDRIn <= 32'h10010028 && ADDRIn >= 32'h10010024 ) begin
		RAMen = 0;
		GPIOen = 1;
		uart_tx_ini = 0;
		uart_tx_data = 0;
		uart_rx_flag = 0;
		ADDROut = ADDRIn - 32'h10010024;
		//Sel = 2'b01;
	end
	else if(ADDRIn >= 32'h00400000) begin  ///Location of memory program
		RAMen = 0;
		GPIOen = 0;
		uart_tx_ini = 0;
		uart_tx_data = 0;
		uart_rx_flag = 0;
		ADDROut = ADDRIn - 32'h00400000;
		Sel = 2'b10;
	end
	else if(ADDRIn <= 32'h00000100 && ADDRIn >= 32'h00000080) begin  ///Location of stack point
		RAMen = 1;
		GPIOen = 0;
		uart_tx_ini = 0;
		uart_tx_data = 0;
		ADDROut = ADDRIn;
		Sel = 2'b00;
	end
	else begin
		RAMen = 1;
		GPIOen = 0;
		uart_tx_ini = 0;
		uart_tx_data = 0;
		uart_rx_flag = 0;
		ADDROut = 32'h0;
		Sel = 2'b00;
	end
end

Mux_4to1 #(.InLength(32))map_mem_data(
.A(ram_out), 
.B(flag_from),
.C(rom_data_out),
.D(data_from),
.Sel(Sel),
.s(data_o_map)
);
endmodule