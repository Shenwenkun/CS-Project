`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/01 16:30:43
// Design Name: 
// Module Name: OutputReader
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


module OutputReader(
input clk, rst,
input [31:0] result_i,
output reg [31:0] out_o
    );
    reg sclk;
    reg [31:0] result, data, out1, out2;
    reg [31:0] count;
    wire t;
    assign t = |(data^result_i);
    reg index;
    always @(negedge clk or negedge rst)begin
        if(~rst)begin
            result<=0;
        end else begin
            result<=result_i;
        end
    end
    always @(posedge clk or negedge rst)begin
        if(~rst)begin
            count <= 0;
            sclk<=1'b0;
        end else begin
            if(count<200000000)begin
                count<=count+1;
            end else begin
                count<=0;
                sclk<=~sclk;
            end
        end
    end
    always @(posedge t or negedge rst) begin
        if(~rst)begin
            index<=1'b0;
        end else begin
            index<=~index;
        end
    end
    always @(posedge clk or negedge rst) begin
        data<=result_i;
        if(~rst)begin
            out1<=0;
            out2<=0;
        end else begin
            case(index)
            1'b0:begin
                out1<=result_i;
                out2<=out2;
            end
            default:begin
                out1<=out1;
                out2<=result_i;
            end
            endcase
        end
    end
    always @(posedge sclk or negedge rst) begin
        if(~rst)begin
            out_o<=0;
        end else begin
            if(out_o==out1)begin
                out_o<=out2;
            end else begin
                out_o<=out1;
            end
        end
    end
    
endmodule
