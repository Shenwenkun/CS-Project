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
input [31:0]instruction,
output Branch_o, MemRead_o, MemToReg_o, MemWrite_o, ALUsrc_o, RegWrite_o,
output reg [3:0] ALUControl_o
    );
    assign MemRead_o=(instruction[6:0]==7'h03)? 1'b1:1'b0;
    assign MemWrite_o=(instruction[6:0]==7'h23)? 1'b1:1'b0;
    assign MemToReg_o=(instruction[6:0]==7'h03)? 1'b1:((instruction[6:0]==7'h33)?1'b0:1'bx);
    assign ALUsrc_o=(instruction[6:0]==7'h03 || instruction[6:0]==7'h23)? 1'b1:1'b0;
    assign RegWrite_o=(instruction[6:0]==7'h33 || instruction[6:0]==7'h03)? 1'b1:1'b0;
    assign Branch_o=(instruction[6:0]==7'h63)? 1'b1:1'b0;
    
    always@* begin
        case(instruction[6:0])
            7'h03,7'h23:ALUControl_o=4'b0010;
            7'h63:ALUControl_o=4'b0110;
            7'h33:begin
                case(instruction[31:25])
                    7'h20:ALUControl_o=4'b0110;
                    7'h00:begin
                        case(instruction[14:12])
                            3'b000: ALUControl_o=4'b0010;
                            3'b111: ALUControl_o=4'b0000;
                            3'b110: ALUControl_o=4'b0001;
                        endcase
                    end
                endcase
            end
        endcase
    end
endmodule