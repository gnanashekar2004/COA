`timescale 1ns / 1ps

module writeBack(
    input clk,
    input [31:0]ldValue,
    input [31:0]aluOut,
    input select,
    output [31:0] writeBack
);

    assign writeBack = (select) ? aluOut : ldValue;

endmodule