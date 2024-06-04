`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/24 02:11:15
// Design Name: 
// Module Name: MemOrIo
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
//input:MemRead_i,MemWrite_i,ioRead_i,ioWrite_i,addr_i,m_rdata_i,io_rdata_i,r_rdata_i
//output:addr_o,r_wdata_o,write_data_o

module MemOrIo(clk,rst_n,confirm_i, MemRead_i, MemWrite_i, ioRead_i, ioWrite_i,ByteOrWord_i,addr_i, addr_o, m_rdata_i, io_rdata_i, r_wdata_o, r_rdata_i, write_data_o);
input clk,rst_n;
input confirm_i;
input MemRead_i; // read memory, from EXMEM
input MemWrite_i; // write memory, from EXMEM
input ioRead_i; // read IO, from EXMEM
input ioWrite_i; // write IO, from EXMEM
input [1:0] ByteOrWord_i;
input[13:0] addr_i; // from EXMEM
output [13:0] addr_o; // address to Data-Memory
input[31:0] m_rdata_i; // data read from Data-Memory
input[15:0] io_rdata_i; // data read from IO,16 bits
output [31:0] r_wdata_o; // data to Decoder(register file)
input[31:0] r_rdata_i; // data read from Decoder(register file)#### In pipeline it should from EXMEM
output [31:0] write_data_o; // data to memory or I/O£¨m_wdata, io_wdata£©


assign addr_o=addr_i;
assign r_wdata_o=(MemRead_i==1'b1)?m_rdata_i:((addr_i==14'h3c80)?((confirm_i==1'b1)?32'b1:32'b0):{{16{io_rdata_i[15]}},io_rdata_i});
assign write_data_o=((MemWrite_i==1'b1||ioWrite_i==1'b1)?r_rdata_i:32'h00000000);
 
endmodule
