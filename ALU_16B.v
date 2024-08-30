module ALU_16B (
	input  wire [15:0] A,B,
	input  wire		   CLK,
	input  wire [3:0]  ALU_FUN,
	output reg  [15:0] ALU_OUT,
	output reg 		   Carry_Flag, Arith_Flag, Logic_Flag, CMP_Flag, Shift_Flag
	);
	
	reg Carry;

	reg [15:0] out;

	always @(posedge CLK) begin
		ALU_OUT <= out;
	end

	always @(*) begin
		if ((ALU_FUN == 4'b0000) | (ALU_FUN == 4'b0001)) begin
			Carry_Flag = Carry;
		end
		else begin
			Carry_Flag = 0;
		end
	end

	always @(*) begin
		if (ALU_FUN == 4'b0000 | ALU_FUN == 4'b0001 | ALU_FUN == 4'b0010 | ALU_FUN == 4'b0011) begin
			Arith_Flag = 1;			
		end
		else begin
			Arith_Flag = 0;
		end
	end

	always @(*) begin
		if (ALU_FUN == 4'b0100 | ALU_FUN == 4'b0101 | ALU_FUN == 4'b0110 | ALU_FUN == 4'b0111 | ALU_FUN == 4'b1000 | ALU_FUN == 4'b1001) begin
			Logic_Flag = 1;			
		end
		else begin
			Logic_Flag = 0;
		end
	end

	always @(*) begin
		if (ALU_FUN == 4'b1010 | ALU_FUN == 4'b1011 | ALU_FUN == 4'b1100) begin
			CMP_Flag = 1;			
		end
		else begin
			CMP_Flag = 0;
		end
	end

	always @(*) begin
		if (ALU_FUN == 4'b1101 | ALU_FUN == 4'b1110) begin
			Shift_Flag = 1;			
		end
		else begin
			Shift_Flag = 0;
		end
	end

	always @(*)
	begin
		case (ALU_FUN)
			4'b0000: {Carry,out} = A + B;
			4'b0001: {Carry,out} = A - B;
			4'b0010: out = A * B;
			4'b0011: out = A / B;
			4'b0100: out = A & B;
			4'b0101: out = A | B;
			4'b0110: out = ~(A & B);
			4'b0111: out = ~(A | B);
			4'b1000: out = A ^ B;
			4'b1001: out = ~(A ^ B);
			4'b1010: begin
						if (A == B)
						begin
							out <= 1;
						end
						else
						begin
							out = 0;
						end
					 end
			4'b1011: begin
						if (A > B)
						begin
							out = 2;
						end
						else
						begin
							out = 0;
						end
					 end
			4'b1100: begin
						if (A < B)
						begin
							out = 3;
						end
						else
						begin
							out = 0;
						end
					 end
			4'b1101: out = A >> 1;
			4'b1110: out = A << 1;
			default: out = 16'b0;
		endcase
	end

endmodule