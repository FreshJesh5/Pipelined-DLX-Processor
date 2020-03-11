//Top level alu module, which performs all the DLX instruction set operations. Its inputs are two 32
//bit values and a func code which tells it which operation to perform. Then its outputs are the 32 bit result from 
//the operation, a carry out bit and an overflow detection bit which are only relevant when the operation is an adder one
module alu32(
    input wire clk,
    input wire[31:0] d1,
    input wire[31:0] d2,
    input wire[5:0] func,
    output reg [31:0] s,
    output reg cout,
    output reg ovf,
    output reg zero_detect
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
       //assign zero_detect_im1 = s[16:31] or s[0:15]
       //assign zero_detect_im2 = 
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
		    endcase
		end
		
endmodule

 
