`timescale 1ns / 1ps

module IFetch(
input clk_i, rst_n,
input PCSrc_i,
input [13:0] addr_i,
output reg [31:0] instr_o,
output reg [13:0] addr_o
    );
    reg [13:0] pc;
    wire [31:0] instr;
    ROM uram(.clka(clk_i),.addra(pc),.douta(instr));
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
        addr_o <= pc;
        instr_o <= instr;
    end
endmodule
