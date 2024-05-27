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
    input			rst_n,				// reset, active high ��λ�ź� (�ߵ�ƽ��Ч)
    input			ior_i,				// from Controller, 1 means read from input device(�ӿ���������I/O��)
    input			SwitchCtrl_i,			// means the switch is selected as input device (��memorio������ַ�߶��߻�õĲ��뿪��ģ��Ƭѡ)
    input	[15:0]	ioread_data_switch_i,	// the data from switch(���������Ķ����ݣ��˴����Բ��뿪��)
    output reg	[15:0]	ioread_data_o		// the data to memorio (���������������͸�memorio)
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
