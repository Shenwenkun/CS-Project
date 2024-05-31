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

module MemOrIo(clk, MemRead_i, MemWrite_i, ioRead_i, ioWrite_i,ByteOrWord_i,addr_i, addr_o, m_rdata_i, io_rdata_i, r_wdata_o, r_rdata_i, write_data_o);
input clk;
//input confirm_i;
input MemRead_i; // read memory, from EXMEM
input MemWrite_i; // write memory, from EXMEM
input ioRead_i; // read IO, from EXMEM
input ioWrite_i; // write IO, from EXMEM
input [1:0] ByteOrWord_i;
input[13:0] addr_i; // from EXMEM
output reg [13:0] addr_o; // address to Data-Memory
input[31:0] m_rdata_i; // data read from Data-Memory
input[15:0] io_rdata_i; // data read from IO,16 bits
output reg [31:0] r_wdata_o; // data to Decoder(register file)
input[31:0] r_rdata_i; // data read from Decoder(register file)#### In pipeline it should from EXMEM
output reg[31:0] write_data_o; // data to memory or I/O（m_wdata, io_wdata）
//output LEDCtrl_o; // LED Chip Select
//output SwitchCtrl_o; // Switch Chip Select 和 led 一起控制
//output TubeCtrl_o;// Tube Chip Select
//assign addr_o= addr_i;
// The data wirte to register file may be from memory or io. 
// While the data is from io, it should be the lower 16bit of r_wdata. 
//assign r_wdata_o =(MemRead_i==1'b1)? m_rdata_i:{{16{io_rdata_i[15]}},io_rdata_i};
// Chip select signal of Led and Switch are all active high;
//assign SwitchCtrl_o= (ioRead_i==1'b1 && addr_i[7:4]==4'h6)? 1'b1:1'b0;
//assign TubeCtrl_o=(ioWrite_i==1'b1 && (addr_i[7:4]==4'h7 || addr_i[7:4]==4'h8))? 1'b1:1'b0;
reg MemRead,MemWrite,ioRead,ioWrite,confirm;
reg [13:0] addr;
reg [31:0] m_rdata,r_rdata;
reg [15:0] io_rdata;
always @(posedge clk)begin
    MemRead<=MemRead_i;MemWrite<=MemWrite_i;ioRead<=ioRead_i;ioWrite<=ioWrite_i;
    addr<=addr_i;r_rdata<=r_rdata_i;
    io_rdata<=io_rdata_i;
//    confirm<=confirm_i;
    case(ByteOrWord_i)
        2'b00:m_rdata<={{24{m_rdata_i[7]}},m_rdata_i[7:0]};
        2'b01:m_rdata<=m_rdata_i;
        2'b10:m_rdata<={{24{1'b0}},m_rdata_i[7:0]};
    endcase
end

always @(negedge clk) begin
    if((MemWrite==1)||(ioWrite==1))begin
    //wirte_data could go to either memory or IO. where is it from?
//        if(confirm==1'b1)begin
//            addr_o <= 14'h3C80;
//            write_data_o<=32'b1;
//        end else begin
            addr_o <= addr;
            write_data_o <= r_rdata;
//        end
    end
    else begin
        write_data_o = 32'hZZZZZZZZ;
    end
    if(ioRead==1'b1)begin
//        if(confirm==1'b1)begin
//            addr_o <= 14'h3C80;
//            write_data_o<=32'b1;
//        end else begin
            addr_o <= 14'h3C70;
            write_data_o <= io_rdata;
            r_wdata_o <= io_rdata;
//        end
    end
    if(MemRead==1'b1)begin
        addr_o <= addr;
        r_wdata_o <= m_rdata;
    end
end
endmodule
