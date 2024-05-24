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
input rst_n,RegWrite_i,ALUSrc_i,Branch_i,MemRead_i,MemWrite_i,MemtoReg_i,
input [31:0] imme_i,rdata1_i,rdata2_i,
input [13:0] addr_i,
input [4:0] rd_i,rs1_i, rs2_i,
input [3:0]ALUControl_i,
output reg [31:0] imme_o,
output reg [13:0] addr_o,
output reg [31:0] rdata1_o,rdata2_o,
output reg [4:0] rd_o,rs1_o, rs2_o,
output reg RegWrite_o,ALUSrc_o,Branch_o,MemRead_o,MemWrite_o,MemtoReg_o,
output reg [3:0]ALUControl_o
    );
    reg RegWrite,ALUSrc,Branch,MemRead,MemWrite,MemtoReg;
    reg [31:0] imme,rdata1,rdata2;
    reg [13:0] addr;
    reg [4:0] rd, rs1, rs2;
    reg [3:0]ALUControl;
    
    always @* begin
        if(rst_n==1'b1) begin
            RegWrite=1'b0;ALUSrc=1'b0;Branch=1'b0;MemRead=1'b0;MemWrite=1'b0;MemtoReg=1'b0;
            imme=32'b0;addr=13'b0;rdata1=32'b0;rdata2=32'b0;
            rd=5'b0;rs1 = 5'b0;rs2 = 5'b0;ALUControl=4'b0;
        end
        else begin
            RegWrite=RegWrite_i;ALUSrc=ALUSrc_i;Branch=Branch_i;MemRead=MemRead_i;MemWrite=MemWrite_i;MemtoReg=MemtoReg_i;
            imme=imme_i;addr=addr_i;rdata1=rdata1_i;rdata2=rdata2_i;
            rd=rd_i;rs1=rs1_i;rs2=rs2_i;ALUControl=ALUControl_i;
        end
    end
endmodule
