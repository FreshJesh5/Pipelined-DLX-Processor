module add32(
    input  [31:0] A,B,
    output [31:0] out,
    output cout,
    output ovf
    );
    cla32 n1(A,B,1'b0,out,cout,ovf);
endmodule

module sub32(
    input [31:0] A,B,
    output [31:0] out,
    output cout,
    output ovf
    );
    wire [31:0] B_neg;
    assign B_neg = -B;
    cla32 n1(A,B_neg,1'b0,out,cout,ovf);
endmodule

module and32(
    input [31:0] A,B,
    output [31:0] out
    );
    assign out = (A&B);
endmodule

module or32(
    input [31:0] A,B,
    output [31:0] out
    );
    assign out = (A|B);
endmodule

module xor32(
    input signed [31:0] A,B,
    output [31:0] out
    );
    assign out = (A^B);
endmodule

module seq32(
    input [31:0] A,B,
    output [31:0]out
    );
    assign out = (A==B);
endmodule

module sle32(
    input [31:0] A,B,
    output [31:0]out
    );
    assign out = (A<=B);
endmodule

module sge32(
    input [31:0] A,B,
    output [31:0]out
    );
    assign out = (A>=B);
endmodule

module sne32(
    input [31:0] A,B,
    output [31:0]out
    );
    assign out = (A!=B);
endmodule

module slt32(
    input signed [31:0] A,B,
    output [31:0]out
    );
    assign out = (A<B);
endmodule

module sgt32(
    input signed [31:0] A,B,
    output [31:0]out
    );
    assign out = (A>B);
endmodule

module sll32(
    input [31:0] A,B,
    output [31:0] out
    );
    assign out = (A<<B);
endmodule

module srl32(
    input [31:0] A,B,
    output [31:0] out
    );
    assign out = (A>>B);
endmodule

module sra32(
    input signed [31:0] A,B,
    output [31:0] out
    );
    assign out = ($signed(A)>>>B);
endmodule
