`timescale 1ns / 1ps
`include "pc.v"
`include "insMem.v"
`include "register.v"
`include "signExtend.v"
`include "stackMem.v"
`include "dataMem.v"
`include "branching.v"
`include "control.v"
`include "alu.v"
`include "writeBack.v"

module processor(
    input clk,
    input clk2,
    input rst,
    // output [31:0] inst,
    // output [31:0] PdataA,PdataB,PdataR,
    // output [4:0] RdataA,RdataB,RdataR
    output [31:0] Pdata
);

    // Declare internal signals
    reg [31:0] pc;
    wire [31:0] pc_out;
    reg [31:0] instruction;
    reg [31:0] pc_branch_target;
    wire [31:0] pc_branch_targetw;
    reg [31:0] pc_4;
    wire [31:0] imm32w;
    reg  [31:0] imm32;
    wire [31:0] douta;
    reg [3:0] aluFunc;
    reg readIn, MuxAlu1, MuxAlu2, writeDm, readDm, muxWB, writeReg;
    reg [2:0] branch;
    wire [3:0] aluFuncw;
    wire readInw, MuxAlu1w, MuxAlu2w, writeDmw, readDmw, muxWBw, writeRegw, rstw;
    wire [2:0] branchw;
    wire [31:0] reg1_dataw, reg2_dataw,aluOutw;
    reg [31:0] reg1_data,reg2_data,aluOut;
    reg [31:0] opA, opB;
    wire carryflag, signflag, overflowflag, zflag;
    wire [31:0] readM_data;
    reg [31:0] write_data,writeM_data,addr;
    wire en, push, pop, data_in, data_out, empty;
    wire [31:0] dataSPin,dataSPout;
    wire [31:0] writeBack;
    wire [31:0] stack_pointer, return_Reg;
    reg [4:0] writeRegister;
    wire reg1Sign;
    reg [31:0] ldValue;

    initial begin
        pc=0;
        branch=000;
        pc_branch_target=32'd2;
        pc_4=32'd0;
        readIn=1;
        // write_data=32'd5;
    end

    // Instantiate modules
    ProgramCounter PC(
        .clk(clk),
        .rst(rst),
        .branch(branch),
        .readIn(readIn),
        .pc_branch_target(pc_branch_target),
        .pc_4(pc_4),
        .pc(pc_out)
    );

    InstructionMemory IMem (
        .clk(clk),
        .rsta(rst),
        .addra(pc_out),
        .douta(douta)
    );

    SignExtend SE (
        .imm16(instruction[15:0]),
        .imm32(imm32w)
    );

    ControlUnit CU (
        .clk(clk),
        .instruction(douta),
        .aluFunc(aluFuncw),
        .readIn(readInw),
        .MuxAlu1(MuxAlu1w),
        .MuxAlu2(MuxAlu2w),
        .writeDm(writeDmw),
        .readDm(readDmw),
        .muxWB(muxWBw),
        .writeReg(writeRegw),
        .rst(rstw),
        .branch(branchw)
    );

    regBank RB (
        .clk(clk),
        .rst(rst),
        .rs(instruction[25:21]),
        .rt(instruction[20:16]),
        .regWrite(writeReg),
        .writeReg(writeRegister),
        .writeData(write_data),
        .rs_out(reg1_dataw),
        .rt_out(reg2_dataw),
        .sp(stack_pointer),
        .retReg(return_Reg)
    );

    // assign RdataA=instruction[25:21];
    // assign RdataB=instruction[20:16];
    // assign RdataR=writeRegister;

    ALU arithematic(
        .operandA(opA),
        .operandB(opB),
        .opCode(aluFunc),
        .clk(clk),
        .carryflag(carryflag),
        .signflag(signflag),
        .overflowflag(overflowflag),
        .zflag(zflag),
        .result(aluOutw)
    );

    // assign PdataA=opA;
    // assign PdataB=opB;

    Branching Br(
        .clk(clk),
        .rst(rst),
        .pc_in(pc),
        .regData(reg1_data),
        .offset(imm32),
        .branch(branch),
        .pc_out(pc_branch_targetw)
    );

    DataMemory DMem(
        .clk(clk),
        .rst(rst),
        .address(addr),
        .mem_write(writeDm),
        .mem_read(readDm),
        .write_data(writeM_data),
        .read_data(readM_data)
    );

    StackPointer stkPtr (
        .clk(clk),
        .rst(rst),
        .enable(en),
        .push(push),
        .pop(pop),
        .data_in(dataSPin),
        .data_out(dataSPout),
        .empty(empty),
        .stackPointer(stack_pointer)
    );

    writeBack WB(
        .clk(clk),
        .ldValue(ldValue),
        .aluOut(aluOut),
        .select(muxWB),
        .writeBack(writeBack)
    );

    // assign PdataR = aluOut;
    // assign inst = instruction;
    assign Pdata = writeBack;

    // Connect internal signals
    always @(posedge clk) begin
        pc=pc_out;

        instruction = douta;

        imm32=imm32w;

        aluFunc=aluFuncw;
        readIn=readInw;
        MuxAlu1=MuxAlu1w;
        MuxAlu2=MuxAlu2w;
        writeDm=writeDmw;
        readDm=readDmw;
        muxWB=muxWBw;
        writeReg=writeRegw;
        branch=branchw;

        writeRegister = (instruction[31:29]==000) ? instruction[15:11]: instruction[20:16];

        opA = (MuxAlu1)? reg1_dataw : pc;
        opB = (MuxAlu2)? reg2_dataw : imm32w;

        reg1_data=reg1_dataw;
        reg2_data=reg2_dataw;

        aluOut=aluOutw;

        addr = aluOutw;
        writeM_data = reg2_dataw;

        ldValue = readM_data;

        write_data = writeBack;
    end

    always @(posedge clk2)begin
        pc_4=pc+1;
        pc_branch_target=pc_branch_targetw;
    end

endmodule
