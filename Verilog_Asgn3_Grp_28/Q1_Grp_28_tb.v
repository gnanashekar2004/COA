`timescale 1ns/1ns

module ALU_tb;

    reg clk;
    reg [7:0] in1,in2;
    reg [2:0] select;
    wire [7:0] result;

    ALU DUT(.in1(in1),.in2(in2),.select(select),.clk(clk),.result(result));

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
    // Test case 0: select = 000 (ADD)
    in1 = 8'b11001100;
    in2 = 8'b00110011;
    select = 3'b000;
    #20;
    $display("output for ADD with %d, %d: %d", in1, in2, result);
    
    // Test case 1: select = 001 (SUB)
    in1 = 8'b10101010;
    in2 = 8'b01010101;
    select = 3'b001;
    #20;
    $display("output for SUB with %d, %d: %d", in1, in2, result);
    
    // Test case 2: select = 010 (IDEN)
    in1 = 8'b11110000;
    in2 = 8'b00001111;
    select = 3'b010;
    #20;
    $display("output for IDEN with %d: %d", in1, result);
      
    // Test case 3: select = 011 (LS)
    in1 = 8'b01010101;
    in2 = 8'b10101010;
    select = 3'b011;
    #20;
    $display("output for LS with %d: %d", in1, result);
    
    // Test case 4: select = 100 (RS)
    in1 = 8'b00110011;
    in2 = 8'b11001100;
    select = 3'b100;
    #20;
    $display("output for RS with %d: %d", in1, result);
    
    // Test case 5: select = 101 (AND)
    in1 = 8'b00001111;
    in2 = 8'b11110000;
    select = 3'b101;
    #20;
    $display("output for AND with %d, %d: %d", in1,in2, result);
    
    // Test case 6: select = 110 (NOT)
    in1 = 8'b11111111;
    in2 = 8'b00000000;
    select = 3'b110;
    #20;
    $display("output for NOT with %d, %d: %d", in1, in2, result);
    
    // Test case 7: select = 111 (OR)
    in1 = 8'b01010101;
    in2 = 8'b10101010;
    select = 3'b111;
    #20;
    $display("output for OR with %d, %d: %d", in1, in2, result);
    
    $finish;
end



endmodule