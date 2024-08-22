`timescale 1ns/1ps

module ALU (
  input [31:0] operand_A,
  input [31:0] operand_B,
  input [5:0] operation,
  input clk,
  output reg [31:0] result,
  output reg carryflag
);

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


  always @(posedge clk) begin
    case (operation)
      ADD, ADDI: result = operand_A + operand_B;
      SUB, SUBI: result = operand_A - operand_B;
      AND, ANDI: result = operand_A & operand_B;
      OR, ORI:   result = operand_A | operand_B;
      XOR, XORI: result = operand_A ^ operand_B;
      NOT, NOTI: result = ~operand_A;
      SLA, SLAI: result = operand_A << operand_B[0];
      SRA, SRAI: result = operand_A >> operand_B[0];
      SRL, SRLI: result = operand_A >>> operand_B[0];
      default:    result = 32'bx;
    endcase

    carryflag = (((operation == ADD) || (operation == ADDI)) && (result < operand_A || result < operand_B)) ? 1'b1 : 1'b0;
  end

endmodule

module ioManager (
  input [7:0] A,
  input [7:0] B,
  input clk,
  input ld,
  input opLd,
  input exe,
  input out,
  output reg [15:0] res,
  output reg carryflag
);

  reg [31:0] operand_A;
  reg [31:0] operand_B;
  reg [5:0] operation;
  reg [31:0] result;

  integer count = 0;

  always @(posedge clk) begin
    if (ld) begin
      case (count)
        0:begin 
            operand_A[7:0] = A;
            operand_B[7:0] = B;
        end
        1:begin 
            operand_A[15:8] = A;
            operand_B[15:8] = B;
        end
        2: begin 
            operand_A[23:16] = A;
            operand_B[23:16] = B;
        end
        3: begin
            operand_A[31:24] = A;
            operand_B[31:24] = B;
        end
      endcase
      count = (count + 1) % 4;
    end
  end

  always @(posedge clk) begin
    if (opLd) begin
      operation[5:0] = B[5:0];
    end
  end
  
  wire carryF;
  wire [31:0]reslt;
  
	ALU ALU_instance (
        .operand_A(operand_A),
        .operand_B(operand_B),
        .operation(operation),
        .clk(clk),
        .result(reslt),
      	.carryflag(carryF)
      );
  
  always @(posedge clk) begin
    if (exe) begin
        result=result;
    end
  end

  always @(posedge clk) begin
    res=result[15:0];
    if (out) begin
      res = result[31:16];
    end
    carryflag=carryF;
  end

endmodule