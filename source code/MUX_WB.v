`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/18 17:36:34
// Design Name: 
// Module Name: MUX_WB
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


module MUX_WB(
input [31:0]data_i,ALUResult_i,
input MemtoReg_i,
output [31:0] data_o
    );
    assign data_o=(MemtoReg_i==1'b0)? ALUResult_i:data_i;
endmodule
