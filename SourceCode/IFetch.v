`timescale 1ns / 1ps

module IFetch(
input clk, rst_n,
input PCSrc_i,
input [13:0] addr_i,
output [31:0] instr_o,
output reg [13:0] addr_o,

input upg_rst_i, // UPG reset (Active High)
input upg_clk_i, // UPG clock (10MHz)
input upg_wen_i, // UPG write enable
input[13:0] upg_addr_i, // UPG write address
input[31:0] upg_data_i, // UPG write data
input upg_done_i // 1 if program finished
    );
    reg [13:0] pc = 14'b0;
    reg PCSrc;

    /* if kickOff is 1 means CPU work on normal mode, otherwise CPU work on Uart communicationmode*/
   wire kickOff = upg_rst_i | (~upg_rst_i & upg_done_i );
//   wire addr = (PCSrc==1'b1)?addr_i:pc;

//   use a RAM, modify the name
    RAM_IF instmem (
    .clka (kickOff ? ~clk : ~upg_clk_i ),
    .wea (kickOff ? 1'b0 : upg_wen_i ),
    .addra (kickOff ? ((PCSrc==1'b1)?addr_i:pc) : upg_addr_i ),
    .dina (kickOff ? 32'h00000000 : upg_data_i ),
    .douta (instr_o)
    );

    always@(posedge clk)begin
        PCSrc<=PCSrc_i;
    end
    always@(negedge clk or posedge rst_n)begin
        if(rst_n==1'b1)begin
            pc<=14'b00000000000000;
        end else begin
            addr_o<=(PCSrc==1'b1)?addr_i:pc;
            pc<=(PCSrc==1'b1)?addr_i:pc+1;
        end
    end
endmodule