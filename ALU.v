`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/25 19:27:20
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU(
input [31:0] ReadData1, ReadData2, imm32,
input [1:0] ALUOp,
input [2:0] funct3,
input [6:0] funct7,
input ALUSrc,
output reg [31:0] ALUResult,
output zero
    );
reg [3:0] ALUControl;
wire [9:0] funct;
assign funct = { funct7, funct3 };

    // get ALUControl
    always @* begin
        case( ALUOp)
            2'b00,2'b01: ALUControl = { ALUOp, 2'b10};
            2'b10:
                case(funct)
                    10'b0000000_000: ALUControl = 4'b0010;
                    10'b0100000_000: ALUControl = 4'b0110;
                    10'b0000000_111: ALUControl = 4'b0000;
                    10'b0000000_110: ALUControl = 4'b0001;
                    default: ALUControl = 4'b1111;
                endcase
        endcase
    end 
    
    // select operand2
    wire[31:0] operand2;
    assign operand2 = (ALUSrc==1)? imm32: ReadData2;
    
    // calculate the result
    
    always @* begin
        case( ALUControl)
            4'b0010: ALUResult= ReadData1 + operand2;
            4'b0110: ALUResult= ReadData1 - operand2;
            4'b0000: ALUResult= ReadData1 & operand2;
            4'b0001: ALUResult= ReadData1 | operand2;
            default: ALUResult= ALUResult;
        endcase
    end

    
    assign zero = (ALUResult == 0)? 1'b1: 1'b0;
            
endmodule
