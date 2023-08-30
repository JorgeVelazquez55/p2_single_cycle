//////////////////////////////////////////////////////////////////////////////////
// Quartus II Verilog Template
// Single port RAM with single read/write address 
//
// Company: ITESO
// Engineer:  Edgar Barba & Jorge Velazquez
// Module: single_port_ram
// Description:
// RAM Module. It is defined as 2^Addres_Width Words of data.
// There is only one Output Data Port and one of each input Address and Input Data
// port.  
//////////////////////////////////////////////////////////////////////////////////
module single_port_ram 
#(parameter DATA_WIDTH = 32, parameter ADDR_WIDTH = 32)
(	input [(DATA_WIDTH-1):0] data,
	input [(ADDR_WIDTH-1):0] addr,
	input we, re, clk,
	output [(DATA_WIDTH-1):0] q );

// Declare the RAM array
reg [DATA_WIDTH-1:0] ram[63:0];
wire [(ADDR_WIDTH-3):0] CurrAddr;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
initial
  begin
    $readmemh("Array_hex.dat", ram);
  end
 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
assign CurrAddr=addr[(ADDR_WIDTH-1):2];
always @ (posedge clk)
	begin
		// Write
		if (we)
			ram[CurrAddr] <= data;
	end
// Reading continuously
assign q = (re)?ram[CurrAddr]:32'b0;

endmodule
