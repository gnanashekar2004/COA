module ADD(in1,in2,result);
    input [7:0] in1,in2;
    output reg [8:0] result;
    
    always @(*) begin
        result = in1 + in2;
    end
endmodule

module SUB(in1,in2,result);
    input [7:0] in1,in2;
    output reg [8:0] result;

    always @(*) begin
        result = in1 - in2;
    end
endmodule

module IDEN(in1,result);
    input [7:0] in1;
    output reg [8:0] result;

    always @(*) begin
        result = in1;
    end
endmodule

module LS(in1,result);
    input [7:0] in1;
    output reg [8:0] result;

    always @(*) begin
        result = in1 << 1;
    end
endmodule

module RS(in1,result);
    input [7:0] in1;
    output reg [8:0] result;

    always @(*) begin
        result = in1 >> 1;
    end
endmodule

module AND(in1,in2,result);
    input [7:0] in1,in2;
    output reg [8:0] result;

    always @(*) begin
        result = in1 & in2;
    end
endmodule

module NOT(in1,result);
    input [7:0] in1;
    output reg [8:0] result;

    always @(*) begin
        result = ~in1;
    end
endmodule


module OR(in1,in2,result);
    input [7:0] in1,in2;
    output reg [8:0] result;

   always @(*) begin
        result = in1 | in2;
    end
endmodule

module ALU(
    input clk,
    input [7:0] in1,
    input [7:0] in2,
    input [2:0] select,
    output reg [7:0] result
);
    reg [7:0] result_internal;
    wire [7:0] result_add, result_sub, result_iden, result_ls, result_rs, result_and, result_not, result_or;


    // Instantiate modules
    ADD add_inst(.in1(in1), .in2(in2), .result(result_add));
    SUB sub_inst(.in1(in1), .in2(in2), .result(result_sub));
    IDEN iden_inst(.in1(in1), .result(result_iden));
    LS ls_inst(.in1(in1), .result(result_ls));
    RS rs_inst(.in1(in1), .result(result_rs));
    AND and_inst(.in1(in1), .in2(in2), .result(result_and));
    NOT not_inst(.in1(in1), .result(result_not));
    OR or_inst(.in1(in1), .in2(in2), .result(result_or));

always @(posedge clk) begin
    case (select)
        3'b000: result <= result_add;
        3'b001: result <= result_sub;
        3'b010: result <= result_iden;
        3'b011: result <= result_ls;
        3'b100: result <= result_rs;
        3'b101: result <= result_and;
        3'b110: result <= result_not;
        3'b111: result <= result_or;
        default: result <= 8'bz;
    endcase
end


endmodule
