`timescale 1ns / 1ps
`include "pc.v"

module ProgramCounter_tb;

  reg clk;
  reg rst;
  reg branch;
  reg [31:0] pc_branch_target;
  reg [31:0] pc_4;
  wire [31:0] pc;

  // Instantiate the ProgramCounter module
  ProgramCounter uut (
    .clk(clk),
    .rst(rst),
    .branch(branch),
    .pc_branch_target(pc_branch_target),
    .pc_4(pc_4),
    .pc(pc)
  );

  // Clock generation
  always begin
    #5 clk = ~clk;
  end

  // Testbench stimulus
  initial begin
    clk = 0;
    rst = 1'b0;
    branch = 1'b0;
    pc_branch_target = 32'h12345678;
    pc_4 = 32'hABCDEF01;

    // rst the program counter
    rst = 1'b1;
    #10 rst = 1'b0;

    // Perform a non-branch operation
    #10;
    $display("Non-branch operation: pc = %h", pc);

    // Perform a branch operation
    branch = 1'b1;
    pc_branch_target = 32'h87654321;
    #10;
    $display("Branch operation: pc = %h", pc);

    $finish;
  end

endmodule
