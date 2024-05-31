`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/24 20:47:50
// Design Name: 
// Module Name: CPU_Top
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


module CPU_Top(
// To be modified
input fpga_rst,
input fpga_clk,

input start, //to start the normal mode
input rx, //with constrain PIN N5
output tx //with constrain PIN T4
    );
    // uart module
    // UART Programmer Pinouts
    wire cpuclk;
    Clock clock(.clk_in1(fpga_clk), .clk_out1(cpuclk));
    
    wire upg_clk_i, upg_clk_o;
    wire upg_wen_o; //Uart write out enable
    wire upg_done_o; //Uart rx data have done
    //data to which memory unit of program_rom/dmemory32
    wire [14:0] upg_addr_o;
    //data to program_rom or dmemory32
    wire [31:0] upg_data_o;
    
    wire spg_bufg;
    BUFG U1(.I(start), .O(spg_bufg)); // de-twitter
    // Generate UART Programmer reset signal
    reg upg_rst;
    always @ (posedge fpga_clk) begin
        if (spg_bufg) upg_rst <= 0;
        if (fpga_rst) upg_rst <= 1;
    end
    //used for other modules which don't relate to UART
    wire rst;
    assign rst = fpga_rst | !upg_rst;
    
    
    // with IFetch/datamemory
    wire upg_wen_i;
    wire [13:0] upg_addr_i;
    assign upg_wen_i = upg_wen_o & upg_addr_o[14];
    assign upg_addr_i[13:0] = upg_addr_o[13:0];
    
    uart_bmpg_0 upg(
    .upg_clk_i(upg_clk_i),
    .upg_rst_i(upg_rst),
    .upg_rx_i(rx),
    .upg_clk_o(upg_clk_o),
    .upg_wen_o(upg_wen_o),
    .upg_adr_o(upg_addr_o),
    .upg_dat_o(upg_data_o),
    .upg_done_o(upg_done_o),
    .upg_tx_o(tx)
    );

   CPU cpu(
   .cpuclk(cpuclk),
   .rst(rst),
   .start(start),
   .upg_rst_i(upg_rst),
   .upg_clk_i(upg_clk_o),
   .upg_wen_i(upg_wen_i),
   .upg_addr_i(upg_addr_i),
   .upg_data_i(upg_data_o),
   .upg_done_i(upg_done_o)
   );
    
endmodule
