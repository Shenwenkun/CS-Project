`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/01 22:25:36
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


module tb_dmem();
reg clk, iowrite, memwrite;
reg [13:0] addr;
reg [31:0] wdata;
wire [31:0] rdata;
DataMemory dm(clk, iowrite, memwrite, addr, wdata, rdata);
initial begin
clk=1'b0;
forever #100 clk=~clk;
end
initial begin
addr=0;
#1000 addr=1;
#1500 addr=0;
forever #1000 addr=addr-1;
end
initial begin
wdata=5;
memwrite=1'b0;
iowrite=1'b0;
#150 memwrite=1'b1;
#500 memwrite=1'b0;
end
endmodule
