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