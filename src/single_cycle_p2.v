//////////////////////////////////////////////////////////////////////////////////
// Company: ITESO
// Engineer:  Jorge Velazquez
// Module: risc_v_multicycle
// Desciption: 
// Top level module. Instanciation for every other module.
//////////////////////////////////////////////////////////////////////////////////
module single_cycle_p2 (
 input clk_in,
 input rst,
 input rx_line_uart,
 output tx_line_uart

);


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Declarations for each interconection.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
wire GPIOen, RAMen, UARTen, MemWrite, MemRead, clk;
wire [1:0] DataSel;
wire [31:0] Data_B, GPIOData, data_o_map, addr_map_o, addr_ram, ram_out, UARTData;
//assign rst = ~n_rst; ///HABILITAR AL PROGRAMAR Y CAMBIAR EL DEL MAIN
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//clock 1hz generator
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//assign clk=clk_in;
pll40MHz clk40MHz(
.refclk(clk_in),   //  refclk.clk
.rst(rst),      //   reset.reset
.outclk_0(clk) // outclk0.clk
	);

core_risc_v #(.DATA_WIDTH(32), .ADDR_WIDTH (32)) core(
	.clk_O(clk),
	.rst(rst),
	.en(1'b1),
	.data_o_map(data_o_map),
 	.MemWrite(MemWrite),
	.MemRead(MemRead),
	.Result(addr_ram),
	.rd2(Data_B)
);


MemController #(.DATA_WIDTH(32), .ADDR_WIDTH(32)) MemCtrl(
.WrtEn(MemWrite),
.ADDRIn(addr_ram),
.RAM_En(RAMen),
.GPIO_En(GPIOen),
.UART_En(UARTen),
.Sel(DataSel),
.ADDROut(addr_map_o)
);

MUXNInput DataMUX(
.sel(DataSel),
.Q0(ram_out),
.Q1(UARTData),
.Q2(GPIOData),
.data(data_o_map)
);

UART uart0
(
.clk(clk),
.rst(rst),
.wrtEn(UARTen),
.addr(addr_map_o[2]),
.TxData(Data_B),
.ReadReg(UARTData),
.SerialOut(tx_line_uart),
.SerialIn(rx_line_uart)
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
.re(MemRead),
.clk(clk), 
.q(ram_out)
); 
							
endmodule