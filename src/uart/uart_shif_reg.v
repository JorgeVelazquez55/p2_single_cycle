module uart_shif_reg (
 input clk,
 input rst,
 input [31:0] flag_ini,
 input [31:0] tx_data,
 input flag_end,
 output reg [7:0]reg_tx_uart,
 output reg btn_send
// output [7:0] gpio_out
// input uart_rx,
// output uart_tx
);

localparam START		= 2'b00;
localparam SHIFT_8		= 2'b01;
localparam SEND			= 2'b10;
localparam END_SHIFT	= 2'b11;
//el registro de inicio deberia iniciar una cuenta revisandolo que sea igual a 1 
// junto con la bandera de fin, 
//despues revisar esa cuenta si esta en menor a 4 y mandar el datos y la bandera de inicio 
//hacer shift del registro.

reg [1:0]Tx_shift;
reg [1:0]cnt_pairs;
reg [31:0]shift_register;

//assign reg_tx_uart = [31:24]shift_register;

	always @(posedge rst, posedge clk)
		begin
			if (rst)begin 
				Tx_shift<= START;
				cnt_pairs <=2'b00;
				end
			
			else 
			case (Tx_shift)
					START: 		if (flag_ini == 8'h00000001)begin
									cnt_pairs <= 2'b00;
									shift_register = tx_data;
									reg_tx_uart = shift_register[31:24];
									Tx_shift <= SHIFT_8;
									end
									else 
									Tx_shift <= START;
									
					SHIFT_8:		if (flag_end == 1'b1 && cnt_pairs <= 2'b11)begin
									shift_register = shift_register<<8;
									
									reg_tx_uart = shift_register[31:24];
									Tx_shift <= SEND;
									end
									else 
									Tx_shift <= SHIFT_8;
					SEND:			if(cnt_pairs == 2'b11)begin
									Tx_shift <= END_SHIFT;
									end
									else begin 
									cnt_pairs <= cnt_pairs + 2'b01;
									Tx_shift <= SHIFT_8;
									end
					END_SHIFT:	Tx_shift <= START;
					default:		Tx_shift <= START;
			endcase
		end
		
always @*
	begin
				case(Tx_shift)
				START:if (flag_ini == 8'h00000001)
						btn_send = 1'b1;
						else 
						btn_send = 1'b0;
				SHIFT_8:btn_send = 1'b0;
				SEND:
					if (cnt_pairs < 2'b11)
						btn_send = 1'b1;
					else 
						btn_send = 1'b0;
				END_SHIFT:btn_send = 1'b0;
				default:		btn_send = 1'b0;
				endcase
	end
		
		  
endmodule