`timescale 1ns / 1ps

module StackPointer (
    input wire clk,       // Clock input
    input wire rst,       // Reset input
    input wire enable,    // Enable signal for stack operations
    input wire push,      // Push data onto the stack
    input wire pop,       // Pop data from the stack
    input wire [31:0] data_in,  // Data to be pushed onto the stack
    output wire [31:0] data_out, // Data popped from the stack
    output wire empty,    // Stack empty signal
    output wire [31:0] stackPointer
);

    reg [31:0] stack[0:63]; // Stack memory with 16 entries (adjust as needed)
    reg [7:0] sp;           // Stack pointer

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset the stack pointer
            sp <= 0;
        end else if (enable) begin
            // Push data onto the stack
            if (push) begin
                stack[sp] <= data_in;
                sp <= sp + 1;
            end
            // Pop data from the stack
            else if (pop) begin
                sp <= sp - 1;
            end
        end
    end

    assign data_out = (sp==0)? 0 : stack[sp - 1]; // Data at the top of the stack
    assign empty = (sp == 0);      // Stack empty when sp is zero
    assign stackPointer=sp;
endmodule
