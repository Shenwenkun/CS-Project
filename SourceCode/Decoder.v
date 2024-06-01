`timescale 1ns / 1ps

module Decoder(
      input clk, rst_n,
      input regWrite_i,
      input [4:0] wrd_i,
      input [31:0] instr_i,
      input [31:0] wdata_i,
      input [13:0] addr_i,//当前PC
      output reg [31:0] imm32_o,
      output reg [31:0] rdata1_o, rdata2_o,
      output reg [4:0] rd_o,
      output reg [4:0] rs1_o, rs2_o,
      output reg jump_o,//为1则清空IFID
      output reg [13:0] addr_o
    );
    reg [31:0] register[31:0];
    reg [31:0]imme;
    integer j;
    reg [4:0]rs1,rs2,rd;
    reg jump;
    reg [13:0] addr;
    initial begin
       for (j=0; j<32; j=j+1) begin
             register[j] <= 0;
        end 
    end
    always @(posedge clk) begin
        if ( rst_n == 1 ) begin
            for (j=0; j<32; j=j+1) begin
                 register[j] <= 0;
            end
        end
        else begin case(instr_i[6:0])
            7'b0110011:begin//R-type
                imme <= 0;
                rs1<={instr_i[19:15]};
                rs2<={instr_i[24:20]};
                rd<={instr_i[11:7]};
                jump<=0;
                addr<=0;
            end
            7'b0010011, 7'b0000011,7'b1100111:begin//I-type
                imme<= {{20{instr_i[31]}},instr_i[31:20]};
                rs1<={instr_i[19:15]};
                rs2<=0;
                if(instr_i[6:0]==7'b1100111)begin//jalr
                    rd<=5'b0;
                    register[instr_i[11:7]]<=addr_i+1;
                    jump<=1'b1;
                    addr<=register[{instr_i[19:15]}]/4+addr_i;
                end else begin
                    rd<={instr_i[11:7]};
                    jump<=0;
                    addr<=0;
                end
            end
            7'b0100011:begin//S-type
                imme<= {{20{instr_i[31]}},instr_i[31:25],instr_i[11:7]};
                rs1<={instr_i[19:15]};
                rs2<={instr_i[24:20]};
                rd<=0;
                jump<=0;
                addr<=0;
            end
            7'b1100011:begin//B-type
                imme<= {{19{instr_i[31]}},instr_i[31],instr_i[7],instr_i[30:25],instr_i[11:8],1'b0};
                rs1<=0;//没用了
                rs2<=0;//没用了
                rd<=0;
                case(instr_i[14:12])
                    3'b000: jump<=(register[{instr_i[19:15]}]-register[{instr_i[24:20]}] == 0)? 1'b1 : 1'b0;
                    3'b001: jump<=(register[{instr_i[19:15]}]-register[{instr_i[24:20]}] == 0)? 1'b0 : 1'b1;
                    3'b100: jump<=(register[{instr_i[19:15]}]-register[{instr_i[24:20]}] < 0)? 1'b1 : 1'b0;
                    3'b110: jump<=($unsigned(register[{instr_i[19:15]}])-$unsigned(register[{instr_i[24:20]}]) < 0)? 1'b1 : 1'b0;
                    3'b101: jump<=(register[{instr_i[19:15]}]-register[{instr_i[24:20]}] >= 0)? 1'b1 : 1'b0;
                    3'b111: jump<=($unsigned(register[{instr_i[19:15]}])-$unsigned(register[{instr_i[24:20]}]) >= 0)? 1'b1 : 1'b0;
                endcase
                addr<=addr_i+{{19{instr_i[31]}},instr_i[31],instr_i[7],instr_i[30:25],instr_i[11:8],1'b0}/4;
            end
            7'b0110111:begin//U-type
                imme <= {instr_i[31:12],12'b0000_0000_0000};
                rs1<=0;
                rs2<=0;
                rd<={instr_i[11:7]};
                jump<=0;
                addr<=0;
            end
            7'b1101111:begin//J-type
                imme <= {{11{instr_i[31]}},instr_i[31],instr_i[19:12],instr_i[20],instr_i[30:21],1'b0};
                rs1<=0;
                rs2<=0;
                rd<=5'b0;//设为0，防止写回错误数据
                register[instr_i[11:7]]=addr_i;
                jump<=1'b1;
                addr<={{11{instr_i[31]}},instr_i[31],instr_i[19:12],instr_i[20],instr_i[30:21],1'b0}/4;
            end
            default:begin
                imme <= 0;
                rs1<=0;
                rs2<=0;
                rd<=0;
                jump<=0;
                addr<=0;
            end
        endcase
        if(regWrite_i)begin
            case(wrd_i)
                5'b00000:register[wrd_i]<=0;
                default:register[wrd_i]<=wdata_i;
            endcase
        end
    end
    end
    
    
    always @(negedge clk) begin
        if(rst_n)begin
            for (j=0; j<32; j=j+1) begin
                 register[j] <= 0;
            end
            imme<=0;
            rs1<=0;rs2<=0;rd<=0;
            jump<=0;addr<=0;
        end else begin
            imm32_o <= imme;
            rdata1_o <= register[rs1];
            rdata2_o <= register[rs2];
            rs1_o <= rs1;
            rs2_o <= rs2;
            rd_o<=rd;
            jump_o<=jump;
            addr_o<=addr;
        end
    end

endmodule