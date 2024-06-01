`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/01 14:27:21
// Design Name: 
// Module Name: Controller_tb
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


module Controller_tb();
reg [31:0]instr_i;
wire ALUsrc_o, RegWrite_o;
wire [1:0] Shift_o;
wire [3:0] ALUControl_o;

Controller tb3(instr_i,ALUsrc_o, RegWrite_o,Shift_o,ALUControl_o);

initial begin
instr_i=32'h00600513;//addi a0, zero, 6
#10
instr_i=32'h00d605b3;//add a1, a2, a3
#10
instr_i=32'h12302283;//lw t0, 0x123
#10
instr_i=32'h000585e7;//jalr a1, 0(a1)
#10
instr_i=32'h116028a3;//sw s6, 0x111
#10
instr_i=32'h00730663;//beq t1, t2, out(0x0000000c)
#10
instr_i=32'h0124c463;//blt s1, s2, out(0x0000000c)
#10
instr_i=32'h00c5f263;//beq a1, a2, out(0x0000000c)
#10
instr_i=32'h0040036f;//jal t1, finish(0x00000004)
#10
instr_i=32'h00239313;//slli t1, t2, 2
#10
$finish;
end 
endmodule
