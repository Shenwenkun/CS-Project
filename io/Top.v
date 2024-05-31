`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/24 13:42:12
// Design Name: 
// Module Name: Top
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


module Top(
input [7:0] switch,
input clk, rst,
input up_i, left_i, right_i, confirm_i,
output [7:0] light, tub_ctrl, seg_ctrl1, seg_ctrl2
    );
    wire [3:0] mode;
    wire [7:0] in;
    wire segclk;
    wire [1:0] state;
    wire up, left, right, confirm;
    wire sclk;
    DebouncerClock dbclock(clk, rst, sclk);
    Debouncer db1(sclk, rst, up_i, up);
    Debouncer db2(sclk, rst, left_i, left);
    Debouncer db3(sclk, rst, right_i, right);
    Debouncer db4(sclk, rst, confirm_i, confirm);
    Counter counter(clk, rst, segclk);
    Shifter shifter(sclk, rst, left, right, up, confirm, state, mode);
    Printer printer(segclk, rst, mode, state, tub_ctrl, seg_ctrl1, seg_ctrl2);
    InputReader inputreader(sclk, switch, confirm&(state[0]^state[1]), in);
    assign light = in;
endmodule
