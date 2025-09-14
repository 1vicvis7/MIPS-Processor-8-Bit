module register_file(clk,reset,rf_ren_wen,acc ,rf_readaddr1,rf_readaddr2, rf_writeaddr,rf_data1,rf_data2); 
  
input	clk;  
input reset;  
input rf_ren_wen;  							//mem_ren  read= 0 /write = 1 enable pin 

input [1:0]rf_writeaddr, rf_readaddr1,rf_readaddr2;  

input [7:0]acc;
  
output reg [7:0]rf_data1, rf_data2;
	
reg [7:0]reg_array [3:0]; 
		
always @ (posedge clk or posedge reset ) 
	begin  
		  if(reset) 
			  begin  
					 reg_array[0] <= 8'b0000_0001;  //azero
					 reg_array[1] <= 8'b0000_0010;  //b
					 reg_array[2] <= 8'b0000_0011;  //c
					 reg_array[3] <= 8'b0000_0101;  //d         
			  end  
		  else 
			  begin  
					 if(rf_ren_wen) 
					 begin  
							reg_array[rf_writeaddr] <= acc;  
					 end
					 else
						begin  //rf_ren_wen == 0 then read
							rf_data1 = ( rf_readaddr1 == 0)? 8'b0 : reg_array[rf_readaddr1];  
							rf_data2 = ( rf_readaddr2 == 0)? 8'b0 : reg_array[rf_readaddr2];  
						end	
			  end	  
 end 

endmodule