`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.03.2023 14:01:17
// Design Name: 
// Module Name: audio_emoji
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


module audio_emoji(input sw13,
                   input CLK,
                   input [15:0] LED,
                   input [6:0] x, input [5:0] y,
                   output reg [15:0] oled_data = 0
                   );
    
reg [15:0] color [0:8];

initial
begin
    color[0] = 16'hff32; //volume = 1
    color[1] = 16'hff2c; //volume = 2
    color[2] = 16'hff20; //volume = 3
    
    color[3] = 16'h95ff; //volume = 4
    color[4] = 16'h65ff; //volume = 5
    color[5] = 16'h05ff; //volume = 6
     
    color[6] = 16'hfb0c; //volume = 7
    color[7] = 16'hf945; //volume = 8
    color[8] = 16'hf800; //volume = 9
end    
    
    
    
always @ (posedge CLK) begin

    if(sw13==1) begin

        if(x>0 && x<94 && y>1 && y<63)
            oled_data <= 16'hf7be;
        else 
            oled_data <= 16'hf800;
             
        if(LED >= 16'h0001 && LED <= 16'h0007) begin //normal emoji
        
            if(((x-24)*(x-24) + (y-33)*(y-33) <= 445) || ((x-70)*(x-70) + (y-33)*(y-33) <= 445) ) begin
                
                case(LED)
                    16'h0001: oled_data <= color[0];
                    16'h0003: oled_data <= color[1];
                    16'h0007: oled_data <= color[2];
                endcase
        
            end
                
            if(((x-16)*(x-16) + (y-22)*(y-22) <= 4) || ((x-32)*(x-32)+(y-22)*(y-22) <= 4)
               ||((x-62)*(x-62) + (y-22)*(y-22) <= 4) || ((x-78)*(x-78)+(y-22)*(y-22) <= 4)
               || (x>13 && x<35 && y==40) || (x>59 && x<81 && y==40)) 
                oled_data <= 16'h0;
        end
        
            
        else if(LED >= 16'h000F && LED <= 16'h003F) begin //smile emoji
        
            if(((x-24)*(x-24) + (y-33)*(y-33) <= 445) || ((x-70)*(x-70) + (y-33)*(y-33) <= 445)) begin
                
                case(LED)
                    16'h000F: oled_data <= color[3];
                    16'h001F: oled_data <= color[4];
                    16'h003F: oled_data <= color[5];
                endcase
                
            end
                    
            if(((x-16)*(x-16) + (y-22)*(y-22) <= 4) || ((x-32)*(x-32)+(y-22)*(y-22) <= 4)
                ||((x-62)*(x-62) + (y-22)*(y-22) <= 4) || ((x-78)*(x-78)+(y-22)*(y-22) <= 4)) 
                oled_data <= 16'h0;
                
            if((x-24)*(x-24) + (y-40)*(y-40) <= 100 && y>=40 || (x-70)*(x-70) + (y-40)*(y-40) <= 100 && y>=40
                ||(x>13 && x<35 && y==40) || (x>59 && x<81 && y==40))
                oled_data <= 16'h0000;    
        end    
        
        
        else if(LED >= 16'h007F && LED <= 16'h01FF) begin //crying emoji
        
            if(((x-24)*(x-24) + (y-33)*(y-33) <= 445) || ((x-70)*(x-70) + (y-33)*(y-33) <= 445)) begin
            
                case(LED)
                    16'h007F: oled_data <= color[6];
                    16'h00FF: oled_data <= color[7];
                    16'h01FF: oled_data <= color[8];
                endcase
                
            end
                    
            if(((x-16)*(x-16) + (y-22)*(y-22) <= 4) || ((x-32)*(x-32)+(y-22)*(y-22) <= 4)
               ||((x-62)*(x-62) + (y-22)*(y-22) <= 4) || ((x-78)*(x-78)+(y-22)*(y-22) <= 4)
               ||((x-24)*(x-24) + 190>=4*y && y<=50) && ((x-24)*(x-24) + 174<=4*y && y<=50) 
               ||((x-70)*(x-70) + 190>=4*y && y<=50) && ((x-70)*(x-70) + 174<=4*y && y<=50))
                oled_data <= 16'h0;       
                    
            if(x>=15 && x<=17 && y>=26 && y<=28 || x>=15 && x<=17 && y>=30 && y<=32 || x>=15 && x<=17 && y>=34 && y<=36 || x>=15 && x<=17 && y>=38 && y<=40
            || x>=31 && x<=33 && y>=26 && y<=28 || x>=31 && x<=33 && y>=30 && y<=32 || x>=31 && x<=33 && y>=34 && y<=36 || x>=31 && x<=33 && y>=38 && y<=40
            || x>=61 && x<=63 && y>=26 && y<=28 || x>=61 && x<=63 && y>=30 && y<=32 || x>=61 && x<=63 && y>=34 && y<=36 || x>=61 && x<=63 && y>=38 && y<=40
            || x>=77 && x<=79 && y>=26 && y<=28 || x>=77 && x<=79 && y>=30 && y<=32 || x>=77 && x<=79 && y>=34 && y<=36 || x>=77 && x<=79 && y>=38 && y<=40)
                oled_data <= 16'h00ff;           
         end
         
     end
        
end

endmodule
