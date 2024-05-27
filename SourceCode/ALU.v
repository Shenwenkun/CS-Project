`timescale 1ns / 1ps

module ALU(
input clk,
input [3:0] ALUControl,
input [31:0] rdata1_i,
input [31:0] rdata2_i,
input [31:0] imme_i,
input ALUSrc,
output reg [31:0] ALUResult_o,
output reg [21:0]Alu_resultHigh_o,
output reg zero
    );
    wire[31:0] operand2;
    reg [31:0]ALUResult;
    assign operand2 = (ALUSrc==1'b1)? rdata2_i : imme_i;
    // ALUControll indications:
    // add:0010
    // sub:0110
    // and:0000
    // or: 0001
    always @ (posedge clk) begin
        case( ALUControl)
            4'b0010: ALUResult <= rdata1_i + operand2;
            4'b0110: ALUResult <= rdata1_i - operand2;
            4'b0000: ALUResult <= rdata1_i & operand2;
            4'b0001: ALUResult <= rdata1_i | operand2;
            default: ALUResult <= 0;
        endcase
    end
    
    always @(negedge clk)begin
        ALUResult_o<=ALUResult;
        Alu_resultHigh_o<=ALUResult[31:10];
        zero = (ALUResult == 0)? 1'b1 : 1'b0;
    end
endmodule
