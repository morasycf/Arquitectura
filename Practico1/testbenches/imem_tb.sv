module imem_tb();
			parameter N = 32;
			logic [5:0] addr;
			logic [N-1:0] q;
			
			
// instantiate device under test
	imem dut(addr,q);
	
// initialize testbench
	initial begin
		for (int i = 0; i < 50; i++)
		begin
			addr = i;
			#10;
				if(i < 47) begin
					$display("Addr: %0d, q: %h", i, q);
				end
				else if(q !== 32'h00000000) begin
					$display("Error: Addr: %0d, Esperado: 0, Recibido: %h", i, q);
				end
				else begin
					$display("Addr: %0d, q: %h", i, q);
				end	
		end
		$stop;
	end

endmodule
