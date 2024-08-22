`timescale 1ns / 1ps
`include "processor.v"

module processor_tb;

    reg clk;
    reg clk2;
    reg rst;
    wire [31:0] GCD;


    // Instantiate the processor module
    processor uut(
        .clk(clk),
        .clk2(clk2),
        .rst(rst),
        .Pdata(GCD)
    );

     // Create a VCD file for simulation waveform dump
    initial begin
        $dumpfile("GCD.vcd");
        $dumpvars(0, processor_tb);
    end

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        clk2 = 0;
        forever #200 clk2 = ~clk2;
    end

    // Testbench stimulus
    initial begin
        // Monitor Pdata
        // Initialize values by asserting rst
        rst = 1;
        #10 rst = 0;

        // Allow some time for initialization
        #100;

        // De-assert rst to start the processor
        rst = 0;

        #600
        $display("GCD = %d",GCD);
        // Simulate for 100 clock cycles (adjust as needed)
        #1000 $finish;
    end

endmodule
