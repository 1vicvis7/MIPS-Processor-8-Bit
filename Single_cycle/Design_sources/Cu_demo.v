module control_unit(
input clk,
input [7:0]instruction,  
input reset,
output reg [3:0]alu_control,
output reg [1:0]reg_addr1,
output reg [1:0]reg_addr2,  
output reg jump,branch,mem_ren_wen,
output reg rf_ren_wen);                      

wire [3:0] opc_fn = instruction[7:4];
always @(posedge clk | reset)  
 begin  
   alu_control = opc_fn;
      if(reset == 1'b1) begin  
                alu_control = 4'b0000;
                jump = 1'b0;  
                branch = 1'b0;  
                mem_ren_wen= 1'b0;
					 rf_ren_wen = 1'b1;	
                
					reg_addr1 = instruction[3:2];
					reg_addr2 = instruction[1:0];	
      end  
      else begin  
      case(opc_fn)   
      4'b0000: begin // add  
                alu_control = 4'b0000;
                jump = 1'b0;  
                branch = 1'b0;  
                mem_ren_wen= 1'b0;
					 rf_ren_wen = 1'b0;	
                reg_addr1 = instruction[3:2];
					 reg_addr2 = instruction[1:0];
                end  
      4'b0001: begin // sub
                 alu_control = 4'b0001;
                jump = 1'b0;  
                branch = 1'b0;  
                mem_ren_wen= 1'b0;
					 rf_ren_wen = 1'b0;	
                
					reg_addr1 = instruction[3:2];
					reg_addr2 = instruction[1:0];
                end  
      4'b0010: begin // and  
              alu_control = 4'b0010;
                jump = 1'b0;  
                branch = 1'b0;  
                mem_ren_wen= 1'b0;
					 rf_ren_wen = 1'b0;	
                reg_addr1 = instruction[3:2];
					 reg_addr2 = instruction[1:0];
                end  
      4'b0011: begin // nor 
               alu_control = 4'b0011;
                jump = 1'b0;  
                branch = 1'b0;  
                mem_ren_wen= 1'b0;
					 rf_ren_wen = 1'b0;	
                
					reg_addr1 = instruction[3:2];
					reg_addr2 = instruction[1:0];  
                end 
		
		4'b0100: begin // load nibble
                alu_control = 4'b0100;
                jump = 1'b0;  
                branch = 1'b0;  
                mem_ren_wen= 1'b1;
					 rf_ren_wen = 1'b1;	
                
					reg_addr1 = instruction[3:2];
					reg_addr2 = instruction[1:0];  
                end 
		4'b0101: begin // store nibble
                 alu_control = 4'b0101;
                jump = 1'b0;  
                branch = 1'b0;  
                mem_ren_wen= 1'b1;
					 rf_ren_wen = 1'b0;	
                
					reg_addr1 = instruction[3:2];
					reg_addr2 = instruction[1:0]; 
                end 
      
		4'b1000: begin // mov R-> Acc 
                 alu_control = 4'b0000;
                jump = 1'b0;  
                branch = 1'b0;  
                mem_ren_wen= 1'b0;
			    rf_ren_wen = 1'b0;	
                
					//reg_addr1 = instruction[3:2];
					reg_addr2 = instruction[1:0];
                end  
      4'b1001: begin // mov Acc->R 
                 alu_control = 4'b0000;
                jump = 1'b0;  
                branch = 1'b0;  
                mem_ren_wen= 1'b0;
			    rf_ren_wen = 1'b0;	
                
                //reg_addr1 = instruction[3:2];
				reg_addr2 = instruction[1:0];
                end 
		  	
      4'b1010: begin // bne  
                alu_control = 4'b0001;
                jump = 1'b0;  
                branch = 1'b1;  
                mem_ren_wen= 1'b0;
			    rf_ren_wen = 1'b0;	
					 
			    reg_addr2 = instruction[1:0]; //address location
                
					
                end  
      4'b1011: begin // bltz  
                 alu_control = 4'b1011;
                jump = 1'b0;  
                branch = 1'b1;  
                mem_ren_wen= 1'b0;
					 rf_ren_wen = 1'b0;	
                
					
					reg_addr2 = instruction[1:0]; 
                end  
      4'b1100: begin // shl  
                 alu_control = 4'b1100;
                jump = 1'b0;  
                branch = 1'b0;  
                mem_ren_wen= 1'b0;
					 rf_ren_wen = 1'b0;	
                
					reg_addr1 = instruction[3:2];
					reg_addr2 = instruction[1:0]; 
                end  
      4'b1101: begin // shr 
                 alu_control = 4'b1101;
                jump = 1'b0;  
                branch = 1'b0;  
                mem_ren_wen= 1'b0;
					 rf_ren_wen = 1'b0;	
                
					reg_addr1 = instruction[3:2];
					reg_addr2 = instruction[1:0]; 
                end  
		4'b1110: begin // j 
                alu_control = 4'b1110;
                jump = 1'b1;  
                branch = 1'b0;  
                mem_ren_wen= 1'b0;
					 rf_ren_wen = 1'b0;	
                //status = 1'b0;
					reg_addr2 = instruction[1:0];
					
                end  
		4'b1111: begin // jal 
                  alu_control = 4'b1111;
                jump = 1'b1;  
                branch = 1'b0;  
                mem_ren_wen= 1'b0;
					 rf_ren_wen = 1'b0;	
                //status = 1'b0;
					reg_addr2 = instruction[1:0];
                end  			 
		
		default: begin  
               alu_control = 4'b0000;  
                jump = 1'b0;  
                branch = 1'b0;  
                mem_ren_wen= 1'b0;
					 rf_ren_wen = 1'b0;	
                
                end  
      endcase  
      end
//if (reg_addr1 == 11) $display ("register d was selected");
//else if(reg_addr1 == 10) $display ("register c was selected");
//else if (reg_addr1 == 01) $display ("register b was selected");		
//else  if(reg_addr1 == 00)$display("register acc was selected");
//else $display("no register selected")
//
//if (reg_addr2 == 11) $display ("register d was selected");
//else if(reg_addr2 == 10) $display ("register c was selected");
//else if (reg_addr2 == 01) $display ("register b was selected");		
//else if (reg_addr2 == 00)$display ("register acc was selected");
//else $display("no register selected")

 end  
 endmodule  
 