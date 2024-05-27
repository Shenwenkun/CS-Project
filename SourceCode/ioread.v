`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/24 03:27:31
// Design Name: 
// Module Name: IoRead
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


module IoRead (
    input			rst_n,				// reset, active high 复位信号 (高电平有效)
    input			ior_i,				// from Controller, 1 means read from input device(从控制器来的I/O读)
    input			SwitchCtrl_i,			// means the switch is selected as input device (从memorio经过地址高端线获得的拨码开关模块片选)
    input	[15:0]	ioread_data_switch_i,	// the data from switch(从外设来的读数据，此处来自拨码开关)
    output reg	[15:0]	ioread_data_o		// the data to memorio (将外设来的数据送给memorio)
);
    
    reg [15:0] ioread_data;
    
    always @* begin
        if (rst_n)
            ioread_data = 16'h0;
        else if (ior_i == 1) begin
            if (SwitchCtrl_i == 1'b1)
                ioread_data_o = ioread_data_switch_i;
            else
				ioread_data_o = ioread_data;
        end
    end
	
endmodule
