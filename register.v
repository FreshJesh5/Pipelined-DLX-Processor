module register158(clk, rst, in, out);
	input clk, rst;
	input  [157:0] in;
	output [157:0] out;
	
	reg [157:0] r;
	
	always @(posedge clk) begin
		if (rst)
			r <= 0;
		else
			r <= in;
	end
	
	assign out = r;
	
endmodule

module register146(clk, rst, in, out);
	input clk, rst;
	input  [145:0] in;
	output [145:0] out;
	
	reg [145:0] r;
	
	always @(posedge clk) begin
		if (rst)
			r <= 0;
		else
			r <= in;
	end
	
	assign out = r;
	
endmodule

module register71(clk, rst, in, out);
	input clk, rst;
	input  [70:0] in;
	output [70:0] out;
	
	reg [70:0] r;
	
	always @(posedge clk) begin
		if (rst)
			r <= 0;
		else
			r <= in;
	end
	
	assign out = r;
	
endmodule

module register(clk, rst, in, out);
   parameter WIDTH = 32;
	input clk, rst;
	input  [WIDTH - 1:0] in;
	output [WIDTH - 1:0] out;
	
	reg [WIDTH - 1:0] r;
	
	always @(posedge clk) begin
		if (rst)
			r <= 0;
		else
			r <= in;
	end
	
	assign out = r;
	
endmodule