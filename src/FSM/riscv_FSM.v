`timescale 1ns / 1ps
module riscv_FSM (
		input clk,
		input rst,
		input en,
		input [2:0] funct3,
		input [6:0] opcode,
		output reg 	IorD, MemWrite, IRWrite, PCSrc, PCWrite, RegWrite, ALU_en, bbeq,bbne, i_ex_ac,
		output reg[1:0] ALUSrcA1, ALUSrcB1, MemToReg, ALUop
);



localparam FETCH			= 4'b0000;  //0
localparam DECODE			= 4'b0001;  //1
localparam MEM_ADDR		= 4'b0010;  //2
localparam MEM_READ		= 4'b0011;  //3
localparam MEM_WR_BACK	= 4'b0100;  //4
localparam MEM_WRITE		= 4'b0101;  //5
localparam EXECUTE		= 4'b0110;  //6
localparam ALU_WR_BACK	= 4'b0111;  //7
localparam I_EXECUTE	   = 4'b1000;  //8
localparam BRANCH	   	= 4'b1001;  //9
localparam JAL_R			= 4'b1010;  //A
localparam JALR			= 4'b1011;	//B
localparam IMM_WR_BACK  = 4'b1100;  //C
localparam HALT			= 4'b1111;	//F


reg [3:0] Instr_state;
//reg [2:0] InstType;

always @(posedge rst, posedge clk)
	begin
		if (rst)
			if (~en)
				Instr_state<= HALT;
			else 
				Instr_state<= Instr_state;
		else
		case (Instr_state)
				HALT: 		Instr_state <= FETCH;
				FETCH: 		Instr_state <= DECODE;
				DECODE:	
					if(opcode[1:0] != 2'b11)
						Instr_state<= HALT;
					else begin
						if (opcode[6:0]==7'b0110011) //instruction type R
							Instr_state <= EXECUTE;
						else if (opcode[6:0]==7'b0010011)//instruction type I
							Instr_state <= I_EXECUTE;
						else if (opcode[6:0]==7'b0000011 || opcode[6:0]==7'b0100011) //instruction type I load and S store
							Instr_state <= MEM_ADDR;
						else if (opcode[6:0]==7'b1100011) //instruction type B
							Instr_state <= BRANCH;
						else if (opcode[6:0]==7'b1101111||opcode[6:0]==7'b1100111) //instruction type jal y jalr
							Instr_state <= JAL_R;
						else if (opcode[6:0]==7'b0110111 || opcode[6:0]==7'b0010111) //instruction type U
							Instr_state <= IMM_WR_BACK;
					end
/////////Type R ///////states//////////////////
					EXECUTE:    
					Instr_state <= ALU_WR_BACK;

//////////////////////////////////////////////	
/////////Type I ///////states//////////////////
			   I_EXECUTE:  
					Instr_state <= ALU_WR_BACK;	
				ALU_WR_BACK:
					Instr_state <= FETCH;
/////////Type I load, store ///////states//////////////////					
				MEM_ADDR:	
					if (opcode[6:0]==7'b0000011)
						Instr_state <= MEM_READ;
					else if (opcode[6:0]==7'b0100011)
						Instr_state <= MEM_WRITE;
				MEM_READ:	
					Instr_state <= MEM_WR_BACK;
				MEM_WR_BACK:
					Instr_state <= FETCH;
				MEM_WRITE:
					Instr_state <= FETCH;
///////////////////////////////////////////////////////
//////////////Type B state/////////////////////////////
			   BRANCH:  
					Instr_state <= FETCH;
//////////////////////////////////////////////
			   JAL_R:  
					Instr_state <= FETCH;
//////////////////////////////////////////////
			   IMM_WR_BACK:  
					Instr_state <= FETCH;
				HALT:
					Instr_state <= HALT;
				default:
					Instr_state <= HALT;
		endcase
	end
	
// OUTPUT DEFINITION
always @*
	begin
				case(Instr_state)
				FETCH:
					begin
						PCWrite = 1'b1;		//FETCH signal.
						bbeq = 1'b0;			//No FETCH signal.
						bbne = 1'b0;			//No FETCH signal.
						IorD = 1'b0;			//FETCH signal.
						MemWrite = 1'b0;		//No FETCH signal.
						IRWrite = 1'b1;		//FETCH signal.
						MemToReg = 2'b00;		//No FETCH signal.
						RegWrite = 1'b0;		//No FETCH signal.
						ALUSrcA1 = 2'b01;		//PC_data
						ALUSrcB1 = 2'b01;		//+4H
						PCSrc = 1'b0;			//FETCH signal.
						ALUop = 2'b00;			//FETCH signal.
						ALU_en = 1'b0;			//No FETCH signal.
						i_ex_ac = 1'b0;		
					end		
				DECODE:
					begin
						PCWrite = 1'b0;		//DECODE signal.
						bbeq = 1'b0;			//No DECODE signal.
						bbne = 1'b0;			//No DECODE signal.
						IorD = 1'b0;			//No DECODE signal.
						MemWrite = 1'b0;		//No DECODE signal.
						IRWrite = 1'b0;		//No DECODE signal.
						MemToReg = 2'b00;		//No DECODE signal.
						RegWrite = 1'b0;		//No DECODE signal.
						ALUSrcA1 = 2'b10;   	//DECODE signal.
						ALUSrcB1 = 2'b10;		//DECODE signal. /////////////////
						PCSrc = 1'b0;			//No DECODE signal.				
						ALUop = 2'b00;			//DECODE signal.
						ALU_en = 1'b1;			//DECODE signal.
						i_ex_ac = 1'b0;	
					end
				EXECUTE:
					begin
						PCWrite = 1'b0;		//EXECUTE signal.
						bbeq = 1'b0;			//No EXECUTE signal.
						bbne = 1'b0;			//No EXECUTE signal.
						IorD = 1'b1;			//No EXECUTE signal.
						MemWrite = 1'b0;		//No EXECUTE signal.
						IRWrite = 1'b0;		//No EXECUTE signal.
						MemToReg = 2'b00;		//No EXECUTE signal.
						RegWrite = 1'b0;		//No EXECUTE signal.
						ALUSrcA1 = 2'b00;		//EXECUTE signal.	
						ALUSrcB1 = 2'b00;		//EXECUTE signal.
						PCSrc = 1'b0;			//				
						ALUop = 2'b10;			//EXECUTE signal.
						ALU_en = 1'b1;			//EXECUTE signal.
						i_ex_ac = 1'b0;	
					end
				ALU_WR_BACK:
					begin
						PCWrite = 1'b0;		//ALU_WR_BACK signal.
						bbeq = 1'b0;			//No ALU_WR_BACK signal.
						bbne = 1'b0;			//No ALU_WR_BACK signal.
						IorD = 1'b1;			//No ALU_WR_BACK signal.
						MemWrite = 1'b0;		//No ALU_WR_BACK signal.
						IRWrite = 1'b0;		//No ALU_WR_BACK signal.
						MemToReg = 2'b00;		//Signal from ALU_O
						RegWrite = 1'b1;		//Write register
						ALUSrcA1 = 2'b00;		//No ALU_WR_BACK signal.	
						ALUSrcB1 = 2'b00;		//No ALU_WR_BACK signal.
						PCSrc = 1'b0;			//No ALU_WR_BACK signal.				
						ALUop = 2'b10;			//No ALU_WR_BACK signal.
						ALU_en = 1'b0;			//No ALU_WR_BACK signal.
						i_ex_ac = 1'b0;	
					end					
				MEM_ADDR:
					begin
						PCWrite = 1'b0;		//MEM_ADDR signal.
						bbeq = 1'b0;			//No MEM_ADDR signal.
						bbne = 1'b0;			//No MEM_ADDR signal.
						IorD = 1'b0;			//No MEM_ADDR signal.
						MemWrite = 1'b0;		//No MEM_ADDR signal.
						IRWrite = 1'b0;		//No MEM_ADDR signal.
						MemToReg = 2'b00;		//No MEM_ADDR signal.
						RegWrite = 1'b0;		//No MEM_ADDR signal.
						ALUSrcA1 = 2'b00;		//registers to add
						ALUSrcB1 = 2'b10;		//Immediate
						PCSrc = 1'b0;			//No MEM_ADDR signal.				
						ALUop = 2'b00;			//Sum 
						ALU_en = 1'b1;			//MEM_ADDR signal.
						i_ex_ac = 1'b0;	
					end				
				MEM_READ:
					begin
						PCWrite = 1'b0;		//MEM_READ signal.
						bbeq = 1'b0;			//No MEM_READ signal.
						bbne = 1'b0;			//No MEM_READ signal.
						IorD = 1'b1;			//MEM_READ signal.
						MemWrite = 1'b0;		//No MEM_READ signal.
						IRWrite = 1'b0;		//No MEM_READ signal.
						MemToReg = 2'b00;		//No MEM_READ signal.
						RegWrite = 1'b0;		//No MEM_READ signal.
						ALUSrcA1 = 2'b00;		//No MEM_READ signal.   
						ALUSrcB1 = 2'b10;		//No MEM_READ signal.	
						PCSrc = 1'b0;			//No MEM_READ signal.		
						ALUop = 2'b00;			//No MEM_READ signal.
						ALU_en = 1'b0;			//No MEM_READ signal.
						i_ex_ac = 1'b0;			
					end				
				MEM_WR_BACK:
					begin
						PCWrite = 1'b0;		//MEM_WR_BACK signal.
						bbeq = 1'b0;			//No MEM_WR_BACK signal.
						bbne = 1'b0;			//No MEM_WR_BACK signal.
						IorD = 1'b1;			//NO MEM_WR_BACK signal.
						MemWrite = 1'b0;		//No MEM_WR_BACK signal.
						IRWrite = 1'b0;		//NO MEM_WR_BACK signal.
						MemToReg = 2'b01;		//MEM_WR_BACK signal.
						RegWrite = 1'b1;		//MEM_WR_BACK signal.
						ALUSrcA1 = 2'b00;		//NO MEM_WR_BACK signal.
						ALUSrcB1 = 2'b01;		//NO MEM_WR_BACK signal.
						PCSrc = 1'b0;			//NO MEM_WR_BACK signal.					
						ALUop = 2'b00;			//NO MEM_WR_BACK signal.
						ALU_en = 1'b0;			//NO MEM_WR_BACK signal.
						i_ex_ac = 1'b0;		
					end				
				MEM_WRITE:
					begin
						PCWrite = 1'b0;		//MEM_WRITE signal.
						bbeq = 1'b0;			//No MEM_WRITE signal.
						bbne = 1'b0;			//No MEM_WRITE signal.
						IorD = 1'b1;			//MEM_WRITE signal.
						MemWrite = 1'b1;		//MEM_WRITE signal.
						IRWrite = 1'b0;		//No MEM_WRITE signal.
						MemToReg = 2'b00;		//No MEM_WRITE signal.
						RegWrite = 1'b0;		//No MEM_WRITE signal.
						ALUSrcA1 = 2'b10;   	//No MEM_WRITE signal.
						ALUSrcB1 = 2'b10;		//No MEM_WRITE signal.
						PCSrc = 1'b0;			//No MEM_WRITE signal.			
						ALUop = 2'b00;			//No MEM_WRITE signal.
						ALU_en = 1'b0;			//No MEM_WRITE signal.
						i_ex_ac = 1'b0;			
					end				
			
				
				I_EXECUTE:
					begin
						PCWrite = 1'b0;		//I_EXECUTE signal.
						bbeq = 1'b0;			//No I_EXECUTE signal.
						bbne = 1'b0;			//No I_EXECUTE signal.
						IorD = 1'b1;			//No I_EXECUTE signal.
						MemWrite = 1'b0;		//I_EXECUTE signal.
						IRWrite = 1'b0;		//I_EXECUTE signal.
						MemToReg = 2'b00;		//No I_EXECUTE signal.
						RegWrite = 1'b0;		//No I_EXECUTE signal.
						ALUSrcA1 = 2'b00;		//I_EXECUTE signal.	
						ALUSrcB1 = 2'b10;		//I_EXECUTE signal.
						PCSrc = 1'b0;			//No I_EXECUTE signal.			
						ALUop = 2'b10;			//I_EXECUTE signal.
						ALU_en = 1'b1;			//I_EXECUTE signal.
						i_ex_ac = 1'b1;	
					end					
				BRANCH:
					begin
						PCWrite = 1'b0;		//BRANCH signal.
						if  (funct3 == 3'b000)
							begin
								bbeq = 1'b1;	//BRANCH signal.
								bbne = 1'b0;	//BRANCH signal.
							end
						else if  (funct3 == 3'b001)
							begin
								bbeq = 1'b0;	//BRANCH signal.
								bbne = 1'b1;	//BRANCH signal.
							end
						else 
							begin
								bbeq = 1'b0;	//BRANCH signal.
								bbne = 1'b0;	//BRANCH signal.
							end
						IorD = 1'b0;			//No BRANCH signal.
						MemWrite = 1'b0;		//BRANCH signal.
						IRWrite = 1'b0;		//BRANCH signal.
						MemToReg = 2'b00;		//No BRANCH signal.
						RegWrite = 1'b0;		//BRANCH signal.
						ALUSrcA1 = 2'b00;		//BRANCH signal.	
						ALUSrcB1 = 2'b00;		//BRANCH signal.
						PCSrc = 1'b1;			//BRANCH signal.			
						ALUop = 2'b01;			//BRANCH signal.
						ALU_en = 1'b1;			//BRANCH signal.
						i_ex_ac = 1'b0;	
					end				
				JAL_R:
					begin
						PCWrite = 1'b1;		//PC_SAVE signal.
						bbeq = 1'b0;			//No PC_SAVE signal.
						bbne = 1'b0;			//No PC_SAVE signal.
						IorD = 1'b0;			//No PC_SAVE signal.
						MemWrite = 1'b0;		//No PC_SAVE signal.
						IRWrite = 1'b0;		//PC_SAVE signal.
						MemToReg = 2'b10;		//PC_SAVE signal.
						RegWrite = 1'b1;		//PC_SAVE signal.
						ALUSrcA1 = 2'b00;		//PC_SAVE signal.	
						ALUSrcB1 = 2'b10;		//PC_SAVE signal.
						if (opcode[6:0]==7'b1101111) //JAL operation
							PCSrc = 1'b1;		//PC_SAVE signal.	
						else
							PCSrc = 1'b0;		//PC_SAVE signal.								
						ALUop = 2'b00;			//PC_SAVE signal.
						ALU_en = 1'b0;			//PC_SAVE signal.
						i_ex_ac = 1'b0;	
					end
				IMM_WR_BACK:
					begin
						PCWrite = 1'b0;		//IMM_WR_BACK signal.
						bbeq = 1'b0;			//No IMM_WR_BACK signal.
						bbne = 1'b0;			//No IMM_WR_BACK signal.
						IorD = 1'b0;			//No IMM_WR_BACK signal.
						MemWrite = 1'b0;		//IMM_WR_BACK signal.
						IRWrite = 1'b0;		//IMM_WR_BACK signal.
						if (opcode[6:2]==7'b01101)
							MemToReg = 2'b11;		//IMM_WR_BACK signal.
						else 
							MemToReg = 2'b00;		//IMM_WR_BACK signal.
						RegWrite = 1'b1;		//IMM_WR_BACK signal.
						ALUSrcA1 = 2'b00;		//No IMM_WR_BACK signal.	
						ALUSrcB1 = 2'b10;		//NO IMM_WR_BACK signal.
						PCSrc = 1'b0;			//No IMM_WR_BACK signal.			
						ALUop = 2'b00;			//No IMM_WR_BACK signal.
						ALU_en = 1'b0;			//No IMM_WR_BACK signal.
						i_ex_ac = 1'b0;	
					end
            HALT:	
					begin
						PCWrite = 1'b0;
						bbeq = 1'b0;
						bbne = 1'b0;
						IorD = 1'b0;
						MemWrite = 1'b0;
						IRWrite = 1'b0;
						MemToReg = 2'b00;
						RegWrite = 1'b0;
						ALUSrcA1 = 2'b00;
						ALUSrcB1 = 2'b00;
						PCSrc = 1'b0;						
						ALUop = 2'b00;
						ALU_en = 1'b0;
						i_ex_ac = 1'b0;	
					end				
				default:
					begin
						PCWrite = 1'b0;
						bbeq = 1'b0;
						bbne = 1'b0;
						IorD = 1'b0;
						MemWrite = 1'b0;
						IRWrite = 1'b0;
						MemToReg = 2'b00;
						RegWrite = 1'b0;
						ALUSrcA1 = 2'b00;
						ALUSrcB1 = 2'b00;
						PCSrc = 1'b0;						
						ALUop = 2'b00;
						ALU_en = 1'b0;
						i_ex_ac = 1'b0;	
					end
			endcase
	end
endmodule