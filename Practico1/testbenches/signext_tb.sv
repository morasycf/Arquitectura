module signext_tb();
						logic [31:0] a;
						logic [63:0] y;
						logic [63:0] yexpected;
						logic [31:0] vectornum, errors; // bookkeeping variables )// array of testvectors
						logic [31:0] testvectors [0:5] = '{ 32'hF84003E0, // LDUR con inmediato positivo
																	   32'hF85083E0, // LDUR con inmediato negativo
	                                                   32'hB80043E0, // STUR con inmediato positivo
	                                                   32'hB800C3E0, // STUR con inmediato negativo
	                                                   32'hB4000041,// CBZ con inmediato negativo
	                                                   32'hD2800020}; // Instrucción sin inmediato, salida debe ser 0
																	  
						logic [63:0] expvectors [0:5] = '{ 64'h0000000000000000,
																	  64'hFFFFFFFFFFFFFF08,
																	  64'h0000000000000000 ,
																	  64'h0000000000000000 ,
																	  64'h0000000000000002,
																	  64'h0000000000000000};
																	 
					
	// instantiate device under test
	signext dut(a,y);
	
	// initialize testbench
	initial begin
		vectornum = 0; errors = 0; 
		#5;
	// Aplicar test vectors
        while (vectornum < 6) begin
            a = testvectors[vectornum];
            #1; // Esperar a que el módulo procese la entrada
            yexpected = expvectors[vectornum];
            if (y !== yexpected) begin  
                $display("Error: input = %h", a);
                $display("  output = %h (%h expected)", y, yexpected);
                errors = errors + 1;
            end

            // Incrementar índice del array
            vectornum = vectornum + 1;
      end

        $display("%d tests completed with %d errors", vectornum, errors);
        $stop;
end

endmodule