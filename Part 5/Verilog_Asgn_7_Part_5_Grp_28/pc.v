`timescale 1ns / 1ps

module ProgramCounter(
    input clk,
    input rst,
    input [2:0] branch,
	input readIn,
    input [31:0] pc_branch_target,
    input [31:0] pc_4,
    output reg [31:0] pc
);
	//	The outputs are defined as registers too
	// reg	[31:0]	pc;
	
	always @(posedge clk)
	begin
		if (rst)
			pc = 0;
		else if (readIn == 1) // Continue fetching next instruction only if readIn is high
        begin
            if (branch != 000)
                pc <= pc_branch_target;
            else
                pc <= pc_4;
        end
        else if (readIn == 0)
        begin
            pc<=127;
        end
	end

endmodule
