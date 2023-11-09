`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.03.2023 17:43:29
// Design Name: 
// Module Name: display_intensity_led
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


module display_intensity_led(
    input [3:0] intensity, 
    output reg [15:0] LED
    );
    
    always @ (*) begin
        
        case(intensity)
            4'd0: LED = 16'b0000000000000000;
            4'd1: LED = 16'b0000000000000001;
            4'd2: LED = 16'b0000000000000011;
            4'd3: LED = 16'b0000000000000111;
            4'd4: LED = 16'b0000000000001111;
            4'd5: LED = 16'b0000000000011111;
            4'd6: LED = 16'b0000000000111111;
            4'd7: LED = 16'b0000000001111111;
            4'd8: LED = 16'b0000000011111111;
            4'd9: LED = 16'b0000000111111111; 
        endcase
        
    end
endmodule
