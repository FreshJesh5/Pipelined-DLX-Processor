// Instruction Memory
// Author: Jiashuo Zhang
// Data: 5/1/2016
module instructionMemory(address, instruction);
	input  [31:0] address;
	output [31:0] instruction;
	
	reg	 [31:0] mem [127:0];
	
	initial
	begin
		$readmemh("test_jump.dat", mem);
	end
	assign instruction = mem[{2'b0,address[31:2]}];
endmodule