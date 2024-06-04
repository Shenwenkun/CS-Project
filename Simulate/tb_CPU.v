`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/01 23:26:55
// Design Name: 
// Module Name: tb_cpu
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


module tb_CPU();
reg clk, rst, confirm;
reg [15:0] din;
wire [31:0] dout;
CPU cpu(clk, rst, confirm, din, dout);
initial begin
clk=1'b0;
forever #5 clk=~clk;
end
initial begin
din=0;
rst=1'b0;
#50 rst=1'b1;
end
initial begin
confirm=1'b0;
#3000 confirm = 1'b1;
#500 confirm = 1'b0;
#300 confirm =1'b1;din=2;
#200 confirm=1'b0;
#1000 confirm=1'b1;din=1;
#100 confirm=1'b0;

end
endmodule