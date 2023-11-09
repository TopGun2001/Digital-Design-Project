`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.03.2023 17:41:49
// Design Name: 
// Module Name: button_reaction
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


module button_reaction(input btnl, btnu, btnr, btnd, btnc,
                       input [6:0] x, input [5:0] y,
                       input CLK, input clk6_25,
                       output reg [15:0] oled_data = 0,
                       input [15:0] sw,
                       output reg [7:0] cat = 8'b11111111,
                       output reg [4:0] an = 4'b1111
                       );
                       
                          
                       
wire clk0p05s, clk0p1s, clk0p2s, clk0p3s, clk0p4s;
clock_divider CLK0p1s (CLK, 9999999, clk0p1s);
clock_divider CLK0p2s (CLK, 19999999, clk0p2s);
clock_divider CLK0p3s (CLK, 29999999, clk0p3s);
clock_divider CLK0p4s (CLK, 39999999, clk0p4s);

wire gameClock = (sw[10]==1) ? clk0p3s : (sw[11]==1) ? clk0p2s : (sw[12]==1) ? clk0p1s : clk0p4s;

reg [4:0] index = 0;
reg [4:0] count = 0;
reg [3:0] c = 1;
reg [1:0] first = 0;

reg flag1=0, flag2=0, flag3=0, flag4=0, flag5=0;
reg lclick=0, uclick=0, rclick=0, dclick=0, cclick=0;

reg [4:0] score = 0;
reg [3:0] played = 0;

always @ (posedge gameClock) begin

    if(sw[9] == 1) begin
        if(sw[0] == 1) begin
        
            if(first == 0)
                first = 1;
        
            index = (index == 29) ? 0 : index + 1;
            count = count + 1;
                
            if(count == 3) begin
                c = 0;
            end
            
            else if(count == 7) begin
                c = 1;
                count <= 0;
                first = 2;
                played = (played == 10) ? played : played + 1;
            end
            
        end
        
        else begin
            first <= 0;
            index <= 0;
            count <= 0;
            c <= 1;
            played <= 0;
        end   
        
    end
          
end

always @ (posedge CLK) begin

    if(sw[9] == 1) begin
        an <= 4'b1110;
                        
            case(score)
                4'd0: cat <= 8'b11000000; // display 0
                4'd1: cat <= 8'b11001111; // display 1
                4'd2: cat <= 8'b10100100; // display 2
                4'd3: cat <= 8'b10110000; // display 3
                4'd4: cat <= 8'b10011001; // display 4
                4'd5: cat <= 8'b10010010; // display 5
                4'd6: cat <= 8'b10000010; // display 6
                4'd7: cat <= 8'b11111000; // display 7
                4'd8: cat <= 8'b10000000; // display 8
                4'd9: cat <= 8'b10010000; // display 9
            endcase
    end
    
end


reg [2:0] rcolor [0:29];

initial begin
    rcolor[0] = 3'd2; rcolor[1] = 3'd3; rcolor[2] = 3'd5; rcolor[3] = 3'd4; rcolor[4] = 3'd1;
    rcolor[5] = 3'd5; rcolor[6] = 3'd3; rcolor[7] = 3'd4; rcolor[8] = 3'd1; rcolor[9] = 3'd2;
    rcolor[10] = 3'd3; rcolor[11] = 3'd5; rcolor[12] = 3'd2; rcolor[13] = 3'd4; rcolor[14] = 3'd1;
    rcolor[15] = 3'd5; rcolor[16] = 3'd3; rcolor[17] = 3'd1; rcolor[18] = 3'd4; rcolor[19] = 3'd2;
    rcolor[20] = 3'd3; rcolor[21] = 3'd5; rcolor[22] = 3'd2; rcolor[23] = 3'd1; rcolor[24] = 3'd4;
    rcolor[25] = 3'd3; rcolor[26] = 3'd2; rcolor[27] = 3'd4; rcolor[28] = 3'd1; rcolor[29] = 3'd5;
end
                       
reg [15:0] color [0:5];
                       
initial begin
   color[0] = 16'hffff;
   color[1] = 16'hf800; // btnl, RED
   color[2] = 16'h301f; // btnu, BLUE
   color[3] = 16'h07e5; // btnr, GREEN
   color[4] = 16'hd01f; // btnd, PURPLE
   color[5] = 16'hffe0; // btnc, YELLOW 
end    


wire length = (x>5 && x<25); 

wire LEFT = (x>=30 && x<=31 && y>=3 && y<=10) || (y>=9 && y<=10 && x>=30 && x<=33) || 
            (x>=35 && x<=36 && y>=3 && y<=10) || (y>=3 && y<=4 && x>=35 && x<=39) || (y>=6 && y<=7 && x>=35 && x<=39) || (y>=9 && y<=10 && x>=35 && x<=39) ||
            (x>=41 && x<=42 && y>=3 && y<=10) || (y>=3 && y<=4 && x>=41 && x<=46) || (y>=6 && y<=7 && x>=41 && x<=46) ||
            (x>=48 && x<=55 && y>=3 && y<=4) || (x>=51 && x<=52 && y>=3 && y<=10);


wire UP = (x>=30 && x<=31 && y>=16 && y<=22) || (x>=30 && x<=36 && y>=21 && y<=22) || (x>=35 && x<=36 && y>=16 && y<=22) || (x>=38 && x<=44 && y==16) || (x>=38 && x<=44 && y>=19 && y<=20) || (x>=38 && x<=39 && y>=16 && y<=22) || (x>=43 && x<=44 && y>=16 && y<=20); 

wire RIGHT = (x>=30 && x<=31 && y>=28 && y<=34) || (x>=30 && x<=34 && y>=28 && y<=29) || (x>=30 && x<=34 && y>=31 && y<=32) || (x>=33 && x<=34 && y>=31 && y<=34) ||
             (x>=36 && x<=38 && y>=28 && y<=29) || (x>=36 && x<=38 && y>=33 && y<=34) || (x==37 && y>=28 && y<=34) ||
             (x>=40 && x<=45 && y>=28 && y<=29) || (x>=40 && x<=45 && y>=33 && y<=34) || (x>=40 && x<=41 && y>=28 && y<=34) || (x>=43 && x<=47 && y==31) || (x==47 && y>=31 && y<=34) ||
             (x>=49 && x<=50 && y>=28 && y<=34) || (x>=52 && x<=53 && y>=28 && y<=34) || (x>=49 && x<=53 && y>=30 && y<=32) || 
             (x>=55 && x<=60 && y>=28 && y<=29) || (x>=57 && x<=58 && y>=29 && y<=34);

wire DOWN = (x>=30 && x<=33 && y>=39 && y<=40) || (x>=30 && x<=31 && y>=39 && y<=45) || (x>=30 && x<=33 && y>=44 && y<=45) || (x==33 && y>=39 && y<=45) ||
            (x>=35 && x<=41 && y>=39 && y<=40) || (x>=35 && x<=41 && y>=44 && y<=45) || (x>=35 && x<=36 && y>=39 && y<=45) || (x>=40 && x<=41 && y>=39 && y<=45) ||
            (x>=43 && x<=44 && y>=39 && y<=45) || (x>=49 && x<=50 && y>=39 && y<=45) || (x>=46 && x<=47 && y>=41 && y<=45) || (x>=43 && x<=50 && y>=44 && y<=45) ||
            (x>=52 && x<=56 && y>=39 && y<=41) || (x>=52 && x<=53 && y>=39 && y<=45) || (x>=55 && x<=56 && y>=39 && y<=45);

wire CENTRE = (x>=30 && x<=35 && y>=50 && y<=52) || (x>=30 && x<=35 && y>=55 && y<=57) || (x>=30 && x<=31 && y>=50 && y<=57) ||
              (x>=37 && x<=41 && y>=50 && y<=51) || (x>=37 && x<=41 && y>=53 && y<=54) || (x>=37 && x<=41 && y>=56 && y<=57) || (x>=37 && x<=38 && y>=50 && y<=57) ||
              (x>=43 && x<=47 && y>=50 && y<=51) || (x>=43 && x<=44 && y>=50 && y<=57) || (x>=46 && x<=47 && y>=50 && y<=57) ||
              (x>=49 && x<=54 && y>=50 && y<=51) || (x>=51 && x<=52 && y>=50 && y<=57) ||
              (x>=56 && x<=60 && y>=50 && y<=51) || (x>=56 && x<=60 && y>=53 && y<=55) || (x>=56 && x<=57 && y>=50 && y<=57) || (x>=59 && x<=60 && y>=56 && y<=57) ||
              (x>=62 && x<=66 && y>=50 && y<=51) || (x>=62 && x<=66 && y>=53 && y<=54) || (x>=62 && x<=66 && y>=56 && y<=57) || (x>=62 && x<=63 && y>=50 && y<=57);
            

wire START = (x>=81 && x<=89 && y==9) || (x==81 && y>=9 && y<=15) || (x>=81 && x<=89 && y==15) || (x==89 && y>=15 && y<=20) || (x>=81 && x<=89 && y==20) ||
             (x>=81 && x<=89 && y==23) || (x==85 && y>=22 && y<=30) || 
             (x>=81 && x<=89 && y==32) || (x>=81 && x<=89 && y==35) || (y>=32 && y<=39 && x==81) || (y>=32 && y<=39 && x==89) ||
             (x>=81 && x<=89 && y==41) || (x>=81 && x<=89 && y==44) || (x>=81 && x<=89 && y==46) || (y>=41 && y<=48 && x==81) || (y>=41 && y<=44 && x==89) || (y>=46 && y<=48 && x==89) ||
             (x>=81 && x<=89 && y==50) || (y>=50 && y<=57 && x==85);
             
wire WIN = (x>=78 && x<=79 && y>=13 && y<=28) || (x>=84 && x<=86 && y>=13 && y<=28) || (x>=91 && x<=92 && y>=13 && y<=28) ||
           (x>=78 && x<=92 && y>=27 && y<=28) ||
           (x>=78 && x<=92 && y>=30 && y<=31) || (x>=78 && x<=92 && y>=42 && y<=43) || (x>=84 && x<=86 && y>=30 && y<=43) ||
           (x>=78 && x<=92 && y>=45 && y<=46) || (x>=78 && x<=79 && y>=45 && y<=58) || (x>=91 && x<=92 && y>=45 && y<=58);

wire LOSS = (x>=77 && x<=78 && y>=7 && y<=23) || (x>=77 && x<=91 && y>=22 && y<=23) ||
            (x>=77 && x<=91 && y>=25 && y<=26) || (x>=77 && x<=91 && y>=35 && y<=36) || (x>=77 && x<=78 && y>=25 && y<=36) ||(x>=90 && x<=91 && y>=25 && y<=36) ||
            (x>=77 && x<=91 && y>=39 && y<=40) || (x>=77 && x<=91 && y>=43 && y<=44) || (x>=77 && x<=91 && y>=47 && y<=48) || (x>=77 && x<=78 && y>=39 && y<=44) || (x>=90 && x<=91 && y>=43 && y<=48) ||
            (x>=77 && x<=91 && y>=50 && y<=51) || (x>=77 && x<=91 && y>=54 && y<=55) || (x>=77 && x<=91 && y>=58 && y<=59) || (x>=77 && x<=78 && y>=50 && y<=55) || (x>=90 && x<=91 && y>=54 && y<=59);

                
wire SPLIT = (x>=70 && x<=73 && y>=0 && y<=63);

wire BOX1 = (x>=80 && x<=90 && y>=7 && y<=12);
wire BOX2 = (x>=80 && x<=90 && y>=19 && y<=24);
wire BOX3 = (x>=80 && x<=90 && y>=31 && y<=36);
wire BOX4 = (x>=80 && x<=90 && y>=43 && y<=48);
wire BOX5 = (x>=80 && x<=90 && y>=55 && y<=60);


always @ (posedge CLK) begin
    
    if(sw[9] == 1) begin
    
            if(sw[0] == 0) begin
                flag1 = 0;
                flag2 = 0;
                flag3 = 0;
                flag4 = 0;
                flag5 = 0;
                score = 0;
            end
        
        if(x>0 && x<95 && y>0 && y<63)
            oled_data <= 16'h0000; //black
        else 
            oled_data <= 16'h07ff; //cyan
        
        if(SPLIT) oled_data <= 16'h07ff;    
            
        if(LEFT) oled_data <= color[1];    
        if(UP) oled_data <= color[2];
        if(RIGHT) oled_data <= color[3];
        if(DOWN) oled_data <= color[4];
        if(CENTRE) oled_data <= color[5];  
            
        if(length && y>3 && y<10) oled_data <= color[1];   
        if(length && y>15 && y<22) oled_data <= color[2];
        if(length && y>27 && y<34) oled_data <= color[3];
        if(length && y>39 && y<46) oled_data <= color[4];  
        if(length && y>50 && y<57) oled_data <= color[5];    
        
        if(played <= 9) begin
        
            if(c) begin
                
                lclick = 0; uclick = 0; rclick = 0; dclick = 0; cclick = 0;
                
                if(first == 0 || first == 1) begin
                    if(START) begin
                        oled_data <= 16'hF812;
                    end
                end
                    
                else begin 
                                
                    if(rcolor[index] == 1 && BOX1) begin
                        oled_data <= color[1];
                        flag1 <= 1;
                    end
                    
                    
                    else if(rcolor[index] == 2 && BOX2) begin
                        oled_data <= color[2];
                        flag2 <= 1;
                    end
                    
                    
                    else if(rcolor[index] == 3 && BOX3) begin
                        oled_data <= color[3];
                        flag3 <= 1;
                    end
                    
                    
                    else if(rcolor[index] == 4 && BOX4) begin
                        oled_data <= color[4];
                        flag4 <= 1;
                    end
                    
                    
                    else if(rcolor[index] == 5 && BOX5) begin
                        oled_data <= color[5];
                        flag5 <= 1;
                    end
                    
                end
                       
            end
            
            else if (!c) begin
            
                if(flag1 && btnl) begin
                    lclick <= 1;
                end
                
                if(flag2 && btnu) begin
                    uclick <= 1;
                end
                
                if(flag3 && btnr) begin
                    rclick <= 1;
                end
                
                if(flag4 && btnd) begin
                    dclick <= 1;
                end
                
                if(flag5 && btnc) begin
                    cclick <= 1;
                end
                    
                    
                    if(lclick && rclick && uclick) begin
                        flag1 <= 0; lclick <= 0;
                        flag3 <= 0; rclick <= 0;
                        flag2 <= 0; uclick <= 0;
                        score <= score + 1;
                    end
                    
                    
                    if(lclick && rclick && dclick) begin
                        flag1 <= 0; lclick <= 0;
                        flag3 <= 0; rclick <= 0;
                        flag4 <= 0; dclick <= 0;
                        score <= score + 1;
                    end
                    
                    
                    if(lclick && rclick && cclick) begin
                        flag1 <= 0; lclick <= 0;
                        flag3 <= 0; rclick <= 0;
                        flag5 <= 0; cclick <= 0;
                        score <= score + 1;
                    end
                    
                    
                    if(lclick && uclick && dclick) begin
                        score <= score + 1; 
                        flag1 <= 0; lclick <= 0;
                        flag2 <= 0; uclick <= 0;
                        flag4 <= 0; dclick <= 0;
                    end
                    
                    
                    if(lclick && uclick && cclick) begin
                        flag1 <= 0; lclick <= 0;
                        flag2 <= 0; uclick <= 0;
                        flag5 <= 0; cclick <= 0;
                        score <= score + 1;
                    end
                    
                      
                    if(lclick && dclick && cclick) begin
                        flag1 <= 0; lclick <= 0;
                        flag4 <= 0; dclick <= 0;
                        flag5 <= 0; cclick <= 0;
                        score <= score + 1;
                    end
                    
                    
                    if(rclick && uclick && dclick) begin
                        flag3 <= 0; rclick <= 0;
                        flag2 <= 0; uclick <= 0;
                        flag4 <= 0; dclick <= 0;
                        score <= score + 1;
                    end
                    
                    
                    if(rclick && uclick && cclick) begin
                        flag3 <= 0; rclick <= 0;
                        flag2 <= 0; uclick <= 0;
                        flag5 <= 0; cclick <= 0;
                        score <= score + 1;
                    end
                    
                    
                    if(rclick && dclick && cclick) begin
                        flag3 <= 0; rclick <= 0;
                        flag4 <= 0; dclick <= 0;
                        flag5 <= 0; cclick <= 0;
                        score <= score + 1;
                    end
                    
                    
                    if(uclick && dclick && cclick) begin
                        flag2 <= 0; uclick <= 0;
                        flag4 <= 0; dclick <= 0;
                        flag5 <= 0; cclick <= 0;
                        score <= score + 1;
                    end
         
            end
        end
        
        else if(played == 10) begin
            if(score>=6 && WIN)
                oled_data <= 16'hFBC0;
                
             else if(score<=5 && LOSS)
                oled_data <= 16'hF800;
        end
        
    end
    
end


  
endmodule
