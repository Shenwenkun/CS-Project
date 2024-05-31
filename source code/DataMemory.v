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
output [31:0] rdata_m_o,

input upg_rst_i, // UPG reset (Active High)
input upg_clk_i, // UPG ram_clk_i (10MHz)
input upg_wen_i, // UPG write enable
input [13:0] upg_addr_i, // UPG write address
input [31:0] upg_data_i, // UPG write data
input upg_done_i // 1 if programming is finished
//,output kickOff
);
   
    /* CPU work on normal mode when kickOff is 1. CPU work on Uart communicate mode when kickOff is 0.*/
    wire kickOff = upg_rst_i | (~upg_rst_i &upg_done_i);
//    assign kickOff = upg_rst_i | (~upg_rst_i &upg_done_i);
    RAM dmram (
    .clka (kickOff ? ~clk : ~upg_clk_i),
    .wea (kickOff ? MemWrite : upg_wen_i),
    .addra (kickOff ? addr_i : upg_addr_i),
    .dina (kickOff ? wdata_m_i : upg_data_i),
    .douta (rdata_m_o)
    );

//    RAM udram(.clka(~clk), .wea(MemWrite), .addra(addr_i[13:0]), .dina(wdata_m_i), .douta(rdata_m_o));
endmodule
