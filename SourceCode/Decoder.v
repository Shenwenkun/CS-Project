`timescale 1ns / 1ps

module Decoder(
      input clk_i, rst_i,
      input regWrite_i,
      input [4:0] wrd_i,
      input [31:0] instr_i,
      input [31:0] wdata_i,
      input [13:0] addr_i,//当前PC
      output reg [31:0] imm32_o,
      output reg [31:0] rdata1_o, rdata2_o,
      output reg [4:0] rd_o,
      output reg [4:0] rs1_o, rs2_o
    );
    reg [31:0] register[31:0];
    reg [31:0]imme;
    integer j;
    reg [4:0]rs1,rs2;

    always @(posedge clk_i) begin
        if ( rst_i == 1 ) begin
            for (j=0; j<32; j=j+1) begin
                 register[j] = 0;
            end
        end
        else begin case(instr_i[6:0])
            7'b0110011:begin//R-type
                imme = 0;
                rs1={instr_i[19:15]};
                rs2={instr_i[24:20]};
                rd_o={instr_i[11:7]};
            end
            7'b0010011, 7'b0000011,7'b1100111:begin//I-type
                imme[11:0] = instr_i[31:20];
            	imme[31:12] = {20{imme[11]}};
                rs1={instr_i[19:15]};
                rs2=0;
                if(instr_i[6:0]==7'b1100111)begin
                    rd_o=5'b0;
                    register[instr_i[11:7]]=addr_i;
                end else begin
                    rd_o={instr_i[11:7]};
                end
            end
            7'b0100011:begin//S-type
                imme[11:0] = {instr_i[31:25],instr_i[11:7]};
		        imme[31:12] = {20{imme[11]}};
                rs1={instr_i[19:15]};
                rs2={instr_i[24:20]};
                rd_o=0;
            end
            7'b1100011:begin//B-type
                imme[12:0] = {instr_i[31],instr_i[7],instr_i[30:25],instr_i[11:8],1'b0};
		        imme[31:13] = {19{imme[12]}};
                rs1={instr_i[19:15]};
                rs2={instr_i[24:20]};
                rd_o=0;
            end
            7'b0110111:begin//U-type
                imme = {instr_i[31:12],12'b0000_0000_0000};
                rs1=0;
                rs2=0;
                rd_o={instr_i[11:7]};
            end
            7'b1101111:begin//J-type
                imme[20:0] = {instr_i[31],instr_i[19:12],instr_i[20],instr_i[30:21],1'b0};
		        imme[31:21] = {11{imme[20]}};
                rs1=0;
                rs2=0;
                rd_o=5'b0;//设为0，防止写回错误数据
                register[instr_i[11:7]]=addr_i;
            end
            default:begin
                imme = 0;
                rs1=0;
                rs2=0;
                rd_o=0;
            end
        endcase
        if(regWrite_i)begin
            case(wrd_i)
                5'b00000:register[wrd_i]=0;
                default:register[wrd_i]=wdata_i;
            endcase
        end
    end
    end
    
    
    always @(negedge clk_i) begin
        imm32_o <= imme;
        rdata1_o <= register[rs1];
        rdata2_o <= register[rs2];
        rs1_o <= rs1;
        rs2_o <= rs2;
    end

endmodule