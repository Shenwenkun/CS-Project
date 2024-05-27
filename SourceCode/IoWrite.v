`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/24 03:44:43
// Design Name: 
// Module Name: IoWrite
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


module IoWrite(
input rst_n,TubeCtrl_i,iow_i,
input [31:0] iowrite_data_i,    //from MemOrIo
output reg [31:0] iowrite_data_o
    );
    reg [31:0] iowrite_data;
    
    always@* begin
        if(rst_n) begin
            iowrite_data=0;
        end
        else begin
            if(TubeCtrl_i==1'b1)begin
                iowrite_data_o=iowrite_data;
            end
            else begin
                iowrite_data=iowrite_data_i;
            end
        end
    end
endmodule
