`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/15 13:23:18
// Design Name: 
// Module Name: DataMemory
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


module DataMemory(
input clk,
input MemRead, MemWrite,
input [13:0] addr_i,
input [31:0] wdata_m_i,
output [31:0] rdata_m_o
    );
    
    RAM udram(.clka(~clk), .wea(MemWrite), .addra(addr_i), .dina(wdata_m_i), .douta(rdata_m_o));
endmodule
