`timescale 1ns / 1ps

module IFetch(
input clk_i, reset,
input branch_i,
input [31:0] imme_i,
output [31:0] instr_o
    );
    reg [31:0] pc;
    RAM uram(.clk_ia(clk_i),.addra(pc),.douta(instr_o));
    always @(posedge clk_i) begin
        if(reset)begin
            pc <= 0; //maybe this should be changed!!!!!
        end
        else
        begin
            case(branch_i)
                1'b1:begin
                    pc <= pc + imme_i;
                    end
                default:begin
                    pc <= pc + 4;
                    end
            endcase
        end
    end
endmodule
