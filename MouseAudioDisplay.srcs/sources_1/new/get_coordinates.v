`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2023 03:42:02 PM
// Design Name: 
// Module Name: break_xy
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


module get_coordinates(
    input [12:0] ind,
    output [6:0] x,
    output [5:0] y
    );
    
    assign x = ind % 96;
    assign y = ind / 96;
    
endmodule
