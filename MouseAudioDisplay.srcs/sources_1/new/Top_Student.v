`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//  
//  Project done by Suresh Abijith Ram
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (input [15:0] sw,
                    input CLK, output [15:0] led,
                    input btnl,btnu,btnr,btnd,btnc,
                    output [7:0] JA, //oled2
                    output [3:0] JXADC, //audio_output
                    input MISO, output clk_samp, sclk, //audio_input
                    inout PS2_CLK, inout PS2_DATA,
                    output [7:0] JC, //oled1
                    output [7:0] cat, output [3:0] an );
                    
                    
                    
//Slow Clocks
wire clk_20khz, clk_6p25MHz;
clock_divider createClock_20khz   (CLK, 2499, clk_20khz);
clock_divider createClock_6p25MHz (CLK,7,clk_6p25MHz);
////////////////////////////////////////////////////////////////////////////////////////////////////

reg [15:0] rLED = 16'h0000;
reg [7:0] rCAT = 8'hff;
reg [3:0] rAN = 4'hf;
                    
                    
wire [11:0] mic_in;
wire [15:0] LEDA;
wire [7:0] catA, catG1, catG2; reg [7:0] catGA; 
wire [3:0] anA, anG1, anG2; reg [3:0] anGA;
wire [15:0] OD1, OD2;
wire flag;
reg [2:0] pos = 0;
wire [7:0] catGT; 
wire [3:0] anGT;
wire [3:0] intensity;


wire [11:0] MOUSE_X_POS, MOUSE_Y_POS;
wire L_CLICK, M_CLICK, R_CLICK, MOUSE_NEW_EVENT;
wire frame_begin1, sending_pixels1, sample_pixel1; 
wire frame_begin2, sending_pixels2, sample_pixel2;
wire [12:0] xy1, xy2; 
wire [6:0] x1, x2; 
wire [5:0] y1, y2;
wire [15:0] LEDG;

wire [3:0] jxadc_2;
wire [7:0] catB;
wire [3:0] anB;  
wire [15:0] ledB;
wire [7:0] stdBOled;
wire [3:0] jxadc_1;
wire [7:0] jc;

wire [15:0] oledButtonGame, oledStudentA;


assign OD1 = (sw[9]==1) ? oledButtonGame : (sw[7]==1) ? oledStudentA : 16'h0000; 
                      
Audio_Input instantiate_Audio_Input (.CLK(CLK), .cs(clk_20khz), .MISO(MISO), .clk_samp(clk_samp), .sclk(sclk), .sample(mic_in));

Audio_Intensity instantiate_AudioVolumeIndicator (.mic_in(mic_in), .clk_20khz(clk_20khz), .cat(catA), .an(anA), .led(LEDA), .Intensity(intensity));

AudioTasks instantiate_AudioTasks(sw[12], sw[13], CLK, clk_6p25MHz, LEDA, x1, y1, xy1, oledStudentA, intensity);

button_reaction instantiate_ButtonReactionGame (btnl, btnu, btnr, btnd, btnc, x1, y1, CLK, clk_6p25MHz, oledButtonGame, sw, catGT, anGT);



always @ (posedge clk_20khz) begin
    pos <= (pos == 2) ? 0 : pos + 1;
end

always @ (posedge clk_20khz) begin 
    case(pos) 
        0: begin 
            anGA <= anG1; 
            catGA <= catG1; 
           end
        
        1: begin
            anGA <= anG2;
            catGA <= catG2;     
           end
            
        2: begin 
            anGA <= anA;
            catGA <= catA;
           end
    endcase
    
end
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////
//Mouse, OLED1, OLED2 instantiations & getting x,y coordinates//
////////////////////////////////////////////////////////////////
mouse_driver instantiate_MouseDriver (.PS2_CLK(PS2_CLK), .PS2_DATA(PS2_DATA),
                                      .CLOCK(CLK), .MOUSE_X_POS(MOUSE_X_POS), .MOUSE_Y_POS(MOUSE_Y_POS), 
                                      .LEFT_CLICK(L_CLICK), .RIGHT_CLICK(R_CLICK),.MIDDLE_CLICK(M_CLICK),
                                      .MOUSE_NEW_EVENT(MOUSE_NEW_EVENT));

assign JC = sw[14] ? stdBOled : jc;
Oled_Display JC_display1 (.clk(clk_6p25MHz), .reset(), .frame_begin(frame_begin1), .sending_pixels(sending_pixels1),
                          .sample_pixel(sample_pixel1), .pixel_index(xy1), .pixel_data(OD1), 
                          .cs(jc[0]), .sdin(jc[1]), .sclk(jc[3]), .d_cn(jc[4]), .resn(jc[5]), .vccen(jc[6]), .pmoden(jc[7]));

Oled_Display JXDAC_display2 (.clk(clk_6p25MHz), .reset(), .frame_begin(frame_begin2), .sending_pixels(sending_pixels2),
                             .sample_pixel(sample_pixel2), .pixel_index(xy2), .pixel_data(OD2), 
                             .cs(JA[0]), .sdin(JA[1]), .sclk(JA[3]), .d_cn(JA[4]), .resn(JA[5]), .vccen(JA[6]), .pmoden(JA[7]));

get_coordinates xyz1 (xy1, x1, y1);
get_coordinates xyz2 (xy2, x2, y2);
////////////////////////////////////////////////////////////////
/////////////////////End of instantiations//////////////////////
//////////////////////////////////////////////////////////////// 


                         
assign led = (sw[9]==1) ? rLED : (sw[8]==1) ? (LEDA | LEDG) : (sw[7]==1) ? LEDA : (sw[14]==1) ? ledB : rLED;
assign cat = (sw[9]==1) ? catGT : (sw[8]==1) ? catGA : (sw[7]==1) ? catA : (sw[14]==1) ? catB : rCAT ;
assign an = (sw[9]==1) ? anGT : (sw[8]==1) ? anGA : (sw[7]==1) ? anA : (sw[14]==1) ? anB : rAN;

endmodule



