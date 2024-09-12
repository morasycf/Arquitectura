module fetch #(parameter N = 64)
				( input logic PCSrc_F,clk,reset,
              input logic [N-1:0]PCBranch_F,
				  output logic [N-1:0]imem_addr_F);
				  
		logic [63:0]addmux;  //c
		logic [N-1:0]muxflopr;
				  
		mux2 mux( .d0(addmux), .d1(PCBranch_F) , .s(PCSrc_F), .y(muxflopr));
		
		flopr flop(.clk(clk), .reset(reset), .d(muxflopr), .q(imem_addr_F));
		
	   adder add( .a(imem_addr_F), .b(64'd4) , .y(addmux));
		
endmodule
