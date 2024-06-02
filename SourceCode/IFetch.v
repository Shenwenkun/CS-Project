`timescale 1ns / 1ps

module IFetch(
input clk, rst_n,
input PCSrc_i,
input [13:0] addr_i,
output [31:0] instr_o,
output reg [13:0] addr_o
    );
    reg [13:0]last_pc;
    reg [13:0] pc;
    initial begin
        pc=14'h0;
    end 
    ROM uram(.clka(~clk),.addra((PCSrc_i==1'b1)?addr_i:pc),.douta(instr_o));
    always@(posedge clk)begin
        last_pc<=(PCSrc_i==1'b1)?addr_i:pc;
    end
    always@(negedge clk or posedge rst_n)begin
        if(rst_n==1'b1)begin
            pc<=14'b00000000000000;
        end else begin
            addr_o<=last_pc;
            pc<=last_pc+1;
        end
    end
endmodule
