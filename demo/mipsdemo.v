module mipsdemo(input [7:0]pc,input clk,input reset, output [7:0]acc, output [7:0]mem_output, 
output [7:0]rf_data1,rf_data2 
);

wire [7:0]instruction;
//output [7:0]acc ;
wire [3:0]aluc;
wire [1:0]reg_addr1,reg_addr2;

wire jump,branch,mem_ren_wen,rf_ren_wen;

//instruction memory
instr_mem IM(clk,pc,instruction);

//control unit
control_unit CU(clk,instruction,reset,aluc,reg_addr1,reg_addr2,jump,branch,mem_ren_wen,rf_ren_wen);

//reg file
register_file RF(clk,reset,rf_ren_wen,acc ,reg_addr1,reg_addr2, reg_addr2,rf_data1,rf_data2);

//alu
alu ALU(.clk(clk),.c(rf_data1),.d(rf_data2),.alu_control(aluc),.acc(acc));

//data memory
data_memory  DM(clk,rf_data1,rf_data1,acc,mem_ren_wen,mem_output);

////next adder block
//next_addr(clk,pc,jump,branch);

endmodule
