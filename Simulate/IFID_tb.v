`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/01 03:59:14
// Design Name: 
// Module Name: IFID_tb
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


module IFID_tb();
reg clk, rst_n,jump_i;
reg [31:0] Instr_i;
reg [13:0] addr_i;
wire [31:0] Instr_o;
wire [13:0] addr_o;

IFID tb1(clk, rst_n,jump_i,Instr_i,addr_i,Instr_o,addr_o);

initial begin
clk=1'b1;
rst_n=1'b0;
jump_i=1'b0;
Instr_i=32'h12345678;
addr_i=14'b00000000000001;
#10
clk=~clk;
jump_i=1'b1;
#10
clk=~clk;
jump_i=1'b0;
#10
clk=~clk;
Instr_i=32'h00000001;
addr_i=14'h0011;
#10
clk=~clk;
#10
clk=~clk;
//#10
//clk=~clk;
//#10
//clk=~clk;
//#10
//clk=~clk;
#10
$finish;
end
endmodule
