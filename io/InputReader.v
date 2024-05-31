`timescale 1ns / 1ps


module InputReader(//read number from switches
input clk_i,
input [7:0] a_i,
input confirm_i,
output reg [7:0] a_o
    );
    always @(posedge clk_i) begin
        if(confirm_i)begin
            a_o<=a_i;
        end else begin
            a_o<=a_o;
        end
    end
endmodule
