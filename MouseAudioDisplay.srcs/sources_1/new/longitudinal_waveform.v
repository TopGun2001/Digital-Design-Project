`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22/03/2023 03:45:34 AM
// Design Name: 
// Module Name: longitudinal_waveform
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// Dependencies: 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module longitudinal_waveform(input CLK, input [3:0] intensity, input [12:0] xy, output reg [15:0] oled_data);

reg [3:0] wave [23:0];
reg [6:0] x = 0;
reg [5:0] y = 0;
reg [6:0] c = 31;
wire count_25Hz;
clock_divider clk1(CLK, 1999999, count_25Hz);
integer count;

    always @ xy begin
            x=xy%96; 
            y=63-xy/96;
            for(count = 0; count < 24; count = count + 1) begin
                if(x>=(count*4) && x<=(count*4 + 3)) begin
                    if (wave[count]>=0 && y==c) oled_data = 16'hf800;
                    else if (wave[count]>=1 && (y==c+2 || y==c-2)) oled_data = 16'h07ff;
                    else if (wave[count]>=2 && (y==c+4 || y==c-4)) oled_data = 16'h07ff;
                    else if (wave[count]>=3 && (y==c+6 || y==c-6)) oled_data = 16'h07ff;   
                    else if (wave[count]>=4 && (y==c+8 || y==c-8)) oled_data = 16'hffa0;
                    else if (wave[count]>=5 && (y==c+10 || y==c-10)) oled_data = 16'hffa0;
                    else if (wave[count]>=6 && (y==c+12 || y==c-12)) oled_data = 16'hffa0;
                    else if (wave[count]>=7 && (y==c+14 || y==c-14)) oled_data = 16'hf800;
                    else if (wave[count]>=8 && (y==c+16 || y==c-16)) oled_data = 16'hf800;
                    else if (wave[count]>=9 && (y==c+18 || y==c-18)) oled_data = 16'hf800;
                    else oled_data = 16'h0000;  
                end
            end
    end

    always @ (posedge count_25Hz) begin
            wave[23] <= intensity;wave[22] <= wave[23];wave[21] <= wave[22];wave[20] <= wave[21];wave[19] <= wave[20];wave[18] <= wave[19];
            wave[17] <= wave[18];wave[16] <= wave[17];wave[15] <= wave[16];wave[14] <= wave[15];wave[13] <= wave[14];wave[12] <= wave[13];
            wave[11] <= wave[12];wave[10] <= wave[11];wave[9] <= wave[10];wave[8] <= wave[9];wave[7] <= wave[8];wave[6] <= wave[7];
            wave[5] <= wave[6];wave[4] <= wave[5];wave[3] <= wave[4];wave[2] <= wave[3];wave[1] <= wave[2];wave[0] <= wave[1];
    end
    
endmodule