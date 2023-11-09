`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.03.2023 15:40:39
// Design Name: 
// Module Name: AV
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


module volume_bar(input sw12,
                  input CLK,
                  input [15:0] LED,
                  input [6:0] x, input [5:0] y,
                  output reg [15:0] oled_data = 0
                  );
    
wire A, B, C, D ,E;
assign A = (x>2 && x<12);
assign B = (x>22 && x<32);
assign C = (x>42 && x<52);
assign D = (x>62 && x<72);
assign E = (x>82 && x<92);

wire y1, y2, y3, y4 , y5, y6, y7, y8, y9;
assign y1 = (y>58 && y<62);
assign y2 = (y>53 && y<57);
assign y3 = (y>48 && y<52);
assign y4 = (y>43 && y<47);
assign y5 = (y>38 && y<42);
assign y6 = (y>33 && y<37);
assign y7 = (y>28 && y<32);
assign y8 = (y>23 && y<27);
assign y9 = (y>18 && y<22);
    
    
wire [2:0] rcolor;    
wire sclk;
clock_divider m(CLK, 499999, sclk);
random_colors generate_rcolor (sclk, rcolor);
reg [15:0] color [0:10];

initial
begin
    color[0] = 16'hF819;
    color[1] = 16'h07F7;
    color[2] = 16'hFFA0;
    color[3] = 16'hE820;
    color[4] = 16'hB598;
    color[5] = 16'h2A69;
    color[6] = 16'hF800;
    color[7] = 16'hB2FC;
    color[8] = 16'hF819;
    color[9] = 16'h07F7;
    color[10] = 16'hFFA0;
end

    integer count;
   
always @ (posedge CLK) begin

    if(sw12==1) begin
            
        if (LED >= 16'h0001 && ((A && y1) 
                            ||  (B && y1)
                            ||  (C && y1)
                            ||  (D && y1)
                            ||  (E && y1))) begin
            oled_data <= color[rcolor+1]; //16'h07E8; 
        end
        
        else if (LED >= 16'h0003 && ((A && y2) 
                                 ||  (B && y2)
                                 ||  (C && y2)
                                 ||  (D && y2)
                                 ||  (E && y2))) begin
            oled_data <= color[rcolor+1]; //16'h07E8; 
        end
        
        else if (LED >= 16'h0007 && ((A && y3) 
                                 ||  (B && y3)
                                 ||  (C && y3)
                                 ||  (D && y3)
                                 ||  (E && y3))) begin
            oled_data <= color[rcolor+1]; //16'h07E8; 
        end
        
        else if (LED >= 16'h000F && ((A && y4) 
                                 ||  (B && y4)
                                 ||  (C && y4)
                                 ||  (D && y4)
                                 ||  (E && y4))) begin
            oled_data <= color[rcolor+2]; //16'hFD00; 
        end
        
        else if (LED >= 16'h001F && ((A && y5) 
                                 ||  (B && y5)
                                 ||  (C && y5)
                                 ||  (D && y5)
                                 ||  (E && y5))) begin
            oled_data <= color[rcolor+2]; //16'hFD00; 
        end
        
        else if (LED >= 16'h003F && ((A && y6) 
                                 ||  (B && y6)
                                 ||  (C && y6)
                                 ||  (D && y6)
                                 ||  (E && y6))) begin
            oled_data <= color[rcolor+2]; //16'hFD00; 
        end
            
        else if (LED >= 16'h007F && ((A && y7) 
                                 ||  (B && y7)
                                 ||  (C && y7)
                                 ||  (D && y7)
                                 ||  (E && y7)))begin
            oled_data <= color[rcolor+3]; //16'h021F;    
        end
                      
        else if (LED >= 16'h00FF && ((A && y8) 
                                 ||  (B && y8)
                                 ||  (C && y8)
                                 ||  (D && y8)
                                 ||  (E && y8))) begin
            oled_data <= color[rcolor+3]; //16'h021F; 
        end
            
        else if (LED >= 16'h01FF && ((A && y9) 
                                 ||  (B && y9)
                                 ||  (C && y9)
                                 ||  (D && y9)
                                 ||  (E && y9))) begin
            oled_data <= color[rcolor+3]; //16'h021F; 
        end
            
        else begin
            oled_data <= 0;
        end
        
    end
    
end
    
endmodule
