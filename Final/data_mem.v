module data_memory(clk,read_addr,write_addr,acc,mem_ren_wen,mem_output);  
   
input     clk; 
input     [7:0]  read_addr,write_addr;   //they could have been merged 
input     [7:0]acc;
  
input     mem_ren_wen;                  //mem_ren  read= 0 /write = 1 enable pin 
output    [7:0] mem_output; 
  
integer i=0;  

reg [7:0] data_mem [255:0];  


initial begin                            //memory initialised
	  for(i=0;i<256;i=i+1)  
			 data_mem[i] <= 8'b0;  
end  
	
      always @(posedge clk) begin  
           if (mem_ren_wen)              //under mem_ren_wen = 1 write
                data_mem[write_addr] <= acc;  
      end  
assign mem_output = (mem_ren_wen==1'b0) ? data_mem[read_addr]: 8'b0; 
		
 endmodule