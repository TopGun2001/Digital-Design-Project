`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.02.2023 10:47:02
// Design Name: 
// Module Name: mouse_driver
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


module mouse_driver(
    input PS2_CLK,
        input PS2_DATA,
        input CLOCK,
        output [11:0] MOUSE_X_POS,
        output [11:0] MOUSE_Y_POS,
        output LEFT_CLICK,
        output RIGHT_CLICK,
        output MIDDLE_CLICK,
        output MOUSE_NEW_EVENT
    );
    wire [3:0] MOUSE_Z_POS; //not needed, excluded
    
     MouseCtl MC1(
                 .clk(CLOCK),
                 .rst(1'b0),
                 .xpos(MOUSE_X_POS),
                 .ypos(MOUSE_Y_POS),
                 .zpos(MOUSE_Z_POS),
                 .left(LEFT_CLICK),
                 .middle(MIDDLE_CLICK),
                 .right(RIGHT_CLICK),
                 .new_event(MOUSE_NEW_EVENT),
                 .value(12'd0),
                 .setx(1'b0),
                 .sety(1'b0),
                 .setmax_x(1'b0),
                 .setmax_y(1'b0),
                 .ps2_clk(PS2_CLK),
                 .ps2_data(PS2_DATA)
             );
    
    
endmodule
