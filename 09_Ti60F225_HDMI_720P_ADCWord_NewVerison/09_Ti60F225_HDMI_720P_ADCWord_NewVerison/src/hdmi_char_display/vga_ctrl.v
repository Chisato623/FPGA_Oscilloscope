`timescale  1ns/1ns
module  vga_ctrl
(
    input   wire            vga_clk     ,   //输入工作时钟,频率25MHz
    input   wire            sys_rst_n   ,   //输入复位信号,低电平有效
    input   wire    [23:0]  pix_data    ,   //输入像素点色彩信息
    input   wire    [23:0]  pix_data_number,

    //wave dispaly
    input                               bram_en                    ,
    input              [   7:0]         bram_data                  ,
    output             [  23:0]         wave_displaydata           ,


    output  wire    [11:0]   pix_x       ,   //输出VGA有效显示区域像素点X轴坐标
    output  wire    [11:0]   pix_y       ,   //输出VGA有效显示区域像素点Y轴坐标
    output  wire            hsync       ,   //输出行同步信号
    output  wire            vsync       ,   //输出场同步信号
    output  wire            rgb_valid      , //VGA有效显示区域
    output  wire    [23:0]  rgb,             //输出像素点色彩信息
    output  wire    [23:0]  rgb_number             //输出像素点色彩信息


);

//********************************************************************//
//****************** Parameter and Internal Signal *******************//
//********************************************************************//

//parameter define
parameter H_SYNC    =   'd40  ,   
          H_BACK    =   'd220  ,  
          H_VALID   =   'd1280 ,  
          H_LEFT    =   'd0   ,   
          H_RIGHT   =   'd0   ,   
          H_FRONT   =   'd110   , 
          H_TOTAL   =   'd1650 ;  
parameter V_SYNC    =   'd5   ,   
          V_BACK    =   'd25  ,   
          V_VALID   =   'd720 ,   
          V_TOP     =   'd0   ,   
          V_BOTTOM  =   'd0   ,   
          V_FRONT   =   'd5   ,   
          V_TOTAL   =   'd750 ;   

//wire  define

wire            pix_data_req    ;   //像素点色彩信息请求信号

//reg   define
reg     [11:0]   cnt_h           ;   //行同步信号计数器
reg     [11:0]   cnt_v           ;   //场同步信号计数器

//********************************************************************//
//***************************** Main Code ****************************//
//********************************************************************//

//cnt_h:行同步信号计数器
always@(posedge vga_clk or  negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        cnt_h   <=  12'd0   ;
    else    if(cnt_h == H_TOTAL - 1'd1)
        cnt_h   <=  12'd0   ;
    else
        cnt_h   <=  cnt_h + 1'd1   ;

//hsync:行同步信号
// assign  hsync = (cnt_h  <=  H_SYNC - 1'd1) ? 1'b1 : 1'b0  ;
assign  hsync = (cnt_h  <=  H_SYNC - 1'd1) ? 1'b0 : 1'b1  ;

//cnt_v:场同步信号计数器
always@(posedge vga_clk or  negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        cnt_v   <=  12'd0 ;
    else    if((cnt_v == V_TOTAL - 1'd1) &&  (cnt_h == H_TOTAL-1'd1))
        cnt_v   <=  12'd0 ;
    else    if(cnt_h == H_TOTAL - 1'd1)
        cnt_v   <=  cnt_v + 1'd1 ;
    else
        cnt_v   <=  cnt_v ;

//vsync:场同步信号
// assign  vsync = (cnt_v  <=  V_SYNC - 1'd1) ? 1'b1 : 1'b0  ;
assign  vsync = (cnt_v  <=  V_SYNC - 1'd1) ? 1'b0 : 1'b1  ;

//rgb_valid:VGA有效显示区域
assign  rgb_valid = (((cnt_h >= H_SYNC + H_BACK + H_LEFT)
                    && (cnt_h < H_SYNC + H_BACK + H_LEFT + H_VALID))
                    &&((cnt_v >= V_SYNC + V_BACK + V_TOP)
                    && (cnt_v < V_SYNC + V_BACK + V_TOP + V_VALID)))
                    ? 1'b1 : 1'b0;

//pix_data_req:像素点色彩信息请求信号,超前rgb_valid信号一个时钟周期
assign  pix_data_req = (((cnt_h >= H_SYNC + H_BACK + H_LEFT - 1'b1)
                    && (cnt_h < H_SYNC + H_BACK + H_LEFT + H_VALID - 1'b1))
                    &&((cnt_v >= V_SYNC + V_BACK + V_TOP)
                    && (cnt_v < V_SYNC + V_BACK + V_TOP + V_VALID)))
                    ? 1'b1 : 1'b0;

//pix_x,pix_y:VGA有效显示区域像素点坐标
assign  pix_x = (pix_data_req == 1'b1)
                ? (cnt_h - (H_SYNC + H_BACK + H_LEFT - 1'b1)) : 12'hfff;
assign  pix_y = (pix_data_req == 1'b1)
                ? (cnt_v - (V_SYNC + V_BACK + V_TOP)) : 12'hfff;

//rgb:输出像素点色彩信息
assign  rgb = (rgb_valid == 1'b1) ? pix_data : 24'b0 ;
assign  rgb_number = (rgb_valid == 1'b1) ? pix_data_number : 24'b0 ;
// =========================================================================================================================================
// wave display
// ========================================================================================================================================= 


reg [11:0] xpos_bram;
always @(posedge vga_clk ) begin
    xpos_bram <= pix_x;
end

wire  [8:0] ypos_bram;
assign ypos_bram = (cnt_v   >=232 + V_SYNC + V_BACK + V_TOP )? ((  cnt_v <= 487 + V_SYNC + V_BACK + V_TOP )?(487 + V_SYNC + V_BACK + V_TOP -cnt_v):(9'b1111_1111_1)):(9'b1111_1111_1);


reg [7:0] wave_temp [1279:0];
reg [11:0] arraydata_cnt;
always @(posedge vga_clk or negedge sys_rst_n) begin
    if (sys_rst_n == 0) begin
        arraydata_cnt <= 0;
    end else if (bram_en) begin
        wave_temp[arraydata_cnt] <= bram_data;
        if (arraydata_cnt == 1279)  
            arraydata_cnt <= 0;
        else
            arraydata_cnt <= arraydata_cnt + 1;
    end
end

parameter WAVE_COLOR = 24'hffffff ;
parameter BACKGROUND_COLOR = 24'h000000;
assign wave_displaydata = (rgb_valid && ypos_bram == wave_temp[xpos_bram]) ? WAVE_COLOR : BACKGROUND_COLOR;



endmodule
