`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/18 14:49:26
// Design Name: 
// Module Name: CPU
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


module CPU(
input clk, rst, start
    );
    wire cpuclk, PCSrc;
    wire rst_n;
    assign rst_n = ~rst;
    wire [13:0] j_addr;
    wire [31:0] instr0;
    wire [13:0] addr0;
    wire [31:0] instr1;
    wire [13:0] addr1;
    wire [4:0] rd1;
    wire [31:0] wdata;
    wire [31:0] imme1, rdata1_1, rdata2_1;
    wire Branch1, MemRead1, MemToReg1, MemWrite1, ALUSrc1, RegWrite1;
    wire [3:0] ALUControl1;
    wire [4:0] rd2, rs1_1, rs2_1, rs1_2, rs2_2;
    wire [31:0] imme2, rdata1_2, rdata2_2;
    wire [13:0] addr2;
    wire Branch2, MemRead2, MemToReg2, MemWrite2, ALUSrc2, RegWrite2;
    wire [3:0] ALUControl2;
    wire [1:0] forwardingA, forwardingB;
    wire [31:0] ALUResult2;
    wire zero;
    wire [31:0] rdata1_3, rdata2_3, rdata_m;
    wire MemRead3, MemToReg3, MemWrite3, RegWrite3;
    wire [31:0] rdata2_4, ALUResult3;
    wire[4:0] rd3;
    wire MemToReg4,RegWrite4;
    wire [4:0] rd4; 


    Clock clock(.clk_in1(clk), .clk_out1(cpuclk));
    IFetch ifetch(.clk_i(cpuclk),.rst_n(rst_n),.PCSrc_i( PCSrc),.addr_i( j_addr), .instr_o(instr0), .addr_o(addr0));
    IFID ifid(.rst_n(rst_n), .Instr_i(instr0), .addr_i(addr0), .Instr_o(instr1), .addr_o(addr1));
    Decoder decoder(cpuclk, rst_n, RegWrite4, rd4, instr1, wdata, imme1, rdata1_1, rdata2_1, rd1, rs1_1, rs2_1);
    
    //Controller controller(instr1, rst_n, Branch1, MemRead1, MemToReg1, MemWrite1, ALUSrc1, RegWrite1, ALUControl1);
    Controller controller(.instr_i(instr1), .Branch_o(Branch1), .MemRead_o(MemRead1), .MemToReg_o(MemToReg1), .MemWrite_o(MemWrite1),
     .ALUsrc_o(ALUSrc1), .RegWrite_o(RegWrite1), .ALUControl_o(ALUControl1));
    IDEX idex(rst_n, RegWrite1, ALUSrc1, Branch1, MemRead1, MemWrite1, MemToReg1, imme1, rdata1_1, rdata2_1, addr1, rd1, rs1_1, rs2_1, ALUControl1,
    imme2, addr2, rdata1_2, rdata2_2, rd2, rs1_2, rs2_2, RegWrite2, ALUSrc2, Branch2, MemRead2, MemWrite2, MemToReg2, ALUControl2);

    ForwardingUnit forwardingunit(RegWrite4, RegWrite3, rst_n, rd4, rd3, rs1_2, rs2_2, forwardingA, forwardingB);
    ALU alu(ALUControl2, rdata1_3, rdata2_3, imme2, ALUSrc2, ALUResult2, zero);

    MUX_F1 mux1(rdata1_2, ALUResult3, wdata, forwardingA, rdata1_3);
    MUX_F2 mux2(rdata2_2, ALUResult3, wdata, forwardingB, rdata2_3);
    
    EXMEM exmem(rst_n, zero, RegWrite2, Branch2, MemRead2, MemWrite2, MemToReg2, ALUResult2, imme2, addr2, rdata2_3, rd2,
    RegWrite3, PCSrc, MemRead3, MemWrite3, MemToReg3, rdata2_4, ALUResult3, j_addr, rd3);
    DataMemory datamemory(cpuclk, MemRead3, MemWrite3, ALUResult3[13:0], rdata2_4, rdata_m);

    MEMWB memwb(.rst_n(rst_n), .RegWrite_i(RegWrite3), .MemToReg_i(MemToReg3), .data_i(rdata_m), .ALUResult_i(ALUResult3), .rd_i(rd3), .RegWrite_o(RegWrite4), .wdata_o(wdata), .rd_o(rd4));
endmodule
