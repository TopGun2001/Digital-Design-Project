`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2023 17:29:00
// Design Name: 
// Module Name: AudioTasks
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


module AudioTasks(input sw12, input sw13, 
                  input clk, input clk6p25mhz, 
                  input [15:0] LED, 
                  input [6:0] x, input [5:0] y, input [12:0] xy, 
                  output [15:0] oled_data, 
                  input [3:0] intensity);
                          
wire [15:0] OD1, OD2, OD3;
                          
volume_bar instantiate_VolumeBar (sw12, clk6p25mhz, LED, x, y, OD1);
audio_emoji instantiate_AudioEmoji (sw13, clk6p25mhz, LED, x, y, OD2);
longitudinal_waveform instantiate_LongitudinalWaveform (clk, intensity, xy, OD3);

assign oled_data = (sw12 == 1) ? OD1 : (sw13 == 1) ? OD2 : OD3;             
              
endmodule
