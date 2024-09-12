module maindec( input logic [10:0]Op,
					 output logic Reg2Loc,ALUSrc,MemtoReg,RegWrite,
					 output logic MemRead,MemWrite,Branch,
                output logic [1:0]ALUOp);
					 
		always_comb
			casez(Op)
			//LDUR
			11'b111_1100_0010: begin
									 Reg2Loc = 0;
									 ALUSrc = 1;
									 MemtoReg = 1;
									 RegWrite = 1;
									 MemRead = 1;
									 MemWrite = 0;
									 Branch = 0;
									 ALUOp = 'b00;  
			end
			//STUR
			11'b111_1100_0000: begin
									 Reg2Loc = 1;
									 ALUSrc = 1;
									 MemtoReg = 0;
									 RegWrite = 0;
									 MemRead = 0;
									 MemWrite = 1;
									 Branch = 0;
									 ALUOp = 'b00; 
			end
			//CBZ
			11'b101_1010_0???: begin 
									 Reg2Loc = 1;
									 ALUSrc = 0;
									 MemtoReg = 0;
									 RegWrite = 0;
									 MemRead = 0;
									 MemWrite = 0;
									 Branch = 1;
									 ALUOp = 'b01; 
			end
			//ADD,SUB,AND,ORR
			   11'b100_0101_1000,
            11'b110_0101_1000,
            11'b100_0101_0000,
            11'b101_0101_0000: begin
									 Reg2Loc = 0;
									 ALUSrc = 0;
									 MemtoReg = 0;
									 RegWrite = 1;
									 MemRead = 0;
									 MemWrite = 0;
									 Branch = 0;
									 ALUOp = 'b10;
			end
			//Other cases
			default: begin
						Reg2Loc = 0;
						ALUSrc = 0;
						MemtoReg = 0;
						RegWrite = 0;
					   MemRead = 0;
						MemWrite = 0;
						Branch = 0;
						ALUOp = 'b00;		
			end
			
			endcase

endmodule
