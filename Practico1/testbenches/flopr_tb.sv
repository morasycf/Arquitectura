module flopr_tb();
	parameter N = 64;
	logic        clk,reset;
	logic        [N-1:0]d,q;
	logic [9:0] ivector, errors;    // bookkeeping variables 
	logic [N-1:0] testvectors [0:9] = '{64'd 5,	// array of testvectors
												   64'd 7,
													64'd 10,
													64'd 3,
													64'd 40,
													64'd 492,
													64'd 7,
													64'd 80,
													64'd 9,
													64'd 99};
// instantiate device under test
	flopr dut(clk, reset, d, q);
	
// generate clock
    always begin
        clk = 1; #5ns; clk = 0; #5ns;
    end
		
    initial begin
        ivector = 0; errors = 0;
        reset = 1;
        #50ns;
        reset = 0;
    end

 always @(posedge clk) begin
            d = testvectors[ivector]; #1ns;

            // Revisamos que no de error los primero [0...4] casos.
            if (reset === 1)    begin
                if (q !== 0) begin
                    $display("El caso %d FALLO (q !== 0)", ivector);
                    errors = errors + 1;
                end
            end

            // Revisamos que no de error los casos [5...9].
            if (reset === 0) begin
                 if (q !== testvectors[ivector-1]) begin
                    $display("El caso %d FALLO (q !== testvectors[ivector-1])", ivector);
                    errors = errors + 1;
                end
            end

            if (d === 'x) // Terminamos todos los casos de uso asique paramos.
                begin
                    $display("Se detectaron %d errores en el test de flopr",errors);
                    $stop;
                end
				 ivector++;
		end
endmodule