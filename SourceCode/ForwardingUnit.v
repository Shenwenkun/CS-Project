`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/18 13:48:10
// Design Name: 
// Module Name: ForwardingUnit
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


module ForwardingUnit(
input RegWrite_MEWB_i,RegWrite_EXME_i,rst_n,
input [4:0] rd_MEWB_i,rd_EXME_i,rs1_i,rs2_i,
output reg [1:0] ForwardA,ForwardB
    );
    always@* begin
        if (rst_n==1'b1)begin
            ForwardA=2'b00;
            ForwardB=2'b00;
        end
        else begin
            if (!RegWrite_EXME_i || rd_EXME_i==5'b00000 || !RegWrite_MEWB_i || rd_MEWB_i==5'b00000 ||rs1_i!=rd_MEWB_i ||rs1_i!=rd_EXME_i)begin
                    ForwardA=2'b00;
            end
            if (!RegWrite_EXME_i || rd_EXME_i==5'b00000 || !RegWrite_MEWB_i || rd_MEWB_i==5'b00000 ||rs2_i!=rd_MEWB_i ||rs2_i!=rd_EXME_i)begin
                    ForwardB=2'b00;
            end
            if (RegWrite_EXME_i && rd_EXME_i!=5'b00000)begin
                if(rs1_i==rd_EXME_i)begin
                    ForwardA=2'b10;
                end
                if(rs2_i==rd_EXME_i)begin
                    ForwardB=2'b10;
                end
            end//EX forwarding
            if (RegWrite_MEWB_i && rd_MEWB_i!=5'b00000)begin
                if (!RegWrite_EXME_i || rd_EXME_i==5'b00000 || rs1_i!=rd_EXME_i)begin
                    if(rs1_i==rd_MEWB_i)begin
                        ForwardA=2'b01;
                    end
                end
                if (!RegWrite_EXME_i || rd_EXME_i==5'b00000 || rs2_i!=rd_EXME_i)begin
                    if(rs2_i==rd_MEWB_i)begin
                        ForwardB=2'b01;
                    end
                end
            end//MEM forwarding
        end
    end
endmodule
