`timescale 1ns / 1ps

module ALU(
input [3:0] ALUControl,
input [31:0] rdata1_i,
input [31:0] rdata2_i,
input [31:0] imme_i,
input ALUSrc,
output reg [31:0] ALUResult,
output zero
    );
    wire[31:0] operand2;
    assign operand2 = (ALUSrc==1'b1)? rdata2_i : imme_i;
    // ALUControll indications:
    // add:0010
    // sub:0110
    // and:0000
    // or: 0001
    always @ * begin
        case( ALUControl)
            4'b0010: ALUResult = rdata1_i + operand2;
            4'b0110: ALUResult = rdata1_i - operand2;
            4'b0000: ALUResult = rdata1_i & operand2;
            4'b0001: ALUResult = rdata1_i | operand2;
            default: ALUResult = 0;
        endcase
    end
    assign zero = (ALUResult == 0)? 1'b1 : 1'b0;
endmodule
