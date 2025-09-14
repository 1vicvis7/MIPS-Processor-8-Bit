`timescale 1ns/1ps

module tb_mipsdemo;

  // Inputs
  reg clk;
  reg reset;
  reg [7:0] pc;

  // Outputs
  wire [7:0] acc;
  wire [7:0] mem_output;
  wire [7:0] rf_data1, rf_data2;

  // Instantiate the DUT (Device Under Test)
  mipsdemo uut (
    .pc(pc),
    .clk(clk),
    .reset(reset),
    .acc(acc),
    .mem_output(mem_output),
    .rf_data1(rf_data1),
    .rf_data2(rf_data2)
  );

  // Clock generation: 10ns period
  always #5 clk = ~clk;

  initial begin
    // Initialize
    clk = 0;
    reset = 1;
    pc = 0;

    // Apply reset for some cycles
    #20 reset = 0;

    // Run through all instructions in instruction memory
    repeat (20) begin
      #10 pc = pc + 1;   // increment PC every cycle
    end

    // End simulation
    #50 $finish;
  end

  // Monitor signals in console
  initial begin
    $monitor("Time=%0t | PC=%d | ACC=%h | RF1=%h | RF2=%h | MEM_OUT=%h",
             $time, pc, acc, rf_data1, rf_data2, mem_output);
  end

//  // Dump VCD for GTKWave (works in Icarus)
//  initial begin
//    $dumpfile("mipsdemo_tb.vcd");
//    $dumpvars(0, tb_mipsdemo);
//  end

endmodule
