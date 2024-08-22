// `timescale 1ns/1ps

module top_module_tb;
    reg [15:0]value;
    reg ldV1;
    reg ldV2;
    reg ldR;
    reg ldIR1;
    reg ldIR2;
    reg clk;
    wire [15:0]display;

    top_module DUT(
        .value(value),
        .ldV1(ldV1),
        .ldV2(ldV2),
        .ldR(ldR),
        .ldIR1(ldIR1),
        .ldIR2(ldIR2),
        .clk(clk),
        .display(display)
    );

    always begin
       #5 clk = ~clk;
    end

    initial begin
        clk=0;
      $monitor("Time= %0t: display output: %b(%d)",$time,display,display);
        
        value=16'b0000000000000110;
        ldV1=1;
        #10
        ldV1=0;
        value=16'b0;
        ldV2=1;
        #10
        ldV2=0;
        value=16'b0000000000000001;
        ldR=1;
        #100
        ldR=0;

        value=16'b0000000000000100;
        ldV1=1;
        #10
        ldV1=0;
        value=16'b0;
        ldV2=1;
        #5
        ldV2=0;
        value=16'b0000000000000010;
        ldR=1;
        #50
        ldR=0;

        value=16'b0010000000000000;
        ldIR1=1;
        #10
        ldIR1=0;
        value=16'b0000000000100010;//ADD
        ldIR2=1;
        #10
        ldIR2=0;
      	#500
      	value=16'b0000010000100010;//SUB
        ldIR2=1;
        #10
        ldIR2=0;
      	#500
      	

        $finish;
    end
endmodule