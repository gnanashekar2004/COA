`timescale 1ns / 1ps

module ProgramCounter(
    input clk,
    input rst,
    input branch,
    input [31:0] pc_branch_target,
    input [31:0] pc_4,
    output [31:0] pc
);
	//	The outputs are defined as registers too
	reg	[31:0]	pc;
	
	always @(posedge clk)
	begin
		if (rst)
			pc = 0;
		else
		begin
			if (branch)
				pc = pc_branch_target;
			else
				pc = pc_4;
		end
	end

endmodule
