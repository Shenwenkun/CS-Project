`timescale 1ns / 1ps

module IFetch(
input clk_i, rst_n,
input PCSrc_i,
input [13:0] addr_i,
output reg [31:0] instr_o,
output reg [13:0] addr_o,

input upg_rst_i, // UPG reset (Active High)
input upg_clk_i, // UPG clock (10MHz)
input upg_wen_i, // UPG write enable
input[13:0] upg_addr_i, // UPG write address
input[31:0] upg_data_i, // UPG write data
input upg_done_i // 1 if program finished
    );
    reg [13:0] pc;
    wire [31:0] instr;
    /* if kickOff is 1 means CPU work on normal mode, otherwise CPU work on Uart communicationmode*/
    wire kickOff = upg_rst_i | (~upg_rst_i & upg_done_i );
//   use a RAM, modify the name
    RAM_IF instmem (
    .clka (kickOff ? clk_i : upg_clk_i ),
    .wea (kickOff ? 1'b0 : upg_wen_i ),
    .addra (kickOff ? addr_i : upg_addr_i ),
    .dina (kickOff ? 32'h00000000 : upg_data_i ),
    .douta (instr)
    );
//    ROM uram(.clka(clk_i),.addra(pc),.douta(instr));
    always @(posedge clk_i) begin
        if(rst_n)begin
            pc <= 0; //maybe this should be changed!!!!!
        end
        else begin
            case(PCSrc_i)
                1'b1:begin
                    pc <= addr_i;
                    end
                default:begin
                    pc <= pc + 4;
                    end
            endcase
        end
    end
    always @(negedge clk_i) begin
        if(rst_n)begin
            pc <= 0; //maybe this should be changed!!!!!
        end
        else begin
            addr_o <= pc;
            instr_o <= instr;
        end
    end
endmodule
