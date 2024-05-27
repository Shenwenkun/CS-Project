`timescale 1ns / 1ps

module Decoder(
      input clk_i, rst_i,
      input regWrite_i,
      input [4:0] wrd_i,
      input [31:0] inst_i,
      input [31:0] wdata_i,
      output reg [31:0] imm32_o,
      output reg [31:0] rdata1_o, rdata2_o,
      output reg [4:0] rd_o,
      output reg [4:0] rs1_o, rs2_o
    );
    reg [31:0] register[31:0];
    reg [31:0]i;
    integer j;
    reg [4:0]rs1,rs2;

    always @(posedge clk_i) begin
        if ( rst_i == 0 ) begin
            for (j=0; j<32; j=j+1) begin
                 register[j] = 0;
            end
        end
        else case(inst_i[6:0])
            7'b0110011:begin//R-type
                i = 0;
                rs1={inst_i[19:15]};
                rs2={inst_i[24:20]};
                rd_o={inst_i[11:7]};
            end
            7'b0010011, 7'b0000011:begin//I-type
                i[11:0] = inst_i[31:20];
            	i[31:12] = {20{i[11]}};
                rs1={inst_i[19:15]};
                rs2=0;
                rd_o={inst_i[11:7]};
            end
            7'b0100011:begin//S-type
                i[11:0] = {inst_i[31:25],inst_i[11:7]};
		i[31:12] = {20{i[11]}};
                rs1={inst_i[19:15]};
                rs2={inst_i[24:20]};
                rd_o=0;
            end
            7'b1100011:begin//B-type
                i[12:0] = {inst_i[31],inst_i[7],inst_i[30:25],inst_i[11:8],1'b0};
		        i[31:13] = {19{i[12]}};
                rs1={inst_i[19:15]};
                rs2={inst_i[24:20]};
                rd_o=0;
            end
            7'b0110111:begin//U-type
                i = {inst_i[31:12],12'b0000_0000_0000};
                rs1=0;
                rs2=0;
                rd_o={inst_i[11:7]};
            end
            7'b1101111:begin//J-type
                i[20:0] = {inst_i[31],inst_i[19:12],inst_i[20],inst_i[30:21],1'b0};
		        i[31:21] = {11{i[20]}};
                rs1=0;
                rs2=0;
                rd_o={inst_i[11:7]};
            end
            default:begin
                i = 0;
                rs1=0;
                rs2=0;
                rd_o=0;
            end
        endcase
    end
    
    always @(posedge clk_i)begin
        if ( rst_i == 0 ) begin
            for (j=0; j<32; j=j+1) begin
               register[j] = 0;
            end
        end
        else case(regWrite_i)
            1'b1:begin
                case(wrd_i)
                    5'b00000:register[wrd_i]=0;
                    default:register[wrd_i]=wdata_i;
                endcase
            end
            1'b0:begin
            end
        endcase
    end
    
    always @(negedge clk_i) begin
        imm32_o <= i;
        rdata1_o <= register[rs1];
        rdata2_o <= register[rs2];
        rs1_o <= rs1;
        rs2_o <= rs2;
    end

endmodule