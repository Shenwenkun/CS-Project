`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/31 20:21:52
// Design Name: 
// Module Name: OutputFiller
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


module Printer(
input clk, rst,
input [3:0] mode_i,
input [1:0] state_i,
output [7:0] tubctrl_o, segctrl1_o, segctrl2_o
    );
    reg [7:0] content_i [7:0];
    reg [7:0] num [3:0];
    reg [7:0] tubctrl, segctrl1, segctrl2;
    assign tubctrl_o = tubctrl;
    assign segctrl1_o = segctrl1;
    assign segctrl2_o = segctrl2;
    always @(posedge clk or negedge rst) begin
    if(~rst) begin
        tubctrl<=8'b10001000;
        segctrl1<=8'b11100000;
        segctrl2<=8'b00000000;
    end else begin
        case(mode_i[0])
            1'b1: num[0] <= 8'b00001100;
            default: num[0] <= 8'b11111100;
        endcase
        case(mode_i[1])
            1'b1: num[1] <= 8'b00001100;
            default: num[1] <= 8'b11111100;
        endcase
        case(mode_i[2])
            1'b1: num[2] <= 8'b00001100;
            default: num[2] <= 8'b11111100;
        endcase
        case(mode_i[3])
            1'b1: num[3] <= 8'b00001100;
            default: num[3] <= 8'b11111100;
        endcase
        case(state_i)
            2'b00:begin // output test sample index
                case({tubctrl[7:4], segctrl1})
                    12'b1000_11100000: {tubctrl[7:4], segctrl1} <= 12'b0100_10011110;
                    12'b0100_10011110: {tubctrl[7:4], segctrl1} <= 12'b0010_10110110;
                    12'b0010_10110110: {tubctrl[7:4], segctrl1} <= 12'b0001_11100000;
                    12'b0001_11100000: {tubctrl[7:4], segctrl1} <= 12'b1000_11100000;
                    default: {tubctrl[7:4], segctrl1} <= 12'b1000_11100000;
                endcase
                case({tubctrl[3:0], segctrl2})
                    {4'b1000, num[3]}: {tubctrl[3:0], segctrl2} <= {4'b0100, num[2]};
                    {4'b0100, num[2]}: {tubctrl[3:0], segctrl2} <= {4'b0010, num[1]};
                    {4'b0010, num[1]}: {tubctrl[3:0], segctrl2} <= {4'b0001, num[0]};
                    {4'b0001, num[0]}: {tubctrl[3:0], segctrl2} <= {4'b1000, num[3]};
                    default: {tubctrl[3:0], segctrl2} <= {4'b1000, num[3]};
                endcase
            end
            2'b01:begin // output "input A"
                case({tubctrl[7:4], segctrl1})
                    12'b1000_01100000: {tubctrl[7:4], segctrl1} <= 12'b0100_11101100;
                    12'b0100_11101100: {tubctrl[7:4], segctrl1} <= 12'b0010_11001110;
                    12'b0010_11001110: {tubctrl[7:4], segctrl1} <= 12'b0001_01111100;
                    12'b0001_01111100: {tubctrl[7:4], segctrl1} <= 12'b1000_01100000;
                    default: {tubctrl[7:4], segctrl1} <= 12'b1000_01100000;
                endcase
                case({tubctrl[3:0], segctrl2})
                    12'b1000_11100000: {tubctrl[3:0], segctrl2} <= 12'b0100_00000000;
                    12'b0100_00000000: {tubctrl[3:0], segctrl2} <= 12'b0010_00000000;
                    12'b0010_00000000: {tubctrl[3:0], segctrl2} <= 12'b0001_11101110;
                    12'b0001_11101110: {tubctrl[3:0], segctrl2} <= 12'b1000_11100000;
                    default: {tubctrl[3:0], segctrl2} <= 12'b1000_11100000;
                endcase
            end
            2'b10:begin // output "input B"
                case({tubctrl[7:4], segctrl1})
                    12'b1000_01100000: {tubctrl[7:4], segctrl1} <= 12'b0100_11101100;
                    12'b0100_11101100: {tubctrl[7:4], segctrl1} <= 12'b0010_11001110;
                    12'b0010_11001110: {tubctrl[7:4], segctrl1} <= 12'b0001_01111100;
                    12'b0001_01111100: {tubctrl[7:4], segctrl1} <= 12'b1000_01100000;
                    default: {tubctrl[7:4], segctrl1} <= 12'b1000_01100000;
                endcase
                case({tubctrl[3:0], segctrl2})
                    12'b1000_11100000: {tubctrl[3:0], segctrl2} <= 12'b0100_00000000;
                    12'b0100_00000000: {tubctrl[3:0], segctrl2} <= 12'b0010_00000000;
                    12'b0010_00000000: {tubctrl[3:0], segctrl2} <= 12'b0001_00111110;
                    12'b0001_00111110: {tubctrl[3:0], segctrl2} <= 12'b1000_11100000;
                    default: {tubctrl[3:0], segctrl2} <= 12'b1000_11100000;
                endcase
            end
            default:begin
                tubctrl<=8'b00001000;
                segctrl1<=8'b00000000;
                segctrl2<=8'b00000001;
            end
        endcase
    end
    end
endmodule
