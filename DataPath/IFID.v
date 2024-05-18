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
input clk, rst_n, 
input [31:0] Instr_i, addr_i,
output reg [31:0] Instr_o, addr_o
    );
    
    reg [31:0] Instr,addr;
    always @(posedge clk)begin
        if (rst_n==1'b1)begin
            Instr_o<=32'b0;
            addr_o<=32'b0;
        end
        else begin
            Instr <= Instr_i;
            addr <= addr_i;
        end
    end
    
    always @(negedge clk)begin
        if (rst_n==1'b1)begin
            Instr_o<=32'b0;
            addr_o<=32'b0;
        end
        else begin
            Instr_o <= Instr;
            addr_o <= addr;
        end
    end
endmodule
