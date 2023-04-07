//////////////////////////////////////////////////////////////////////////////////
// Company: ITESO
// Engineer: Edgar Fabricio Barba Flores & Jorge Velazquez Maldonado
//  
// Module Name: ALU
// Module description: 
// This module ALU is capable of proccess 10 logic and arithmetic functions as 
// follows:
// Function 010b: Arithmetic signed sum.
// Function 110b: Arithmetic signed substraction.
// Function 000b: Logic AND.
// Function 001b: Logic OR.
// Function 011b: Shift Right.
// 
// This module receives 3 inputs (two operands and one control) and outputs one 
// Result and two output flags (negative and zero).
// 
//////////////////////////////////////////////////////////////////////////////////

module ALU #(parameter LENGTH = 32)(
//Inputs
 input signed [LENGTH-1:0] A,
 input signed [LENGTH-1:0] B,
 input [4:0] control,
//Outputs
 output zeroflag,
 output negativeflag,
 output reg signed [LENGTH-1:0] Result
);

wire [LENGTH-1:0] suma,resta,Land,Lor,Lxor,Sleft,Sright,SrightU,SetLess,SetLessU, Mul;
wire unsigned [LENGTH-1:0] UA, UB;
//wire co;

assign UA = A;
assign UB = B;

//Set All the ALU logic into wires outside the Always statement.
assign suma = A+B;     //Current assignment for sum of two signed numbers (a, b)
assign resta = A-B;     //Current assignment for rest of two signed numbers (a, b)
assign Land = A&B; //Assigment for a logical AND operation of two numbers (a, b)
assign Lor = A|B;  //Assigment for a logical OR operation of two numbers (a, b)
assign Sleft = A<<({27'b0,UB[4:0]}); //Assigment logic for shift rigth of data (a) according with (B) data
assign Sright = A>>({27'b0,UB[4:0]});
assign SrightU = UA>>>({27'b0,UB[4:0]});
assign Lxor = A^B;
assign SetLess = (A<B)?1:0;
assign SetLessU = (UA<UB)?1:0;
assign Mul = A*B;

//Always to Mux the output.
always @ * begin
   //Case sentence for Muxing the output.
	case (control)
	  5'b00000:Result= suma;
	  5'b01000:Result= resta;
	  5'b00111:Result= Land; 
	  5'b00110:Result= Lor;
	  5'b00100:Result= Lxor;
	  5'b00001:Result= Sleft;
	  5'b00101:Result= Sright;
	  5'b01101:Result= SrightU;
	  5'b00010:Result= SetLess;
	  5'b00011:Result= SetLessU;
	  5'b10000:Result= Mul;	 
	  default:Result= {LENGTH{1'b0}};
	endcase
end

assign zeroflag = (Result == {LENGTH{1'b0}})?1'b1:1'b0;	//Define the Zero Flag to be the 1 if the Result is 0.
assign negativeflag = Result[LENGTH-1];		//Define the Negative flag to be 1 if the MSB of Result is 1.
endmodule