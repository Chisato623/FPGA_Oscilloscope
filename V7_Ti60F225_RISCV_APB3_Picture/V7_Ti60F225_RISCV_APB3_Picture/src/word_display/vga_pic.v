`timescale  1ns/1ns
module  vga_pic
(
    input  wire                         vga_clk                    ,//输入工作时钟,频率25MHz
    input  wire                         sys_rst_n                  ,//输入复位信号,低电平有效
    input  wire        [  11:0]         pix_x                      ,//输入有效显示区域像素点X轴坐标
    input  wire        [  11:0]         pix_y                      ,//输入有效显示区域像素点Y轴坐标


    input                               data_en                    ,//align
    input              [   7:0]         data                       ,

    output reg         [  23:0]         pix_data                    //输出像素点色彩信息
);

//********************************************************************//
//****************** Parameter and Internal Signal *******************//
//********************************************************************//
//parameter define
parameter   CHAR_W  =   'd64 ,   //字符宽度
            CHAR_H  =   'd64  ;   //字符高度

parameter   CHAR_B_H=   (1280-CHAR_W)/2 ,   //字符开始X轴坐标
            CHAR_B_V=   (720-CHAR_H)/2 ;   //字符开始Y轴坐标

parameter   BLACK   =   24'h00_00_00,   //黑色
            WHITE   =   24'hFF_FF_FF,   //白色
            DIY_COLOR  =   24'hFF_FF_00,  //自定义颜色1
            DIY_COLOR2  =   24'h00_FF_FF;   //自定义颜色2

//wire  define
wire    [11:0]   char_x  ;   //字符显示X轴坐标
wire    [11:0]   char_y  ;   //字符显示Y轴坐标
// =========================================================================================================================================
// data combination assign
// ========================================================================================================================================= 
parameter ONE_LINE_BYTES = 8;
parameter ONE_WORD_LINES = 64;
reg     [63:0] char_one_word    [63:0]; 
reg [10:0] pixel_cnt;
reg [10:0] line_cnt;
//pixel cnt
always@(posedge vga_clk or negedge sys_rst_n)
begin
if(!sys_rst_n)
    begin
        pixel_cnt   <=  'd0 ;
    end
else if(pixel_cnt == ONE_LINE_BYTES - 1)
    begin
        pixel_cnt   <=  'd0 ;
    end
else if(data_en)
    begin
        pixel_cnt   <=  pixel_cnt + 1 ;
    end
else
    begin
        pixel_cnt   <=  pixel_cnt ;
    end
end
//line cnt
always@(posedge vga_clk or negedge sys_rst_n)
begin
if(!sys_rst_n)
    begin
        line_cnt   <=  'd0 ;
    end
else if((pixel_cnt == ONE_LINE_BYTES - 1)&&(line_cnt ==  ONE_WORD_LINES - 1))
    begin
        line_cnt   <=  0 ;
    end
else if(pixel_cnt == ONE_LINE_BYTES - 1)
    begin
        line_cnt   <=  line_cnt + 1 ;
    end
else
    begin
        line_cnt   <=  line_cnt ;
    end
end
//data combination assignment
always@(posedge vga_clk)
begin
    if (data_en) begin
        char_one_word[line_cnt][r_pixel_cnt:pixel_cnt] <=data;
    end
end

reg r_pixel_cnt;
always @(posedge vga_clk ) begin
    r_pixel_cnt <= pixel_cnt + 7;
end
// =========================================================================================================================================
// data display
// ========================================================================================================================================= 
//字符显示坐标
assign  char_x  =   (((pix_x >= CHAR_B_H) && (pix_x < (CHAR_B_H + CHAR_W)))
                    && ((pix_y >= CHAR_B_V) && (pix_y < (CHAR_B_V + CHAR_H))))
                    ? (pix_x - CHAR_B_H) : 12'hFFF;
assign  char_y  =   (((pix_x >= CHAR_B_H) && (pix_x < (CHAR_B_H + CHAR_W)))
                    && ((pix_y >= CHAR_B_V) && (pix_y < (CHAR_B_V + CHAR_H))))
                    ? (pix_y - CHAR_B_V) : 12'hFFF;

//pix_data:输出像素点色彩信息,根据当前像素点坐标指定当前像素点颜色数据
always@(posedge vga_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        pix_data    <= BLACK;
    else    if((((pix_x >= (CHAR_B_H - 1'b1))
                && (pix_x < (CHAR_B_H + CHAR_W -1'b1)))
                && ((pix_y >= CHAR_B_V) && (pix_y < (CHAR_B_V + CHAR_H))))
                && (char_one_word[char_y][63 - char_x] == 1'b1))
        pix_data    <=  DIY_COLOR;
    else
        pix_data    <=  BLACK;
endmodule

 







