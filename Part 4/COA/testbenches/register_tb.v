`timescale 1ns / 1ps
`include "register.v"

module regBank_tb;

  reg clk;
  reg rst;
  reg [4:0] rs;
  reg [4:0] rt;
  reg regWrite;
  reg [4:0] writeReg;
  reg [31:0] writeData;
  wire [31:0] rs_out;
  wire [31:0] rt_out;
  wire [31:0] sp;
  wire [31:0] retReg;

  // Instantiate the regBank module
  regBank uut (
    .clk(clk),
    .rst(rst),
    .rs(rs),
    .rt(rt),
    .regWrite(regWrite),
    .writeReg(writeReg),
    .writeData(writeData),
    .rs_out(rs_out),
    .rt_out(rt_out),
    .sp(sp),
    .retReg(retReg)
  );

  // Clock generation
  always begin
    #5 clk = ~clk;
  end

  // Testbench stimulus
  initial begin
    clk = 0;
    rst = 1'b0;
    rs = 5'b00100;   // Register index 4
    rt = 5'b00101;   // Register index 5
    regWrite = 1'b1;
    writeReg = 5'b00100;  // Write to register 4
    writeData = 32'hAABBCCDD;

    // Reset and initialize the registers
    rst = 1'b1;
    #10 rst = 1'b0;

    // Perform a write operation
    #10;
    $display("Writing to register 4");
    writeData = 32'h12345678;
    regWrite = 1'b1;
    writeReg = 5'b00100; // Write to register 4

    // Perform a read operation
    #10;
    $display("Reading from register 4 (rs_out) = %h", rs_out);

    // Perform another read operation
    rs = 5'b00101; // Read from register 5
    #10;
    $display("Reading from register 5 (rt_out) = %h", rt_out);

    // Display the values of the stack pointer and return register
    #10;
    $display("Stack Pointer (sp) = %h", sp);
    $display("Return Register (retReg) = %h", retReg);

    $finish;
  end

endmodule
