module alu(clk,c,d,alu_control,acc);      
      input clk;
		input [7:0]     c;           
      input [7:0]     d;           
      input [3:0]     alu_control;      
      output reg [7:0] acc;                 
      //output status; 
     
always @(posedge clk)  
 begin   
      case(alu_control)  
      4'b0000: acc = d + c; // add  
      4'b0001: acc = d - c; // sub  
      4'b0010: acc = d & c; // and  
      4'b0011: acc = ~(d | c); // nor  
      4'b1100: acc = (d << c); // shift left 
		4'b1101: acc = (d >> c); // shift right
		4'b1011: begin 
						if (d<c) acc = 8'b1;  
                        else acc = 8'b0;  
                 end  //bltz
		4'b1010: acc = (d!=c); // bne 					
      default:acc = d + c; // add  
      endcase  
 end  
//assign status = (acc==8'b0) ? 1'b1: 1'b0;  
endmodule