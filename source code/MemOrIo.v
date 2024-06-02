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
output reg [13:0] addr_o; // address to Data-Memory
input[31:0] m_rdata_i; // data read from Data-Memory
input[15:0] io_rdata_i; // data read from IO,16 bits
output reg [31:0] r_wdata_o; // data to Decoder(register file)
input[31:0] r_rdata_i; // data read from Decoder(register file)#### In pipeline it should from EXMEM
output reg[31:0] write_data_o; // data to memory or I/O£¨m_wdata, io_wdata£©

 
reg MemRead,MemWrite,ioRead,ioWrite,confirm;
reg [13:0] addr;
reg [31:0] m_rdata,r_rdata;
reg [15:0] io_rdata;
always @(posedge clk or posedge rst_n)begin
    if(rst_n==1'b1)begin
        MemRead<=0;MemWrite<=0;ioRead<=0;ioWrite<=0;
        addr<=0;r_rdata<=0;
        io_rdata<=0;
        confirm<=0;
    end else begin
    MemRead<=MemRead_i;MemWrite<=MemWrite_i;ioRead<=ioRead_i;ioWrite<=ioWrite_i;
    addr<=addr_i;r_rdata<=r_rdata_i;
    io_rdata<=io_rdata_i;
    confirm<=confirm_i;
    case(ByteOrWord_i)
        2'b00:m_rdata<={{24{m_rdata_i[7]}},m_rdata_i[7:0]};
        2'b01:m_rdata<=m_rdata_i;
        2'b10:m_rdata<={{24{1'b0}},m_rdata_i[7:0]};
    endcase
    end
end

always @(negedge clk) begin
    if((MemWrite==1)||(ioWrite==1))begin
    //wirte_data could go to either memory or IO. where is it from?
//        if(confirm==1'b1)begin
//            addr_o <= 14'h3C80;
//            write_data_o<=32'h00000001;
//        end else begin
            addr_o <=(confirm==1'b1)? 14'h3C80:addr;
            write_data_o <=(confirm==1'b1)?32'h0: r_rdata;
//        end
    end
    else begin
        write_data_o = 32'hZZZZZZZZ;
    end
    if(ioRead==1'b1)begin
//        if(confirm==1'b1)begin
//            addr_o <= 14'h3C80;
//            write_data_o<=32'h00000001;
//        end else begin
            addr_o <= (confirm==1'b1)?14'h3C80:14'h3C70;
            write_data_o <=(confirm==1'b1)?32'h00000001: io_rdata;
            r_wdata_o <=(confirm==1'b1)?32'h00000001: io_rdata;
//        end
    end
    if(MemRead==1'b1)begin
        addr_o <= addr;
        r_wdata_o <= m_rdata;
    end
end
endmodule
