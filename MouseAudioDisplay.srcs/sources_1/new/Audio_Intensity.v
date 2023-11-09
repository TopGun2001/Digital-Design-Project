`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.03.2023 17:25:46
// Design Name: 
// Module Name: Audio_Intensity
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


module Audio_Intensity (input[11:0] mic_in, input clk_20khz,
                        output [7:0] cat, output [3:0] an, 
                        output [15:0] led, output [3:0] Intensity);
                        
    wire [15:0] LED1; 
    reg [15:0] LED2; 
    wire [7:0] CAT1; reg [7:0] CAT2; 
    wire [3:0] AN1;  reg [3:0] AN2;
    
    reg [4:0] intensity = 4'd0;
    reg [12:0] top = 12'd0;
    reg [31:0] count = 32'd0;
    
    always @ (posedge clk_20khz) begin
        
        count <= count + 1;
        top <= (mic_in > top) ? mic_in : top;
        
        if(count >= 2000) begin
            LED2 <= LED1;
            AN2 <= AN1;
            CAT2 <= CAT1;
            count <= 32'd0;
            top <= 12'd0;
        end
        
    end
    
    always @ (top) begin
    
        if(top <= 2296) intensity <= 0;
        else if(top > 2296 && top <= 2496)  intensity <= 1;
        else if(top > 2496 && top <= 2696)  intensity <= 2;
        else if(top > 2696 && top <= 2896) intensity <= 3;
        else if(top > 2896 && top <= 3096) intensity <= 4;
        else if(top > 3096 && top <= 3296) intensity <= 5;
        else if(top > 3296 && top <= 3496) intensity <= 6;
        else if(top > 3496 && top <= 3696) intensity <= 7;
        else if(top > 3696 && top <= 3896) intensity <= 8;
        else if(top > 3896 && top <= 4096) intensity <= 9;
          
    end

    
    display_intensity A (.intensity(intensity), .an(AN1), .cat(CAT1));
    display_intensity_led D (.intensity(intensity), .LED(LED1));
    
    assign led = LED2;
    assign an = AN2;
    assign cat = CAT2;
    assign Intensity = intensity;    
    
endmodule
