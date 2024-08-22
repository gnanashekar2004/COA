`timescale 1ns / 1ps

module processor(
    input clk;
    input rst;
);

    ProgramCounter PC(
        .clk(clk),
        .rst(rst),
        .branch(branch),
        .pc_branch_target(pc_branch_target),
        .pc_4(pc_4),
        .pc(pc)
    );

    InstructionMemory IMem (
        .clk(clk),
        .rsta(rst),
        .addra(pc),
        .douta(douta)
    );

    SignExtend SE (
        .imm16(imm16),
        .imm32(imm32)
    ); 

    ControlUnit CU(

    );

    regBank RB (
        .clk(clk),
        .rst(rst),
        .rs(reg1),
        .rt(reg2),
        .regWrite(writeReg),
        .writeReg(writeRegister),
        .writeData(writeData),
        .rs_out(reg1_data),
        .rt_out(reg2_data),
        .sp(stack_pointer),
        .retReg(return_Reg)
    );

    ALU arithematic(
        .operandA(opA),
        .operandB(opB),
        .opCode(aluOP),
        .clk(clk),
        .carryflag(carryflag),
        .signflag(signflag),
        .overflowflag(overflowflag),
        .zflag(zflag),
        .result(aluOut)
    )

    Branching Br(
        .clk(clk),
        .rst(rst),
        .pc_in(pc),
        .regData(reg1),
        .regDataSign(reg1Sign),
        .offset(imm32),
        .branch(branch),
        .pc_out(pc_branch_target)
    );

    DataMemory DMem(
        .clk(clk),
        .rst(rst),
        .address(addr),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .write_data(write_data),
        .read_data(read_data)
    );

    StackPointer stkPtr (
        .clk(clk),       
        .rst(rst),      
        .enable(en),    
        .push(push),      
        .pop(pop),
        .data_in(data_in),
        .data_out(data_out),
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





endmodule