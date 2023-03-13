module instr_mem(clk,pc,instruction);            
input clk;  
input  [7:0]pc;  
output reg  [7:0]instruction;  
//output reg [1:0]addr1,addr2;
  
wire   [3 : 0] rom_addr = pc[2 : 0];  
	/* and $1 $0 $2
		   00000001
			or $1 $0 $2
			00100001
 */  
      reg [3:0] rom[15:0];
		
initial 
begin
                rom[0] = 8'b00000001;  
                rom[1] = 8'b00101110;  //sub d-c
				    rom[2] = 8'b00111110;  //nor d,c
                rom[3] = 8'b00101110;  //and d,c
				    rom[4] = 8'b00010001;  
                rom[5] = 8'b00101001;
					 rom[6] = 8'b00100001;
				    rom[7] = 8'b00000101;           
					 
					 rom[8] = 8'b00000000;
					 rom[9] = 8'b00000000;
					 rom[10] = 8'b00000000;
					 rom[11] = 8'b00000000;
					 rom[12] = 8'b00000000;
					 rom[13] = 8'b00000000;
					 rom[14] = 8'b00000000;
					 rom[15] = 8'b00000000;			
					
end

always @(posedge clk)  
 begin   
      case(rom_addr)  
      4'b0000: instruction = rom[0];
      4'b0001: instruction = rom[1];
		4'b0010: instruction = rom[2];
		4'b0011: instruction = rom[3];
		4'b0100: instruction = rom[4];
		4'b0101: instruction = rom[5];
		4'b0110: instruction = rom[6];
		4'b0111: instruction = rom[7];
     					
      default:instruction = 8'b00000000;// add  
      endcase  
 
end    

//addr1 = instruction[3:2];
//addr2 = instruction[1:0];
endmodule   