`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/24 15:54:03
// Design Name: 
// Module Name: tb_dmem
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


module tb_dmem(); //part1 of tb
reg clk, IoWrite2_i, MemWrite,
upg_rst_i, upg_clk_i, upg_wen_i, upg_done_i;
reg [13:0] addr,
 upg_addr_i;
reg [31:0] din,
 upg_dat_i;
wire [31:0] dout;

DataMemory udmem(.clk(clk),
.IoWrite2_i(IoWrite2_i), .MemWrite_i(MemWrite),
.addr_i(addr), .wdata_m_i(din),.rdata_m_o(dout), 
.upg_rst_i(upg_rst_i), .upg_clk_i(upg_clk_i), .upg_wen_i(upg_wen_i), .upg_addr_i(upg_addr_i), .upg_data_i(upg_dat_i), .upg_done_i(upg_done_i));
initial begin
clk =1'b0;
forever #5 clk=~clk;
end

initial begin
upg_clk_i = 1'b0;
forever #2 upg_clk_i = ~upg_clk_i;
end

initial begin //part2 of tb
IoWrite2_i = 1'b0;
MemWrite = 1'b0;
#100 forever #70 MemWrite = ~MemWrite;
end
initial begin
din = 32'h0;
#250 repeat(10) #12 din = din+16;
end

initial begin
addr =32'h0;
#175 repeat(20) #12 addr = addr + 4;
#20 $finish;
end

initial begin
upg_dat_i = 32'h0;
#116 repeat(20) #6 upg_dat_i = upg_dat_i + 16;
end

initial begin
upg_addr_i = 32'h0;
#100 repeat(20) #6 upg_addr_i = upg_addr_i + 4;
end

initial begin
upg_rst_i = 1'b0;
upg_wen_i = 1'b0;
#110 upg_wen_i = 1'b1;
#230 upg_rst_i = 1'b1;
end

initial begin
upg_done_i = 1'b0;
#220 upg_done_i = 1'b1;
end

endmodule

