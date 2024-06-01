`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/16 23:35:39
// Design Name: 
// Module Name: IDEX
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


module IDEX(
input clk,rst_n,RegWrite_i,ALUSrc_i,
input [1:0]Shift_i,
//input [2:0]Compare_i,
//input J_i,
input [31:0] imme_i,rdata1_i,rdata2_i,instr_i,
input [13:0] addr_i,
input [4:0] rd_i,rs1_i, rs2_i,
input [3:0]ALUControl_i,
output reg [31:0] imme_o,
output reg [13:0] addr_o,
output reg [31:0] rdata1_o,rdata2_o,instr_o,
output reg [4:0] rd_o,rs1_o, rs2_o,
output reg RegWrite_o,ALUSrc_o,
output reg [1:0] Shift_o,
output reg [3:0]ALUControl_o
//output reg [2:0]Compare_o,
//output reg Jalr_o
    );
    reg RegWrite,ALUSrc,Shift;
    reg [31:0] imme,rdata1,rdata2,instr;
    reg [13:0] addr;
    reg [4:0] rd, rs1, rs2;
    reg [3:0]ALUControl;
//    reg [2:0]Compare;
//    reg Jalr;
    
    always @(posedge clk or posedge rst_n)begin
        if(rst_n==1'b1) begin
            RegWrite<=1'b0;ALUSrc<=1'b0;
            imme<=32'b0;addr<=13'b0;rdata1<=32'b0;rdata2<=32'b0;
            rd<=5'b0;rs1 <= 5'b0;rs2 <= 5'b0;ALUControl<=4'b0;
            instr<=32'b0;Shift<=2'b0;
        end
        else begin
            RegWrite<=RegWrite_i;ALUSrc<=ALUSrc_i;
            imme<=imme_i;addr<=addr_i;rdata1<=rdata1_i;rdata2<=rdata2_i;
            rd<=rd_i;rs1<=rs1_i;rs2<=rs2_i;ALUControl<=ALUControl_i;
            instr<=instr_i;Shift<=Shift_i;
        end
    end
    
    always @(negedge clk)begin
        RegWrite_o<=RegWrite;
        ALUSrc_o<=ALUSrc;
        imme_o<=imme;
        addr_o<=addr;
        rdata1_o<=rdata1;
        rdata2_o<=rdata2;
        rd_o<=rd;
        rs1_o<=rs1;
        rs2_o<=rs2;
        ALUControl_o<=ALUControl;
        instr_o<=instr;
        Shift_o<=Shift;
    end
endmodule
