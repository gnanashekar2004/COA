module ALU(
  input [31:0]operandA,
  input [31:0]operandB,
  input [3:0]opCode,
  input clk,
  output reg carryflag,
	output reg signflag,
  output reg overflowflag,
  output reg zflag,
  output reg [31:0]result
);

    always @(posedge clk)begin
      case(opCode)
        4'b0000: //ADD
          begin
            {carryflag, result} = operandA + operandB;
            if((operandA >= 0 && operandB >=0  && result < 0) || (operandA<0 && operandB<0 && result >=0))begin
              overflowflag = 1;
            end
            else
            begin
              overflowflag = 0;
            end
            zflag = (result == 0) ? 1 : 0;
          end
        4'b0001: //SUB
          begin
            result = operandA - operandB;
            overflowflag = 0;
            carryflag = 0;
            zflag = (result == 0) ? 1 : 0;
          end
        4'b0010: //NOT
        begin
            result = ~operandA;//NOT
            overflowflag = 0;
            carryflag = 0;
            zflag = (result == 0) ? 1 : 0;
        end
         
        4'b0011: //AND
          begin
            result = operandA & operandB;
            overflowflag = 0;
            carryflag = 0;
            zflag = (result == 0) ? 1 : 0;
          end
        4'b0100: //OR
        begin
            result = operandA | operandB;
            overflowflag = 0;
            carryflag = 0;
            zflag = (result == 0) ? 1 : 0;
        end
        4'b0101://XOR
        begin
            result = operandA ^ operandB;
            overflowflag = 0;
            carryflag = 0;
            zflag = (result == 0) ? 1 : 0;
        end
        4'b0110://SLL
        begin
            result = operandA >> operandB[0];
            overflowflag = 0;
            carryflag = 0;
            zflag = (result == 0) ? 1 : 0;
        end
        4'b0111://SRL
        begin
            result = operandA << operandB[0];
            overflowflag = 0;
            carryflag = 0;
            zflag = (result == 0) ? 1 : 0;
        end
        4'b1000://SRA
        begin
            result = (operandB[0] == 1'b1) ? {operandA[0], operandA[31:1]} : operandA;//SRA
            overflowflag = 0;
            carryflag = 0;
            zflag = (result == 0) ? 1 : 0;
        end
        default:
        begin
            result = 32'bx;
            overflowflag = 0;
            carryflag = 0;
            zflag = 0;
        end
      endcase

    if (result[31] | overflowflag)
			signflag = 1;
		else
			signflag = 0;
      

    end

endmodule