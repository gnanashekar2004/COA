`timescale 1ns / 1ps
`include "writeBack.v"

module writeBack_tb;

  reg clk;
  reg [31:0] ldValue;
  reg [31:0] aluOut;
  reg select;
  wire [31:0] writeBack;

  // Instantiate the writeBack module
  writeBack uut (
    .clk(clk),
    .ldValue(ldValue),
    .aluOut(aluOut),
    .select(select),
    .writeBack(writeBack)
  );

  // Clock generation
  always begin
    #5 clk = ~clk;
  end

  // Testbench stimulus
  initial begin
    clk = 0;
    ldValue = 32'h12345678;
    aluOut = 32'h87654321;
    select = 1'b0;

    // Set select to 0, output should be aluOut
    select = 1'b0;
    #10;
    $display("Select is 0: writeBack = %h", writeBack);

    // Set select to 1, output should be ldValue
    select = 1'b1;
    #10;
    $display("Select is 1: writeBack = %h", writeBack);

    $finish;
  end

endmodule
