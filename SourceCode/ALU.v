`timescale 1ns / 1ps

module ALU(
input clk,
//input [2:0]Compare_i,
input [1:0] Shift_i,
input [3:0] ALUControl_i,
input [31:0] rdata1_i,
input [31:0] rdata2_i,
input [31:0] imme_i,
input ALUSrc_i,
output reg [31:0] ALUResult_o,
output reg [5:0]Alu_resultHigh_o
//output reg zero
    );
    wire[31:0] operand2;
    reg [31:0]ALUResult;
    reg [2:0]Compare;
    assign operand2 = (ALUSrc_i==1'b1)? rdata2_i:imme_i;
    // ALUControll indications:
    // add:0010
    // sub:0110
    // and:0000
    // or: 0001
    always @ (*) begin
//        Compare<=Compare_i;
        case( ALUControl_i)
            4'b0010:begin
               ALUResult = rdata1_i + operand2;
            end
            4'b0110: begin
//                if(Compare_i[1]==1'b1)begin
//                    ALUResult<= $unsigned(rdata1_i)-$unsigned(operand2);
//                end else begin
                    ALUResult = rdata1_i - operand2;
//                end
            end
            4'b0000: ALUResult = rdata1_i & operand2;
            4'b0001: ALUResult = rdata1_i | operand2;
            default:begin
                case(Shift_i)
                    2'b11:ALUResult = (rdata1_i<<operand2);
                    2'b10:ALUResult = (rdata1_i>>operand2);
                    default:ALUResult = 0;
                endcase
            end
        endcase
    end

    always @(negedge clk)begin
        ALUResult_o<=ALUResult;
        Alu_resultHigh_o<=ALUResult[13:8];

//        case(Compare)
//            3'b000: zero<=(ALUResult == 0)? 1'b1 : 1'b0;
//            3'b001: zero<=(ALUResult == 0)? 1'b0 : 1'b1;
//            3'b100,3'b110: zero<=(ALUResult < 0)? 1'b1 : 1'b0;
//            3'b101,3'b111: zero<=(ALUResult >= 0)? 1'b1 : 1'b0;
//        endcase//?¡§????Decoder
    end
endmodule
