// Quartus II Verilog Template
// Single Port ROM
module single_port_rom
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=32)
	(input [(ADDR_WIDTH-1):0] addr,
	output [(DATA_WIDTH-1):0] q );
// ROM Variable Declaration
reg [DATA_WIDTH-1:0] rom[63:0];
// Initialize the ROM: put the memory content in the file
// ROM_init.txt, for example. Read this file with $readmemh
// without this file this design will not compile.
// Memory initialization.
initial
  begin
    $readmemb("Numero_mas_chico.txt", rom);
  end
  
assign q = rom[addr[31:2]];

endmodule
