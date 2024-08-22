`timescale 1ns / 1ps

module SignExtend(input [15:0] imm16, output  [31:0] imm32);

	assign imm32[31:0] = { {16{imm16[15]}},imm16[15:0] };

endmodule
