`timescale 1ns / 1ps
`include "insMem.v"

module InstructionMemory_tb;

  reg clk;
  reg rsta;
  reg [31:0] addra;
  wire [31:0] douta;

  // Instantiate the InstructionMemoryi module
  InstructionMemory uut (
    .clk(clk),
    .rsta(rsta),
    .addra(addra),
    .douta(douta)
  );

  // Clock generation
  always begin
    #5 clk = ~clk;
  end

  // Testbench stimulus
  initial begin
    clk = 0;
    rsta = 1'b0;

    // Reset the instruction memory and initialize it
    rsta = 1'b1;
    #10 rsta = 1'b0;

    // Read and display instructions from IMem[0] to IMem[31]
    for (addra = 0; addra < 32; addra = addra + 1) begin
      #10;
      $display("Instruction at address %d: %h", addra, douta);
    end

    // Read and display instructions from IMem[32] to IMem[127]
    for (addra = 32; addra < 128; addra = addra + 1) begin
      #10;
      $display("Instruction at address %d: %h", addra, douta);
    end

    $finish;
  end

endmodule
