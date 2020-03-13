// 8 to 1 mux
module mux8_1 (d, sel, out); 
	output out;
	input [7:0] d;
	input [2:0] sel;
	assign out = (~sel[2] & ~sel[1] & ~sel[0] & d[0])
				  | (~sel[2] & ~sel[1] &  sel[0] & d[1])
				  | (~sel[2] &  sel[1] & ~sel[0] & d[2])
				  | (~sel[2] &  sel[1] &  sel[0] & d[3])
				  | ( sel[2] & ~sel[1] & ~sel[0] & d[4])
				  | ( sel[2] & ~sel[1] &  sel[0] & d[5])
				  | ( sel[2] &  sel[1] & ~sel[0] & d[6])
				  | ( sel[2] &  sel[1] &  sel[0] & d[7]);
endmodule


// A 32 to 1 mux in gate level
module mux32_1(out, sel, d);
	input  [4:0]  sel;
	input  [31:0] d;
	output out;
	wire   [7:0]  x;
	wire   [3:0]  y;
	genvar i, j;
	generate
		for (i=0; i<8; i=i+1) begin: test0
			mux4_1 m1 (x[i], sel[1], sel[0], d[4*i], d[4*i+1], d[4*i+2], d[4*i+3]);
		end
		for (j=0; j<4; j=j+1) begin: test1
			mux2_1 m2 (y[j], sel[2], x[2*j], x[2*j+1]);
		end
	endgenerate
	mux4_1 m3 (out, sel[4], sel[3], y[0], y[1], y[2], y[3]);
endmodule

// A 4 to 1 mux in gate level
module mux4_1(out, sel1, sel0, d0, d1, d2, d3);
	output out;
	input  sel1, sel0;
	input  d0, d1, d2, d3;
	
	wire sel1Bar, sel0Bar;
	
	not (sel1Bar, sel1);
	not (sel0Bar, sel0);
	
	wire out0, out1, out2, out3;
	
	and (out0, d0, sel1Bar, sel0Bar);
	and (out1, d1, sel1Bar, sel0   );
	and (out2, d2, sel1   , sel0Bar);
	and (out3, d3, sel1   , sel0   );
	
	or  (out, out0, out1, out2, out3);
endmodule

// A 2 to 1 mux in gate level
module mux2_1(out, sel, d0, d1);
	output out;
	input  sel;
	input  d0, d1;
	
	wire selBar;
	not (selBar, sel);
	
	wire out0, out1;
	
	and (out0, d0, selBar);
	and (out1, d1, sel);
	or  (out, out0, out1);
endmodule