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
input clk, rst, rx, tx,
input up_i, left_i, right_i, confirm_i, down_i,
output [7:0] light, tub_ctrl, seg_ctrl1, seg_ctrl2
    );
    wire [3:0] mode;
    wire [7:0] in;
    wire segclk;
    wire [1:0] state;
    wire [31:0] result, out;
    wire up, left, right, confirm, down;
    wire sclk, cpuclk;

    DebouncerClock dbclock(clk, rst, sclk);
    Debouncer db1(sclk, rst, up_i, up);
    Debouncer db2(sclk, rst, left_i, left);
    Debouncer db3(sclk, rst, right_i, right);
    Debouncer db4(sclk, rst, confirm_i, confirm);
    Debouncer db5(sclk, rst, down_i, down);
    Counter counter(clk, rst, segclk);
    Shifter shifter(sclk, rst, left, right, up, confirm, state, mode);
    Printer printer(segclk, rst, mode, state, out, tub_ctrl, seg_ctrl1, seg_ctrl2);
    InputReader inputreader(sclk, switch, confirm&(state[0]^state[1]), in);
    CPU_Top cputop(rst, clk, confirm, {8'b00000000, in}, result, down, rx, tx);
//    CPU cpu(cpuclk, rst, confirm, {8'b00000000, in}, result);
    OutputReader outputreader(clk, rst|~left|~up|~right, result, out);
    assign light = switch;
endmodule