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
output ALUsrc_o, RegWrite_o,
output [1:0] Shift_o,
output reg [3:0] ALUControl_o
//output [2:0] Compare_o,
//output Jalr_o
    );
    assign ALUsrc_o=(instr_i[6:0]==7'h13 || instr_i[6:0]==7'h03 || instr_i[6:0]==7'h67)? 1'b0:1'b1;
    assign RegWrite_o=(instr_i[6:0]==7'h33 || instr_i[6:0]==7'h03 || instr_i[6:0]==7'h13)? 1'b1:1'b0;
//    assign Branch_o=(instr_i[6:0]==7'h63)? 1'b1:1'b0;
    assign Shift_o=(instr_i[6:0]==7'h13)? ((instr_i[14:12]==3'h1)? 2'b11:(instr_i[14:12]==3'h5)?2'b10:2'b00):2'b00;
//    assign Compare_o=(instr_i[6:0]==7'h63)?instr_i[14:12]:3'bzzz;
//    assign J_o=(instr_i[6:0]==7'h6F)?1'b1:1'b0;
//    assign Jalr_o=(instr_i[6:0]==7'h67)?1'b1:1'b0;
//    assign MemToReg_o=(instr_i[6:0]==7'h03)? 1'b1:((instr_i[6:0]==7'h33)?1'b0:1'bx);
    
    always@* begin
        case(instr_i[6:0])
            7'h63:begin
                ALUControl_o=4'b0110;//sub
            end
            7'h33:begin
                case(instr_i[31:25])
                    7'h00:begin
                        case(instr_i[14:12])
                            3'b000: ALUControl_o=4'b0010;//add
                            3'b111: ALUControl_o=4'b0000;//and
                            default: ALUControl_o=4'b0001;//3'b110//or
                        endcase
                    end
                    default:ALUControl_o=4'b0110;//7'h20:
                endcase
            end
            7'h03,7'h23,7'h67:ALUControl_o=4'b0010;//7'h03,7'h23
            7'h13:ALUControl_o=4'b0010;
        endcase
    end
endmodule