// ALU module in dataflow level model
// Author: Jiashuo Zhang
// Data: 4/29/2016
module ALU_rtl(A, B, ctrl, shamt, out, Z, V, C, N);
	input  [31:0] A, B;
	input  [2:0]  ctrl; 
	input  [4:0] shamt;
	output [31:0] out;
	output Z, V, C, N; //Z-Zero, V-Overflow, C-Carryout, N-Negative
	
	wire [31:0] out0, out1, out2, out3, out4, out5, out6, out7; // Different operation lines
	wire carryAdd, carrySub;
	wire overflowSub; // Determine subtraction overflow
	
	assign out0 = 32'bz;
	// Add operation: Carry Lookahead Control Unit
	CLU cluAdd(.A(A), .B(B), .sum(out1), .C(carryAdd));
	// Sub operation
	CLU cluSub(.A(A), .B(~B + 1'b1), .sum(out2), .C(carrySub));
	
	assign out3 = A & B; // AND
	assign out4 = A | B; // OR
	assign out5 = A ^ B; // XOR
	assign out6 = A < B ? 32'b1 : 32'b0; // Set Less Than
	
	// Shift Left
	shifter shft(.A(A), .ctrl(shamt), .out(out7));
	// Pick Operation
	genvar i;
	generate
		for (i=0; i<=31; i=i+1) begin : pickOperation
			mux8_1 m8 ({out7[i], out6[i], out5[i], out4[i], out3[i], out2[i], out1[i], out0[i]}, ctrl, out[i]); end
	endgenerate
	
	assign overflowSub = ~A[31] & B[31] & out[31] | A[31] & ~B[31] & ~out[31]; // Check subtraction overflow
	assign Z = (out==32'b0) ? 1'b1 : 1'b0;							// Zero 
	assign V = ctrl==2 & overflowSub | ctrl==1 & A[31] & B[31] & ~out[31] | ctrl==1 & ~A[31] & ~B[31] & out[31];	// Overflow
	assign C = ctrl==2 & carrySub | ctrl==1 & carryAdd;		// Carry out
	assign N = out[31];													// Negative
endmodule

module alu(
    input wire[31:0] d1,
    input wire[31:0] d2,
    input wire[5:0] func,
    output reg [31:0] s,
    output reg zero_detect,
    output reg ovf,
    output reg cout,
    output N
    );
    wire [31:0] s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16;
    wire cout1,cout2,cout3,cout4;
    wire ovf1,ovf3;
    //compute all alu operations in parallel and then choose which value at the very end
    //also make sure to have the adder functions output the cout and overflow values, and
    //for all others, simply set them both equal to zero
    sll32 shift_l(d1,d2,s1);
    srl32 shift_rl(d1,d2,s2);
    sra32 shift_ra(d1,d2,s3);
    add32 adder(d1,d2,s4,cout1,ovf1);
    add32 add_uns(d1,d2,s5,cout2,ovf2);
    sub32 subt_32(d1,d2,s6,cout3,ovf3);
    sub32 subt_32u(d1,d2,s7,cout4,ovf4);
    and32 andfunc(d1,d2,s8);
    or32 orr(d1,d2,s9);
    xor32 xorfunc(d1,d2,s10);
    seq32 seqfunc(d1,d2,s11);
    sne32 snefunc(d1,d2,s12);
    slt32 sltfunc(d1,d2,s13);
    sgt32 sgtfunc(d1,d2,s14);
    sle32 slefunc(d1,d2,s15);
    sge32 sgefunc(d1,d2,s16);
    
    assign N = s[31];
    always @(s) begin    
    	 zero_detect = (s == 32'b0);
    end
    
    always @(*) begin
	     case(func) 
	       //shift logical left case
		    6'b000100: begin
		                s = s1; 
		                cout = 1'b0;
		                ovf = 1'b0;
		                end
		    //shift logical right case
		    6'b000110: begin
		                s = s2;
		                cout = 1'b0;
                      ovf = 1'b0;
                      end
          //shift arithmetic right case
		    6'b000111: begin
		                s = s3;
		                cout = 1'b0;
                      ovf = 1'b0;
                      end
          //add signed case
		    6'b100000: begin 
		                s = s4;
		                cout = cout1;
		                ovf = ovf1;
		                end
		    //add unsigned case
		    6'b100001: begin 
		                s = s5;
		                cout = cout2;
		                ovf = cout2;
		                end
		    //subtract case
		    6'b100010: begin
		                s = s6;
		                cout = cout3;
		                ovf = ovf3;
		                end
		    //subtract unsigned
		    6'b100011: begin
		                s = s7;
		                cout = cout4;
		                ovf = cout4;
		                end
		    //and case
		    6'b100100: begin
		                s = s8;
		                cout = 1'b0;
		                ovf = 1'b0;
		                end
           //or case
		    6'b100101: begin
		                s = s9;
		                cout = 1'b0;
		                ovf = 1'b0;
		                end
           //xor case
		    6'b100110: begin
		                s = s10;
		                cout = 1'b0;
		                ovf = 1'b0;
		                end
            //set equal to case
		    6'b101000: begin
		                s = s11;
		                cout = 1'b0;
		                ovf = 1'b0;
		                end
            //set not equal to case
		    6'b101001: begin
		                s = s12;
		                cout = 1'b0;
		                ovf = 1'b0;
		                end
            //set less than case
		    6'b101010: begin
		                s = s13;
		                cout = 1'b0;
		                ovf = 1'b0;
		                end
            //set greater than case
		    6'b101011: begin
		                s = s14;
		                cout = 1'b0;
		                ovf = 1'b0;
		                end
            //set less than eqqual to case
		    6'b101100: begin
		                s = s15;
		                cout = 1'b0;
		                ovf = 1'b0;
		                end
            //set greater than equal to case
		    6'b101101: begin
		                s = s16;
		                cout = 1'b0;
		                ovf = 1'b0;
		                end
		       //mult
		    6'b001110: begin
		                s = d1*d2;
		                cout = 1'b0;
		                ovf = 1'b0;
		               end
		    endcase
		end
		
endmodule