// -----------------------------------------------------------------------------
// Author : Xiao Bai FPGA
// File   : vga_driver.v
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps

module vga_driver(
	input					 vga_clk,
	input               	 reset,

    /*--------------vga驱动端口--------------------*/
    output          		 o_vga_hsync,     //行同步信号
    output          		 o_vga_vsync,     //场同步信号
    output          		 o_vga_de,        //数据使能
    output  [23:0]  		 o_vga_rgb888,    //RGB888颜色数据	

     /*--------------用户端口--------------------*/   
    output                   o_vga_frame_req,
    output                   o_vga_line_req, //行请求相比与数据提前一个clk
    input   [15:0]           i_vga_rgb565

    );

/*------------------------------------------*\
        1024x768@60hz,clk = 65m 
\*------------------------------------------*/
localparam  H_SYNC     =  11'd136;  //行同步
localparam  H_BACK     =  11'd160;  //行显示后沿
localparam  H_ACTIVE   =  11'd1024; //行有效数据
localparam  H_FRONT    =  11'd24;   //行显示前沿
localparam  H_TOTAL    =  11'd1344; //行扫描周期

localparam  V_SYNC     =  11'd6;    //场同步
localparam  V_BACK     =  11'd29;   //场显示后沿
localparam  V_ACTIVE   =  11'd768;  //场有效数据
localparam  V_FRONT    =  11'd3;    //场显示前沿
localparam  V_TOTAL    =  11'd806;  //场扫描周期

/*------------------------------------------*\
                复位信号/计数器定义
\*------------------------------------------*/
reg         reset_sync_d0;
reg         reset_sync_d1;
reg         reset_sync;

reg [15:0]  pixel_cnt; //列计数器，计数每一行的像素点
reg [15:0]  line_cnt; //行计数器，计数多少行

/*------------------------------------------*\
                   assign
\*------------------------------------------*/
assign o_vga_hsync     = pixel_cnt <= H_SYNC -1 ? 1'b1 : 0;
assign o_vga_vsync     = line_cnt  <= V_SYNC -1 ? 1'b1 : 0;
assign o_vga_de        = (pixel_cnt >= H_SYNC + H_BACK) & (pixel_cnt <= H_SYNC + H_BACK + H_ACTIVE-1) & (line_cnt >= V_SYNC + V_BACK) & (line_cnt <= V_SYNC + V_BACK + V_ACTIVE-1);

//rgb565转rgb888
assign o_vga_rgb888    = o_vga_de ? {i_vga_rgb565[15:11], 3'h0 , i_vga_rgb565[10:5] , 2'h0 , i_vga_rgb565[4:0] , 3'h0 } : 0;
assign o_vga_frame_req = ~o_vga_vsync;

//o_vga_line_req信号相比与o_vga_de提前一个clk拉高
assign o_vga_line_req  = (pixel_cnt >= H_SYNC + H_BACK - 1) & (pixel_cnt <= H_SYNC + H_BACK + H_ACTIVE - 2) & (line_cnt >= V_SYNC + V_BACK) & (line_cnt <= V_SYNC + V_BACK + V_ACTIVE-1);

/*------------------------------------------*\
                同步复位信号
\*------------------------------------------*/
always @(posedge vga_clk) begin
	reset_sync_d0 <= reset;
	reset_sync_d1 <= reset_sync_d0;
	reset_sync    <= reset_sync_d1;
end

/*------------------------------------------*\
                计数器设计
\*------------------------------------------*/
always @(posedge vga_clk) begin
    if (reset_sync) 
        pixel_cnt <= 0;
    else if (pixel_cnt == H_TOTAL-1) 
        pixel_cnt <= 0;
    else 
        pixel_cnt <= pixel_cnt + 1;
end

always @(posedge vga_clk) begin
    if (reset_sync) 
        line_cnt <= 0;
    else if (line_cnt == V_TOTAL-1 && pixel_cnt == H_TOTAL-1) 
        line_cnt <= 0;
    else if (pixel_cnt == H_TOTAL-1)
        line_cnt <= line_cnt + 1;
    else 
    	line_cnt <= line_cnt;
end

endmodule
