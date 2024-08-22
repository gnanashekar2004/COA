`timescale 1ns / 1 ps

module Branching(
    input clk,
    input rst,
    input [31:0] pc_in,
    input [31:0] regData,
    input regDataSign,
    input [31:0] offset,
    input [2:0] branch,
    output reg [31:0] pc_out
);

    always @(posedge clk)begin
        if(rst)
        begin
            pc_out<=32'b0;
        end
        case(branch)
            3'b000: pc_out<=pc_in+1;
            3'b001:
            begin
                   pc_out<=pc_in+offset;
            end
            3'b010: 
            begin
                if(regDataSign)
                    pc_out<=pc_in+offset;
                else
                    pc_out<=pc_in+1;
            end
            3'b011:
            begin
                if(regDataSign)
                    pc_out<=pc_in+1;
                else
                    pc_out<=pc_in+offset;
            end
            3'b100:
                if(regData==0)
                    pc_out<=pc_in+offset;
                else
                    pc_out<=pc_in+1;
        endcase  
    end

endmodule