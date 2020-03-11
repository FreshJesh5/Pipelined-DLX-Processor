//Top Module to create our 32-bit adder This module is created using 8 4-bit
//carry lookahead adders.
module cla32( d1,d2,cin,s,cout, ovf); //32 bit CLA using 8 4-bit CLA adderes
    input [31:0] d1;
    input [31:0] d2;
    input cin;
    output cout;
    output [31:0] s;
    output ovf;
    //Note the clock input does nothing in this module
    wire c0,c1,c2,c3,c4,c5,c6;
    wire ovf1,ovf2,ovf3,ovf4,ovf5,ovf6,ovf7,ovf8;
    //We just call our cla4 module 8 times, which gives us a total of 32 bits
    //more efficiently than a ripple carry adder
    cla4 n1(d1[3:0],d2[3:0],cin,s[3:0],c0, ovf1);
    cla4 n2(d1[7:4],d2[7:4],c0,s[7:4],c1, ovf2);
    cla4 n3(d1[11:8],d2[11:8],c1,s[11:8],c2, ovf3);
    cla4 n4(d1[15:12],d2[15:12],c2,s[15:12],c3, ovf4);
    cla4 n5(d1[19:16],d2[19:16],c3,s[19:16],c4, ovf5);
    cla4 n6(d1[23:20],d2[23:20],c4,s[23:20],c5, ovf6);
    cla4 n7(d1[27:24],d2[27:24],c5,s[27:24],c6, ovf7);
    cla4 n8(d1[31:28],d2[31:28],c6,s[31:28],cout, ovf8);
    //overflow detection
    assign ovf = ovf8;
endmodule

//This module is our base module we will use to construct the 32-bit
//carry-lookahead adder
module cla4(
    input [3:0] A,B,
    input Cin,
    output [3:0] S,
    output Cout,
    output ovf
    );
    wire [3:0] G,P,C;
 
    //Create the Generate bits and propogate bits
    assign G = A & B; //Generate
    assign P = A ^ B; //Propagate
    //Formulae to calculate each carry-in 
    assign C[0] = Cin;
    assign C[1] = G[0] | (P[0] & C[0]);
    assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & C[0]);
    assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & C[0]);
    assign Cout = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) |(P[3] & P[2] & P[1] & P[0] & C[0]);
    //Finally, to calculate the sum we simply use an xor
    assign S = P ^ C;
    assign ovf = C[3] ^ Cout; 
endmodule
