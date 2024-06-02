`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/16 20:50:32
// Design Name: 
// Module Name: IFID
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


module IFID(
input clk, rst_n, jump_i,
input [31:0] Instr_i,
input [13:0] addr_i,
output reg [31:0] Instr_o,
output reg [13:0] addr_o
    );
    
    wire [31:0] Instr;
    wire [13:0] addr;
    assign Instr=Instr_i;
    assign addr=addr_i;
    
    always @(posedge clk or posedge rst_n)begin
        if (rst_n==1'b1 || jump_i==1'b1)begin
            Instr_o<=32'h00000033;
            addr_o<=14'b0;
        end
        else begin
            Instr_o <= Instr;
            addr_o <= addr;
        end
    end
endmodule
