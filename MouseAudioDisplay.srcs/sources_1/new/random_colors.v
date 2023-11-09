`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2023 21:33:09
// Design Name: 
// Module Name: random_colors
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


module random_colors(input CLK, output reg [3:0] Q = 4'b0000);
    
    always @ (posedge CLK) begin
        
        Q[3] = Q[2];
        Q[2] = Q[1];
        Q[1] = Q[0];
        Q[0] = ~(Q[2] ^ Q[3]);
         
    end

endmodule
