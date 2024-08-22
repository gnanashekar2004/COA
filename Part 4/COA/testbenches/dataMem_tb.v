`timescale 1ns / 1ps
`include "dataMem.v"

module DataMemory_tb;

  reg clk;
  reg rst;
  reg [31:0] address;
  reg mem_write;
  reg mem_read;
  reg [31:0] write_data;
  wire [31:0] read_data;

  // Instantiate the DataMemory module
  DataMemory uut (
    .clk(clk),
    .rst(rst),
    .address(address),
    .mem_write(mem_write),
    .mem_read(mem_read),
    .write_data(write_data),
    .read_data(read_data)
  );

  // Clock generation
  always begin
    #5 clk = ~clk;
  end

  // Testbench stimulus
  initial begin
    clk = 0;
    rst = 1'b0;
    address = 32'h0;
    mem_write = 1'b0;
    mem_read = 1'b0;
    write_data = 32'h0;

    // Reset the memory and initialize it
    rst = 1'b1;
    #10 rst = 1'b0;

    // Read and display initial memory values
    for (address = 0; address < 6; address = address + 1) begin
      mem_read = 1'b1;
      #10;
      $display("Read from address %d: %h", address, read_data);
      mem_read = 1'b0;
    end

    // Write to memory and read the modified values
    address = 32'h1;
    write_data = 32'h12345678;
    mem_write = 1'b1;
    #10;
    $display("Write to address 1: %h", write_data);
    mem_write = 1'b0;

    address = 32'h1;
    mem_read = 1'b1;
    #10;
    $display("Read from address 1: %h", read_data);
    mem_read = 1'b0;

    $finish;
  end

endmodule
