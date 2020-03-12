// SRAM module to store data and instructions
// Author: Jiashuo Zhang
// Data: 5/1/2016
module SRAM(clk, address, data, we, re);
	input [10:0] address;
	input  		 we, re;
	input  		 clk;
	inout [15:0] data;
	
	reg	 [15:0] mem [2047:0];
	
	initial
	begin
		$readmemh("dataSet.dat", mem);
	end
	assign data = re & !we ? mem[address] : 16'hzzzz; // Read re = 1
	always @(posedge clk) begin
		if (!re & we) begin			//write  we = 1
			mem[address] <= data;	//data as input
		end
	end
	
endmodule