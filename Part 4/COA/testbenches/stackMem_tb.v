`timescale 1ns / 1ps
`include "stackMem.v"

module StackPointer_tb;

  reg clk;
  reg rst;
  reg enable;
  reg push;
  reg pop;
  reg [31:0] data_in;
  wire [31:0] data_out;
  wire empty;
  wire [7:0] stackPointer;

  // Instantiate the StackPointer module
  StackPointer uut (
    .clk(clk),
    .rst(rst),
    .enable(enable),
    .push(push),
    .pop(pop),
    .data_in(data_in),
    .data_out(data_out),
    .empty(empty),
    .stackPointer(stackPointer)
  );

  // Clock generation
  always begin
    #5 clk = ~clk;
  end

  // Testbench stimulus
  initial begin

    // Check if the stack is empty
    $monitor("Is stack empty? %b, Popped data: %h, Stack pointer: %d", empty,data_out,stackPointer);

    clk = 0;
    rst = 1'b0;
    enable = 1'b1;
    push = 1'b0;
    pop = 1'b0;
    data_in = 32'h0;

    // Reset the stack pointer
    rst = 1'b1;
    #10 rst = 1'b0;

    // Push data onto the stack
    data_in = 32'h12345678;
    push = 1'b1;
    #10 push = 1'b0;

    // Pop data from the stack
    pop = 1'b1;
    #10 pop = 1'b0;

    $finish;
  end

endmodule
