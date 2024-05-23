module Decoder(
      input clk, rst,
      input regWrite,
      input [31:0] inst,
      input [31:0] writeData,
      output reg [31:0] rs1Data, rs2Data,
      output reg [31:0] imm32 
    );
reg [31:0] register[31:0];
reg [31:0]i;
reg [4:0]rs1,rs2,rd;
    
    always @(*) begin
        if ( rst == 0 ) begin
            for (i=0; i<32; i=i+1) begin
                 register[i] = 0;
            end
        end
    end

    always @(posedge clk) begin
        case(inst[6:0])
            7'b0110011:begin//R-type
                i = 0;
                rs1={inst[19:15]};
                rs2={inst[24:20]};
                rd={inst[11:7]};
            end
            7'b0010011, 7'b0000011:begin//I-type
                i[11:0] = inst[31:20];
            	i[31:12] = {20{i[11]}};
                rs1={inst[19:15]};
                rs2=0;
                rd={inst[11:7]};
            end
            7'b0100011:begin//S-type
                i[11:0] = {inst[31:25],inst[11:7]};
		i[31:12] = {20{i[11]}};
                rs1={inst[19:15]};
                rs2={inst[24:20]};
                rd=0;
            end
            7'b1100011:begin//B-type
                i[12:0] = {inst[31],inst[7],inst[30:25],inst[11:8],1'b0};
		i[31:13] = {19{i[12]}};
                rs1={inst[19:15]};
                rs2={inst[24:20]};
                rd=0;
            end
            7'b0110111:begin//U-type
                i = {inst[31:12],12'b0000_0000_0000};
                rs1=0;
                rs2=0;
                rd={inst[11:7]};
            end
            7'b1101111:begin//J-type
                i[20:0] = {inst[31],inst[19:12],inst[20],inst[30:21],1'b0};
		i[31:21] = {11{i[20]}};
                rs1=0;
                rs2=0;
                rd={inst[11:7]};
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
        case(regWrite)
            1'b1:begin
                case(rd)
                    5'b00000:register[rd]=0;
                    default:register[rd]<=writeData;
                endcase
            end
            1'b0:begin
            end
        endcase
    end
    
    always @(negedge clk) begin
        imm32 <= i;
        rs1Data <= register[rs1];
        rs2Data <= register[rs2];
    end

endmodule