`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/31 17:08:23
// Design Name: 
// Module Name: DebouncerClock
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


module DebouncerClock(
input clk, rst,
output reg sclk_o
    );
    reg [31:0] count;
    always @(negedge clk or negedge rst) begin
        if(~rst)begin
            sclk_o<=1'b0;
            count<=0;
        end else begin
            if(count<100000)begin
                count<=count+1;
            end else begin
                count<=0;
                sclk_o<=~sclk_o;
            end
        end
    end
    
endmodule
