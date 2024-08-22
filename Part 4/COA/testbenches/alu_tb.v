`timescale 1ns / 1ps
`include "alu.v"

module ALU_tb;

  reg [31:0] operandA;
  reg [31:0] operandB;
  reg [3:0] opCode;
  reg clk;
  wire [31:0] result;

  // Instantiate the ALU module
  ALU uut (
    .operandA(operandA),
    .operandB(operandB),
    .opCode(opCode),
    .clk(clk),
    .result(result)
  );

  // Clock generation
  always begin
    #5 clk = ~clk;
  end

  // Testbench stimulus
  initial begin
    clk = 0;
    operandA = 32'hAABBCCDD;
    operandB = 32'hE1223341;
    
    // Test case 1: ADD
    opCode = 4'b0000;
    #10;
    $display("ADD: operandA + operandB = %h", result);
    
    // Test case 2: SUB
    opCode = 4'b0001;
    #10;
    $display("SUB: operandA - operandB = %h", result);
    
    // Test case 3: NOT
    opCode = 4'b0010;
    #10;
    $display("NOT: ~operandA = %h", result);
    
    // Test case 4: AND
    opCode = 4'b0011;
    #10;
    $display("AND: operandA & operandB = %h", result);
    
    // Test case 5: OR
    opCode = 4'b0100;
    #10;
    $display("OR: operandA | operandB = %h", result);
    
    // Test case 6: XOR
    opCode = 4'b0101;
    #10;
    $display("XOR: operandA ^ operandB[0] = %h", result);
    
    // Test case 7: SLL
    opCode = 4'b0110;
    #10;
    $display("SLL: operandA << operandB[0] = %h", result);
    
    // Test case 8: SRL
    opCode = 4'b0111;
    #10;
    $display("SRL: operandA >> operandB[0] = %h", result);
    
    // Test case 9: SRA
    opCode = 4'b1000;
    #10;
    $display("SRA: operandA >> operandB[0] = %h", result);
    
    $finish;
  end

endmodule
