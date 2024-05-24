`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/24 16:07:25
// Design Name: 
// Module Name: Controller
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


module Controller(
input [31:0]instr_i,
//input[21:0] Alu_resultHigh_i,//from the EXMEM
output Branch_o, MemRead_o,  MemWrite_o, ALUsrc_o, RegWrite_o,MemToReg_o,
output reg [3:0] ALUControl_o
//output MemOrIoToReg_o, //1 indicates that read date from memory or I/O to write to the register
//output IoRead_o, // 1 indicates I/O read
//output IoWrite_o // 1 indicates I/O write
    );
    assign MemRead_o=(instr_i[6:0]==7'h03 )? 1'b1:1'b0;//&& Alu_resultHigh_i!=22'h3FFFFF
    assign MemWrite_o=(instr_i[6:0]==7'h23 )? 1'b1:1'b0;
//    assign IoRead_o=(instr_i[6:0]==7'h03 )? 1'b1:1'b0;
//    assign IoWrite_o=(instr_i[6:0]==7'h23 )? 1'b1:1'b0;
    assign ALUsrc_o=(instr_i[6:0]==7'h03 || instr_i[6:0]==7'h23)? 1'b1:1'b0;
    assign RegWrite_o=(instr_i[6:0]==7'h33 || instr_i[6:0]==7'h03)? 1'b1:1'b0;
    assign Branch_o=(instr_i[6:0]==7'h63)? 1'b1:1'b0;
    assign MemToReg_o=(instr_i[6:0]==7'h03)? 1'b1:((instr_i[6:0]==7'h33)?1'b0:1'bx);
//    assign MemOrIoToReg_o=MemRead_o||IoRead_o;    
    always@* begin
        case(instr_i[6:0])
            7'h63:ALUControl_o=4'b0110;
            7'h33:begin
                case(instr_i[31:25])
                    7'h00:begin
                        case(instr_i[14:12])
                            3'b000: ALUControl_o=4'b0010;
                            3'b111: ALUControl_o=4'b0000;
                            default: ALUControl_o=4'b0001;//3'b110
                        endcase
                    end
                    default:ALUControl_o=4'b0110;//7'h20:
                endcase
            end
            default:ALUControl_o=4'b0010;//7'h03,7'h23
        endcase
    end
endmodule