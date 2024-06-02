`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/02 11:44:48
// Design Name: 
// Module Name: tb_outputreader
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


module tb_outputreader();
reg clk, rst;
reg [31:0] result_i;
wire [31:0] out;
OutputReader dor(clk, rst, result_i, out);
initial begin
result_i = 1;
forever #102 result_i[0]=~result_i;
end
initial begin
clk=1'b0;
forever #10 clk=~clk;
end
initial begin
rst=1'b0;
#15 rst=1'b1;
end
endmodule
