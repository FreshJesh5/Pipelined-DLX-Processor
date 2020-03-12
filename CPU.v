module CPU(clk, rst, sramA, sramData, sramWe, sramRe, instrA, instrD);
	input rst;
	input clk; // 50MHz clock.
	input [31:0] instrD;
	inout [31:0] sramData;
	output sramWe, sramRe;
	output [31:0] sramA, instrA;
	
	wire [31:0] instr_out, pcOut, incrPC, branchPC, extended, resultALU,wData, rData1, rData2, B, dataExtended;
	reg  [31:0] A, B_0, pcIn;
	wire RegDst, Branch, Jump, JR, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, PC_write, IFID_write, mux_ctrl, PCSrc, Z, IFflush, IDflush, EXflush, V, C, N;
	wire [4:0] ws1, ws2, shamt;
	wire [5:0] ALUOp;
	wire [63:0] IFID_out; 
	wire [157:0] IDEX_out;
	wire [145:0] EXMEM_out;
	wire [70:0] MEMWB_out;
	wire [1:0] WB;		
	wire [2:0] M;		
	wire [7:0] EX;
	wire [12:0] controlSignals;
	wire [4:0] controlSignals_EX;
	wire [1:0] J_JR, J_JR_EX, forward_A, forward_B;
	//wire [31:0] sramData;
	wire [2:0] opSelect;
	wire C1,C2;

	//instructionMemory instMem (.address(pcOut), .instruction(instr_out));
   assign instrA = pcOut;
   assign instr_out = instrD;
   
	pc pCounter (.clk(clk), .rst(rst), .pcOut(pcOut), .pcIn(pcIn), .PC_write(PC_write));

	// Pipeline registers
	IFID_reg #(64)  IF_ID (.clk(clk), .rst(rst), .in({incrPC, instr_out}), .out(IFID_out), .IFID_write(IFID_write), .IFflush(IFflush));

	register #(158) ID_EX (.clk(clk), .rst(rst), .in({J_JR, IFID_out[25:21], controlSignals, IFID_out[63:32], rData1, rData2, extended, IFID_out[20:16], IFID_out[15:11]}), .out(IDEX_out));

	register #(146) EX_MEM (.clk(clk), .rst(rst), .in({IDEX_out[41:10], J_JR_EX, IDEX_out[155:151], controlSignals_EX, branchPC, Z, resultALU, B_0, ws1}), .out(EXMEM_out));
	
	register #(71) MEM_WB (.clk(clk), .rst(rst), .in({EXMEM_out[106:105] , sramData, EXMEM_out[68:37], EXMEM_out[4:0]}), .out(MEMWB_out));
	
	// Control Unit
	control ctrl (.Opcode(IFID_out[31:26]), .funct(IFID_out[5:0]), 
				  .RegDst(RegDst), .ALUOp(ALUOp), .ALUSrc(ALUSrc), .Branch(Branch), .MemRead(MemRead), .MemWrite(MemWrite), .MemtoReg(MemtoReg), .RegWrite(RegWrite), .Jump(Jump), .JR(JR),
				  .branchCheck(PCSrc), .JumpCheck(EXMEM_out[113]), .JRCheck(EXMEM_out[112]), .IFflush(IFflush), .IDflush(IDflush), .EXflush(EXflush));

	// Adders increment PC and branch PC
	CLU add1 (.A(pcOut), .B(32'd4), .sum(incrPC), .C(C1));
	CLU add2 (.A(IDEX_out[137:106]), .B(IDEX_out[41:10]), .sum(branchPC), .C(C2));
	
	// Sign Extenders
	signExtender se (IFID_out[15:0], extended);

	// Data memory
	//SRAM sram(.clk(clk), .address(EXMEM_out[68:37]), .data(sramData), .we(EXMEM_out[102]), .re(EXMEM_out[103]));
   //assign sramData = sramDout;
   assign sramA = EXMEM_out[68:37];
   assign sramWe = EXMEM_out[102];
   assign sramRe = EXMEM_out[103];
   
	// Register file
	GPR regfile (.clk(clk), .rst(rst), .rs1(IFID_out[25:21]), .rs2(IFID_out[20:16]), .ws(MEMWB_out[4:0]), .we(MEMWB_out[70]), .wData(wData), .rData1(rData1), .rData2(rData2));
	

	
	// ALU
	//ALUcontrol aluCtrl (.funct(IDEX_out[15:10]), .enable(IDEX_out[144:139]), .opSelect(opSelect));
	//ALU_rtl alu (.A(A), .B(B), .ctrl(opSelect), .shamt(IDEX_out[20:16]), .out(resultALU), .Z, .V, .C, .N);
	alu mainalu (.d1(A), .d2(B), .func(IDEX_out[144:139]), .s(resultALU), .zero_detect(Z), .ovf(V), .cout(C), .N(N));
	
	// Forwarding unit
	forwarding f(.IDEX_rs(IDEX_out[155:151]), .IDEX_rt(IDEX_out[9:5]), .EXMEM_rd(EXMEM_out[4:0]), .MEMWB_rd(MEMWB_out[4:0]), 
						.EXMEM_RegWrite(EXMEM_out[106]), .MEMWB_RegWrite(MEMWB_out[70]), 
						.IDEX_MemWrite(IDEX_out[146]), .EXMEM_MemWrite(EXMEM_out[102]),
						.forward_A(forward_A), .forward_B(forward_B));

	hazard_detect hdu (.clk(clk), .rst(rst), .IFID_rs(IFID_out[25:21]), .IFID_rt(IFID_out[20:16]), .IDEX_rt(IDEX_out[9:5]), .IDEX_MemRead(IDEX_out[147]), .PC_write(PC_write), .IFID_write(IFID_write), .mux_ctrl(mux_ctrl));

	// Write back control signals
	assign WB = {RegWrite, MemtoReg};

	// Memory control signals
	assign M  = {Branch, MemRead, MemWrite};

	// Execution control signals
	assign EX = {RegDst, ALUOp, ALUSrc};

	// Flush signals in IDEX
	assign controlSignals = (mux_ctrl || IDflush) ? 0 : {WB, M, EX};

	// Flush signals in EXMEM
	assign controlSignals_EX = EXflush ? 0 : IDEX_out[150:146];

	// Flush Jump and JumpRegister in IDEX and EXMEM
	assign J_JR = (mux_ctrl || IDflush) ? 0 : {Jump, JR};
	assign J_JR_EX = EXflush ? 0 : IDEX_out[157:156];

	// Write address for register file for EXMEM
	assign ws1 = IDEX_out[145] ? IDEX_out[4:0] : IDEX_out[9:5];

	// Branch & Zero
	assign PCSrc = EXMEM_out[104] & EXMEM_out[69]; 

	// Pick write address for Register File
	assign wData = MEMWB_out[69] ? MEMWB_out[36:5] : MEMWB_out[68:37];

	// Data out
	assign sramData = EXMEM_out[102] & ~EXMEM_out[103] ? EXMEM_out[36:5] : 32'bz;

	// Source B after forwarding selection
	assign B = IDEX_out[138] ? IDEX_out[41:10] : B_0;

	// Forwarding muxes
	always @(*) begin
		case (forward_A)
			2'b00: A = IDEX_out[105:74];
			2'b01: A = wData;
			2'b10: A = EXMEM_out[68:37];
			default: A = 32'b0;
		endcase
		
		case (forward_B)
			2'b00: B_0 = IDEX_out[73:42];
			2'b01: B_0 = wData;
			2'b10: B_0 = EXMEM_out[68:37];
			default: A = 32'b0;
		endcase
	end

	// Update program counter
	always@(*) begin
		if (EXMEM_out[112]) 				// JR
			pcIn = EXMEM_out[68:37];
		else if (EXMEM_out[113])			// J[145:114]
			pcIn = EXMEM_out[101:70];
		else if (PCSrc)						// Branch
			pcIn = EXMEM_out[101:70];
		else								// Increment PC by 1
			pcIn = incrPC;
	end

endmodule
