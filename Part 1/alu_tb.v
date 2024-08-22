`timescale 1ns/1ps

module ALU_TestBench;
  reg [7:0] A, B;
  reg clk;        
  reg ld;
  reg opLd;
  reg exe;
  reg out;
  wire [15:0] res;
  wire carryflag;

  parameter ADD  = 6'b000000;
  parameter SUB = 6'b000001;
  parameter AND  = 6'b000010;
  parameter OR = 6'b000011;
  parameter XOR  = 6'b000100;
  parameter NOT = 6'b000101;
  parameter SLA  = 6'b000110;
  parameter SRA = 6'b000111;
  parameter SRL = 6'b001000;
  parameter ADDI = 6'b001001;
  parameter SUBI  = 6'b001010;
  parameter ANDI = 6'b001011;
  parameter ORI  = 6'b001100;
  parameter XORI = 6'b001101;
  parameter NOTI = 6'b001110;
  parameter SLAI = 6'b001111;
  parameter SRAI  = 6'b010000;
  parameter SRLI = 6'b010001;

  ALU uut (
    .A(A),
    .B(B),
    .clk(clk),
    .ld(ld),
    .opLd(opLd),
    .exe(exe),
    .out(out),
    .res(res),
    .carryflag(carryflag)
  );

  always begin
    #5 clk = ~clk; 
  end

  initial begin
    clk = 0;

    A=8'b00001000;
    B=8'b00000100;
    ld=0;
    opLd=0;
    exe=0;
    out=0;
    
    $dumpfile("sim.vcd");
    $dumpvars(0, ALU_TestBench);
    
    #5 ld=1;
    #5 ld=0;
    A=8'b00000000;
    B=8'b00000000;
    #5 ld=1;
    #5 ld=0;
    A=8'b00000000;
    B=8'b00000000;
    #5 ld=1;
    #5 ld=0;
    A=8'b00000000;
    B=8'b00000000;
    #5 ld=1;
    #5 ld=0;
    #5 B[5:0]=SUB;
    #20 opLd=1;
    #5 opLd=0;
    #5 exe=1;#20
    $display("result: %b,%b",res,carryflag);
    #5 out=1;#10
    $display("result: %b,%b",res,carryflag);
    #5 out=0;
    #5 exe=0;


    $finish;
  end

endmodule
