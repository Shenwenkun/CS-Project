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
    wire [31:0] j_addr, instr0, addr0;
    wire [31:0] instr1, addr1;  //话说addr的位数是32位吗???????????
    wire [4:0] rd1;
    wire [31:0] wdata;
    wire [31:0] imme1, rdata1_1, rdata2_1;
    wire Branch1, MemRead1, MemToReg1, MemWrite1, ALUSrc1, RegWrite1, ALUControl1;
    wire [4:0] rd2, rs1_1, rs2_1, rs1_2, rs2_2;
    wire [31:0] imme2, rdata1_2, rdata2_2, addr2;
    wire Branch2, MemRead2, MemToReg2, MemWrite2, ALUSrc2, RegWrite2, ALUControl2;
    wire [1:0] forwardingA, forwardingB;
    wire [31:0] ALUResult2;
    wire zero;
    wire [31:0] rdata1_3, rdata2_3, rdata_m;
    wire MemRead3, MemToReg3, MemWrite3, RegWrite3;
    wire [31:0] rdata2_4, ALUResult3;
    wire[4:0] rd3;
    wire MemToReg4,RegWrite4;
    wire [4:0] rd4; 


    Clock clock(clk, cpuclk);
    IFetch ifetch(cpuclk, rst_n, PCSrc, j_addr, instr0, addr0);
    IFID ifid(cpuclk, rst_n, instr0, addr0, instr1, addr1);
    Decoder decoder(cpuclk, RegWrite4, rd4, instr1, wdata, imme1, rdata1_1, rdata2_1, rd1);
    
    Controller controller(instr1, rst_n, Branch1, MemRead1, MemToReg1, MemWrite1, ALUSrc1, RegWrite1, ALUControl1);
    
    IDEX idex(cpuclk, rst_n, RegWrite1, ALUSrc1, Branch1, MemRead1, MemWrite1, MemToReg1, imme1, addr1, rdata1_1, rdata2_1, rd1, rs1_1, rs2_1, ALUControl1,
    imme2, addr2, rdata1_2, rdata2_2, rd2, rs1_2, rs2_2, RegWrite2, ALUSrc2, Branch2, MemRead2, MemWrite2, MemToReg2, ALUControl2);

    ForwardingUnit forwardingunit(RegWrite4, RegWrite3, rst_n, rd4, rd3, rs1_2, rs2_2, forwardingA, forwardingB);
    ALU alu(ALUControl2, rdata1_3, rdata2_3, imme2, ALUSrc2, ALUResult2, zero);

    MUX_F1 mux1(rdata1_2, ALUResult3, wdata, forwardingA, rdata1_3);
    MUX_F2 mux2(rdata2_2, ALUResult3, wdata, forwardingB, rdata2_3);
    
    EXMEM exmem(cpuclk, rst_n, zero, RegWrite2, Branch2, MemRead2, MemWrite2, MemToReg2, ALUResult2, imme2, addr2, rdata2_3, rd2,
    RegWrite3, PCSrc, MemRead3, MemWrite3, MemToReg3, j_addr, rdata2_4, ALUResult3, rd3);
    DataMemory datamemory(cpuclk, MemRead3, MemWrite3, ALUResult3, rdata2_4, rdata_m);

    MEMWB memwb(cpuclk, rst_n, RegWrite3, MemToReg3, rdata_m, ALUResult3, rd3, RegWrite4, wdata, rd4);
endmodule
