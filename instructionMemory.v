// Instruction Memory
// Author: Jiashuo Zhang
// Data: 5/1/2016
module instructionMemory(address, instruction);
	input  [31:0] address;
	output [31:0] instruction;
	
	reg	 [31:0] mem [127:0];
	
	initial
	begin
		$readmemh("instructionSet.dat", mem);
	end
	assign instruction = mem[{address[31:2],2'b00}];
endmodule