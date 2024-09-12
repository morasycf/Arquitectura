module alu_tb();
			logic [63:0] a,b;
			logic [3:0] ALUcontrol;
			logic [63:0] y, yexpected;
			logic zero,zeroexp;
			logic [31:0] vectornum, errors;
			logic [63:0] testvectors_a [0:4] = '{64'd2, // 2
															 64'd2,  // 2
															 64'd3,  // 3
															 64'd3, // 3
															 64'd0};  // 0
															 
			logic [63:0] testvectors_b [0:4] = '{64'd3, // 2 & 3
															 64'd3,  // 2 | 3
															 64'd3,  // 3 + 3= 6
															 64'd3, // 3 - 3 = 0
															 64'd0};  // 0+0
															 
			logic [3:0] vcontrol [0:4] = '{4'd0, // 2&3
													 4'd1,  // 2|3
													 4'd2,  // 3+3
													 4'd6, // 3-3
													 4'd7};  // 0
															 
			logic [63:0] expvectors [0:4] = '{64'd2, // 0011 & 0010 = 0010
													  	 64'd3,  // 0011 | 0010 = 0011
												 		 64'd6,  // 3 + 2 = 5
														 64'd0, // 3 - 3 = 0
														 64'd0};   //0	
			logic [0:0] vzero [0:4] = '{1'd0, // 0
												 1'd0,  // 0
												 1'd0,  // 0
												 1'd1, // 1
												 1'd1};  //1	 
					
// instantiate device under test
	alu dut(a,b,ALUcontrol,y,zero);
	
// initialize testbench
	initial begin
		vectornum = 0; errors = 0; 
		#5;
		
			// Aplicar test vectors
        while (vectornum < 5) begin
            a = testvectors_a[vectornum];
				b = testvectors_b[vectornum];
				ALUcontrol = vcontrol[vectornum];
            #1; // Esperar a que el módulo procese la entrada
            yexpected = expvectors[vectornum];
				zeroexp = vzero[vectornum];
            if (y !== yexpected) begin  
                $display("Error y: input a = %h, b = %h, control = %b", a, b, ALUcontrol);
                $display("  output_y = %h (%h expected)", y, yexpected);
                errors = errors + 1;
            end
				if (zero !== zeroexp) begin  
                $display("Error zero: input a = %h, b = %h, control = %b", a, b, ALUcontrol);
					 $display("  output_zero = %h (%h expected)", zero, zeroexp);
            end

            // Incrementar índice del array
            vectornum = vectornum + 1;
      end
        $display("%d tests completed with %d errors", vectornum, errors);
        $stop;
	end

endmodule
