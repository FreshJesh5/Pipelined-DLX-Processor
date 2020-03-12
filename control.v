module control(Opcode, funct, RegDst, Branch, Jump, JR,MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, 
					branchCheck, JumpCheck, JRCheck, IFflush, IDflush, EXflush);
	input [5:0] Opcode, funct;
	input branchCheck, JumpCheck, JRCheck;
	output RegDst, Branch, Jump, JR, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
	output [1:0] ALUOp;
	output reg IFflush, IDflush, EXflush;
	
	reg RegDst, Branch, Jump, JR, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
	reg [5:0] ALUOp;
	
	parameter ADDI =  6'h08,R = 6'h00,Mult = 6'h01,J = 6'h02,JAL = 6'h03,BEQ = 6'h04,BNEZ = 6'h05,ADDUI=6'h09,SUBI=6'h0a,SUBUI=6'h0b;
	parameter ANDI=6'h0c,ORI=6'h0d,XORI=6'h0e,LHI=6'h0f,JRf=6'h12,JALR=6'h13,SLLI=6'h14,SRLI=6'h16,SRAI=6'h17,SEQI=6'h18,SNEI=6'h19;
	parameter SLTI=6'h1a,SGTI=6'h1b,SLEI=6'h1c,SGEI=6'h1d,LB=6'h20,LH=6'h21;
	parameter LW = 6'h23,LBU=6'h24,LHU=6'h25,SB=6'h28,SH=6'h29,SW = 6'h2b; 
	
	// Specify signals to set up different datapaths
	always @(*) begin
		if (branchCheck|| JumpCheck || JRCheck) begin
			IFflush = 1;
			IDflush = 1;
			EXflush = 1;
		end else begin
			IFflush = 0;
			IDflush = 0;
			EXflush = 0;
			case (Opcode)
				// Immediate
				ADDI: begin
					 RegDst = 0;
					 Branch = 0; Jump = 0; JR = 0;
					 MemRead = 0; MemtoReg = 1; MemWrite = 0;
					 ALUSrc = 1;
					 RegWrite = 1;
					 ALUOp = 6'h20;
					 end
				ADDUI: begin
	             RegDst = 0;
	             Branch = 0; Jump = 0; JR = 0;
	             MemRead = 0; MemtoReg = 1; MemWrite = 0;
	             ALUSrc = 1;
	             RegWrite = 1;
	             ALUOp = 6'h21;
	             end
	         SUBI: begin
	             RegDst = 0;
	             Branch = 0; Jump = 0; JR = 0;
	             MemRead = 0; MemtoReg = 1; MemWrite = 0;
	             ALUSrc = 1;
	             RegWrite = 1;
	             ALUOp = 6'h22;
	             end
            SUBUI: begin
                RegDst = 0;
                Branch = 0; Jump = 0; JR = 0;
                MemRead = 0; MemtoReg = 1; MemWrite = 0;
                ALUSrc = 1;
                RegWrite = 1;
                ALUOp = 6'h23;
                end
            ANDI: begin
	             RegDst = 0;
	             Branch = 0; Jump = 0; JR = 0;
	             MemRead = 0; MemtoReg = 1; MemWrite = 0;
	             ALUSrc = 1;
	             RegWrite = 1;
	             ALUOp = 6'h24;
	             end
            ORI: begin
                RegDst = 0;
                Branch = 0; Jump = 0; JR = 0;
                MemRead = 0; MemtoReg = 1; MemWrite = 0;
                ALUSrc = 1;
                RegWrite = 1;
                ALUOp = 6'h25;
                end
            XORI: begin
	             RegDst = 0;
	             Branch = 0; Jump = 0; JR = 0;
	             MemRead = 0; MemtoReg = 1; MemWrite = 0;
	             ALUSrc = 1;
	             RegWrite = 1;
	             ALUOp = 6'h26;
	             end
            SLLI: begin
                RegDst = 0;
                Branch = 0; Jump = 0; JR = 0;
                MemRead = 0; MemtoReg = 1; MemWrite = 0;
                ALUSrc = 1;
                RegWrite = 1;
                ALUOp = 6'h04;
                end
            SRLI: begin
	             RegDst = 0;
	             Branch = 0; Jump = 0; JR = 0;
	             MemRead = 0; MemtoReg = 1; MemWrite = 0;
	             ALUSrc = 1;
	             RegWrite = 1;
	             ALUOp = 6'h06;
	             end
            SRAI: begin
                RegDst = 0;
                Branch = 0; Jump = 0; JR = 0;
                MemRead = 0; MemtoReg = 1; MemWrite = 0;
                ALUSrc = 1;
                RegWrite = 1;
                ALUOp = 6'h07;
                end
            SEQI: begin
	             RegDst = 0;
	             Branch = 0; Jump = 0; JR = 0;
	             MemRead = 0; MemtoReg = 1; MemWrite = 0;
	             ALUSrc = 1;
	             RegWrite = 1;
	             ALUOp = 6'h28;
	             end
            SNEI: begin
                RegDst = 0;
                Branch = 0; Jump = 0; JR = 0;
                MemRead = 0; MemtoReg = 1; MemWrite = 0;
                ALUSrc = 1;
                RegWrite = 1;
                ALUOp = 6'h29;
                end
            SLTI: begin
                RegDst = 0;
                Branch = 0; Jump = 0; JR = 0;
                MemRead = 0; MemtoReg = 1; MemWrite = 0;
                ALUSrc = 1;
                RegWrite = 1;
                ALUOp = 6'h2a;
                end
            SGTI: begin
                RegDst = 0;
                Branch = 0; Jump = 0; JR = 0;
                MemRead = 0; MemtoReg = 1; MemWrite = 0;
                ALUSrc = 1;
                RegWrite = 1;
                ALUOp = 6'h2b;
                end
            SLEI: begin
                RegDst = 0;
                Branch = 0; Jump = 0; JR = 0;
                MemRead = 0; MemtoReg = 1; MemWrite = 0;
                ALUSrc = 1;
                RegWrite = 1;
                ALUOp = 6'h2c;
                end
            SGEI: begin
                RegDst = 0;
                Branch = 0; Jump = 0; JR = 0;
                MemRead = 0; MemtoReg = 1; MemWrite = 0;
                ALUSrc = 1;
                RegWrite = 1;
                ALUOp = 6'h2d;
                end
				// R type instruction including JumpRegister
				R: 
					begin
						RegDst = 1;
						Branch = 0; Jump = 0; JR = 0;
						MemRead = 0; MemtoReg = 1; MemWrite = 0;
						ALUSrc = 0;
						RegWrite = 1;
						ALUOp = funct;
					end
				Mult: begin
		            RegDst = 1;
		            Branch = 0; Jump = 0; JR = 0;
		            MemRead = 0; MemtoReg = 1; MemWrite = 0;
		            ALUSrc = 0;
		            RegWrite = 1;
		            ALUOp = funct;
	             end
	             
				// Load word from SRAM to register
				LW: begin
					 RegDst = 0;
					 Branch = 0; Jump = 0; JR = 0;
					 MemRead = 1; MemtoReg = 0; MemWrite = 0;
					 ALUSrc = 1;
					 RegWrite = 1;
					 ALUOp = 6'h20;
					 end
				// Store word from register back to memory
				SW: begin
					 RegDst = 0;
					 Branch = 0; Jump = 0; JR = 0;
					 MemRead = 0; MemtoReg = 0; MemWrite = 1;
					 ALUSrc = 1;
					 RegWrite = 0;
					 ALUOp = 6'h20;
					 end
				// Jump
				J : begin
					 RegDst = 0; Branch = 0; Jump = 1; JR = 0; MemRead = 0; MemtoReg = 0; MemWrite = 0; 
					 ALUSrc = 0; RegWrite = 0; ALUOp = 6'h11;
					 end
					 /*
			   JAL: begin
			       RegDst = 0; Branch = 0; Jump = 1; JR = 0; MemRead = 0; MemtoReg = 0; MemWrite = 0;
			       ALUSrc = 0; RegWrite = 1; ALUOp = 6'h11;
			       end
			       */
			   JRf: begin
			       RegDst = 0; Branch = 0; Jump = 0; JR = 1; MemRead = 0; MemtoReg = 1; MemWrite = 0;
                ALUSrc = 0; RegWrite = 0; ALUOp = 6'h11;
            end
            /*
            JALR: begin
                RegDst = 0; Branch = 0; Jump = 0; JR = 1; MemRead = 0; MemtoReg = 0; MemWrite = 0;
                ALUSrc = 0; RegWrite = 1; ALUOp = 6'h11;
            end
            
            LHI: begin
                RegDst = 0; Branch = 0; Jump = 0; JR = 0; MemRead = 1; MemtoReg = 0; MemWrite = 0;
                ALUSrc = 1; RegWrite = 1; ALUOp = 6'h20;
            end
            
            LB: begin
                RegDst = 0; Branch = 0; Jump = 0; JR = 0; MemRead = 1; MemtoReg = 0; MemWrite = 0;
                ALUSrc = 1; RegWrite = 1; ALUOp = 6'h20;
            end
            
            LH: begin
                RegDst = 0; Branch = 0; Jump = 0; JR = 0; MemRead = 1; MemtoReg = 0; MemWrite = 0;
                ALUSrc = 1; RegWrite = 1; ALUOp = 6'h20;
            end
            LBU: begin
                RegDst = 0; Branch = 0; Jump = 0; JR = 0; MemRead = 1; MemtoReg = 0; MemWrite = 0;
                ALUSrc = 1; RegWrite = 1; ALUOp = 6'h20;
            end
            LHU: begin
                RegDst = 0; Branch = 0; Jump = 0; JR = 0; MemRead = 1; MemtoReg = 0; MemWrite = 0;
                ALUSrc = 1; RegWrite = 1; ALUOp = 6'h20;
            end
            SB: begin
                RegDst = 0; Branch = 0; Jump = 0; JR = 0; MemRead = 0; MemtoReg = 0; MemWrite = 1;
                ALUSrc = 1; RegWrite = 0; ALUOp = 6'h20;
            end
            SH: begin
                RegDst = 0; Branch = 0; Jump = 0; JR = 0; MemRead = 0; MemtoReg = 0; MemWrite = 1;
                ALUSrc = 1; RegWrite = 0; ALUOp = 6'h20;
            end
*/
				// Branch equal
				
				BEQ:begin
					 RegDst = 0; Branch = 1; Jump = 0; JR = 0; MemRead = 0; MemtoReg = 0; MemWrite = 0;
					 ALUSrc = 0; RegWrite = 0; ALUOp = 6'h22;
					 end
				BNEZ: begin
				    RegDst = 0; Branch = 1; Jump = 0; JR = 0; MemRead = 0; MemtoReg = 0; MemWrite = 0;
                ALUSrc = 0; RegWrite = 0; ALUOp = 6'h22;
            end
				default: begin
					 RegDst = 1'bx; Branch = 1'bx; Jump = 1'bx; JR = 1'bx; MemRead = 1'bx; MemtoReg = 1'bx; MemWrite = 1'bx;
					 ALUSrc = 1'bx;
					 RegWrite = 1'bx;
					 ALUOp = 6'hxx; end
			endcase
		end
	end
	
endmodule
