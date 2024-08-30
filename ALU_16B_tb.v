`timescale 1us/1ns

module ALU_16B_tb();

	reg   [15:0] A_tb,B_tb;
	reg		     CLK_tb;
	reg   [3:0]  ALU_FUN_tb;
	wire  [15:0] ALU_OUT_tb;
	wire	     Carry_Flag_tb, Arith_Flag_tb, Logic_Flag_tb, CMP_Flag_tb, Shift_Flag_tb;

ALU_16B DUT
(.A (A_tb),
 .B (B_tb),
 .CLK (CLK_tb),
 .ALU_FUN (ALU_FUN_tb),
 .ALU_OUT (ALU_OUT_tb),
 .Carry_Flag (Carry_Flag_tb),
 .Arith_Flag (Arith_Flag_tb),
 .Logic_Flag (Logic_Flag_tb),
 .CMP_Flag (CMP_Flag_tb),
 .Shift_Flag (Shift_Flag_tb) );

always #5 CLK_tb =~ CLK_tb;

initial
begin
    $dumpfile("ALU_16B.vcd");   
    $dumpvars;
	CLK_tb = 0;
	A_tb = 16'b1010111100001010;
	B_tb = 16'b1111001011001101;
	ALU_FUN_tb = 4'b0000;
	
	#10 //check addition
	if (ALU_OUT_tb == (16'b1010111100001010+16'b1111001011001101) & (Carry_Flag_tb == 1) & (Arith_Flag_tb == 1)) begin
		$display("Addition with carry succeded");
	end
	else begin
		$display("failed Addition");
	end
	ALU_FUN_tb = 4'b0010;
	A_tb = 16'b0011011010101001;
	B_tb = 16'b0000001101001010;
	
	#10 //check multiplication
	if (ALU_OUT_tb == (16'b0011011010101001*16'b0000001101001010) & (Arith_Flag_tb == 1)) begin
		$display("Multiplication succeded");
	end
	else begin
		$display("failed Multiplication");
	end
	ALU_FUN_tb = 4'b0100;
	A_tb = 16'b1100111011011011;
	B_tb = 16'b1001101111010111;

	#10 //check and logic
	if ((ALU_OUT_tb == (A_tb & B_tb)) & (Logic_Flag_tb == 1)) begin
		$display("And succeded");
	end
	else begin
		$display("And failed");
	end
	ALU_FUN_tb = 4'b0001;
	A_tb = 16'b1010111100001010;
	B_tb = 16'b1111001011001101;

	#10 //check subtraction
	if (ALU_OUT_tb == (16'b1010111100001010-16'b1111001011001101) & (Carry_Flag_tb == 1) & (Arith_Flag_tb == 1)) begin
		$display("Subtraction with borrow succeded");
	end
	else begin
		$display("failed Subtraction");
	end
	ALU_FUN_tb = 4'b0110;
	A_tb = 16'b1100111011011011;
	B_tb = 16'b1001101111010111;

	#10 //check nand logic
	if ((ALU_OUT_tb == (~(16'b1100111011011011&16'b1001101111010111))) & (Logic_Flag_tb == 1)) begin
		$display("Nand succeded");
	end
	else begin
		$display("Nand failed");
	end
	ALU_FUN_tb = 4'b0011;
	A_tb = 16'b1101111011011011;
	B_tb = 16'b1101101111010111;
	
	#10 //check division
	if ((ALU_OUT_tb == (16'b1101111011011011/16'b1101101111010111)) & (Arith_Flag_tb == 1)) begin
		$display("Division succeded");
	end
	else begin
		$display("failed Division");
	end
	ALU_FUN_tb = 4'b0101;
	A_tb = 16'b1100111011011011;
	B_tb = 16'b1001101111010111;

	#10 //check or logic
	if ((ALU_OUT_tb == (16'b1100111011011011|16'b1001101111010111)) & (Logic_Flag_tb == 1)) begin
		$display("or succeded");
	end
	else begin
		$display("or Failed");
	end
	ALU_FUN_tb = 4'b0111;

	#10 //check nor logic
	if ((ALU_OUT_tb == (~(16'b1100111011011011|16'b1001101111010111))) & (Logic_Flag_tb == 1)) begin
		$display("Nor succeded");
	end
	else begin
		$display("Nor Failed");
	end
	ALU_FUN_tb = 4'b1000;

	#10 //check xor logic
	if ((ALU_OUT_tb == (16'b1100111011011011^16'b1001101111010111)) & (Logic_Flag_tb == 1)) begin
		$display("Xor succeded");
	end
	else begin
		$display("Xor Failed");
	end
	ALU_FUN_tb = 4'b1001;

	#10 //check xnor logic
	if ((ALU_OUT_tb == (16'b1100111011011011~^16'b1001101111010111)) & (Logic_Flag_tb == 1)) begin
		$display("Xnor succeded");
	end
	else begin
		$display("Xnor Failed");
	end
	ALU_FUN_tb = 4'b1010;
	A_tb = 8;
	B_tb = 8;

	#10 //check compare with equal operands
	if ((ALU_OUT_tb == 1) & (CMP_Flag_tb == 1)) begin
		$display("equal compare succeded");
	end
	else begin
		$display("equal compare Failed");
	end
	A_tb = 26;

	#10 //check compare with non equal operands
	if ((ALU_OUT_tb == 0) & (CMP_Flag_tb == 1)) begin
		$display("equal compare ne succeded");
	end
	else begin
		$display("equal compare ne Failed");
	end
	ALU_FUN_tb = 4'b1011;

	#10 //check compare with true case operands
	if ((ALU_OUT_tb == 2) & (CMP_Flag_tb == 1)) begin
		$display("gt compare succeded");
	end
	else begin
		$display("gt compare Failed");
	end
	A_tb = 8;

	#10 //check compare with false case operands
	if ((ALU_OUT_tb == 0) & (CMP_Flag_tb == 1)) begin
		$display("gt compare ne succeded");
	end
	else begin
		$display("gt compare ne Failed");
	end
	ALU_FUN_tb = 4'b1100;
	A_tb = 5;

	#10 //check compare with true case operands
	if ((ALU_OUT_tb == 3) & (CMP_Flag_tb == 1)) begin
		$display("sm compare succeded");
	end
	else begin
		$display("sm compare Failed");
	end
	A_tb = 27;

	#10 //check compare with false case operands
	if ((ALU_OUT_tb == 0) & (CMP_Flag_tb == 1)) begin
		$display("sm compare ne succeded");
	end
	else begin
		$display("sm compare ne Failed");
	end
	ALU_FUN_tb = 4'b1101;
	A_tb = 16'b1110001101010100;

	#10 //check logical shift right
	if ((ALU_OUT_tb == 16'b0111000110101010) & (Shift_Flag_tb == 1)) begin
		$display("shift right succeded");
	end
	else begin
		$display("shift right Failed");
	end
	ALU_FUN_tb = 4'b1110;

	#10 //check logical shift left
	if ((ALU_OUT_tb == 16'b1100011010101000) & (Shift_Flag_tb == 1)) begin
		$display("shift left succeded");
	end
	else begin
		$display("shift left Failed");
	end
	ALU_FUN_tb = 4'b1111;

	#10 //check no operation case
	if (ALU_OUT_tb == 0) begin
		$display("NOP succeded");
	end
	else begin
		$display("NOP Failed");
	end

	#100

	$finish;
end

endmodule