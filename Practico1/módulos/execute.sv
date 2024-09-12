module execute #(parameter N = 64)
					(input logic AluSrc,
				  	 input logic [3:0]AluControl,
                input logic [N-1:0]PC_E,signImm_E,readData1_E,readData2_E,
					 output logic [N-1:0]PCBranch_E,aluResult_E,writeData_E,
                output logic zero_E);
					 
	logic [N-1:0] SrcBAlu,sftadd;  //si es un cable interno genero una variable auxiliar
	
	mux2 alumux(.d0(readData2_E),.d1(signImm_E), .s(AluSrc), .y(SrcBAlu));
	
	alu alu( .a(readData1_E), .b(SrcBAlu), .ALUControl(AluControl),
				.result(aluResult_E) ,.zero(zero_E));
				
	sl2 shiftlft( .a(signImm_E) , .y(sftadd));
	
	adder add( .a(PC_E) , .b(sftadd) , .y(PCBranch_E));
	
	assign writeData_E = readData2_E;

endmodule
	