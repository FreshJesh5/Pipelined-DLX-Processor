module IFID_reg(clk, rst, in, out, IFID_write, IFflush);
	input clk, rst, IFID_write, IFflush;
	input  [63:0] in;
	output [63:0] out;
	
	reg [63:0] r;
	
	always @(posedge clk) begin
		if (rst)
			r <= 0;
		// Flush
		else if (IFflush)
			r[31:0] <= 0;
		// Stall
		else if (!IFID_write)
			r <= 0;
		else
			r <= in;
	end
	
	assign out = r;
	
endmodule