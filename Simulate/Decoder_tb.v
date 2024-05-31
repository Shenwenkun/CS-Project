`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/01 04:14:41
// Design Name: 
// Module Name: Decoder_tb
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


module Decoder_tb();
reg clk, rst_n,regWrite_i;
reg [4:0] wrd_i;
reg [31:0] instr_i;
reg [31:0] wdata_i;
reg [13:0] addr_i;
wire [31:0] imm32_o;
wire [31:0] rdata1_o, rdata2_o;
wire [4:0] rd_o,rs1_o,rs2_o;
wire jump_o;
wire [13:0] addr_o;

Decoder tb2(clk, rst_n,regWrite_i,wrd_i,instr_i,wdata_i,addr_i,imm32_o,rdata1_o, rdata2_o,rd_o,rs1_o,rs2_o,jump_o,addr_o);

initial begin
clk=1'b1;
rst_n=1'b0;
regWrite_i=1'b0;
wrd_i=5'b00000;
instr_i=32'h00600513;//addi a0, zero, 6
wdata_i=32'h00000006;
addr_i=14'h0003;
#10
clk=~clk;
#10
instr_i=32'h00d605b3;//add a1, a2, a3
clk=~clk;
#10
clk=~clk;
#10
instr_i=32'h12302283;//lw t0, 0x123
clk=~clk;
#10
clk=~clk;
#10
instr_i=32'h000585e7;//jalr a1, 0(a1)
clk=~clk;
#10
clk=~clk;
#10
instr_i=32'h116028a3;//sw s6, 0x111
clk=~clk;
#10
clk=~clk;
#10
instr_i=32'h00730663;//beq t1, t2, out(0x0000000c)
clk=~clk;
#10
clk=~clk;
#10
instr_i=32'h0124c463;//blt s1, s2, out(0x0000000c)
clk=~clk;
#10
clk=~clk;
#10
instr_i=32'h00c5f263;//beq a1, a2, out(0x0000000c)
clk=~clk;
#10
clk=~clk;
#10
instr_i=32'h0040036f;//jal t1, finish(0x00000004)
clk=~clk;
#10
clk=~clk;
#10
$finish;
end
endmodule
