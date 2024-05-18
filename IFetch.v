`timescale 1ns / 1ps

module IFetch(
input clk_i, reset,
input PCSrc_i,
input [31:0] addr_i,
output [31:0] instr_o,
output [31:0] addr_o
    );
    reg [31:0] pc;
    RAM uram(.clk_ia(clk_i),.addra(pc),.douta(instr_o));
    always @(posedge clk_i) begin
        if(reset)begin
            pc <= 0; //maybe this should be changed!!!!!
        end
        else
        begin
            case(PCSrc_i)
                1'b1:begin
                    pc <= pc + addr_i;
                    end
                default:begin
                    pc <= pc + 4;
                    end
            endcase
        end
    end
    assign addr_o = pc;
endmodule
