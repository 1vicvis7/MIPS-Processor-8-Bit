module mipsdemo(
    input [7:0] pc,
    input clk,
    input reset,
    output [7:0] acc,
    output [7:0] mem_output,
    output [7:0] rf_data1, rf_data2
);

wire [7:0] instruction;
wire [3:0] aluc;
wire [1:0] reg_addr1, reg_addr2;

// Control signals
wire jump, branch, mem_ren_wen, rf_ren_wen;

// Instruction memory
instr_mem IM(clk, pc, instruction);

// Control unit
control_unit CU(
    .clk(clk),
    .instruction(instruction),
    .reset(reset),
    .alu_control(aluc),
    .reg_addr1(reg_addr1),
    .reg_addr2(reg_addr2),
    .jump(jump),
    .branch(branch),
    .mem_ren_wen(mem_ren_wen),
    .rf_ren_wen(rf_ren_wen)
);

// Register file (FIX: write address should not reuse reg_addr2)
register_file RF(
    .clk(clk),
    .reset(reset),
    .rf_ren_wen(rf_ren_wen),
    .acc(acc),
    .rf_readaddr1(reg_addr1),
    .rf_readaddr2(reg_addr2),
    .rf_writeaddr(reg_addr1),   // TEMP FIX: choose reg_addr1 as write addr
    .rf_data1(rf_data1),
    .rf_data2(rf_data2)
);

// ALU
alu ALU(
    .clk(clk),
    .c(rf_data1),
    .d(rf_data2),
    .alu_control(aluc),
    .acc(acc)
);

// Data memory (FIX: separate read/write addr)
data_memory DM(
    .clk(clk),
    .read_addr(rf_data1),
    .write_addr(rf_data2),
    .acc(acc),
    .mem_ren_wen(mem_ren_wen),
    .mem_output(mem_output)
);

// TODO: Add program counter update (next_addr) using jump/branch

endmodule
