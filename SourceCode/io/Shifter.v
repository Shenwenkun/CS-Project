`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/31 19:09:58
// Design Name: 
// Module Name: Shifter
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


module Shifter(
input clk, rst, left_i, right_i, up_i, confirm_i,
output [1:0] state_o,
output [3:0] mode_o
    );
    reg [1:0] state;
    reg [3:0] mode;
    assign state_o = state;
    assign mode_o = mode;
    always @(posedge clk or negedge rst) begin
        if(~rst)begin
            mode<=4'b0000;
            state<=2'b00;
        end else begin
            case({up_i, left_i, right_i})
            3'b100:begin
                mode[3]<=~mode[3];
                mode[2:0]<=mode[2:0];
                state<=2'b00;
            end
            3'b010:begin
                mode<=mode-1;
                state<=2'b00;
            end
            3'b001:begin
                mode<=mode+1;
                state<=2'b00;
            end
            default:begin
                mode<=mode;
                case(mode)
                    4'b0000,4'b1001,4'b1010,4'b1011,4'b1100,4'b1101:begin
                        if(confirm_i)begin
                            case(state)
                                2'b00:state<=2'b01;
                                2'b01:state<=2'b10;
                                2'b10:state<=2'b11;
                                default:state<=2'b00;
                            endcase
                        end else begin
                            state<=state;
                        end
                    end
                    4'b0001,4'b0010,4'b1000,4'b1110,4'b1111:begin
                        if(confirm_i)begin
                            case(state)
                                2'b00:state<=2'b11;
                                default:state<=2'b00;
                            endcase
                        end else begin
                            state<=state;
                        end
                    end
                    default:begin
                        if(confirm_i)begin
                            case(state)
                                2'b00:state<=2'b01;
                                2'b01:state<=2'b11;
                                default:state<=2'b00;
                            endcase
                        end else begin
                            state<=state;
                        end
                    end
                endcase
            end
            endcase
        end
    end
endmodule
