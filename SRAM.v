module SRAM(clk, address, data, we, re);
	input [31:0] address;
	input  		 we, re;
	input  		 clk;
	inout [31:0] data;
	
	reg	 [31:0] mem [148:0];
	
	initial
	begin
		$readmemh("dataSet.dat", mem);
	end
	
	assign data = re & !we ? mem[address] : 32'hzzzz; // Read re = 1
	
	always @(posedge clk) begin
		if (!re & we) begin			//write  we = 1
			mem[address] <= data;	//data as input
		end
	end
	
endmodule