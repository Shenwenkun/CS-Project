`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/25 21:01:32
// Design Name: 
// Module Name: Debouncer
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


module Debouncer(
input sclk_i, rst, button_i,
output button_o
    );
    reg k1, k2;
    always @(negedge sclk_i or negedge rst) begin
        if (~rst) begin
            k1<=1'b0;
            k2<=1'b0;
        end else begin
            k1<=button_i;
            k2<=k1;
        end
    end
    assign button_o=k1&~k2;
endmodule
