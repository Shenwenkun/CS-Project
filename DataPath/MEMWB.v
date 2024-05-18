`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/18 01:53:37
// Design Name: 
// Module Name: MEMWB
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


module MEMWB(
input clk,rst_n,RegWrite_i,MemtoReg_i,
input [31:0]data_i,ALUResult_i,
input [4:0]rd_i,
output reg RegWrite_o,MemtoReg_o,
output reg [31:0]data_o,ALUResult_o,
output reg [4:0]rd_o
    );
    reg RegWrite,MemtoReg;
    reg [31:0]data,ALUResult;
    reg [4:0]rd;
    always@(posedge clk)begin
        if (rst_n==1'b1)begin
            RegWrite_o<=1'b0;MemtoReg_o<=1'b0;
            data_o<=32'b0;ALUResult_o<=32'b0;
        end
        else begin
            RegWrite<=RegWrite_i;
            MemtoReg<=MemtoReg_i;
            data<=data_i;
            ALUResult<=ALUResult_i;
            rd<=rd_i;
        end
    end
    
    always@(negedge clk)begin
        if (rst_n==1'b1)begin
            RegWrite_o<=1'b0;MemtoReg_o<=1'b0;
            data_o<=32'b0;ALUResult_o<=32'b0;
        end
        else begin
            RegWrite_o<=RegWrite;
            MemtoReg_o<=MemtoReg;
            data_o<=data;
            ALUResult_o<=ALUResult;
            rd_o<=rd;
        end
    end
endmodule
