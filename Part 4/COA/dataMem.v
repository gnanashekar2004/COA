`timescale 1ns / 1ps

module DataMemory(
    input clk,
    input rst,
    input [31:0] address,
    input mem_write,
    input mem_read,
    input [31:0] write_data,
    output [31:0] read_data
);

   parameter MemSize=128;
	
	reg	[31:0]	DMem[0:MemSize];

	assign read_data = DMem[address];

	always @(posedge clk ) 
	begin
		if(rst)
		begin
			DMem[0] = 3;
			DMem[1] = 4;
			DMem[2] = 10;
			DMem[3] = 28;
			DMem[4] = 5;
			DMem[5] = 20;
		end
		if (mem_write)	
			DMem[address] = write_data;
	end	
endmodule
