module imem #(parameter N = 32)
			    (input logic [5:0] addr,
				  output logic [N-1:0] q);
				  
   logic [N-1:0] rom [0:63]; 
	
	initial
	begin
	rom [0:12] ='{32'h8b1f03e2,
					  32'h8b1f03e3,
				     32'h8b1f03e6,
                 32'hb40000e4,
                 32'hf8400065,
                 32'h8b0500c6,
                 32'h8b010042,
                 32'h8b080063,
                 32'hcb0203c4,
                 32'hb4ffff5f,
                 32'hf8000066,
                 32'hb400003f,
                 32'hb400001f};

					  
        for (int i = 13; i < 64; i = i + 1) begin
            rom[i] = 32'h00000000;
        end
   end	
	
	assign q = rom[addr];	
				 
endmodule
