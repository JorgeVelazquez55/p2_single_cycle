//////////////////////////////////////////////////////////////////////////////////
// Company: ITESO
// Engineer: Edgar Fabricio Barba Flores & Jorge Velazquez Maldonado
//  
// Module Name: ALU
// Module description: 
// This module ALU is capable of proccess 10 logic and arithmetic functions as 
// follows:
//	  4'b0000:Result= suma = A+B;    
//	  4'b1000:Result= resta = A-B;   
//	  4'b0111:Result= Land = A&B;  
//	  4'b0110:Result= Lor = A|B;   
//	  4'b0100:Result= Sleft = UnnA<<UnnB;  
//	  4'b0001:Result= Sright = UnnA>>UnnB; 
//	  4'b0101:Result= SrightU = A>>>B; 
//	  4'b1101:Result= Lxor = A^B; 
//	  4'b0010:Result= SetLess = (A<B)?1:0; 
//	  4'b0011:Result= SetLessU = (UnnA<UnnB)?1:0; 
//	  4'b1100:Result= A*B;
// 
// This module receives 3 inputs (two operands and one control) and outputs one 
// Result and two output flags (negative and zero).
// 
//////////////////////////////////////////////////////////////////////////////////

module ALU #(parameter LENGTH = 32)(
//Inputs
 input signed [LENGTH-1:0] A,
 input signed [LENGTH-1:0] B,
 input [3:0] control,
//Outputs
 output zeroflag,
 output negativeflag,
 output reg signed [LENGTH-1:0] Result
);

wire [LENGTH-1:0] Suma, Resta,Land,Lor,Lxor,Sleft,Sright,SrightU,SetLess,SetLessU,Multi;
wire unsigned [LENGTH-1:0] UnnA, UnnB;
//wire co;

assign UnnA = A;
assign UnnB = B;

//Set All the ALU logic into wires outside the Always statement.
assign Suma = A+B;     //Current assignment for sum of two signed numbers (a, b)
assign Resta = A-B;     //Current assignment for rest of two signed numbers (a, b)
assign Land = A&B; //Assigment for a logical AND operation of two numbers (a, b)
assign Lor = A|B;  //Assigment for a logical OR operation of two numbers (a, b)
assign Sleft = UnnA<<UnnB; //Assigment logic for shift rigth of data (a) according with (B) data
assign Sright = UnnA>>UnnB;
assign SrightU = A>>>B;
assign Lxor = A^B;
assign SetLess = (A<B)?1:0;
assign SetLessU = (UnnA<UnnB)?1:0;
assign Multi = A*B;

//Always to Mux the output.
always @ * begin
   //Case sentence for Muxing the output.
	case (control)
	  4'b0000:Result= Suma;
	  4'b1000:Result= Resta;
	  4'b0111:Result= Land;
	  4'b0110:Result= Lor;
	  4'b0100:Result= Lxor;
	  4'b0001:Result= Sleft;
	  4'b0101:Result= Sright;
	  4'b1101:Result= SrightU;
	  4'b0010:Result= SetLess;
	  4'b0011:Result= SetLessU;
	  4'b1100:Result= Multi;
	  default:Result= {LENGTH{1'b0}};
	endcase
end

assign zeroflag = (Result == {LENGTH{1'b0}})?1'b1:1'b0;	//Define the Zero Flag to be the 1 if the Result is 0.
assign negativeflag = Result[LENGTH-1];		//Define the Negative flag to be 1 if the MSB of Result is 1.
endmodule