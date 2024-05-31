`timescale 1ns / 1ps

module IFetch(
input clk, rst_n,
input PCSrc_i,
input [13:0] addr_i,
output reg [31:0] instr_o,
output reg [13:0] addr_o
    );
    reg [13:0] current_pc;
    wire [31:0] instr;
    reg [13:0]addr;
    initial begin
        current_pc=14'b0;
    end
//    always @(posedge clk) begin
//        if(rst_n==1'b1)begin
//            pc <= 14'b00000000000000; //maybe this should be changed!!!!!
//        end
//        else begin
//            case(PCSrc_i)
//                1'b1:begin
//                    pc <= addr_i;
//                end
//                1'b0:begin
//                    pc <= pc + 4;
//                end
//            endcase
//        end
//    end
//    always @(negedge clk) begin
//        if(rst_n==1'b1)begin
//            pc <= 14'b00000000000000; //maybe this should be changed!!!!!
//        end else
//        begin
//            addr_o <= pc;
//            instr_o <= instr;
//        end
//    end
//    assign pc=(rst_n==1'b1)? 1'b0:(PCSrc==1'b1)? addr:current_pc;
    
    always@(posedge clk)begin
        if(rst_n==1'b1)begin
            addr<=14'b0;
            current_pc<=14'b0;
        end else begin
            addr<=addr_i;
            current_pc<=(PCSrc_i==1'b1)? addr_i:(current_pc+4);
        end
    end
    ROM uram(.clka(clk),.addra(current_pc),.douta(instr));
    always@(negedge clk)begin
        if(rst_n==1'b1)begin
            addr<=14'b0;
            current_pc<=14'b0;
            instr_o<=0;
            addr_o<=0;
        end else begin
            instr_o<=instr;
            addr_o<=current_pc;
        end
    end
    
endmodule
