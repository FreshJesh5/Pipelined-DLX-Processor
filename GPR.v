module GPR(clk, rst, rs1, rs2, ws, we, 
			  wData, rData1, rData2);
	
	input  clk, we, rst;						// High true enable
	input  [4:0] rs1, rs2, ws;			// Read select 1, read select 2, and write select
	input  [31:0] wData;					// Write data in
	output [31:0] rData1, rData2;  // Read Data
	
	wire   [31:0] register_out [31:0];
	wire   [31:0] decode_out;
	wire   [31:0] reg_we;
	wire   [4:0]  re1, re2;
	
	Register r (.clk(clk), .rst(rst), .in(32'b0), .out(register_out[0]), .enable(reg_we[0]));  // Register 0 always output 0
	
	genvar i;
	generate
		for (i=1; i<32; i=i+1) begin: generateRegisters     // Write
			Register reg0 (.clk(clk), .rst(rst), .in(wData), .out(register_out[i]), .enable(reg_we[i]));  // Create 32x32 register by write operation
		end
	endgenerate
	
	Decoder5_32 d1 (.in(ws), .out(decode_out));    // Decode write address
	
	wire [31:0] muxOut1, muxOut2;

	genvar j;
		generate
		for (j=0; j<32; j = j+1) begin: filterDataOut   
			and (reg_we[j], decode_out[j], we);  // Write enable
			mux32_1 m31 (.out(rData1[j]), .sel(rs1), .d({register_out[31][j], register_out[30][j], register_out[29][j], register_out[28][j], register_out[27][j],
			register_out[26][j], register_out[25][j], register_out[24][j], register_out[23][j], register_out[22][j],
			register_out[21][j], register_out[20][j], register_out[19][j], register_out[18][j], register_out[17][j],
			register_out[16][j], register_out[15][j], register_out[14][j], register_out[13][j], register_out[12][j],
			register_out[11][j], register_out[10][j], register_out[9][j], register_out[8][j], register_out[7][j],
			register_out[6][j], register_out[5][j], register_out[4][j], register_out[3][j], register_out[2][j],
			register_out[1][j], register_out[0][j]}));  // Read 1 data
			mux32_1 m32 (.out(rData2[j]), .sel(rs2), .d({register_out[31][j], register_out[30][j], register_out[29][j], register_out[28][j], register_out[27][j],
			register_out[26][j], register_out[25][j], register_out[24][j], register_out[23][j], register_out[22][j],
			register_out[21][j], register_out[20][j], register_out[19][j], register_out[18][j], register_out[17][j],
			register_out[16][j], register_out[15][j], register_out[14][j], register_out[13][j], register_out[12][j],
			register_out[11][j], register_out[10][j], register_out[9][j], register_out[8][j], register_out[7][j],
			register_out[6][j], register_out[5][j], register_out[4][j], register_out[3][j], register_out[2][j],
			register_out[1][j], register_out[0][j]}));  // Read 2 data
		end
	endgenerate
endmodule

// A 32-bit register created by 32 DFlipFlops
module Register(clk, rst, in, out, enable);
	input 		  clk, rst;
	input  		  enable;
	input  [31:0] in;
	output [31:0] out;
	wire   [31:0] ns;
	wire   [31:0] out;
	
	// Generate 32 DFlipFlops
	genvar i;
	generate
		for (i=0; i<32; i=i+1) begin: test
			mux2_1 m (.out(ns[i]), .sel(enable), .d0(out[i]), .d1(in[i]));
			DFlipFlop dff0 (.q(out[i]), .D(ns[i]), .clk(clk), .rst(rst));
		end
	endgenerate
endmodule

// DFlipFlop module
module DFlipFlop(q, D, clk, rst);
	input D, clk, rst;
	output q;
	reg q;
	
	//not n1 (qBar, q);
	always@ (negedge clk)
		begin
			if(rst)
			q = 0;
		else
			q = D;
		end
endmodule

// 5 to 32 Decoder
module Decoder5_32 (in, out);
	input  [4:0]  in;
	output [31:0] out;
	wire   [3:0]  x;
	
	Decoder2_4 d0(.en(1'b1), .in(in[4:3]), .out(x));
	
	genvar i;
	generate
		for (i=0; i<4; i = i + 1) begin: test
			Decoder3_8 d1(.en(x[i]), .in(in[2:0]), .out(out[(8*i+7):(8*i)]));
		end
	endgenerate
endmodule

// 3 to 8 Decoder
module Decoder3_8(en, in, out);
	input 		 en;
	input  [2:0] in;
	output [7:0] out;
	
	wire inBar;
	wire [1:0] enable;
	
	
	not (inBar, in[2]);
	and (enable[0], inBar, en);
	and (enable[1], in[2], en);
	
	Decoder2_4 d0(.en(enable[0]), .in(in[1:0]), .out(out[3:0]));
	Decoder2_4 d1(.en(enable[1]), .in(in[1:0]), .out(out[7:4]));
endmodule

// 2 to 4 Decoder
module Decoder2_4(en, in, out);
	input  		 en;
	input  [1:0] in;
	output [3:0] out;
	
	wire [1:0] inBar;
	
	not (inBar[0], in[0]);
	not (inBar[1], in[1]);
	
	and (out[0], en, inBar[1], inBar[0]);
	and (out[1], en, inBar[1], in[0]	 );
	and (out[2], en, in[1]	, inBar[0]);
	and (out[3], en, in[1]	, in[0]	 );
endmodule