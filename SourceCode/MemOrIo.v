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


module MemOrIo( MemRead_i, MemWrite_i, ioRead_i, ioWrite_i,addr_i, addr_o, m_rdata_i, io_rdata_i, r_wdata_o, r_rdata_i, write_data_o, SwitchCtrl_o,TubeCtrl_o);
input MemRead_i; // read memory, from EXMEM
input MemWrite_i; // write memory, from EXMEM
input ioRead_i; // read IO, from EXMEM
input ioWrite_i; // write IO, from EXMEM
input[13:0] addr_i; // from EXMEM
output[13:0] addr_o; // address to Data-Memory
input[31:0] m_rdata_i; // data read from Data-Memory
input[15:0] io_rdata_i; // data read from IO,16 bits
output[31:0] r_wdata_o; // data to Decoder(register file)
input[31:0] r_rdata_i; // data read from Decoder(register file)#### In pipeline it should from EXMEM
output reg[31:0] write_data_o; // data to memory or I/O（m_wdata, io_wdata）
//output LEDCtrl_o; // LED Chip Select
output SwitchCtrl_o; // Switch Chip Select 和 led 一起控制
output TubeCtrl_o;// Tube Chip Select
assign addr_o= addr_i;
// The data wirte to register file may be from memory or io. // While the data is from io, it should be the lower 16bit of r_wdata. 
assign r_wdata_o =(MemRead_i==1'b1)? m_rdata_i:{{16{io_rdata_i[15]}},io_rdata_i};
// Chip select signal of Led and Switch are all active high;
assign LEDCtrl_o= (ioRead_i==1'b1 && addr_i[7:4]==4'h6)? 1'b1:1'b0;  
assign SwitchCtrl_o= (ioRead_i==1'b1 && addr_i[7:4]==4'h6)? 1'b1:1'b0;
assign TubeCtrl_o=(ioWrite_i==1'b1 && addr_i[7:4]==4'h7)? 1'b1:1'b0;
always @* begin
if((MemWrite_i==1)||(ioWrite_i==1))
//wirte_data could go to either memory or IO. where is it from?
write_data_o = r_rdata_i;
else
write_data_o = 32'hZZZZZZZZ;
end
endmodule
