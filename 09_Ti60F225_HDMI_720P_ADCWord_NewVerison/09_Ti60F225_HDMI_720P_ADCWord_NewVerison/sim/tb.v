//-----------------------------------------------------------------//
//-----------------------------------------------------------------//
//-----------------------------------------------------------------//
//This is a per fect stimulation for dvp_data 
//The feature is
//              1.parameter to control the pixel of one horizon
//              2.parameter to control the horizonal number of one frame
//              3.every horizon have blanking
//              4.every veritonal have blanking
//              5.you can check out the final number of pixel/horizon/veritical 
//              6.the data is increasing from 0 to 255
//Version:
//              2024/7/26 :Birthday
//
//
//
//
//s
//-----------------------------------------------------------------//
//-----------------------------------------------------------------//
//-----------------------------------------------------------------//
`timescale  1ns/1ns
module  SZOVS_DVP_RANDOM_HREF_VSYNC_BLANKING();


reg              sys_clk         ;   //clk_in
reg              sys_rst_n       ;   //rst_n


//-----------------------------------------------------------------//
//-----------------------------------------------------------------//
//-----------------------------------------------------------------//
//initial
initial
  begin
    sys_clk     =   1'b1  ;
    sys_rst_n   <=  1'b0  ;
    #200
    sys_rst_n   <=  1'b1  ;
  end

always  #6.7 sys_clk = ~sys_clk;
//-----------------------------------------------------------------//
//-----------------------------------------------------------------//
//-----------------------------------------------------------------//
wire        lcd_hs;
wire        lcd_vs;
wire        lcd_de;
wire[7:0]   lcd_red;
wire[7:0]   lcd_green;
wire[7:0]   lcd_blue;
wire    [23:0]  pix_data;   //VGA像素点色彩信息
wire    [11:0]   pix_x   ;   //VGA有效显示区域X轴坐标
wire    [11:0]   pix_y   ;   //VGA有效显示区域Y轴坐标
//------------- vga_ctrl_inst -------------
vga_ctrl  vga_ctrl_inst
(
    .vga_clk    (sys_clk  ),
    .sys_rst_n  (sys_rst_n      ),
    .pix_data   (pix_data   ),

    .pix_x      (pix_x      ),
    .pix_y      (pix_y      ),
    .hsync      (lcd_hs      ),
    .vsync      (lcd_vs      ),
    .rgb_valid      (lcd_de),
    .rgb        ({lcd_red, lcd_green, lcd_blue}        ) 
);

//------------- vga_pic_inst -
vga_pic vga_pic_inst
(
    .vga_clk    (sys_clk    ),
    .sys_rst_n  (sys_rst_n        ),
    .pix_x      (pix_x      ),
    .pix_y      (pix_y      ),

    .pix_data   (pix_data   ) 

);





endmodule

