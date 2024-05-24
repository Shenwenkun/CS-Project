`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/17 10:46:32
// Design Name: 
// Module Name: EXMEM
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


module EXMEM(
input rst_n,Zero_i,RegWrite_i,Branch_i,MemRead_i,MemWrite_i,MemtoReg_i,
input [31:0] ALUResult_i,imme_i,
input [13:0] addr_i,
input [31:0] rdata2_i,
input [4:0] rd_i,
output reg RegWrite_o,Branch_o,MemRead_o,MemWrite_o,MemtoReg_o,
output reg [31:0] rdata2_o,ALUResult_o,
output reg [13:0] addr_jump_o,
output reg [4:0] rd_o
    );
    reg RegWrite,Branch,MemRead,MemWrite,MemtoReg;
    reg [13:0] addr_jump;
    reg [31:0] rdata2,ALUResult;
    reg [4:0] rd;
    always@* begin
        if (rst_n==1'b1)begin
            RegWrite=1'b0;Branch=1'b0;MemRead=1'b0;MemWrite=1'b0;MemtoReg=1'b0;
            addr_jump=14'b0;rdata2=32'b0;ALUResult=32'b0;
            rd=4'b0;
        end
        else begin
            RegWrite=RegWrite_i;Branch=Branch_i&Zero_i;MemRead=MemRead_i;MemWrite=MemWrite_i;MemtoReg=MemtoReg_i;
            addr_jump=addr_i+imme_i;rdata2=rdata2_i;ALUResult=ALUResult_i;
            rd=rd_i;
        end
    end
endmodule
