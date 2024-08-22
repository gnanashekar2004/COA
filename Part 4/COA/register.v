module regBank(
    input clk,
    input rst,
    input [4:0] rs,
    input [4:0] rt,
    input regWrite,
    input [4:0] writeReg,
    input [31:0] writeData,
    output [31:0] rs_out,
    output [31:0] rt_out,
    output [31:0] sp, //stack pointer = 29th register
    output [31:0] retReg // for getting final output while testing
);

    reg [31:0] registers [31:0];
    integer i;

    always @(posedge clk) begin
      if(rst) begin
        for(i=0;i<32;i=i+1)
            registers[i]<=32'b0;
      end
      else if(regWrite) begin
        registers[writeReg] <= writeData;
      end
    end

    assign rs_out=registers[rs];
    assign rt_out=registers[rt];
    assign retReg = registers[5'b00001];
    assign sp = registers[5'b11101];
endmodule