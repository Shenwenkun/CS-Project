`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/24 20:02:54
// Design Name: 
// Module Name: Counter
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


module Counter(
input clk, rst,
output reg segclk_o
    );
    reg [31:0] count, max;
    always @(posedge clk) begin
        if(~rst)begin
            segclk_o<=1'b0;
            count<=0;
        end else begin
            max<=100000;
            if(count<max)begin
                count<=count+1;
            end else begin
                count<=0;
                segclk_o<=~segclk_o;
            end
        end
    end
    
endmodule
