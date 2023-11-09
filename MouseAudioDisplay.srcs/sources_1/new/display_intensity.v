`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.03.2023 17:39:44
// Design Name: 
// Module Name: display_intensity
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


module display_intensity(
    input [3:0] intensity,
    output reg [3:0] an=4'b1111,
    output reg [7:0] cat=8'b11111111
    );
    
    always @ (intensity) begin
        an <= 4'b1110;
        
        case(intensity)
            4'd0: cat = 8'b11000000; // display 0
            4'd1: cat = 8'b11001111; // display 1
            4'd2: cat = 8'b10100100; // display 2
            4'd3: cat = 8'b10110000; // display 3
            4'd4: cat = 8'b10011001; // display 4
            4'd5: cat = 8'b10010010; // display 5
            4'd6: cat = 8'b10000010; // display 6
            4'd7: cat = 8'b11111000; // display 7
            4'd8: cat = 8'b10000000; // display 8
            4'd9: cat = 8'b10010000; // display 9
        endcase
        
    end
    
endmodule
