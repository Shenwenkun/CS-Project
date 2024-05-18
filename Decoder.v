`timescale 1ns / 1ps

module Decoder(
input clk,regwrite,
input [31:0] instr_i,wdata,
output reg signed [31:0] imme_o,
output reg [31:0] rdata1,rdata2
    );
reg [31:0] register[31:0];
reg [31:0]i;
reg [4:0]rs1,rs2,rd;
    
    always @(posedge clk) begin
        case(instr_i[6:0])
            7'b0110011:begin//R-type
                i = 1;
                rs1={instr_i[19:15]};
                rs2={instr_i[24:20]};
                rd={instr_i[11:7]};
            end
            7'b0010011:begin//I-type
                i = {instr_i[31:20]};
                rs1={instr_i[19:15]};
                rs2=0;
                rd={instr_i[11:7]};
            end
            7'b0100011:begin//S-type
                i = {instr_i[31:25],instr_i[11:7]};
                rs1={instr_i[19:15]};
                rs2={instr_i[24:20]};
                rd=0;
            end
            7'b1100011:begin//B-type
                i = {instr_i[31],instr_i[7],instr_i[30:25],instr_i[11:8],1'b0};
                rs1={instr_i[19:15]};
                rs2={instr_i[24:20]};
                rd=0;
            end
            7'b0110111:begin//U-type
                i = {instr_i[31:12],12'b0000_0000_0000};
                rs1=0;
                rs2=0;
                rd={instr_i[11:7]};
            end
            7'b1101111:begin//J-type
                i = {instr_i[31],instr_i[19:12],instr_i[20],instr_i[30:21],1'b0};
                rs1=0;
                rs2=0;
                rd={instr_i[11:7]};
            end
            default:begin
                i = 0;
                rs1=0;
                rs2=0;
                rd=0;
            end
        endcase
    end
    
    always @(posedge clk)begin
        case(regwrite)
            1'b1:begin
                case(rd)
                    5'b00000:register[rd]=0;
                    default:register[rd]<=wdata;
                endcase
            end
            1'b0:begin
            end
        endcase
    end
    
    always @(negedge clk) begin
        imme_o <= i;
        rdata1 <= register[rs1];
        rdata2 <= register[rs2];
    end

endmodule
