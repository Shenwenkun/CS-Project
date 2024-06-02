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
input clk,rst_n,RegWrite_i,MemRead_i,MemWrite_i,MemOrIoToReg_i,IoRead_i,IoWrite_i,
//input Jalr_i,
input [1:0] ByteOrWord_i,
input [31:0] ALUResult_i,
input [13:0] addr_i,
input [31:0] rdata2_i,
input [4:0] rd_i,
output reg RegWrite_o,MemRead_o,MemWrite_o,MemOrIoToReg_o,IoRead_o,IoWrite_o,
output reg [31:0] rdata2_o,ALUResult_o,
//output reg [13:0] addr_jump_o,
output reg [4:0] rd_o,
output reg [1:0] ByteOrWord_o
    );
    wire RegWrite;
    wire MemRead,MemWrite,MemOrIoToReg,IoRead,IoWrite;
    assign MemRead=MemRead_i;
    assign MemWrite=MemWrite_i;
    assign MemOrIoToReg=MemOrIoToReg_i;
    assign IoRead=IoRead_i;
    assign IoWrite=IoWrite_i;
//    reg [13:0] addr_jump;
    wire [31:0] rdata2;
    wire [31:0]ALUResult;
    reg [4:0] rd;
    reg [1:0] ByteOrWord;
    assign RegWrite=RegWrite_i;
    assign ALUResult=ALUResult_i;
    assign rdata2=rdata2_i;
    always@(negedge clk or posedge rst_n) begin
        if (rst_n==1'b1)begin
//            RegWrite<=1'b0;
//            MemRead<=1'b0;MemWrite<=1'b0;MemOrIoToReg<=1'b0;
//            rdata2<=32'b0;ALUResult<=32'b0;
            rd<=4'b0;
//            IoRead<=1'b0;IoWrite<=1'b0;
            ByteOrWord<=2'b0;
        end
        else begin
//            RegWrite<=RegWrite_i;
//            MemRead<=MemRead_i;MemWrite<=MemWrite_i;MemOrIoToReg<=MemOrIoToReg_i;
//            rdata2<=rdata2_i;ALUResult<=ALUResult_i;
            rd<=rd_i;
//            IoRead<=IoRead_i;IoWrite<=IoWrite_i;
            ByteOrWord<=ByteOrWord_i;
        end
    end

    always@(posedge clk) begin
        RegWrite_o<=RegWrite;
        MemRead_o<=MemRead;
        MemWrite_o<=MemWrite;
        MemOrIoToReg_o<=MemOrIoToReg;
        rdata2_o<=rdata2;
        ALUResult_o<=ALUResult;
        rd_o<=rd;
        IoRead_o<=IoRead;
        IoWrite_o<=IoWrite;
        ByteOrWord_o<=ByteOrWord;
    end
endmodule