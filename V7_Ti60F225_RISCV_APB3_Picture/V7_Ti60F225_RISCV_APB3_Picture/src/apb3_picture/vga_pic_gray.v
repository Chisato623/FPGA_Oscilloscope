`timescale  1ns/1ns


module  vga_pic
(
    input   wire            vga_clk     ,   //输入工作时钟,频率25MHz
    input   wire            sys_clk     ,   //输入RAM写时钟,频率50MHz
    input   wire            sys_rst_n   ,   //输入复位信号,低电平有效
    input   wire    [7:0]   pi_data     ,   //输入RAM写数据
    input   wire            pi_flag     ,   //输入RAM写使能
    input   wire    [10:0]   pix_x       ,   //输入有效显示区域像素点X轴坐标
    input   wire    [10:0]   pix_y       ,   //输入有效显示区域像素点Y轴坐标

    output  wire    [23:0]   pix_data_out    //输出VGA显示图像数据
);

//********************************************************************//
//****************** Parameter and Internal Signal *******************//
//********************************************************************//
//parameter define
parameter   H_VALID =   11'd1280     ,   //行有效数据
            V_VALID =   11'd720     ;   //场有效数据

parameter   H_PIC   =   10'd100     ,   //图片长度
            W_PIC   =   10'd100     ;   //图片宽度

parameter   RED     =   24'hff0000,   //红色
            GREEN   =   24'h00ff00,   //绿色
            BLUE    =   24'h0000ff,   //蓝色
            BLACK   =   24'h000000,   //黑色
            WHITE   =   24'hffffff;   //白色

//wire  define
wire            rd_en       ;   //ROM读使能
wire    [23:0]   pic_data    ;   //自ROM读出的图片数据

//reg   define
reg     [13:0]  wr_addr     ;   //ram写地址
reg     [13:0]  rd_addr     ;   //ram读地址
reg             pic_valid   ;   //图片数据有效信号
reg     [23:0]   pix_data    ;   //背景色彩信息

// =========================================================================================================================================
// combination the input data 
// ========================================================================================================================================= 
reg                    [   3:0]         rgb_cnt                    ;
reg                                     wr_rgb_en                  ;
reg                    [  23:0]         wr_rgb_data                ;

parameter PIC_SIZE=   'd10000   ;   //图片像素个数
parameter ADDR_END = PIC_SIZE - 1;
parameter DISPLAY_CHANNEL = 0; //0:Red 1:Green 2:Blue

always@(posedge sys_clk or negedge sys_rst_n)
begin
    if(!sys_rst_n)
        begin
            rgb_cnt   <=  'd0 ;
        end

    else if(rgb_cnt == 2  &&  pi_flag == 1)
        begin
            rgb_cnt   <=  'd0 ;
        end
    else if(pi_flag)
        begin
            rgb_cnt   <=  rgb_cnt + 1 ;
        end
    else
        begin
            rgb_cnt   <=  rgb_cnt ;
        end
end

always@(posedge sys_clk or negedge sys_rst_n)
begin
    if(!sys_rst_n)
        begin
            wr_rgb_en   <=  'd0 ;
        end

    else if(rgb_cnt == DISPLAY_CHANNEL  &&  pi_flag == 1)
        begin
            wr_rgb_en   <=  1 ;
        end
    else
        begin
            wr_rgb_en   <=  0 ;
        end
end





//********************************************************************//
//***************************** Main Code ****************************//
//********************************************************************//
//wr_addr:ram写地址
always@(posedge sys_clk or  negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        wr_addr <=  14'd0;
    else    if((wr_addr == ADDR_END) && (wr_rgb_en == 1'b1))
        wr_addr <=  14'd0;
    else    if(wr_rgb_en == 1'b1)
        wr_addr <=  wr_addr + 1;

//rd_addr:ram读地址
always@(posedge vga_clk or  negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        rd_addr <=  14'd0;
    else    if(rd_addr == ADDR_END)
        rd_addr <=  14'd0;
    else    if(rd_en == 1'b1)
        rd_addr <=  rd_addr + 1;
    else
        rd_addr <=  rd_addr;

//rd_en:ROM读使能
assign  rd_en = (((pix_x >= (((H_VALID - H_PIC)/2) - 1'b1))
                && (pix_x < (((H_VALID - H_PIC)/2) + H_PIC - 1'b1))) 
                &&((pix_y >= ((V_VALID - W_PIC)/2))
                && ((pix_y < (((V_VALID - W_PIC)/2) + W_PIC)))));

//pic_valid:图片数据有效信号
always@(posedge vga_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        pic_valid   <=  1'b1;
    else
        pic_valid   <=  rd_en;


//pix_data_out:输出VGA显示图像数据
assign  pix_data_out = (pic_valid == 1'b1) ? {rd_data,rd_data,rd_data} : pix_data;

//根据当前像素点坐标指定当前像素点颜色数据，在屏幕上显示彩条
always@(posedge vga_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        pix_data    <=  8'd0;
    else    if((pix_x >= 0) && (pix_x < (H_VALID/10)*1))
        pix_data    <=  RED;
    else    if((pix_x >= (H_VALID/10)*1) && (pix_x < (H_VALID/10)*2))
        pix_data    <=  GREEN;
    else    if((pix_x >= (H_VALID/10)*2) && (pix_x < (H_VALID/10)*3))
        pix_data    <=  BLUE;
    else    if((pix_x >= (H_VALID/10)*3) && (pix_x < (H_VALID/10)*4))
        pix_data    <=  BLACK;
    else    if((pix_x >= (H_VALID/10)*4) && (pix_x < (H_VALID/10)*5))
        pix_data    <=  WHITE;
    else    if((pix_x >= (H_VALID/10)*5) && (pix_x < (H_VALID/10)*6))
        pix_data    <=  RED;
    else    if((pix_x >= (H_VALID/10)*6) && (pix_x < (H_VALID/10)*7))
        pix_data    <=  GREEN;
    else    if((pix_x >= (H_VALID/10)*7) && (pix_x < (H_VALID/10)*8))
        pix_data    <=  BLUE;
    else    if((pix_x >= (H_VALID/10)*8) && (pix_x < (H_VALID/10)*9))
        pix_data    <=  BLACK;
    else    if((pix_x >= (H_VALID/10)*9) && (pix_x < H_VALID))
        pix_data    <=  WHITE;
    else
        pix_data    <=  BLACK;

//********************************************************************//
//*************************** Instantiation **************************//
//********************************************************************//
//-------------ram_pic_inst-------------
// ram_pic ram_pic_inst
// (
//     .inclock    (sys_clk    ),    //输入RAM写时钟,50MHz,1bit
//     .wren       (pi_flag    ),    //输入RAM写使能,1bit
//     .wraddress  (wr_addr    ),    //输入RAM写地址,15bit
//     .data       (pi_data    ),    //输入写入RAM的图片数据,8bit
//     .outclock   (vga_clk    ),    //输入RAM读时钟,25MHz,1bit
//     .rdaddress  (rd_addr    ),    //输入RAM读地址,15bit

//     .q          (pic_data   )     //输出读取RAM的图片数据,8bit
// );
wire [7:0] rd_data ;
bram_test u_bram_test
(
    .we                                (wr_rgb_en                   ),
    .wdata_a                           (pi_data                   ),
    .waddr                             (wr_addr                   ),
    
    
    .re                                (rd_en                        ),
    .rdata_b                           (rd_data                  ),
    .raddr                             (rd_addr                   ),
   
    .reset                             (~sys_rst_n                ),
    .wclk                              (sys_clk                   ),
    .rclk                              (vga_clk                   ) 
);


endmodule
