`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/01 20:55:46
// Design Name: 
// Module Name: tb_ifetch
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_ifetch(

    );
    
    reg clk, rst_n, PCSrc,
    upg_rst_i, upg_clk_i, upg_wen_i, upg_done_i;
    reg [13:0] addr,
     upg_addr_i;
    reg [31:0] upg_dat_i;
    wire [13:0] addr_o;
    wire [31:0] inst;
    
    IFetch IF(.clk(clk),
    .rst_n(rst_n), .PCSrc_i(PCSrc),
    .addr_i(addr), .instr_o(inst), .addr_o(addr_o), 
    .upg_rst_i(upg_rst_i), .upg_clk_i(upg_clk_i), .upg_wen_i(upg_wen_i), .upg_addr_i(upg_addr_i), .upg_data_i(upg_dat_i), .upg_done_i(upg_done_i)
    );
    initial begin
    clk =1'b0;
    forever #5 clk=~clk;
    end
    
    initial begin
    PCSrc = 1'b0;
    end
    
    initial begin
    upg_clk_i = 1'b0;
    forever #2 upg_clk_i = ~upg_clk_i;
    end
    
    initial begin
    rst_n = 1'b1;
    #5 rst_n = 1'b0;
    end
    
    initial begin
    addr =32'h0;
    #75 repeat(20) #12 addr = addr + 1;
    #20 $finish;
    end
    
    initial begin
    upg_dat_i = 32'h0;
    #16 repeat(20) #6 upg_dat_i = upg_dat_i + 16;
    end
    
    initial begin
    upg_addr_i = 32'h0;
    repeat(20) #6 upg_addr_i = upg_addr_i + 1;
    end
    
    initial begin
    upg_rst_i = 1'b0;
    upg_wen_i = 1'b0;
    #10 upg_wen_i = 1'b1;
    #130 upg_rst_i = 1'b1;
    end
    
    initial begin
    upg_done_i = 1'b0;
    #120 upg_done_i = 1'b1;
    end

endmodule
