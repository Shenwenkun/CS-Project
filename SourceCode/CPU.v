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
input clk, rst,conf_i,
input [15:0] rdata_from_io,
output [31:0] data_to_io
    );
    wire cpuclk, PCSrc;
    wire rst_n;
    assign rst_n = ~rst;
    
    wire [13:0] j_addr;
    wire [31:0] instr0;
    wire [13:0] addr0;
    wire [31:0] instr1,instr2;
    wire [13:0] addr1;
    wire [4:0] rd1;
    wire [31:0] wdata;
    wire [31:0] imme1, rdata1_1, rdata2_1;
    wire MemRead1, MemOrIoToReg1, MemWrite1, ALUSrc1, RegWrite1;
    wire [3:0] ALUControl1;
    wire [4:0] rd2, rs1_1, rs2_1, rs1_2, rs2_2;
    wire [31:0] imme2, rdata1_2, rdata2_2;
    wire [13:0] addr2;
    wire MemRead2, MemOrIoToReg2, MemWrite2, ALUSrc2, RegWrite2;
    wire [3:0] ALUControl2;
    wire [1:0] forwardingA, forwardingB;
    wire [31:0] ALUResult1, ALUResult2;
    wire zero;
    wire [31:0] rdata1_3, rdata2_3, rdata_m,rdata_m1;
    wire MemRead3,MemWrite3, RegWrite3;
    wire [31:0] rdata2_4,rdata2_5;
    wire[4:0] rd3;
    wire MemOrIoToReg4,RegWrite4;
    wire [4:0] rd4; 
    wire [5:0] Alu_resultHigh;
    wire IoRead1,IoWrite1,IoRead2,IoWrite2;
    wire [15:0]rdata_io;//拨码开关送来的数据
//    wire LEDCtrl,SwitchCtrl,TubeCtrl;
//    wire [15:0]ioread_data_switch;
    wire [13:0] addr3;
    wire [1:0] Shift1,Shift2;
    wire [1:0] ByteOrWord1,ByteOrWord2;
    assign rdata_io=rdata_from_io;
    assign data_to_io= rdata2_5;
    Clock clock(
    .clk_in1(clk), 
    .clk_out1(cpuclk)
    );
    
    IFetch ifetch(cpuclk, rst_n, PCSrc, j_addr, instr0, addr0);
    
    IFID ifid(cpuclk, rst_n,PCSrc, instr0, addr0, instr1, addr1);
    
    Decoder decoder(cpuclk, rst_n, RegWrite4, rd4, instr1, wdata,addr1, imme1, rdata1_1, rdata2_1, rd1, rs1_1, rs2_1,PCSrc,j_addr);
    
    //Controller controller(instr1, rst_n, Branch1, MemRead1, MemToReg1, MemWrite1, ALUSrc1, RegWrite1, ALUControl1);
    Controller controller(
    .instr_i(instr1),
//    .Branch_o(Branch1),
//    .MemRead_o(MemRead1),
//    .MemToReg_o(MemToReg1),
//    .MemWrite_o(MemWrite1),
    .ALUsrc_o(ALUSrc1), 
    .RegWrite_o(RegWrite1), 
    .Shift_o(Shift1),
    .ALUControl_o(ALUControl1)
    );
    
    IDEX idex(
    cpuclk,rst_n,
    RegWrite1,ALUSrc1, Shift1,
//    MemRead1, MemWrite1, MemToReg1, 
    imme1, rdata1_1, rdata2_1,instr1, addr1, rd1, rs1_1, rs2_1, 
    ALUControl1,
    imme2, addr2, rdata1_2, rdata2_2,instr2, rd2, rs1_2, rs2_2, 
    RegWrite2, ALUSrc2, Shift2,
//    MemRead2, MemWrite2, MemToReg2, 
    ALUControl2
    );

    ForwardingUnit forwardingunit(RegWrite4, RegWrite3, rst_n, rd4, rd3, rs1_2, rs2_2, forwardingA, forwardingB);
    
    ALU alu(cpuclk,Shift2,ALUControl2, rdata1_3, rdata2_3, imme2, ALUSrc2, ALUResult1,Alu_resultHigh);
    
    Controller2 controller2(instr2,Alu_resultHigh,MemOrIoToReg1,MemRead1,MemWrite1,IoRead1,IoWrite1,ByteOrWord1);

    MUX_F1 mux1(rdata1_2, ALUResult1, wdata, forwardingA, rdata1_3);
    
    MUX_F2 mux2(rdata2_2, ALUResult1, wdata, forwardingB, rdata2_3);
    
    EXMEM exmem(
    cpuclk, rst_n, 
    RegWrite2, 
    MemRead1, MemWrite1, MemOrIoToReg1, IoRead1,IoWrite1,ByteOrWord1,
    ALUResult1, 
    imme2, addr2, rdata2_3, rd2,
    RegWrite3,
    MemRead2, MemWrite2, MemOrIoToReg2, IoRead2,IoWrite2,
    rdata2_4, ALUResult2, rd3,ByteOrWord2
    );
    
    DataMemory datamemory(cpuclk, IoWrite2, MemWrite2, addr3, rdata2_5, rdata_m);
    
    MemOrIo memorio(
    cpuclk,conf_i,
    MemRead2,MemWrite2,IoRead2,IoWrite2,ByteOrWord2,
    ALUResult2[13:0],addr3,
    rdata_m,rdata_io,rdata_m1,rdata2_4,rdata2_5
    );
    
//    IoWrite iowrite(rst_n,TubeCtrl,IoWrite2,rdata2_5,rdata2_6);//connect output device
    
//    IoRead ioread(rst_n,IoRead2,SwitchCtrl,ioread_data_switch,rdata_io);//connect input device
    
    MEMWB memwb(cpuclk, rst_n, RegWrite3, MemOrIoToReg2, rdata_m1, ALUResult2, rd3, RegWrite4, wdata, rd4);
    
endmodule
