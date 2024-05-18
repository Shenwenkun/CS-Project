`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/18 17:46:35
// Design Name: 
// Module Name: MUX_F2
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


module MUX_F2(
input [31:0] rdata2_i,ALUResult_i,data_i,
input [1:0] ForwardA,
output reg [31:0] rdata2_o
    );
    always@*begin
       case(ForwardB)
       2'b00: rdata2_o=rdata2_i;
       2'b01:rdata2_o=data_i;
       2'b10: rdata2_o=ALUResult_i;
       endcase
    end
endmodule
