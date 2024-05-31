`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/01 02:45:41
// Design Name: 
// Module Name: IFetch_tb
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


module IFetch_tb();
reg clk;
reg rst_n;
reg PCSrc;
reg [13:0] addr_i;
wire [31:0] instr;
wire [13:0] addr_o;

IFetch tb0(clk,rst_n,PCSrc,addr_i,instr,addr_o);
initial begin
clk=1'b1;
rst_n=1'b0;
PCSrc=1'b0;
addr_i=14'b00000000000110;
#10
clk=~clk;
#10
clk=~clk;
#10
clk=~clk;
#10
clk=~clk;
PCSrc=1'b1;
#10
clk=~clk;
#10;
clk=~clk;
#10
$finish;
end

endmodule
