module execute_tb();
				logic AluSrc;
				logic [3:0]AluControl;
            logic [63:0]PC_E,signImm_E,readData1_E,readData2_E;
				logic [63:0]PCBranch_E,aluResult_E,writeData_E;
            logic zero_E;
				logic [31:0] vectornum, errors;
				
				
		execute dut(AluSrc,AluControl,PC_E,signImm_E,
						readData1_E,readData2_E,PCBranch_E,
						aluResult_E,writeData_E,zero_E);
						
	 // Inicialización de las señales de prueba
    initial begin
        // Prueba 1: Suma (AluControl = 4'b0010, AluSrc = 1)
        AluSrc = 1'b1;
        AluControl = 4'b0010;
        PC_E = 64'd100;
        signImm_E = 64'd4;        // Valor inmediato
        readData1_E = 64'd10;     // Primer operando de la ALU
        readData2_E = 64'd20;     // Segundo operando de la ALU
        
        #5;

        // Verificar resultados
        $display("Prueba 1: Suma");
        $display("aluResult_E: %d (esperado: 14)", aluResult_E);
        $display("PCBranch_E: %d (esperado: 104)", PCBranch_E);
        $display("zero_E: %b (esperado: 0)", zero_E);
        $display("writeData_E: %d (esperado: 20)", writeData_E);
		  
		  // Prueba 2: Resta (AluControl = 4'b0110, AluSrc = 1)
        AluSrc = 1'b1;
        AluControl = 4'b0110;
        PC_E = 64'd100;
        signImm_E = 64'd4;        // Valor inmediato
        readData1_E = 64'd10;     // Primer operando de la ALU
        readData2_E = 64'd20;     // Segundo operando de la ALU
        
        #5;

        // Verificar resultados
        $display("Prueba 2: Resta");
        $display("aluResult_E: %d (esperado: 6)", aluResult_E);
        $display("PCBranch_E: %d (esperado: 96)", PCBranch_E);
        $display("zero_E: %b (esperado: 0)", zero_E);
        $display("writeData_E: %d (esperado: 20)", writeData_E);
		   // Prueba 2: AND lógico (AluControl = 4'b0000, AluSrc = 0)
        AluSrc = 1'b0;
        AluControl = 4'b0000;
        PC_E = 64'd100;
        signImm_E = 64'd8;        // Valor inmediato (no se usa en esta prueba)
        readData1_E = 64'hFFFFFFFFFFFFFFFF; // Todos unos
        readData2_E = 64'h0F0F0F0F0F0F0F0F; // Patrón

        #5;

        // Verificar resultados
        $display("Prueba 2: AND lógico");
        $display("aluResult_E: %h (esperado: 0F0F0F0F0F0F0F0F)", aluResult_E);
        $display("PCBranch_E: %d (esperado: 108)", PCBranch_E);
        $display("zero_E: %b (esperado: 0)", zero_E);
        $display("writeData_E: %h (esperado: 0F0F0F0F0F0F0F0F)", writeData_E);
		  
		  // Prueba 3: CBZ (AluControl = 4'b0110, AluSrc = 1)
        AluSrc = 1'b1;
        AluControl = 4'b0110;
        PC_E = 64'd100;
        signImm_E = 64'd4;        // Valor inmediato
        readData1_E = 64'd0;      // Para hacer la comparación con cero
        readData2_E = 64'd10;

        #5; 

        // Verificar resultados
        $display("Prueba 3: CBZ");
        $display("aluResult_E: %d (esperado: 0)", aluResult_E);
        $display("PCBranch_E: %d (esperado: 104)", PCBranch_E);
        $display("zero_E: %b (esperado: 1)", zero_E);
        $display("writeData_E: %d (esperado: 10)", writeData_E);
		  
		  	  $stop;
	  end
	  
endmodule
						
		
		
		
		
		
		
		
				