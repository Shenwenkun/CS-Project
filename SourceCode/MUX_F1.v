`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/18 17:29:31
// Design Name: 
// Module Name: MUX_F1
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


module MUX_F1(
input [31:0] rdata1_i,ALUResult_i,data_i,
input [1:0] ForwardA,
output reg [31:0] rdata1_o
    );
    
    always@*begin
       case(ForwardA)
           2'b00: rdata1_o=rdata1_i;
           2'b01:rdata1_o=data_i;
           default: rdata1_o=ALUResult_i;//2'b10
       endcase
    end
    
endmodule
