module core_risc_v #(parameter DATA_WIDTH = 32, parameter ADDR_WIDTH = 32)(
	input clk_O,
	input rst,
	input en,
	input [(DATA_WIDTH-1):0] data_o_map,
 	output MemWrite,
	output [(ADDR_WIDTH-1):0] Result,
	output [(DATA_WIDTH-1):0] rd2
	
);
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Declarations for each interconection.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
wire IorD, IRWrite, PCSrc, PCWrite, ALUSrcA, RegWrite, ALU_Out_en, PC_Src, zeroflag, PCen, bbeq, bbne;
wire [31:0] nxt_PC, PC, ALU_Out, ALU_Result, Instr_out, srcA, srcB, Data_A, to_ALU,Data_out, rd1, Imm, WD3_Out, PCPrev, ImmM4, pc_adder, pc_add_imm;
wire [4:0]A3_Out;
wire [1:0]ALUSrcB1, ALUSrcA1, MemToReg;
wire [3:0]ALUcontrol;
wire [2:0]Ins_type;
//assign rst = ~n_rst; ///HABILITAR AL PROGRAMAR Y CAMBIAR EL DEL MAIN
assign PCen = (zeroflag & bbeq) | (~zeroflag & bbne) | PCWrite;

////////////////////////////////////////////////////////
//PC Register.
////////////////////////////////////////////////////////
Register #(.DATA_WIDTH(32)) PCReg(
.D(nxt_PC),
.dafault_D(32'h0040_0000),
.rst(rst),
.en(1'b1),
.clk(clk_O),
.Q(PC)
);

////////////////////////////////////////////////////////
//adder pc + 0x00000004
////////////////////////////////////////////////////////
adder PC_adder(
//Inputs
.A(PC),
.B(32'h0000_0004),
.Result(pc_adder)
);
////////////////////////////////////////////////////////
//adder pc + immediato
////////////////////////////////////////////////////////
adder PC_add_imm(
//Inputs
.A(PC),
.B(Imm),
.Result(pc_add_imm)
);

////////////////////////////////////////////////////////
//PC intputs Address MUX.
//  OP1: PC_+4.
//  OP2: PC_+_imm.
////////////////////////////////////////////////////////
Mux_2to1 #(.InLength(32))pc_adders(
.A(pc_adder), 
.B(pc_add_imm),
.Sel(PCen), ////PENDIENTE
.s(nxt_PC)
);
////////////////////////////////////////////////////////
//R0M Input Address secction
//  section to map address to ROM
////////////////////////////////////////////////////////
memory_ROM #(.DATA_WIDTH(32), .ADDR_WIDTH(32)) ROM(
.addr_pc(PC),
.instruction(Instr_out)
);


///////////////////////////////////////////////////////////////
//4 to 1 MUX declarations.
//Define data from alu, from memory, from PC previous
///////////////////////////////////////////////////////////////
Mux_4to1 #(.InLength(32))data_pc_rd(
.A(Result), 
.B(data_o_map), ///salida del memory map 
.C(PC),
.D(Imm),
.Sel(MemToReg),
.s(WD3_Out)
);
///////////////////////////////////////////////////////////////////////
//Register File Module declaration.
///////////////////////////////////////////////////////////////////////
RegisterFile RegFile(
.clk(clk_O),
.rst(rst),
.we3(RegWrite),
.A1(Instr_out[19:15]),
.A2(Instr_out[24:20]),
.A3(Instr_out[11:7]),
.wd3(WD3_Out),
.rd1(Data_A),
.rd2(rd2)
); 

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Sing Extend and Zero Extend Module declaration.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
imm GenImm(
  .Datain(Instr_out[31:7]),
  .Ins_type(Ins_type),
  .Imm(Imm),
  .Doutm4(ImmM4)
);

Mux_2to1 #(.InLength(32))src_B(
.A(rd2), 
.B(Imm),
.Sel(),  ///selector de la nueva control unit
.s(Data_B)
);


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//ALU Module declaration.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
ALU ALU_Block(
//Inputs
.A(Data_A),
.B(Data_B),
.control(ALUcontrol),
//Outputs
.zeroflag(zeroflag),
.negativeflag(),
.Result(Result)
);


////////////////////////////////////////////////////////
//mUX 2:1 FOR DATA OR PC
////////////////////////////////////////////////////////
Control_unit_riscv cu_riscV(
//inputs
.clk(clk_O),
.rst(rst),
.en(en),
.mod(Instr_out[30]),
.opcode(Instr_out[6:0]),
.funct3(Instr_out[14:12]),
.funct7(Instr_out[31:25]),

//outputs
.IorD(IorD), .MemWrite(MemWrite), .IRWrite(IRWrite), .RegWrite(RegWrite), .PCSrc(PCSrc), .PCWrite(PCWrite), .bbeq(bbeq), .bbne(bbne), .ALUOutEn(ALU_Out_en),
.MemToReg(MemToReg),
.ALUSrcB1(ALUSrcB1), 
.ALUSrcA1(ALUSrcA1),
.ALUcontrol(ALUcontrol),
.Ins_type(Ins_type)
);

endmodule