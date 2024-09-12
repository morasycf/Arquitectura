module maindec_tb();
					 logic [8:0] expected,y;
					 logic [10:0]Op;
					 logic Reg2Loc,ALUSrc,MemtoReg,RegWrite;
					 logic MemRead,MemWrite,Branch;
                logic [1:0]ALUOp;
					 logic [31:0] vectornum, errors;
					 logic [10:0] testvectors [0:6] = '{11'b111_1100_0010, //LDUR
																   11'b111_1100_0000,  //STUR
																	11'b101_1010_0???,  //CBZ
															      11'b100_0101_1000,  //ADD,SUB,AND,ORR
															      11'b111_1111_1111,  //Other case 1
																	11'b000_0000_0000,  //Other case 2
																	11'b101_1010_1010}; //Othe case 3
					 logic [8:0] expvectors [0:6] = '{ 9'b011110000,   //LDUR
															     9'b110001000,   //STUR
																  9'b100000101,   //CBZ
																  9'b000100010,   //TIPO R
																  9'b000000000,
																  9'b000000000,
																  9'b000000000};
   maindec dut(Op,Reg2Loc,ALUSrc,
					MemtoReg,RegWrite,MemRead,
					MemWrite,Branch,ALUOp);	
						
	   // initialize testbench
	initial begin
		vectornum = 0; errors = 0; 
		#5;
		
			// Aplicar test vectors
        while (vectornum <7) begin
            Op = testvectors[vectornum];
				
            #1; // Esperar a que el módulo procese la entrada}
				y = {Reg2Loc,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUOp};
				
            expected = expvectors[vectornum];
            if (y !== expected) begin  
                $display("Outputs = {Reg2Loc=%b, ALUSrc=%b, MemtoReg=%b, RegWrite=%b, MemRead=%b, MemWrite=%b, Branch=%b, ALUOp=%b}", 
                         Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp);
					 $display("Expected = %b", expected);
                errors = errors + 1;
            end

            // Incrementar índice del array
            vectornum = vectornum + 1;
			end
		
	     $display("%d tests completed with %d errors", vectornum, errors);
        $stop;	
	end

endmodule
