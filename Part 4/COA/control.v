`timescale 1ns / 1ps

`define ADD 6'b000000
`define SUB 6'b000001
`define NOT 6'b000010
`define AND 6'b000011
`define OR  6'b000100
`define XOR 6'b000101
`define SLL 6'b000110
`define SR  6'b000111 //based on func go for SRL or SRA

`define ADDI 6'b001000
`define SUBI 6'b001001
`define NOTI 6'b001010
`define ANDI 6'b001011
`define ORI  6'b001100
`define XORI 6'b001101
`define SLLI 6'b001110
`define SRLI 6'b001111

`define LD 6'b010000
`define ST 6'b010001
`define LDSP 6'b010010
`define STSP 6'b010011

`define BR 6'b011000
`define BMI 6'b011001
`define BPL 6'b011010
`define BZ 6'b011011

`define PUSH 6'b100000
`define POP 6'b100001
`define CALL 6'b100010
`define RET 6'0100011

`define MOVE 6'b101000

`define NOP 6'b110000

`define HALT 6'b111000

module ControlUnit(
    input clk,
    input [31:0] instruction,
    output reg [3:0] aluFunc;
    output reg readIn,MuxAlu1,MuxAlu2,writeDm,readDm,muxWB,writeReg,
    output reg rst,
    output reg [2:0] branch
);

    always@(posedge clk)begin
        always@(instruction)begin
            case(instruction[31:26])
                ADD:
                    begin
                        readIn=1'b1;
                        MuxAlu1=1'b1;
                        MuxAlu2=1'b1;
                        writeDm=1'b0;
                        readDm=1'b0;
                        muxWB=1'b1;
                        writeReg=1'b1;
                        rst=1'b0;
                        branch=3'b000;
                        aluFunc=4'b0000;
                    end
                SUB:
                    begin
                        readIn=1'b1;
                        MuxAlu1=1'b1;
                        MuxAlu2=1'b1;
                        writeDm=1'b0;
                        readDm=1'b0;
                        muxWB=1'b1;
                        writeReg=1'b1;
                        rst=1'b0;
                        branch=3'b000;
                        aluFunc=4'b0001;
                    end
                NOT:
                    begin
                        readIn=1'b1;
                        MuxAlu1=1'b1;
                        MuxAlu2=1'b1;
                        writeDm=1'b0;
                        readDm=1'b0;
                        muxWB=1'b1;
                        writeReg=1'b1;
                        rst=1'b0;
                        branch=3'b000;
                        aluFunc=4'b0010;
                    end
                AND:
                    begin
                        readIn=1'b1;
                        MuxAlu1=1'b1;
                        MuxAlu2=1'b1;
                        writeDm=1'b0;
                        readDm=1'b0;
                        muxWB=1'b1;
                        writeReg=1'b1;
                        rst=1'b0;
                        branch=3'b000;
                        aluFunc=4'b0011;
                    end
                OR:
                    begin
                        readIn=1'b1;
                        MuxAlu1=1'b1;
                        MuxAlu2=1'b1;
                        writeDm=1'b0;
                        readDm=1'b0;
                        muxWB=1'b1;
                        writeReg=1'b1;
                        rst=1'b0;
                        branch=3'b000;
                        aluFunc=4'b0100;
                    end
                XOR:
                    begin
                        readIn=1'b1;
                        MuxAlu1=1'b1;
                        MuxAlu2=1'b1;
                        writeDm=1'b0;
                        readDm=1'b0;
                        muxWB=1'b1;
                        writeReg=1'b1;
                        rst=1'b0;
                        branch=3'b000;
                        aluFunc=4'b0101;
                    end
                SLL:
                    begin
                        readIn=1'b1;
                        MuxAlu1=1'b1;
                        MuxAlu2=1'b1;
                        writeDm=1'b0;
                        readDm=1'b0;
                        muxWB=1'b1;
                        writeReg=1'b1;
                        rst=1'b0;
                        branch=3'b000;
                        aluFunc=4'b0110;
                    end
                SR:
                    begin
                        readIn=1'b1;
                        MuxAlu1=1'b1;
                        MuxAlu2=1'b1;
                        writeDm=1'b0;
                        readDm=1'b0;
                        muxWB=1'b1;
                        writeReg=1'b1;
                        rst=1'b0;
                        branch=3'b000;
                        case(instruction[5:0])
                            6'b000000:aluFunc=4'b0111;
                            6'b000001:aluFunc=4'b1000;
                        endcase
                    end
                ADDI:
                    begin
                        readIn=1'b1;
                        MuxAlu1=1'b1;
                        MuxAlu2=1'b0;
                        writeDm=1'b0;
                        readDm=1'b0;
                        muxWB=1'b1;
                        writeReg=1'b1;
                        rst=1'b0;
                        branch=3'b000;
                        aluFunc=4'b0000;
                    end
                SUBI:
                    begin
                        readIn=1'b1;
                        MuxAlu1=1'b1;
                        MuxAlu2=1'b0;
                        writeDm=1'b0;
                        readDm=1'b0;
                        muxWB=1'b1;
                        writeReg=1'b1;
                        rst=1'b0;
                        branch=3'b000;
                        aluFunc=4'b0001;
                    end
                NOTI:
                    begin
                        readIn=1'b1;
                        MuxAlu1=1'b1;
                        MuxAlu2=1'b0;
                        writeDm=1'b0;
                        readDm=1'b0;
                        muxWB=1'b1;
                        writeReg=1'b1;
                        rst=1'b0;
                        branch=3'b000;
                        aluFunc=4'b0010;
                    end
                ANDI:
                    begin
                        readIn=1'b1;
                        MuxAlu1=1'b1;
                        MuxAlu2=1'b0;
                        writeDm=1'b0;
                        readDm=1'b0;
                        muxWB=1'b1;
                        writeReg=1'b1;
                        rst=1'b0;
                        branch=3'b000;
                        aluFunc=4'b0011;
                    end
                ORI:
                    begin
                        readIn=1'b1;
                        MuxAlu1=1'b1;
                        MuxAlu2=1'b0;
                        writeDm=1'b0;
                        readDm=1'b0;
                        muxWB=1'b1;
                        writeReg=1'b1;
                        rst=1'b0;
                        branch=3'b000;
                        aluFunc=4'b0100;
                    end
                XORI:
                    begin
                        readIn=1'b1;
                        MuxAlu1=1'b1;
                        MuxAlu2=1'b0;
                        writeDm=1'b0;
                        readDm=1'b0;
                        muxWB=1'b1;
                        writeReg=1'b1;
                        rst=1'b0;
                        branch=3'b000;
                        aluFunc=4'b0101;
                    end
                SLLI:
                    begin
                        readIn=1'b1;
                        MuxAlu1=1'b1;
                        MuxAlu2=1'b0;
                        writeDm=1'b0;
                        readDm=1'b0;
                        muxWB=1'b1;
                        writeReg=1'b1;
                        rst=1'b0;
                        branch=3'b000;
                        aluFunc=4'b0110;
                    end
                SRLI:
                    begin
                        readIn=1'b1;
                        MuxAlu1=1'b1;
                        MuxAlu2=1'b0;
                        writeDm=1'b0;
                        readDm=1'b0;
                        muxWB=1'b1;
                        writeReg=1'b1;
                        rst=1'b0;
                        branch=3'b000;
                        aluFunc=4'b0111;
                    end
                LD:
                    begin
                        readIn=1'b1;
                        MuxAlu1=1'b1;
                        MuxAlu2=1'b0;
                        writeDm=1'b0;
                        readDm=1'b1;
                        muxWB=1'b0;
                        writeReg=1'b1;
                        rst=1'b0;
                        branch=3'b000;
                        aluFunc=4'b0000;
                    end
                ST:
                    begin
                        readIn=1'b1;
                        MuxAlu1=1'b1;
                        MuxAlu2=1'b0;
                        writeDm=1'b1;
                        readDm=1'b0;
                        muxWB=1'b0;
                        writeReg=1'b1;
                        rst=1'b0;
                        branch=3'b000;
                        aluFunc=4'b0000;
                    end
                LDSP:
                    begin
                        readIn=1'b1;
                        MuxAlu1=1'b1;
                        MuxAlu2=1'b0;
                        writeDm=1'b0;
                        readDm=1'b1;
                        muxWB=1'b0;
                        writeReg=1'b1;
                        rst=1'b0;
                        branch=3'b000;
                        aluFunc=4'b0000;
                    end
                STSP:
                    begin
                        readIn=1'b1;
                        MuxAlu1=1'b1;
                        MuxAlu2=1'b0;
                        writeDm=1'b1;
                        readDm=1'b0;
                        muxWB=1'b0;
                        writeReg=1'b1;
                        rst=1'b0;
                        branch=3'b000;
                        aluFunc=4'b0000;
                    end
                BR:
                    begin
                        readIn=1'b1;
                        MuxAlu1=1'b0;
                        MuxAlu2=1'b0;
                        writeDm=1'b0;
                        readDm=1'b0;
                        muxWB=1'b0;
                        writeReg=1'b0;
                        rst=1'b0;
                        branch=3'b001;
                        aluFunc=4'b0000;
                    end
                BMI:
                    begin
                        readIn=1'b1;
                        MuxAlu1=1'b0;
                        MuxAlu2=1'b0;
                        writeDm=1'b0;
                        readDm=1'b0;
                        muxWB=1'b0;
                        writeReg=1'b0;
                        rst=1'b0;
                        branch=3'b010;
                        aluFunc=4'b0000;
                    end
                BPL:
                    begin
                        readIn=1'b1;
                        MuxAlu1=1'b0;
                        MuxAlu2=1'b0;
                        writeDm=1'b0;
                        readDm=1'b0;
                        muxWB=1'b0;
                        writeReg=1'b0;
                        rst=1'b0;
                        branch=3'b011;
                        aluFunc=4'b0000;
                    end
                BZ:
                    begin
                        readIn=1'b1;
                        MuxAlu1=1'b0;
                        MuxAlu2=1'b0;
                        writeDm=1'b0;
                        readDm=1'b0;
                        muxWB=1'b0;
                        writeReg=1'b0;
                        rst=1'b0;
                        branch=3'b100;
                        aluFunc=4'b0000;
                    end
                PUSH:
                    begin
                        readIn=1'b1;
                        MuxAlu1=1'b1;
                        MuxAlu2=1'b0;
                        writeDm=1'b1;
                        readDm=1'b0;
                        muxWB=1'b0;
                        writeReg=1'b1;
                        rst=1'b0;
                        branch=3'b000;
                        aluFunc=4'b0001;
                    end
                POP:
                    begin
                        readIn=1'b1;
                        MuxAlu1=1'b0;
                        MuxAlu2=1'b0;
                        writeDm=1'b0;
                        readDm=1'b1;
                        muxWB=1'b0;
                        writeReg=1'b1;
                        rst=1'b0;
                        branch=3'b000;
                        aluFunc=4'b0000;
                    end
                CALL:
                    begin
                        readIn=1'b1;
                        MuxAlu1=1'b1;
                        MuxAlu2=1'b0;
                        writeDm=1'b1;
                        readDm=1'b0;
                        muxWB=1'b0;
                        writeReg=1'b1;
                        rst=1'b0;
                        branch=3'b000;
                        aluFunc=4'b0001;
                    end
                RET:
                    begin
                        readIn=1'b1;
                        MuxAlu1=1'b0;
                        MuxAlu2=1'b0;
                        writeDm=1'b0;
                        readDm=1'b1;
                        muxWB=1'b0;
                        writeReg=1'b1;
                        rst=1'b0;
                        branch=3'b000;
                        aluFunc=4'b0000;
                    end
                MOVE:
                    begin
                        readIn=1'b1;
                        MuxAlu1=1'b1;
                        MuxAlu2=1'b0;
                        writeDm=1'b0;
                        readDm=1'b0;
                        muxWB=1'b1;
                        writeReg=1'b1;
                        rst=1'b0;
                        branch=3'b000;
                        aluFunc=4'b0000;
                    end
                NOP:
                    begin
                        readIn=1'b1;
                        MuxAlu1=1'b0;
                        MuxAlu2=1'b0;
                        writeDm=1'b0;
                        readDm=1'b0;
                        muxWB=1'b0;
                        writeReg=1'b0;
                        rst=1'b0;
                        branch=3'b000;
                        aluFunc=4'b0000;
                    end
                HALT:
                    begin
                        readIn=1'b0;
                        MuxAlu1=1'b0;
                        MuxAlu2=1'b0;
                        writeDm=1'b0;
                        readDm=1'b0;
                        muxWB=1'b0;
                        writeReg=1'b0;
                        rst=1'b1;
                        branch=3'b000;
                        aluFunc=4'b0000;
                    end
            endcase
        end
    end
