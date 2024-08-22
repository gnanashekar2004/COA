`timescale 1ns / 1ps
`include "signExtend.v"

module SignExtend_tb;

  reg [15:0] imm16;
  wire [31:0] imm32;

  // Instantiate the SignExtend module
  SignExtend uut (
    .imm16(imm16),
    .imm32(imm32)
  );

  // Testbench stimulus
  initial begin
    // Test case 1: Positive value
    imm16 = 16'b0000000000111100; // 12-bit positive value
    #10;
    $display("Test case 1: imm32 = %h", imm32);

    // Test case 2: Negative value
    imm16 = 16'b1111111111000011; // 12-bit negative value
    #10;
    $display("Test case 2: imm32 = %h", imm32);

    // Test case 3: Zero value
    imm16 = 16'b0000000000000000; // 12-bit zero value
    #10;
    $display("Test case 3: imm32 = %h", imm32);

    $finish;
  end

endmodule
