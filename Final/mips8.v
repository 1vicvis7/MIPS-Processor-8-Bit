module mips8(input pc,input clk, output mem_output);

//instruction memory
instr_mem IM(clk,pc,instruction);

//control unit
control_unit CU(clk,instruction,reset,aluc,reg_addr1,reg_addr2,jump,branch,mem_wen_ren,rf_ren_wen,status);

//reg file
register_file RF(clk,reset,rf_wen_ren,acc ,rf_readaddr1,rf_readaddr2, rf_writeaddr,rf_data1,rf_data2);

//alu
alu ALU(.clk(clk),.c(rf_data1),.d(rf_data2),.alu_control(aluc),.acc(acc),.status(status));

//data memory
data_memory  DM(clk,read_addr,write_addr,acc,mem_wen_ren,mem_output);

endmodule
