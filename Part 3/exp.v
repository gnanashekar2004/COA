module ALU(
  input [31:0]operandA,
  input [31:0]operandB,
  input [2:0]opCode,
    input clk,
  output reg [31:0]result
);

    always @(posedge clk)begin
      case(opCode)
        3'b000: result = operandA + operandB;//ADD
        3'b001: result = operandA - operandB;//SUB
        3'b010: result = ~operandA;//NOT
        3'b011: result = operandA & operandB;//AND
        3'b100: result = operandA | operandB;//OR
        3'b101: result = operandA ^ operandB[0];//XOR
        3'b110: result = operandA >> operandB[0];//SLL
        3'b111: result = operandA << operandB[0];//SRL
        //SRA???
        default: result = 32'bx;
      endcase
    end

endmodule

module regBank(
    input clk,
    input rst,
    input [4:0] rs,
    input [4:0] rt,
    input regWrite,
    input [4:0] writeReg,
    input [31:0] writeData,
    output [31:0] rs_out,
    output [31:0] rt_out
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

    assign rs_out=register[rs];
    assign rt_out=registers[rt];
endmodule

module top_module(
  	input [15:0]value,
    input ldV1,
    input ldV2,
    input ldR,
    input ldIR1,
    input ldIR2,
    input clk,
  	output reg [15:0]display
);
    initial begin
        display=16'b0;
        regNum=5'b0;
        val=32'b0;
        regA=32'b0;
        regB=32'b0;
        IR=32'b0;
        alu_result=32'b0;
    end

    regBank rbank(
        .clk(clk),
        .rst(0),
        .rs(IR[25:21]),
        .rt(IR[20:16]),
        .regWrite(1),
        .writeReg(regNum),
        .writeData(datain),
        .rs_out(regA_wire),
        .rt_out(regB_wire)
    );

    ALU aluwork(
        .operandA(regA),
        .operandB(regB),
        .opCode(IR[28:26]),
        .clk(clk),
      	.result(alu_result_wire)
    );


    reg [31:0] val;
    reg [31:0] datain;
    reg [4:0] regNum;
    reg [31:0] IR;
  	reg  [31:0] regA;
  	reg  [31:0] regB;
    wire [31:0] regA_wire;
    wire [31:0] regB_wire;
  	wire [31:0] alu_result_wire;
  	reg  [31:0] alu_result;

    always @(posedge clk)begin
        if(ldV1)begin
            val[15:0]=value;
        end
        if(ldV2)begin
            val[31:16]=value;
        end
        if(ldR)begin
            regNum<=value[4:0];
            datain<=val;
        end
        if(ldR==0)begin
            regNum<=IR[15:11];
            datain<=alu_result;
        end
        if(ldIR1)begin
            IR[15:0]=value;
        end
        if(ldIR2)begin
            IR[31:16]=value;
        end

        assign regA=regA_wire;
        assign regB=regB_wire;
      	assign alu_result=alu_result_wire;
        assign display=alu_result[15:0];
    end

    
endmodule