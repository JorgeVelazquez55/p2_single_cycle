//////////////////////////////////////////////////////////////////////////////////
// Company: ITESO
// Engineer:  Jorge Velazquez
// Module: risc_v_multicycle
// Desciption: 
// Top level module. Instanciation for every other module.
//////////////////////////////////////////////////////////////////////////////////
module single_cycle_p2 (
 input clk,
 input rst,
 input rx_line_uart,
 output tx_line_uart

);


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Declarations for each interconection.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
wire GPIOen, RAMen, map_sel, MemWrite, uart_flag_en, uart_data_en, btn_send, finish, enable_out_reg_w, uart_rx_flag_rst;
wire [31:0] Data_B, GPIOData, data_o_map, addr_map_o, addr_ram, ram_out, rom_data_out, flag_from, data_from, flag_to_uart, data_to_uart;
wire [7:0] reg_tx_uart, rx_register;
//assign rst = ~n_rst; ///HABILITAR AL PROGRAMAR Y CAMBIAR EL DEL MAIN
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//clock 1hz generator
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//clk_1hz_gen clk_1Hz(  ////HABILITAR AL PROGRAMAR
//.clk_50mhz(clk),
//.rst(rst),
//.clk_1hz(clk_O)
//);

uart_shif_reg uart_shift(
 .clk(clk),
 .rst(rst),
 .flag_ini(flag_to_uart),
 .tx_data(data_to_uart),
 .flag_end(finish),
 .reg_tx_uart(reg_tx_uart),
 .btn_send(btn_send)
// output [7:0] gpio_out
// input uart_rx,
// output uart_tx
);

core_risc_v #(.DATA_WIDTH(32), .ADDR_WIDTH (32)) core(
	.clk_O(clk),
	.rst(rst),
	.en(1'b1),
	.data_o_map(data_o_map),
 	.MemWrite(MemWrite),
	.Result(addr_ram),
	.rd2(Data_B)
);



Memory_map #(.DATA_WIDTH(32), .ADDR_WIDTH(32)) maping(
.WrtEn(MemWrite),
.ram_out(ram_out),
.GPIOData(GPIOData),
.rom_data_out(rom_data_out),
.flag_from(flag_from),
.data_from(data_from),
.ADDRIn(addr_ram),
.RAM_En(RAMen),
.GPIO_En(GPIOen),
.uart_flag_en(uart_flag_en),
.uart_data_en(uart_data_en),
.uart_rx_flag_rst(uart_rx_flag_rst),
.ADDROut(addr_map_o),
.data_o_map(data_o_map)
);

uart_in_out uart_memory(
	.clk(clk),
	.rst(rst),
	.uart_tx_ini(uart_flag_en), .uart_tx_data(uart_data_en), .enable_out_reg_w(enable_out_reg_w), .uart_rx_flag_rst(uart_rx_flag_rst),
	.DataToOut(Data_B),
	.rx_register(rx_register),
	.flag_from(flag_from), .data_from(data_from), .flag_to_uart(flag_to_uart), .data_to_uart(data_to_uart)
);

GPIO_in_out GPIO(
.clk(clk),
.rst(rst),
.en(GPIOen),
.PORT_IN(),
.DataToOut(Data_B),
.PORT_OUT(),
.DataFromIn(GPIOData)
);
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//RAM Module declaration.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

single_port_ram #(.DATA_WIDTH(32), .ADDR_WIDTH(32))RAM_32bit_dataMemory
(
.data(Data_B), 
.addr(addr_map_o), 
.we(RAMen), 
.clk(clk), 
.q(ram_out)
); 
UART_RX RX(
	.clk(clk),
	.rst(rst),
	.rx(rx_line_uart),
	.rx_register(rx_register),
	.enable_out_reg_w(enable_out_reg_w)
	);

UART_TX TX(
//Inputs: TX (8sw, 1 button), RX(1 GPIO)
	.clk(clk),
	.n_rst(rst),
	.data(reg_tx_uart),
	.btn_tx(btn_send),
   .tx_line(tx_line_uart),
	.finish(finish)
);									
endmodule