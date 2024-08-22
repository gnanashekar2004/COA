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