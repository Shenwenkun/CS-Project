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
input rst_n,RegWrite_i,MemToReg_i,
input [31:0]data_i,ALUResult_i,
input [4:0]rd_i,
output reg RegWrite_o,
output reg [31:0]wdata_o,
output reg [4:0]rd_o
    );
    reg RegWrite;
    reg [31:0]wdata;
    reg [4:0]rd;
    always@* begin
        if (rst_n==1'b1)begin
            RegWrite=1'b0;
            wdata=32'b0;
            rd=5'b0;
        end
        else begin
            RegWrite=RegWrite_i;
            rd=rd_i;
            case(MemToReg_i)
                1'b1:wdata=data_i;
                default:wdata=ALUResult_i;
            endcase
        end
    end
endmodule
