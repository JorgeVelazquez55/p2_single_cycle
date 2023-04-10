module memory_ROM
#(parameter DATA_WIDTH = 32, parameter ADDR_WIDTH = 32)(
input [(ADDR_WIDTH-1):0] addr_pc,
output [(DATA_WIDTH-1):0] instruction
);

reg [31:0] addr_pros;

always @ *
begin
	addr_pros = addr_pc - 32'h00400000;
	//addr_pros = {12'b0, addr_pc[19:0]};
end

single_port_rom #(.DATA_WIDTH(32), .ADDR_WIDTH(32))ROM_32bitD_programMemory
(
.addr(addr_pros), 
.q(instruction)
);
endmodule
