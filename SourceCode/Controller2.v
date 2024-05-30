`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/24 21:32:58
// Design Name: 
// Module Name: Controller2
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


module Controller2(
input [31:0]instr_i,
input[21:0] Alu_resultHigh_i,//from the EXMEM
output MemOrIoToReg_o,MemRead_o,  MemWrite_o, //1 indicates that read date from memory or I/O to write to the register
output IoRead_o, // 1 indicates I/O read
output IoWrite_o, // 1 indicates I/O write
output reg [1:0] ByteOrWord_o
    );
        assign MemRead_o=(instr_i[6:0]==7'h03 && Alu_resultHigh_i!=22'h3FFFFF)? 1'b1:1'b0;//&& Alu_resultHigh_i!=22'h3FFFFF
        assign MemWrite_o=(instr_i[6:0]==7'h23 && Alu_resultHigh_i!=22'h3FFFFF)? 1'b1:1'b0;
        assign IoRead_o=(instr_i[6:0]==7'h03 && Alu_resultHigh_i==22'h3FFFFF)? 1'b1:1'b0;
        assign IoWrite_o=(instr_i[6:0]==7'h23 && Alu_resultHigh_i==22'h3FFFFF)? 1'b1:1'b0;
        assign MemOrIoToReg_o=MemRead_o||IoRead_o;
        always @* begin
            if(instr_i[6:0]==7'h03)begin
                case(instr_i[14:12])
                    3'b000: ByteOrWord_o=2'b00;//lb
                    3'b010: ByteOrWord_o=2'b01;//lw
                    3'b100: ByteOrWord_o=2'b10;//lbu
                    default: ByteOrWord_o=2'b01;
                endcase
            end
        end
endmodule
