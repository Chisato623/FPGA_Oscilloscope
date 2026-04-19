`timescale  1ns/1ns
module  vga_number // 
(
    input   wire            vga_clk     ,   //输入工作时钟,频率25MHz
    input   wire            sys_rst_n   ,   //输入复位信号,低电平有效
    input   wire    [11:0]   pix_x       ,   //输入有效显示区域像素点X轴坐标
    input   wire    [11:0]   pix_y       ,   //输入有效显示区域像素点Y轴坐标

    input                               freq_freq_rd_en            ,
    input              [  19:0]         freq_rd_data               ,

    output  reg     [23:0]  pix_data        //输出像素点色彩信息
);
// =========================================================================================================================================
// data temp
// ========================================================================================================================================= 
reg                    [   3:0]         unit_temp                  ;
reg                    [   3:0]         ten_temp                   ;
reg                    [   3:0]         hundred_temp               ;
reg                    [   3:0]         thousand_temp              ;
reg                    [   3:0]         ten_thousand_temp          ;
reg                                     r_rd_en;

always@(posedge vga_clk or negedge sys_rst_n)
begin
    if(!sys_rst_n)
        begin
            unit_temp        <= 0;
            ten_temp         <= 0;
            hundred_temp     <= 0;
            thousand_temp    <= 0;
            ten_thousand_temp<= 0;
            r_rd_en<= 0;
        end

    else if (freq_freq_rd_en) begin
        unit_temp        <= freq_rd_data[3:0];
        ten_temp         <= freq_rd_data[7:4];
        hundred_temp     <= freq_rd_data[11:8];
        thousand_temp    <= freq_rd_data[15:12];
        ten_thousand_temp<= freq_rd_data[19:16];
        r_rd_en<= freq_freq_rd_en;
    end
    else      begin
        unit_temp        <=  unit_temp        ;
        ten_temp         <=  ten_temp         ;
        hundred_temp     <=  hundred_temp     ;
        thousand_temp    <=  thousand_temp    ;
        ten_thousand_temp<=  ten_thousand_temp;
        r_rd_en<=  0;
        end
end

// =========================================================================================================================================
// parameter
// ========================================================================================================================================= 
//parameter define
parameter   CHAR_W  =   'd24 ,   //字符宽度
            CHAR_H  =   'd48  ;   //字符高度
parameter   CHAR_UNIT_W = 'd72,
            CHAR_UNIT_H = 'd48;
parameter   CHAR_FREQ_W = 'd120,
            CHAR_FREQ_H = 'd48;

parameter   BASE_LINE =150 ;    
parameter   ORIGINAL_ADDR = 20;        
parameter   CHAR1_B_H=   BASE_LINE ,   //字符开始X轴坐标
            CHAR2_B_H=   BASE_LINE + 24 ,   //字符开始X轴坐标
            CHAR3_B_H=   BASE_LINE + 24*2 ,   //字符开始X轴坐标
            CHAR4_B_H=   BASE_LINE + 24*3 ,   //字符开始X轴坐标
            CHAR5_B_H=   BASE_LINE + 24*4 ,   //字符开始X轴坐标
            CHAR_UNIT_B_H=   BASE_LINE + 24*5 ,   //字符开始X轴坐标
            CHAR_B_V=   650 ;   //字符开始Y轴坐标

parameter   BLACK      =   24'h00_00_00,   //黑色
            WHITE      =   24'hFF_FF_FF,   //白色
            DIY_COLOR  =   24'h10F3F2,  //自定义颜色1
            DIY_COLOR2 =   24'h00_FF_FF;   //自定义颜色2

//wire  define
wire    [11:0]   char1_x  ;   //字符显示X轴坐标
wire    [11:0]   char1_y  ;   //字符显示Y轴坐标
wire    [11:0]   char2_x  ;   //字符显示X轴坐标
wire    [11:0]   char2_y  ;   //字符显示Y轴坐标
wire    [11:0]   char3_x  ;   //字符显示X轴坐标
wire    [11:0]   char3_y  ;   //字符显示Y轴坐标
wire    [11:0]   char4_x  ;   //字符显示X轴坐标
wire    [11:0]   char4_y  ;   //字符显示Y轴坐标
wire    [11:0]   char5_x  ;   //字符显示X轴坐标
wire    [11:0]   char5_y  ;   //字符显示Y轴坐标
wire    [11:0]   char_unit_x  ;   //字符显示X轴坐标
wire    [11:0]   char_unit_y  ;   //字符显示Y轴坐标
wire    [11:0]   char_freq_x  ;   //字符显示X轴坐标
wire    [11:0]   char_freq_y  ;   //字符显示Y轴坐标


//reg   define
reg     [23:0] number0    [47:0]  ;  
reg     [23:0] number1    [47:0]  ;  
reg     [23:0] number2    [47:0]  ;  
reg     [23:0] number3    [47:0]  ;  
reg     [23:0] number4    [47:0]  ;  
reg     [23:0] number5    [47:0]  ;  
reg     [23:0] number6    [47:0]  ;  
reg     [23:0] number7    [47:0]  ;  
reg     [23:0] number8    [47:0]  ;  
reg     [23:0] number9    [47:0]  ;  
reg     [71:0] unit_khz    [47:0]  ;  
reg     [119:0] unit_freq    [47:0]  ;  


// =========================================================================================================================================
// main code
// ========================================================================================================================================= 

//char1
assign  char1_x  =   (((pix_x >= CHAR1_B_H) && (pix_x < (CHAR1_B_H + CHAR_W)))
                    && ((pix_y >= CHAR_B_V) && (pix_y < (CHAR_B_V + CHAR_H))))
                    ? (pix_x - CHAR1_B_H) : 12'hFFF;
assign  char1_y  =   (((pix_x >= CHAR1_B_H) && (pix_x < (CHAR1_B_H + CHAR_W)))
                    && ((pix_y >= CHAR_B_V) && (pix_y < (CHAR_B_V + CHAR_H))))
                    ? (pix_y - CHAR_B_V) : 12'hFFF;
//char2
assign  char2_x  =   (((pix_x >= CHAR2_B_H) && (pix_x < (CHAR2_B_H + CHAR_W)))
                    && ((pix_y >= CHAR_B_V) && (pix_y < (CHAR_B_V + CHAR_H))))
                    ? (pix_x - CHAR2_B_H) : 12'hFFF;
assign  char2_y  =   (((pix_x >= CHAR2_B_H) && (pix_x < (CHAR2_B_H + CHAR_W)))
                    && ((pix_y >= CHAR_B_V) && (pix_y < (CHAR_B_V + CHAR_H))))
                    ? (pix_y - CHAR_B_V) : 12'hFFF;
//char3
assign  char3_x  =   (((pix_x >= CHAR3_B_H) && (pix_x < (CHAR3_B_H + CHAR_W)))
                    && ((pix_y >= CHAR_B_V) && (pix_y < (CHAR_B_V + CHAR_H))))
                    ? (pix_x - CHAR3_B_H) : 12'hFFF;
assign  char3_y  =   (((pix_x >= CHAR3_B_H) && (pix_x < (CHAR3_B_H + CHAR_W)))
                    && ((pix_y >= CHAR_B_V) && (pix_y < (CHAR_B_V + CHAR_H))))
                    ? (pix_y - CHAR_B_V) : 12'hFFF;
//char4
assign  char4_x  =   (((pix_x >= CHAR4_B_H) && (pix_x < (CHAR4_B_H + CHAR_W)))
                    && ((pix_y >= CHAR_B_V) && (pix_y < (CHAR_B_V + CHAR_H))))
                    ? (pix_x - CHAR4_B_H) : 12'hFFF;
assign  char4_y  =   (((pix_x >= CHAR4_B_H) && (pix_x < (CHAR4_B_H + CHAR_W)))
                    && ((pix_y >= CHAR_B_V) && (pix_y < (CHAR_B_V + CHAR_H))))
                    ? (pix_y - CHAR_B_V) : 12'hFFF;
//char5
assign  char5_x  =   (((pix_x >= CHAR5_B_H) && (pix_x < (CHAR5_B_H + CHAR_W)))
                    && ((pix_y >= CHAR_B_V) && (pix_y < (CHAR_B_V + CHAR_H))))
                    ? (pix_x - CHAR5_B_H) : 12'hFFF;
assign  char5_y  =   (((pix_x >= CHAR5_B_H) && (pix_x < (CHAR5_B_H + CHAR_W)))
                    && ((pix_y >= CHAR_B_V) && (pix_y < (CHAR_B_V + CHAR_H))))
                    ? (pix_y - CHAR_B_V) : 12'hFFF;
//char unit
assign  char_unit_x  =   (((pix_x >= CHAR_UNIT_B_H) && (pix_x < (CHAR_UNIT_B_H + CHAR_UNIT_W)))
                    && ((pix_y >= CHAR_B_V) && (pix_y < (CHAR_B_V + CHAR_H))))
                    ? (pix_x - CHAR_UNIT_B_H) : 12'hFFF;
assign  char_unit_y  =   (((pix_x >= CHAR_UNIT_B_H) && (pix_x < (CHAR_UNIT_B_H + CHAR_UNIT_W)))
                    && ((pix_y >= CHAR_B_V) && (pix_y < (CHAR_B_V + CHAR_H))))
                    ? (pix_y - CHAR_B_V) : 12'hFFF;
//char freq
assign  char_freq_x  =   (((pix_x >= ORIGINAL_ADDR) && (pix_x < (ORIGINAL_ADDR + CHAR_FREQ_W)))
                    && ((pix_y >= CHAR_B_V) && (pix_y < (CHAR_B_V + CHAR_H))))
                    ? (pix_x - ORIGINAL_ADDR) : 12'hFFF;
assign  char_freq_y  =   (((pix_x >= ORIGINAL_ADDR) && (pix_x < (ORIGINAL_ADDR + CHAR_FREQ_W)))
                    && ((pix_y >= CHAR_B_V) && (pix_y < (CHAR_B_V + CHAR_H))))
                    ? (pix_y - CHAR_B_V) : 12'hFFF;


 reg     [23:0] word0    [47:0];
 reg     [23:0] word1    [47:0];
 reg     [23:0] word2    [47:0];
 reg     [23:0] word3    [47:0];
 reg     [23:0] word4    [47:0];

//pix_data:输出像素点色彩信息,根据当前像素点坐标指定当前像素点颜色数据
always@(posedge vga_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        pix_data    <= BLACK;
    else    if((((pix_x >= (CHAR1_B_H - 1'b1))
                && (pix_x < (CHAR1_B_H + CHAR_W -1'b1)))
                && ((pix_y >= CHAR_B_V) && (pix_y < (CHAR_B_V + CHAR_H))))
                && (word0[char1_y][24 - char1_x] == 1'b1))
        pix_data    <=  WHITE;
    else    if((((pix_x >= (CHAR2_B_H - 1'b1))
                && (pix_x < (CHAR2_B_H + CHAR_W -1'b1)))
                && ((pix_y >= CHAR_B_V) && (pix_y < (CHAR_B_V + CHAR_H))))
                && (word1[char2_y][24 - char2_x] == 1'b1))
        pix_data    <=  WHITE;
    else    if((((pix_x >= (CHAR3_B_H - 1'b1))
                && (pix_x < (CHAR3_B_H + CHAR_W -1'b1)))
                && ((pix_y >= CHAR_B_V) && (pix_y < (CHAR_B_V + CHAR_H))))
                // && (number2[char3_y][24 - char3_x] == 1'b1))
                && (word2[char3_y][24 - char3_x] == 1'b1))
        pix_data    <=  WHITE;
    else    if((((pix_x >= (CHAR4_B_H - 1'b1))
                && (pix_x < (CHAR4_B_H + CHAR_W -1'b1)))
                && ((pix_y >= CHAR_B_V) && (pix_y < (CHAR_B_V + CHAR_H))))
                && (word3[char4_y][24 - char4_x] == 1'b1))
        pix_data    <=  WHITE;
    else    if((((pix_x >= (CHAR5_B_H - 1'b1))
                && (pix_x < (CHAR5_B_H + CHAR_W -1'b1)))
                && ((pix_y >= CHAR_B_V) && (pix_y < (CHAR_B_V + CHAR_H))))
                && (word4[char5_y][24 - char5_x] == 1'b1))
        pix_data    <=  WHITE;
    else    if((((pix_x >= (CHAR_UNIT_B_H - 1'b1))
                && (pix_x < (CHAR_UNIT_B_H + CHAR_UNIT_W -1'b1)))
                && ((pix_y >= CHAR_B_V) && (pix_y < (CHAR_B_V + CHAR_H))))
                && (unit_khz[char_unit_y][72 - char_unit_x] == 1'b1))
        pix_data    <=  WHITE;
    else    if((((pix_x >= (ORIGINAL_ADDR - 1'b1))
                && (pix_x < (ORIGINAL_ADDR + CHAR_FREQ_W -1'b1)))
                && ((pix_y >= CHAR_B_V) && (pix_y < (CHAR_B_V + CHAR_H))))
                && (unit_freq[char_freq_y][120 - char_freq_x] == 1'b1))
        pix_data    <=  WHITE;
    else
        pix_data    <=  BLACK;
// //pix_data:输出像素点色彩信息,根据当前像素点坐标指定当前像素点颜色数据
// always@(posedge vga_clk or negedge sys_rst_n)
//     if(sys_rst_n == 1'b0)
//         pix_data    <= BLACK;
//     else    if((((pix_x >= (CHAR1_B_H - 1'b1))
//                 && (pix_x < (CHAR1_B_H + CHAR_W -1'b1)))
//                 && ((pix_y >= CHAR_B_V) && (pix_y < (CHAR_B_V + CHAR_H))))
//                 && (number0[char1_y][24 - char1_x] == 1'b1))
//         pix_data    <=  DIY_COLOR;
//     else    if((((pix_x >= (CHAR2_B_H - 1'b1))
//                 && (pix_x < (CHAR2_B_H + CHAR_W -1'b1)))
//                 && ((pix_y >= CHAR_B_V) && (pix_y < (CHAR_B_V + CHAR_H))))
//                 && (number1[char2_y][24 - char2_x] == 1'b1))
//         pix_data    <=  DIY_COLOR;
//     else    if((((pix_x >= (CHAR3_B_H - 1'b1))
//                 && (pix_x < (CHAR3_B_H + CHAR_W -1'b1)))
//                 && ((pix_y >= CHAR_B_V) && (pix_y < (CHAR_B_V + CHAR_H))))
//                 // && (number2[char3_y][24 - char3_x] == 1'b1))
//                 && (number4[char3_y][24 - char3_x] == 1'b1))
//         pix_data    <=  DIY_COLOR;
//     else    if((((pix_x >= (CHAR4_B_H - 1'b1))
//                 && (pix_x < (CHAR4_B_H + CHAR_W -1'b1)))
//                 && ((pix_y >= CHAR_B_V) && (pix_y < (CHAR_B_V + CHAR_H))))
//                 && (number3[char4_y][24 - char4_x] == 1'b1))
//         pix_data    <=  DIY_COLOR;
//     else    if((((pix_x >= (CHAR5_B_H - 1'b1))
//                 && (pix_x < (CHAR5_B_H + CHAR_W -1'b1)))
//                 && ((pix_y >= CHAR_B_V) && (pix_y < (CHAR_B_V + CHAR_H))))
//                 && (number4[char5_y][24 - char5_x] == 1'b1))
//         pix_data    <=  DIY_COLOR;
//     else
//         pix_data    <=  BLACK;
// =========================================================================================================================================
// unit char
// ========================================================================================================================================= 
        always@(posedge vga_clk)
        begin
            unit_freq[0]     <=  120'h000000000000000000000000000000;
            unit_freq[1]     <=  120'h000000000000000000000000000000;
            unit_freq[2]     <=  120'h000000000000000000000000000000;
            unit_freq[3]     <=  120'h000000000000000000000000000000;
            unit_freq[4]     <=  120'h000000000000000000000000000000;
            unit_freq[5]     <=  120'h000000000000000000000000000000;
            unit_freq[6]     <=  120'hFFFF80000000000000000000000000;
            unit_freq[7]     <=  120'h3C0F80000000000000000000000000;
            unit_freq[8]     <=  120'h3C0780000000000000000000000000;
            unit_freq[9]     <=  120'h3C0180000000000000000000000000;
            unit_freq[10]    <=  120'h3C01C0000000000000000000000000;
            unit_freq[11]    <=  120'h3C00C0000000000000000000000000;
            unit_freq[12]    <=  120'h3C0000000000000000000000000000;
            unit_freq[13]    <=  120'h3C0C00000000000000000000000000;
            unit_freq[14]    <=  120'h3C0C0000000000000000000000C000;
            unit_freq[15]    <=  120'h3C0C00061E0001F00003E20001E000;
            unit_freq[16]    <=  120'h3C1C007E2300060C00061E0001E000;
            unit_freq[17]    <=  120'h3FFC0006C3000C06000C0E0000C000;
            unit_freq[18]    <=  120'h3C1C00068300180600180600000000;
            unit_freq[19]    <=  120'h3C0C00070000100300180600000000;
            unit_freq[20]    <=  120'h3C0C00060000300300300600000000;
            unit_freq[21]    <=  120'h3C0C00060000300300300600000000;
            unit_freq[22]    <=  120'h3C00000600003FFF00300600000000;
            unit_freq[23]    <=  120'h3C0000060000300000300600000000;
            unit_freq[24]    <=  120'h3C0000060000300000300600000000;
            unit_freq[25]    <=  120'h3C0000060000300000300600000000;
            unit_freq[26]    <=  120'h3C0000060000100100300600000000;
            unit_freq[27]    <=  120'h3C000006000018010018060000C000;
            unit_freq[28]    <=  120'h3C00000600000C0200180E0001E000;
            unit_freq[29]    <=  120'h3C0000060000060C000C160001E000;
            unit_freq[30]    <=  120'hFF00007FE00001F80003E60000C000;
            unit_freq[31]    <=  120'h000000000000000000000600000000;
            unit_freq[32]    <=  120'h000000000000000000000600000000;
            unit_freq[33]    <=  120'h000000000000000000000600000000;
            unit_freq[34]    <=  120'h000000000000000000000600000000;
            unit_freq[35]    <=  120'h000000000000000000001F80000000;
            unit_freq[36]    <=  120'h000000000000000000000000000000;
            unit_freq[37]    <=  120'h000000000000000000000000000000;
            unit_freq[38]    <=  120'h000000000000000000000000000000;
            unit_freq[39]    <=  120'h000000000000000000000000000000;
            unit_freq[40]    <=  120'h000000000000000000000000000000;
            unit_freq[41]    <=  120'h000000000000000000000000000000;
            unit_freq[42]    <=  120'h000000000000000000000000000000;
            unit_freq[43]    <=  120'h000000000000000000000000000000;
            unit_freq[44]    <=  120'h000000000000000000000000000000;
            unit_freq[45]    <=  120'h000000000000000000000000000000;
            unit_freq[46]    <=  120'h000000000000000000000000000000;
            unit_freq[47]    <=  120'h000000000000000000000000000000;
        end

// =========================================================================================================================================
// unit char
// ========================================================================================================================================= 
        always@(posedge vga_clk)
        begin
            unit_khz[0]     <=  72'h000000000000000000;
            unit_khz[1]     <=  72'h000000000000000000;
            unit_khz[2]     <=  72'h000000000000000000;
            unit_khz[3]     <=  72'h000000000000000000;
            unit_khz[4]     <=  72'h000000000000000000;
            unit_khz[5]     <=  72'h1C0000000000000000;
            unit_khz[6]     <=  72'hFC00007E1F80000000;
            unit_khz[7]     <=  72'h7C0000180600000000;
            unit_khz[8]     <=  72'h3C0000180600000000;
            unit_khz[9]     <=  72'h3C0000180600000000;
            unit_khz[10]    <=  72'h3C0000180600000000;
            unit_khz[11]    <=  72'h3C0000180600000000;
            unit_khz[12]    <=  72'h3C0000180600000000;
            unit_khz[13]    <=  72'h3C0000180600000000;
            unit_khz[14]    <=  72'h3C0000180600000000;
            unit_khz[15]    <=  72'h3C7F801806001FFC00;
            unit_khz[16]    <=  72'h3C1E00180600381C00;
            unit_khz[17]    <=  72'h3C38001FFE00303800;
            unit_khz[18]    <=  72'h3C7000180600203000;
            unit_khz[19]    <=  72'h3CE000180600207000;
            unit_khz[20]    <=  72'h3DC00018060000E000;
            unit_khz[21]    <=  72'h3FE00018060000C000;
            unit_khz[22]    <=  72'h3FE00018060001C000;
            unit_khz[23]    <=  72'h3FF000180600038000;
            unit_khz[24]    <=  72'h3E7800180600030000;
            unit_khz[25]    <=  72'h3C7800180600060200;
            unit_khz[26]    <=  72'h3C3C001806000E0200;
            unit_khz[27]    <=  72'h3C1E001806000C0600;
            unit_khz[28]    <=  72'h3C1E00180600180400;
            unit_khz[29]    <=  72'h3C0F00180600380C00;
            unit_khz[30]    <=  72'h7F3FC07E1F803FFC00;
            unit_khz[31]    <=  72'h000000000000000000;
            unit_khz[32]    <=  72'h000000000000000000;
            unit_khz[33]    <=  72'h000000000000000000;
            unit_khz[34]    <=  72'h000000000000000000;
            unit_khz[35]    <=  72'h000000000000000000;
            unit_khz[36]    <=  72'h000000000000000000;
            unit_khz[37]    <=  72'h000000000000000000;
            unit_khz[38]    <=  72'h000000000000000000;
            unit_khz[39]    <=  72'h000000000000000000;
            unit_khz[40]    <=  72'h000000000000000000;
            unit_khz[41]    <=  72'h000000000000000000;
            unit_khz[42]    <=  72'h000000000000000000;
            unit_khz[43]    <=  72'h000000000000000000;
            unit_khz[44]    <=  72'h000000000000000000;
            unit_khz[45]    <=  72'h000000000000000000;
            unit_khz[46]    <=  72'h000000000000000000;
            unit_khz[47]    <=  72'h000000000000000000;
        end

// =========================================================================================================================================
// number char
// ========================================================================================================================================= 
    //number1
        always@(posedge vga_clk)
        begin
            number0[0]     <=  24'h000000;
            number0[1]     <=  24'h000000;
            number0[2]     <=  24'h000000;
            number0[3]     <=  24'h000000;
            number0[4]     <=  24'h000000;
            number0[5]     <=  24'h000000;
            number0[6]     <=  24'h03F000;
            number0[7]     <=  24'h0FBC00;
            number0[8]     <=  24'h0E1C00;
            number0[9]     <=  24'h1E1E00;
            number0[10]    <=  24'h3C0F00;
            number0[11]    <=  24'h3C0F00;
            number0[12]    <=  24'h3C0F00;
            number0[13]    <=  24'h780F00;
            number0[14]    <=  24'h780780;
            number0[15]    <=  24'h780780;
            number0[16]    <=  24'h780780;
            number0[17]    <=  24'h780780;
            number0[18]    <=  24'h780780;
            number0[19]    <=  24'h780780;
            number0[20]    <=  24'h780780;
            number0[21]    <=  24'h780780;
            number0[22]    <=  24'h780780;
            number0[23]    <=  24'h780F00;
            number0[24]    <=  24'h3C0F00;
            number0[25]    <=  24'h3C0F00;
            number0[26]    <=  24'h3C0F00;
            number0[27]    <=  24'h1E1E00;
            number0[28]    <=  24'h0E1C00;
            number0[29]    <=  24'h0FF800;
            number0[30]    <=  24'h03F000;
            number0[31]    <=  24'h000000;
            number0[32]    <=  24'h000000;
            number0[33]    <=  24'h000000;
            number0[34]    <=  24'h000000;
            number0[35]    <=  24'h000000;
            number0[36]    <=  24'h000000;
            number0[37]    <=  24'h000000;
            number0[38]    <=  24'h000000;
            number0[39]    <=  24'h000000;
            number0[40]    <=  24'h000000;
            number0[41]    <=  24'h000000;
            number0[42]    <=  24'h000000;
            number0[43]    <=  24'h000000;
            number0[44]    <=  24'h000000;
            number0[45]    <=  24'h000000;
            number0[46]    <=  24'h000000;
            number0[47]    <=  24'h000000;
        end
        //number1
        always@(posedge vga_clk)
        begin
            number1[0]     <=  24'h000000;
            number1[1]     <=  24'h000000;
            number1[2]     <=  24'h000000;
            number1[3]     <=  24'h000000;
            number1[4]     <=  24'h000000;
            number1[5]     <=  24'h000000;
            number1[6]     <=  24'h006000;
            number1[7]     <=  24'h01E000;
            number1[8]     <=  24'h1FE000;
            number1[9]     <=  24'h0FE000;
            number1[10]    <=  24'h01E000;
            number1[11]    <=  24'h01E000;
            number1[12]    <=  24'h01E000;
            number1[13]    <=  24'h01E000;
            number1[14]    <=  24'h01E000;
            number1[15]    <=  24'h01E000;
            number1[16]    <=  24'h01E000;
            number1[17]    <=  24'h01E000;
            number1[18]    <=  24'h01E000;
            number1[19]    <=  24'h01E000;
            number1[20]    <=  24'h01E000;
            number1[21]    <=  24'h01E000;
            number1[22]    <=  24'h01E000;
            number1[23]    <=  24'h01E000;
            number1[24]    <=  24'h01E000;
            number1[25]    <=  24'h01E000;
            number1[26]    <=  24'h01E000;
            number1[27]    <=  24'h01E000;
            number1[28]    <=  24'h01E000;
            number1[29]    <=  24'h03F000;
            number1[30]    <=  24'h1FFE00;
            number1[31]    <=  24'h000000;
            number1[32]    <=  24'h000000;
            number1[33]    <=  24'h000000;
            number1[34]    <=  24'h000000;
            number1[35]    <=  24'h000000;
            number1[36]    <=  24'h000000;
            number1[37]    <=  24'h000000;
            number1[38]    <=  24'h000000;
            number1[39]    <=  24'h000000;
            number1[40]    <=  24'h000000;
            number1[41]    <=  24'h000000;
            number1[42]    <=  24'h000000;
            number1[43]    <=  24'h000000;
            number1[44]    <=  24'h000000;
            number1[45]    <=  24'h000000;
            number1[46]    <=  24'h000000;
            number1[47]    <=  24'h000000;
        end
          //number2
        always@(posedge vga_clk)
        begin
            number2[0]     <=  24'h000000;
            number2[1]     <=  24'h000000;
            number2[2]     <=  24'h000000;
            number2[3]     <=  24'h000000;
            number2[4]     <=  24'h000000;
            number2[5]     <=  24'h000000;
            number2[6]     <=  24'h07F800;
            number2[7]     <=  24'h0F3C00;
            number2[8]     <=  24'h1C1E00;
            number2[9]     <=  24'h380F00;
            number2[10]    <=  24'h380F00;
            number2[11]    <=  24'h3C0F00;
            number2[12]    <=  24'h3C0F00;
            number2[13]    <=  24'h3C0F00;
            number2[14]    <=  24'h1C0F00;
            number2[15]    <=  24'h000E00;
            number2[16]    <=  24'h001E00;
            number2[17]    <=  24'h001C00;
            number2[18]    <=  24'h003800;
            number2[19]    <=  24'h007000;
            number2[20]    <=  24'h00E000;
            number2[21]    <=  24'h01C000;
            number2[22]    <=  24'h038000;
            number2[23]    <=  24'h078000;
            number2[24]    <=  24'h0F0100;
            number2[25]    <=  24'h1E0300;
            number2[26]    <=  24'h1C0300;
            number2[27]    <=  24'h380700;
            number2[28]    <=  24'h7FFF00;
            number2[29]    <=  24'h7FFF00;
            number2[30]    <=  24'h7FFF00;
            number2[31]    <=  24'h000000;
            number2[32]    <=  24'h000000;
            number2[33]    <=  24'h000000;
            number2[34]    <=  24'h000000;
            number2[35]    <=  24'h000000;
            number2[36]    <=  24'h000000;
            number2[37]    <=  24'h000000;
            number2[38]    <=  24'h000000;
            number2[39]    <=  24'h000000;
            number2[40]    <=  24'h000000;
            number2[41]    <=  24'h000000;
            number2[42]    <=  24'h000000;
            number2[43]    <=  24'h000000;
            number2[44]    <=  24'h000000;
            number2[45]    <=  24'h000000;
            number2[46]    <=  24'h000000;
            number2[47]    <=  24'h000000;
        end
        //number3
        always@(posedge vga_clk)
        begin
            number3[0]     <=  24'h000000;
            number3[1]     <=  24'h000000;
            number3[2]     <=  24'h000000;
            number3[3]     <=  24'h000000;
            number3[4]     <=  24'h000000;
            number3[5]     <=  24'h000000;
            number3[6]     <=  24'h07F000;
            number3[7]     <=  24'h1E7C00;
            number3[8]     <=  24'h3C1C00;
            number3[9]     <=  24'h3C1E00;
            number3[10]    <=  24'h3C0E00;
            number3[11]    <=  24'h3C0E00;
            number3[12]    <=  24'h3C0E00;
            number3[13]    <=  24'h000E00;
            number3[14]    <=  24'h001E00;
            number3[15]    <=  24'h003C00;
            number3[16]    <=  24'h00F800;
            number3[17]    <=  24'h03F000;
            number3[18]    <=  24'h007C00;
            number3[19]    <=  24'h001E00;
            number3[20]    <=  24'h000E00;
            number3[21]    <=  24'h000F00;
            number3[22]    <=  24'h000F00;
            number3[23]    <=  24'h000F00;
            number3[24]    <=  24'h3C0F00;
            number3[25]    <=  24'h3C0F00;
            number3[26]    <=  24'h7C0F00;
            number3[27]    <=  24'h3C0F00;
            number3[28]    <=  24'h3C1E00;
            number3[29]    <=  24'h1E7C00;
            number3[30]    <=  24'h0FF800;
            number3[31]    <=  24'h000000;
            number3[32]    <=  24'h000000;
            number3[33]    <=  24'h000000;
            number3[34]    <=  24'h000000;
            number3[35]    <=  24'h000000;
            number3[36]    <=  24'h000000;
            number3[37]    <=  24'h000000;
            number3[38]    <=  24'h000000;
            number3[39]    <=  24'h000000;
            number3[40]    <=  24'h000000;
            number3[41]    <=  24'h000000;
            number3[42]    <=  24'h000000;
            number3[43]    <=  24'h000000;
            number3[44]    <=  24'h000000;
            number3[45]    <=  24'h000000;
            number3[46]    <=  24'h000000;
            number3[47]    <=  24'h000000;
        end
        //number4
        always@(posedge vga_clk)
        begin
            number4[0]     <=  24'h000000;
            number4[1]     <=  24'h000000;
            number4[2]     <=  24'h000000;
            number4[3]     <=  24'h000000;
            number4[4]     <=  24'h000000;
            number4[5]     <=  24'h000000;
            number4[6]     <=  24'h003C00;
            number4[7]     <=  24'h003C00;
            number4[8]     <=  24'h007C00;
            number4[9]     <=  24'h007C00;
            number4[10]    <=  24'h00FC00;
            number4[11]    <=  24'h01FC00;
            number4[12]    <=  24'h01FC00;
            number4[13]    <=  24'h03BC00;
            number4[14]    <=  24'h033C00;
            number4[15]    <=  24'h073C00;
            number4[16]    <=  24'h0E3C00;
            number4[17]    <=  24'h0E3C00;
            number4[18]    <=  24'h1C3C00;
            number4[19]    <=  24'h183C00;
            number4[20]    <=  24'h383C00;
            number4[21]    <=  24'h703C00;
            number4[22]    <=  24'h703C00;
            number4[23]    <=  24'hFFFF80;
            number4[24]    <=  24'h003C00;
            number4[25]    <=  24'h003C00;
            number4[26]    <=  24'h003C00;
            number4[27]    <=  24'h003C00;
            number4[28]    <=  24'h003C00;
            number4[29]    <=  24'h007C00;
            number4[30]    <=  24'h03FF80;
            number4[31]    <=  24'h000000;
            number4[32]    <=  24'h000000;
            number4[33]    <=  24'h000000;
            number4[34]    <=  24'h000000;
            number4[35]    <=  24'h000000;
            number4[36]    <=  24'h000000;
            number4[37]    <=  24'h000000;
            number4[38]    <=  24'h000000;
            number4[39]    <=  24'h000000;
            number4[40]    <=  24'h000000;
            number4[41]    <=  24'h000000;
            number4[42]    <=  24'h000000;
            number4[43]    <=  24'h000000;
            number4[44]    <=  24'h000000;
            number4[45]    <=  24'h000000;
            number4[46]    <=  24'h000000;
            number4[47]    <=  24'h000000;
        end
        //number5
        always@(posedge vga_clk)
        begin
            number5[0]     <=  24'h000000;
            number5[1]     <=  24'h000000;
            number5[2]     <=  24'h000000;
            number5[3]     <=  24'h000000;
            number5[4]     <=  24'h000000;
            number5[5]     <=  24'h000000;
            number5[6]     <=  24'h1FFF00;
            number5[7]     <=  24'h1FFF00;
            number5[8]     <=  24'h1FFE00;
            number5[9]     <=  24'h180000;
            number5[10]    <=  24'h180000;
            number5[11]    <=  24'h180000;
            number5[12]    <=  24'h180000;
            number5[13]    <=  24'h180000;
            number5[14]    <=  24'h18E000;
            number5[15]    <=  24'h1FF800;
            number5[16]    <=  24'h1FFC00;
            number5[17]    <=  24'h3C1E00;
            number5[18]    <=  24'h3C0F00;
            number5[19]    <=  24'h180F00;
            number5[20]    <=  24'h000700;
            number5[21]    <=  24'h000700;
            number5[22]    <=  24'h000700;
            number5[23]    <=  24'h180700;
            number5[24]    <=  24'h3C0700;
            number5[25]    <=  24'h7C0F00;
            number5[26]    <=  24'h7C0F00;
            number5[27]    <=  24'h380E00;
            number5[28]    <=  24'h381E00;
            number5[29]    <=  24'h1F3C00;
            number5[30]    <=  24'h07F800;
            number5[31]    <=  24'h000000;
            number5[32]    <=  24'h000000;
            number5[33]    <=  24'h000000;
            number5[34]    <=  24'h000000;
            number5[35]    <=  24'h000000;
            number5[36]    <=  24'h000000;
            number5[37]    <=  24'h000000;
            number5[38]    <=  24'h000000;
            number5[39]    <=  24'h000000;
            number5[40]    <=  24'h000000;
            number5[41]    <=  24'h000000;
            number5[42]    <=  24'h000000;
            number5[43]    <=  24'h000000;
            number5[44]    <=  24'h000000;
            number5[45]    <=  24'h000000;
            number5[46]    <=  24'h000000;
            number5[47]    <=  24'h000000;
        end
        //number6
        always@(posedge vga_clk)
        begin
            number6[0]     <=  24'h000000;
            number6[1]     <=  24'h000000;
            number6[2]     <=  24'h000000;
            number6[3]     <=  24'h000000;
            number6[4]     <=  24'h000000;
            number6[5]     <=  24'h000000;
            number6[6]     <=  24'h03FC00;
            number6[7]     <=  24'h079E00;
            number6[8]     <=  24'h0F1F00;
            number6[9]     <=  24'h1E1F00;
            number6[10]    <=  24'h1C0E00;
            number6[11]    <=  24'h3C0000;
            number6[12]    <=  24'h3C0000;
            number6[13]    <=  24'h380000;
            number6[14]    <=  24'h780000;
            number6[15]    <=  24'h7BFC00;
            number6[16]    <=  24'h7FFE00;
            number6[17]    <=  24'h7F1F00;
            number6[18]    <=  24'h7C0F00;
            number6[19]    <=  24'h7C0700;
            number6[20]    <=  24'h780780;
            number6[21]    <=  24'h780780;
            number6[22]    <=  24'h780780;
            number6[23]    <=  24'h780780;
            number6[24]    <=  24'h780780;
            number6[25]    <=  24'h3C0780;
            number6[26]    <=  24'h3C0700;
            number6[27]    <=  24'h1E0F00;
            number6[28]    <=  24'h1E0E00;
            number6[29]    <=  24'h0FBC00;
            number6[30]    <=  24'h07F800;
            number6[31]    <=  24'h000000;
            number6[32]    <=  24'h000000;
            number6[33]    <=  24'h000000;
            number6[34]    <=  24'h000000;
            number6[35]    <=  24'h000000;
            number6[36]    <=  24'h000000;
            number6[37]    <=  24'h000000;
            number6[38]    <=  24'h000000;
            number6[39]    <=  24'h000000;
            number6[40]    <=  24'h000000;
            number6[41]    <=  24'h000000;
            number6[42]    <=  24'h000000;
            number6[43]    <=  24'h000000;
            number6[44]    <=  24'h000000;
            number6[45]    <=  24'h000000;
            number6[46]    <=  24'h000000;
            number6[47]    <=  24'h000000;
        end
         //number7
        always@(posedge vga_clk)
        begin
            number7[0]     <=  24'h000000;
            number7[1]     <=  24'h000000;
            number7[2]     <=  24'h000000;
            number7[3]     <=  24'h000000;
            number7[4]     <=  24'h000000;
            number7[5]     <=  24'h000000;
            number7[6]     <=  24'h3FFF80;
            number7[7]     <=  24'h3FFF00;
            number7[8]     <=  24'h3FFF00;
            number7[9]     <=  24'h380E00;
            number7[10]    <=  24'h300E00;
            number7[11]    <=  24'h301C00;
            number7[12]    <=  24'h001C00;
            number7[13]    <=  24'h003800;
            number7[14]    <=  24'h003800;
            number7[15]    <=  24'h007000;
            number7[16]    <=  24'h007000;
            number7[17]    <=  24'h00F000;
            number7[18]    <=  24'h00E000;
            number7[19]    <=  24'h00E000;
            number7[20]    <=  24'h01E000;
            number7[21]    <=  24'h01E000;
            number7[22]    <=  24'h01C000;
            number7[23]    <=  24'h03C000;
            number7[24]    <=  24'h03C000;
            number7[25]    <=  24'h03C000;
            number7[26]    <=  24'h03C000;
            number7[27]    <=  24'h03C000;
            number7[28]    <=  24'h03C000;
            number7[29]    <=  24'h03C000;
            number7[30]    <=  24'h03C000;
            number7[31]    <=  24'h000000;
            number7[32]    <=  24'h000000;
            number7[33]    <=  24'h000000;
            number7[34]    <=  24'h000000;
            number7[35]    <=  24'h000000;
            number7[36]    <=  24'h000000;
            number7[37]    <=  24'h000000;
            number7[38]    <=  24'h000000;
            number7[39]    <=  24'h000000;
            number7[40]    <=  24'h000000;
            number7[41]    <=  24'h000000;
            number7[42]    <=  24'h000000;
            number7[43]    <=  24'h000000;
            number7[44]    <=  24'h000000;
            number7[45]    <=  24'h000000;
            number7[46]    <=  24'h000000;
            number7[47]    <=  24'h000000;
        end
         //number8
        always@(posedge vga_clk)
        begin
            number8[0]     <=  24'h000000;
            number8[1]     <=  24'h000000;
            number8[2]     <=  24'h000000;
            number8[3]     <=  24'h000000;
            number8[4]     <=  24'h000000;
            number8[5]     <=  24'h000000;
            number8[6]     <=  24'h07F800;
            number8[7]     <=  24'h1F3C00;
            number8[8]     <=  24'h3C0E00;
            number8[9]     <=  24'h380F00;
            number8[10]    <=  24'h380700;
            number8[11]    <=  24'h780700;
            number8[12]    <=  24'h780700;
            number8[13]    <=  24'h3C0700;
            number8[14]    <=  24'h3E0F00;
            number8[15]    <=  24'h1F0E00;
            number8[16]    <=  24'h1FFC00;
            number8[17]    <=  24'h07F800;
            number8[18]    <=  24'h0FF800;
            number8[19]    <=  24'h1CFC00;
            number8[20]    <=  24'h3C3E00;
            number8[21]    <=  24'h381F00;
            number8[22]    <=  24'h780F00;
            number8[23]    <=  24'h700780;
            number8[24]    <=  24'h700780;
            number8[25]    <=  24'h700780;
            number8[26]    <=  24'h780700;
            number8[27]    <=  24'h380F00;
            number8[28]    <=  24'h3C0E00;
            number8[29]    <=  24'h1F3C00;
            number8[30]    <=  24'h07F800;
            number8[31]    <=  24'h000000;
            number8[32]    <=  24'h000000;
            number8[33]    <=  24'h000000;
            number8[34]    <=  24'h000000;
            number8[35]    <=  24'h000000;
            number8[36]    <=  24'h000000;
            number8[37]    <=  24'h000000;
            number8[38]    <=  24'h000000;
            number8[39]    <=  24'h000000;
            number8[40]    <=  24'h000000;
            number8[41]    <=  24'h000000;
            number8[42]    <=  24'h000000;
            number8[43]    <=  24'h000000;
            number8[44]    <=  24'h000000;
            number8[45]    <=  24'h000000;
            number8[46]    <=  24'h000000;
            number8[47]    <=  24'h000000;
        end
         //number9
        always@(posedge vga_clk)
        begin
            number9[0]     <=  24'h000000;
            number9[1]     <=  24'h000000;
            number9[2]     <=  24'h000000;
            number9[3]     <=  24'h000000;
            number9[4]     <=  24'h000000;
            number9[5]     <=  24'h000000;
            number9[6]     <=  24'h07F000;
            number9[7]     <=  24'h1F7C00;
            number9[8]     <=  24'h3C1E00;
            number9[9]     <=  24'h380E00;
            number9[10]    <=  24'h780F00;
            number9[11]    <=  24'h780F00;
            number9[12]    <=  24'h780F00;
            number9[13]    <=  24'h780700;
            number9[14]    <=  24'h780780;
            number9[15]    <=  24'h780F80;
            number9[16]    <=  24'h780F80;
            number9[17]    <=  24'h781F80;
            number9[18]    <=  24'h3C1F80;
            number9[19]    <=  24'h3E7F80;
            number9[20]    <=  24'h1FFF80;
            number9[21]    <=  24'h03CF00;
            number9[22]    <=  24'h000F00;
            number9[23]    <=  24'h000F00;
            number9[24]    <=  24'h000F00;
            number9[25]    <=  24'h001E00;
            number9[26]    <=  24'h1C1E00;
            number9[27]    <=  24'h3C1C00;
            number9[28]    <=  24'h3E3800;
            number9[29]    <=  24'h1EF800;
            number9[30]    <=  24'h0FE000;
            number9[31]    <=  24'h000000;
            number9[32]    <=  24'h000000;
            number9[33]    <=  24'h000000;
            number9[34]    <=  24'h000000;
            number9[35]    <=  24'h000000;
            number9[36]    <=  24'h000000;
            number9[37]    <=  24'h000000;
            number9[38]    <=  24'h000000;
            number9[39]    <=  24'h000000;
            number9[40]    <=  24'h000000;
            number9[41]    <=  24'h000000;
            number9[42]    <=  24'h000000;
            number9[43]    <=  24'h000000;
            number9[44]    <=  24'h000000;
            number9[45]    <=  24'h000000;
            number9[46]    <=  24'h000000;
            number9[47]    <=  24'h000000;
        end
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// ========================================================================================================================================= 
// =========================================================================================================================================
// ========================================================================================================================================= 
// =========================================================================================================================================
// ========================================================================================================================================= 
// =========================================================================================================================================
// ========================================================================================================================================= 
// =========================================================================================================================================
// ========================================================================================================================================= 
// =========================================================================================================================================
// ========================================================================================================================================= 
// =========================================================================================================================================
// ========================================================================================================================================= 
// =========================================================================================================================================
// ========================================================================================================================================= 
// =========================================================================================================================================
// ========================================================================================================================================= 
// =========================================================================================================================================
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
        always @(posedge vga_clk ) begin
            if (freq_freq_rd_en) begin
                case (unit_temp)
                0: begin
                    word4[0]     <=  24'h000000;
                    word4[1]     <=  24'h000000;
                    word4[2]     <=  24'h000000;
                    word4[3]     <=  24'h000000;
                    word4[4]     <=  24'h000000;
                    word4[5]     <=  24'h000000;
                    word4[6]     <=  24'h03F000;
                    word4[7]     <=  24'h0FBC00;
                    word4[8]     <=  24'h0E1C00;
                    word4[9]     <=  24'h1E1E00;
                    word4[10]    <=  24'h3C0F00;
                    word4[11]    <=  24'h3C0F00;
                    word4[12]    <=  24'h3C0F00;
                    word4[13]    <=  24'h780F00;
                    word4[14]    <=  24'h780780;
                    word4[15]    <=  24'h780780;
                    word4[16]    <=  24'h780780;
                    word4[17]    <=  24'h780780;
                    word4[18]    <=  24'h780780;
                    word4[19]    <=  24'h780780;
                    word4[20]    <=  24'h780780;
                    word4[21]    <=  24'h780780;
                    word4[22]    <=  24'h780780;
                    word4[23]    <=  24'h780F00;
                    word4[24]    <=  24'h3C0F00;
                    word4[25]    <=  24'h3C0F00;
                    word4[26]    <=  24'h3C0F00;
                    word4[27]    <=  24'h1E1E00;
                    word4[28]    <=  24'h0E1C00;
                    word4[29]    <=  24'h0FF800;
                    word4[30]    <=  24'h03F000;
                    word4[31]    <=  24'h000000;
                    word4[32]    <=  24'h000000;
                    word4[33]    <=  24'h000000;
                    word4[34]    <=  24'h000000;
                    word4[35]    <=  24'h000000;
                    word4[36]    <=  24'h000000;
                    word4[37]    <=  24'h000000;
                    word4[38]    <=  24'h000000;
                    word4[39]    <=  24'h000000;
                    word4[40]    <=  24'h000000;
                    word4[41]    <=  24'h000000;
                    word4[42]    <=  24'h000000;
                    word4[43]    <=  24'h000000;
                    word4[44]    <=  24'h000000;
                    word4[45]    <=  24'h000000;
                    word4[46]    <=  24'h000000;
                    word4[47]    <=  24'h000000;
                end
                1: begin
                    word4[0]     <=  24'h000000;
                    word4[1]     <=  24'h000000;
                    word4[2]     <=  24'h000000;
                    word4[3]     <=  24'h000000;
                    word4[4]     <=  24'h000000;
                    word4[5]     <=  24'h000000;
                    word4[6]     <=  24'h006000;
                    word4[7]     <=  24'h01E000;
                    word4[8]     <=  24'h1FE000;
                    word4[9]     <=  24'h0FE000;
                    word4[10]    <=  24'h01E000;
                    word4[11]    <=  24'h01E000;
                    word4[12]    <=  24'h01E000;
                    word4[13]    <=  24'h01E000;
                    word4[14]    <=  24'h01E000;
                    word4[15]    <=  24'h01E000;
                    word4[16]    <=  24'h01E000;
                    word4[17]    <=  24'h01E000;
                    word4[18]    <=  24'h01E000;
                    word4[19]    <=  24'h01E000;
                    word4[20]    <=  24'h01E000;
                    word4[21]    <=  24'h01E000;
                    word4[22]    <=  24'h01E000;
                    word4[23]    <=  24'h01E000;
                    word4[24]    <=  24'h01E000;
                    word4[25]    <=  24'h01E000;
                    word4[26]    <=  24'h01E000;
                    word4[27]    <=  24'h01E000;
                    word4[28]    <=  24'h01E000;
                    word4[29]    <=  24'h03F000;
                    word4[30]    <=  24'h1FFE00;
                    word4[31]    <=  24'h000000;
                    word4[32]    <=  24'h000000;
                    word4[33]    <=  24'h000000;
                    word4[34]    <=  24'h000000;
                    word4[35]    <=  24'h000000;
                    word4[36]    <=  24'h000000;
                    word4[37]    <=  24'h000000;
                    word4[38]    <=  24'h000000;
                    word4[39]    <=  24'h000000;
                    word4[40]    <=  24'h000000;
                    word4[41]    <=  24'h000000;
                    word4[42]    <=  24'h000000;
                    word4[43]    <=  24'h000000;
                    word4[44]    <=  24'h000000;
                    word4[45]    <=  24'h000000;
                    word4[46]    <=  24'h000000;
                    word4[47]    <=  24'h000000;
                end
                    2: begin
                        word4[0]     <=  24'h000000;
                        word4[1]     <=  24'h000000;
                        word4[2]     <=  24'h000000;
                        word4[3]     <=  24'h000000;
                        word4[4]     <=  24'h000000;
                        word4[5]     <=  24'h000000;
                        word4[6]     <=  24'h07F800;
                        word4[7]     <=  24'h0F3C00;
                        word4[8]     <=  24'h1C1E00;
                        word4[9]     <=  24'h380F00;
                        word4[10]    <=  24'h380F00;
                        word4[11]    <=  24'h3C0F00;
                        word4[12]    <=  24'h3C0F00;
                        word4[13]    <=  24'h3C0F00;
                        word4[14]    <=  24'h1C0F00;
                        word4[15]    <=  24'h000E00;
                        word4[16]    <=  24'h001E00;
                        word4[17]    <=  24'h001C00;
                        word4[18]    <=  24'h003800;
                        word4[19]    <=  24'h007000;
                        word4[20]    <=  24'h00E000;
                        word4[21]    <=  24'h01C000;
                        word4[22]    <=  24'h038000;
                        word4[23]    <=  24'h078000;
                        word4[24]    <=  24'h0F0100;
                        word4[25]    <=  24'h1E0300;
                        word4[26]    <=  24'h1C0300;
                        word4[27]    <=  24'h380700;
                        word4[28]    <=  24'h7FFF00;
                        word4[29]    <=  24'h7FFF00;
                        word4[30]    <=  24'h7FFF00;
                        word4[31]    <=  24'h000000;
                        word4[32]    <=  24'h000000;
                        word4[33]    <=  24'h000000;
                        word4[34]    <=  24'h000000;
                        word4[35]    <=  24'h000000;
                        word4[36]    <=  24'h000000;
                        word4[37]    <=  24'h000000;
                        word4[38]    <=  24'h000000;
                        word4[39]    <=  24'h000000;
                        word4[40]    <=  24'h000000;
                        word4[41]    <=  24'h000000;
                        word4[42]    <=  24'h000000;
                        word4[43]    <=  24'h000000;
                        word4[44]    <=  24'h000000;
                        word4[45]    <=  24'h000000;
                        word4[46]    <=  24'h000000;
                        word4[47]    <=  24'h000000;
                    end
                    3: begin
                        word4[0]     <=  24'h000000;
                        word4[1]     <=  24'h000000;
                        word4[2]     <=  24'h000000;
                        word4[3]     <=  24'h000000;
                        word4[4]     <=  24'h000000;
                        word4[5]     <=  24'h000000;
                        word4[6]     <=  24'h07F000;
                        word4[7]     <=  24'h1E7C00;
                        word4[8]     <=  24'h3C1C00;
                        word4[9]     <=  24'h3C1E00;
                        word4[10]    <=  24'h3C0E00;
                        word4[11]    <=  24'h3C0E00;
                        word4[12]    <=  24'h3C0E00;
                        word4[13]    <=  24'h000E00;
                        word4[14]    <=  24'h001E00;
                        word4[15]    <=  24'h003C00;
                        word4[16]    <=  24'h00F800;
                        word4[17]    <=  24'h03F000;
                        word4[18]    <=  24'h007C00;
                        word4[19]    <=  24'h001E00;
                        word4[20]    <=  24'h000E00;
                        word4[21]    <=  24'h000F00;
                        word4[22]    <=  24'h000F00;
                        word4[23]    <=  24'h000F00;
                        word4[24]    <=  24'h3C0F00;
                        word4[25]    <=  24'h3C0F00;
                        word4[26]    <=  24'h7C0F00;
                        word4[27]    <=  24'h3C0F00;
                        word4[28]    <=  24'h3C1E00;
                        word4[29]    <=  24'h1E7C00;
                        word4[30]    <=  24'h0FF800;
                        word4[31]    <=  24'h000000;
                        word4[32]    <=  24'h000000;
                        word4[33]    <=  24'h000000;
                        word4[34]    <=  24'h000000;
                        word4[35]    <=  24'h000000;
                        word4[36]    <=  24'h000000;
                        word4[37]    <=  24'h000000;
                        word4[38]    <=  24'h000000;
                        word4[39]    <=  24'h000000;
                        word4[40]    <=  24'h000000;
                        word4[41]    <=  24'h000000;
                        word4[42]    <=  24'h000000;
                        word4[43]    <=  24'h000000;
                        word4[44]    <=  24'h000000;
                        word4[45]    <=  24'h000000;
                        word4[46]    <=  24'h000000;
                        word4[47]    <=  24'h000000;
                    end
                    4: begin
                        word4[0]     <=  24'h000000;
                        word4[1]     <=  24'h000000;
                        word4[2]     <=  24'h000000;
                        word4[3]     <=  24'h000000;
                        word4[4]     <=  24'h000000;
                        word4[5]     <=  24'h000000;
                        word4[6]     <=  24'h003C00;
                        word4[7]     <=  24'h003C00;
                        word4[8]     <=  24'h007C00;
                        word4[9]     <=  24'h007C00;
                        word4[10]    <=  24'h00FC00;
                        word4[11]    <=  24'h01FC00;
                        word4[12]    <=  24'h01FC00;
                        word4[13]    <=  24'h03BC00;
                        word4[14]    <=  24'h033C00;
                        word4[15]    <=  24'h073C00;
                        word4[16]    <=  24'h0E3C00;
                        word4[17]    <=  24'h0E3C00;
                        word4[18]    <=  24'h1C3C00;
                        word4[19]    <=  24'h183C00;
                        word4[20]    <=  24'h383C00;
                        word4[21]    <=  24'h703C00;
                        word4[22]    <=  24'h703C00;
                        word4[23]    <=  24'hFFFF80;
                        word4[24]    <=  24'h003C00;
                        word4[25]    <=  24'h003C00;
                        word4[26]    <=  24'h003C00;
                        word4[27]    <=  24'h003C00;
                        word4[28]    <=  24'h003C00;
                        word4[29]    <=  24'h007C00;
                        word4[30]    <=  24'h03FF80;
                        word4[31]    <=  24'h000000;
                        word4[32]    <=  24'h000000;
                        word4[33]    <=  24'h000000;
                        word4[34]    <=  24'h000000;
                        word4[35]    <=  24'h000000;
                        word4[36]    <=  24'h000000;
                        word4[37]    <=  24'h000000;
                        word4[38]    <=  24'h000000;
                        word4[39]    <=  24'h000000;
                        word4[40]    <=  24'h000000;
                        word4[41]    <=  24'h000000;
                        word4[42]    <=  24'h000000;
                        word4[43]    <=  24'h000000;
                        word4[44]    <=  24'h000000;
                        word4[45]    <=  24'h000000;
                        word4[46]    <=  24'h000000;
                        word4[47]    <=  24'h000000;
                    end
                    5: begin
                        word4[0]     <= 24'h000000;
                        word4[1]     <= 24'h000000;
                        word4[2]     <= 24'h000000;
                        word4[3]     <= 24'h000000;
                        word4[4]     <= 24'h000000;
                        word4[5]     <= 24'h000000;
                        word4[6]     <= 24'h1FFF00;
                        word4[7]     <= 24'h1FFF00;
                        word4[8]     <= 24'h1FFE00;
                        word4[9]     <= 24'h180000;
                        word4[10]    <= 24'h180000;
                        word4[11]    <= 24'h180000;
                        word4[12]    <= 24'h180000;
                        word4[13]    <= 24'h180000;
                        word4[14]    <= 24'h18E000;
                        word4[15]    <= 24'h1FF800;
                        word4[16]    <= 24'h1FFC00;
                        word4[17]    <= 24'h3C1E00;
                        word4[18]    <= 24'h3C0F00;
                        word4[19]    <= 24'h180F00;
                        word4[20]    <= 24'h000700;
                        word4[21]    <= 24'h000700;
                        word4[22]    <= 24'h000700;
                        word4[23]    <= 24'h180700;
                        word4[24]    <= 24'h3C0700;
                        word4[25]    <= 24'h7C0F00;
                        word4[26]    <= 24'h7C0F00;
                        word4[27]    <= 24'h380E00;
                        word4[28]    <= 24'h381E00;
                        word4[29]    <= 24'h1F3C00;
                        word4[30]    <= 24'h07F800;
                        word4[31]    <= 24'h000000;
                        word4[32]    <= 24'h000000;
                        word4[33]    <= 24'h000000;
                        word4[34]    <= 24'h000000;
                        word4[35]    <= 24'h000000;
                        word4[36]    <= 24'h000000;
                        word4[37]    <= 24'h000000;
                        word4[38]    <= 24'h000000;
                        word4[39]    <= 24'h000000;
                        word4[40]    <= 24'h000000;
                        word4[41]    <= 24'h000000;
                        word4[42]    <= 24'h000000;
                        word4[43]    <= 24'h000000;
                        word4[44]    <= 24'h000000;
                        word4[45]    <= 24'h000000;
                        word4[46]    <= 24'h000000;
                        word4[47]    <= 24'h000000;
                    end
                    6: begin
                        word4[0]     <=  24'h000000;
                        word4[1]     <=  24'h000000;
                        word4[2]     <=  24'h000000;
                        word4[3]     <=  24'h000000;
                        word4[4]     <=  24'h000000;
                        word4[5]     <=  24'h000000;
                        word4[6]     <=  24'h03FC00;
                        word4[7]     <=  24'h079E00;
                        word4[8]     <=  24'h0F1F00;
                        word4[9]     <=  24'h1E1F00;
                        word4[10]    <=  24'h1C0E00;
                        word4[11]    <=  24'h3C0000;
                        word4[12]    <=  24'h3C0000;
                        word4[13]    <=  24'h380000;
                        word4[14]    <=  24'h780000;
                        word4[15]    <=  24'h7BFC00;
                        word4[16]    <=  24'h7FFE00;
                        word4[17]    <=  24'h7F1F00;
                        word4[18]    <=  24'h7C0F00;
                        word4[19]    <=  24'h7C0700;
                        word4[20]    <=  24'h780780;
                        word4[21]    <=  24'h780780;
                        word4[22]    <=  24'h780780;
                        word4[23]    <=  24'h780780;
                        word4[24]    <=  24'h780780;
                        word4[25]    <=  24'h3C0780;
                        word4[26]    <=  24'h3C0700;
                        word4[27]    <=  24'h1E0F00;
                        word4[28]    <=  24'h1E0E00;
                        word4[29]    <=  24'h0FBC00;
                        word4[30]    <=  24'h07F800;
                        word4[31]    <=  24'h000000;
                        word4[32]    <=  24'h000000;
                        word4[33]    <=  24'h000000;
                        word4[34]    <=  24'h000000;
                        word4[35]    <=  24'h000000;
                        word4[36]    <=  24'h000000;
                        word4[37]    <=  24'h000000;
                        word4[38]    <=  24'h000000;
                        word4[39]    <=  24'h000000;
                        word4[40]    <=  24'h000000;
                        word4[41]    <=  24'h000000;
                        word4[42]    <=  24'h000000;
                        word4[43]    <=  24'h000000;
                        word4[44]    <=  24'h000000;
                        word4[45]    <=  24'h000000;
                        word4[46]    <=  24'h000000;
                        word4[47]    <=  24'h000000;
                    end
                    7: begin
                        word4[0]     <=  24'h000000;
                        word4[1]     <=  24'h000000;
                        word4[2]     <=  24'h000000;
                        word4[3]     <=  24'h000000;
                        word4[4]     <=  24'h000000;
                        word4[5]     <=  24'h000000;
                        word4[6]     <=  24'h3FFF80;
                        word4[7]     <=  24'h3FFF00;
                        word4[8]     <=  24'h3FFF00;
                        word4[9]     <=  24'h380E00;
                        word4[10]    <=  24'h300E00;
                        word4[11]    <=  24'h301C00;
                        word4[12]    <=  24'h001C00;
                        word4[13]    <=  24'h003800;
                        word4[14]    <=  24'h003800;
                        word4[15]    <=  24'h007000;
                        word4[16]    <=  24'h007000;
                        word4[17]    <=  24'h00F000;
                        word4[18]    <=  24'h00E000;
                        word4[19]    <=  24'h00E000;
                        word4[20]    <=  24'h01E000;
                        word4[21]    <=  24'h01E000;
                        word4[22]    <=  24'h01C000;
                        word4[23]    <=  24'h03C000;
                        word4[24]    <=  24'h03C000;
                        word4[25]    <=  24'h03C000;
                        word4[26]    <=  24'h03C000;
                        word4[27]    <=  24'h03C000;
                        word4[28]    <=  24'h03C000;
                        word4[29]    <=  24'h03C000;
                        word4[30]    <=  24'h03C000;
                        word4[31]    <=  24'h000000;
                        word4[32]    <=  24'h000000;
                        word4[33]    <=  24'h000000;
                        word4[34]    <=  24'h000000;
                        word4[35]    <=  24'h000000;
                        word4[36]    <=  24'h000000;
                        word4[37]    <=  24'h000000;
                        word4[38]    <=  24'h000000;
                        word4[39]    <=  24'h000000;
                        word4[40]    <=  24'h000000;
                        word4[41]    <=  24'h000000;
                        word4[42]    <=  24'h000000;
                        word4[43]    <=  24'h000000;
                        word4[44]    <=  24'h000000;
                        word4[45]    <=  24'h000000;
                        word4[46]    <=  24'h000000;
                        word4[47]    <=  24'h000000;
                    end
                    8: begin
                        word4[0]     <=  24'h000000;
                        word4[1]     <=  24'h000000;
                        word4[2]     <=  24'h000000;
                        word4[3]     <=  24'h000000;
                        word4[4]     <=  24'h000000;
                        word4[5]     <=  24'h000000;
                        word4[6]     <=  24'h07F800;
                        word4[7]     <=  24'h1F3C00;
                        word4[8]     <=  24'h3C0E00;
                        word4[9]     <=  24'h380F00;
                        word4[10]    <=  24'h380700;
                        word4[11]    <=  24'h780700;
                        word4[12]    <=  24'h780700;
                        word4[13]    <=  24'h3C0700;
                        word4[14]    <=  24'h3E0F00;
                        word4[15]    <=  24'h1F0E00;
                        word4[16]    <=  24'h1FFC00;
                        word4[17]    <=  24'h07F800;
                        word4[18]    <=  24'h0FF800;
                        word4[19]    <=  24'h1CFC00;
                        word4[20]    <=  24'h3C3E00;
                        word4[21]    <=  24'h381F00;
                        word4[22]    <=  24'h780F00;
                        word4[23]    <=  24'h700780;
                        word4[24]    <=  24'h700780;
                        word4[25]    <=  24'h700780;
                        word4[26]    <=  24'h780700;
                        word4[27]    <=  24'h380F00;
                        word4[28]    <=  24'h3C0E00;
                        word4[29]    <=  24'h1F3C00;
                        word4[30]    <=  24'h07F800;
                        word4[31]    <=  24'h000000;
                        word4[32]    <=  24'h000000;
                        word4[33]    <=  24'h000000;
                        word4[34]    <=  24'h000000;
                        word4[35]    <=  24'h000000;
                        word4[36]    <=  24'h000000;
                        word4[37]    <=  24'h000000;
                        word4[38]    <=  24'h000000;
                        word4[39]    <=  24'h000000;
                        word4[40]    <=  24'h000000;
                        word4[41]    <=  24'h000000;
                        word4[42]    <=  24'h000000;
                        word4[43]    <=  24'h000000;
                        word4[44]    <=  24'h000000;
                        word4[45]    <=  24'h000000;
                        word4[46]    <=  24'h000000;
                        word4[47]    <=  24'h000000;
                    end
                    9: begin
                        word4[0]     <=  24'h000000;
                        word4[1]     <=  24'h000000;
                        word4[2]     <=  24'h000000;
                        word4[3]     <=  24'h000000;
                        word4[4]     <=  24'h000000;
                        word4[5]     <=  24'h000000;
                        word4[6]     <=  24'h07F000;
                        word4[7]     <=  24'h1F7C00;
                        word4[8]     <=  24'h3C1E00;
                        word4[9]     <=  24'h380E00;
                        word4[10]    <=  24'h780F00;
                        word4[11]    <=  24'h780F00;
                        word4[12]    <=  24'h780F00;
                        word4[13]    <=  24'h780700;
                        word4[14]    <=  24'h780780;
                        word4[15]    <=  24'h780F80;
                        word4[16]    <=  24'h780F80;
                        word4[17]    <=  24'h781F80;
                        word4[18]    <=  24'h3C1F80;
                        word4[19]    <=  24'h3E7F80;
                        word4[20]    <=  24'h1FFF80;
                        word4[21]    <=  24'h03CF00;
                        word4[22]    <=  24'h000F00;
                        word4[23]    <=  24'h000F00;
                        word4[24]    <=  24'h000F00;
                        word4[25]    <=  24'h001E00;
                        word4[26]    <=  24'h1C1E00;
                        word4[27]    <=  24'h3C1C00;
                        word4[28]    <=  24'h3E3800;
                        word4[29]    <=  24'h1EF800;
                        word4[30]    <=  24'h0FE000;
                        word4[31]    <=  24'h000000;
                        word4[32]    <=  24'h000000;
                        word4[33]    <=  24'h000000;
                        word4[34]    <=  24'h000000;
                        word4[35]    <=  24'h000000;
                        word4[36]    <=  24'h000000;
                        word4[37]    <=  24'h000000;
                        word4[38]    <=  24'h000000;
                        word4[39]    <=  24'h000000;
                        word4[40]    <=  24'h000000;
                        word4[41]    <=  24'h000000;
                        word4[42]    <=  24'h000000;
                        word4[43]    <=  24'h000000;
                        word4[44]    <=  24'h000000;
                        word4[45]    <=  24'h000000;
                        word4[46]    <=  24'h000000;
                        word4[47]    <=  24'h000000;
                    end
                    default: 
                    begin
                        word4[0]     <=  24'h000000;
                        word4[1]     <=  24'h000000;
                        word4[2]     <=  24'h000000;
                        word4[3]     <=  24'h000000;
                        word4[4]     <=  24'h000000;
                        word4[5]     <=  24'h000000;
                        word4[6]     <=  24'h03F000;
                        word4[7]     <=  24'h0FBC00;
                        word4[8]     <=  24'h0E1C00;
                        word4[9]     <=  24'h1E1E00;
                        word4[10]    <=  24'h3C0F00;
                        word4[11]    <=  24'h3C0F00;
                        word4[12]    <=  24'h3C0F00;
                        word4[13]    <=  24'h780F00;
                        word4[14]    <=  24'h780780;
                        word4[15]    <=  24'h780780;
                        word4[16]    <=  24'h780780;
                        word4[17]    <=  24'h780780;
                        word4[18]    <=  24'h780780;
                        word4[19]    <=  24'h780780;
                        word4[20]    <=  24'h780780;
                        word4[21]    <=  24'h780780;
                        word4[22]    <=  24'h780780;
                        word4[23]    <=  24'h780F00;
                        word4[24]    <=  24'h3C0F00;
                        word4[25]    <=  24'h3C0F00;
                        word4[26]    <=  24'h3C0F00;
                        word4[27]    <=  24'h1E1E00;
                        word4[28]    <=  24'h0E1C00;
                        word4[29]    <=  24'h0FF800;
                        word4[30]    <=  24'h03F000;
                        word4[31]    <=  24'h000000;
                        word4[32]    <=  24'h000000;
                        word4[33]    <=  24'h000000;
                        word4[34]    <=  24'h000000;
                        word4[35]    <=  24'h000000;
                        word4[36]    <=  24'h000000;
                        word4[37]    <=  24'h000000;
                        word4[38]    <=  24'h000000;
                        word4[39]    <=  24'h000000;
                        word4[40]    <=  24'h000000;
                        word4[41]    <=  24'h000000;
                        word4[42]    <=  24'h000000;
                        word4[43]    <=  24'h000000;
                        word4[44]    <=  24'h000000;
                        word4[45]    <=  24'h000000;
                        word4[46]    <=  24'h000000;
                        word4[47]    <=  24'h000000;
                    end
                endcase
            end
        end
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
        always @(posedge vga_clk ) begin
            if (freq_freq_rd_en) begin
                case (thousand_temp)
                0: begin
                    word1[0]     <=  24'h000000;
                    word1[1]     <=  24'h000000;
                    word1[2]     <=  24'h000000;
                    word1[3]     <=  24'h000000;
                    word1[4]     <=  24'h000000;
                    word1[5]     <=  24'h000000;
                    word1[6]     <=  24'h03F000;
                    word1[7]     <=  24'h0FBC00;
                    word1[8]     <=  24'h0E1C00;
                    word1[9]     <=  24'h1E1E00;
                    word1[10]    <=  24'h3C0F00;
                    word1[11]    <=  24'h3C0F00;
                    word1[12]    <=  24'h3C0F00;
                    word1[13]    <=  24'h780F00;
                    word1[14]    <=  24'h780780;
                    word1[15]    <=  24'h780780;
                    word1[16]    <=  24'h780780;
                    word1[17]    <=  24'h780780;
                    word1[18]    <=  24'h780780;
                    word1[19]    <=  24'h780780;
                    word1[20]    <=  24'h780780;
                    word1[21]    <=  24'h780780;
                    word1[22]    <=  24'h780780;
                    word1[23]    <=  24'h780F00;
                    word1[24]    <=  24'h3C0F00;
                    word1[25]    <=  24'h3C0F00;
                    word1[26]    <=  24'h3C0F00;
                    word1[27]    <=  24'h1E1E00;
                    word1[28]    <=  24'h0E1C00;
                    word1[29]    <=  24'h0FF800;
                    word1[30]    <=  24'h03F000;
                    word1[31]    <=  24'h000000;
                    word1[32]    <=  24'h000000;
                    word1[33]    <=  24'h000000;
                    word1[34]    <=  24'h000000;
                    word1[35]    <=  24'h000000;
                    word1[36]    <=  24'h000000;
                    word1[37]    <=  24'h000000;
                    word1[38]    <=  24'h000000;
                    word1[39]    <=  24'h000000;
                    word1[40]    <=  24'h000000;
                    word1[41]    <=  24'h000000;
                    word1[42]    <=  24'h000000;
                    word1[43]    <=  24'h000000;
                    word1[44]    <=  24'h000000;
                    word1[45]    <=  24'h000000;
                    word1[46]    <=  24'h000000;
                    word1[47]    <=  24'h000000;
                end
                1: begin
                    word1[0]     <=  24'h000000;
                    word1[1]     <=  24'h000000;
                    word1[2]     <=  24'h000000;
                    word1[3]     <=  24'h000000;
                    word1[4]     <=  24'h000000;
                    word1[5]     <=  24'h000000;
                    word1[6]     <=  24'h006000;
                    word1[7]     <=  24'h01E000;
                    word1[8]     <=  24'h1FE000;
                    word1[9]     <=  24'h0FE000;
                    word1[10]    <=  24'h01E000;
                    word1[11]    <=  24'h01E000;
                    word1[12]    <=  24'h01E000;
                    word1[13]    <=  24'h01E000;
                    word1[14]    <=  24'h01E000;
                    word1[15]    <=  24'h01E000;
                    word1[16]    <=  24'h01E000;
                    word1[17]    <=  24'h01E000;
                    word1[18]    <=  24'h01E000;
                    word1[19]    <=  24'h01E000;
                    word1[20]    <=  24'h01E000;
                    word1[21]    <=  24'h01E000;
                    word1[22]    <=  24'h01E000;
                    word1[23]    <=  24'h01E000;
                    word1[24]    <=  24'h01E000;
                    word1[25]    <=  24'h01E000;
                    word1[26]    <=  24'h01E000;
                    word1[27]    <=  24'h01E000;
                    word1[28]    <=  24'h01E000;
                    word1[29]    <=  24'h03F000;
                    word1[30]    <=  24'h1FFE00;
                    word1[31]    <=  24'h000000;
                    word1[32]    <=  24'h000000;
                    word1[33]    <=  24'h000000;
                    word1[34]    <=  24'h000000;
                    word1[35]    <=  24'h000000;
                    word1[36]    <=  24'h000000;
                    word1[37]    <=  24'h000000;
                    word1[38]    <=  24'h000000;
                    word1[39]    <=  24'h000000;
                    word1[40]    <=  24'h000000;
                    word1[41]    <=  24'h000000;
                    word1[42]    <=  24'h000000;
                    word1[43]    <=  24'h000000;
                    word1[44]    <=  24'h000000;
                    word1[45]    <=  24'h000000;
                    word1[46]    <=  24'h000000;
                    word1[47]    <=  24'h000000;
                end
                    2: begin
                        word1[0]     <=  24'h000000;
                        word1[1]     <=  24'h000000;
                        word1[2]     <=  24'h000000;
                        word1[3]     <=  24'h000000;
                        word1[4]     <=  24'h000000;
                        word1[5]     <=  24'h000000;
                        word1[6]     <=  24'h07F800;
                        word1[7]     <=  24'h0F3C00;
                        word1[8]     <=  24'h1C1E00;
                        word1[9]     <=  24'h380F00;
                        word1[10]    <=  24'h380F00;
                        word1[11]    <=  24'h3C0F00;
                        word1[12]    <=  24'h3C0F00;
                        word1[13]    <=  24'h3C0F00;
                        word1[14]    <=  24'h1C0F00;
                        word1[15]    <=  24'h000E00;
                        word1[16]    <=  24'h001E00;
                        word1[17]    <=  24'h001C00;
                        word1[18]    <=  24'h003800;
                        word1[19]    <=  24'h007000;
                        word1[20]    <=  24'h00E000;
                        word1[21]    <=  24'h01C000;
                        word1[22]    <=  24'h038000;
                        word1[23]    <=  24'h078000;
                        word1[24]    <=  24'h0F0100;
                        word1[25]    <=  24'h1E0300;
                        word1[26]    <=  24'h1C0300;
                        word1[27]    <=  24'h380700;
                        word1[28]    <=  24'h7FFF00;
                        word1[29]    <=  24'h7FFF00;
                        word1[30]    <=  24'h7FFF00;
                        word1[31]    <=  24'h000000;
                        word1[32]    <=  24'h000000;
                        word1[33]    <=  24'h000000;
                        word1[34]    <=  24'h000000;
                        word1[35]    <=  24'h000000;
                        word1[36]    <=  24'h000000;
                        word1[37]    <=  24'h000000;
                        word1[38]    <=  24'h000000;
                        word1[39]    <=  24'h000000;
                        word1[40]    <=  24'h000000;
                        word1[41]    <=  24'h000000;
                        word1[42]    <=  24'h000000;
                        word1[43]    <=  24'h000000;
                        word1[44]    <=  24'h000000;
                        word1[45]    <=  24'h000000;
                        word1[46]    <=  24'h000000;
                        word1[47]    <=  24'h000000;
                    end
                    3: begin
                        word1[0]     <=  24'h000000;
                        word1[1]     <=  24'h000000;
                        word1[2]     <=  24'h000000;
                        word1[3]     <=  24'h000000;
                        word1[4]     <=  24'h000000;
                        word1[5]     <=  24'h000000;
                        word1[6]     <=  24'h07F000;
                        word1[7]     <=  24'h1E7C00;
                        word1[8]     <=  24'h3C1C00;
                        word1[9]     <=  24'h3C1E00;
                        word1[10]    <=  24'h3C0E00;
                        word1[11]    <=  24'h3C0E00;
                        word1[12]    <=  24'h3C0E00;
                        word1[13]    <=  24'h000E00;
                        word1[14]    <=  24'h001E00;
                        word1[15]    <=  24'h003C00;
                        word1[16]    <=  24'h00F800;
                        word1[17]    <=  24'h03F000;
                        word1[18]    <=  24'h007C00;
                        word1[19]    <=  24'h001E00;
                        word1[20]    <=  24'h000E00;
                        word1[21]    <=  24'h000F00;
                        word1[22]    <=  24'h000F00;
                        word1[23]    <=  24'h000F00;
                        word1[24]    <=  24'h3C0F00;
                        word1[25]    <=  24'h3C0F00;
                        word1[26]    <=  24'h7C0F00;
                        word1[27]    <=  24'h3C0F00;
                        word1[28]    <=  24'h3C1E00;
                        word1[29]    <=  24'h1E7C00;
                        word1[30]    <=  24'h0FF800;
                        word1[31]    <=  24'h000000;
                        word1[32]    <=  24'h000000;
                        word1[33]    <=  24'h000000;
                        word1[34]    <=  24'h000000;
                        word1[35]    <=  24'h000000;
                        word1[36]    <=  24'h000000;
                        word1[37]    <=  24'h000000;
                        word1[38]    <=  24'h000000;
                        word1[39]    <=  24'h000000;
                        word1[40]    <=  24'h000000;
                        word1[41]    <=  24'h000000;
                        word1[42]    <=  24'h000000;
                        word1[43]    <=  24'h000000;
                        word1[44]    <=  24'h000000;
                        word1[45]    <=  24'h000000;
                        word1[46]    <=  24'h000000;
                        word1[47]    <=  24'h000000;
                    end
                    4: begin
                        word1[0]     <=  24'h000000;
                        word1[1]     <=  24'h000000;
                        word1[2]     <=  24'h000000;
                        word1[3]     <=  24'h000000;
                        word1[4]     <=  24'h000000;
                        word1[5]     <=  24'h000000;
                        word1[6]     <=  24'h003C00;
                        word1[7]     <=  24'h003C00;
                        word1[8]     <=  24'h007C00;
                        word1[9]     <=  24'h007C00;
                        word1[10]    <=  24'h00FC00;
                        word1[11]    <=  24'h01FC00;
                        word1[12]    <=  24'h01FC00;
                        word1[13]    <=  24'h03BC00;
                        word1[14]    <=  24'h033C00;
                        word1[15]    <=  24'h073C00;
                        word1[16]    <=  24'h0E3C00;
                        word1[17]    <=  24'h0E3C00;
                        word1[18]    <=  24'h1C3C00;
                        word1[19]    <=  24'h183C00;
                        word1[20]    <=  24'h383C00;
                        word1[21]    <=  24'h703C00;
                        word1[22]    <=  24'h703C00;
                        word1[23]    <=  24'hFFFF80;
                        word1[24]    <=  24'h003C00;
                        word1[25]    <=  24'h003C00;
                        word1[26]    <=  24'h003C00;
                        word1[27]    <=  24'h003C00;
                        word1[28]    <=  24'h003C00;
                        word1[29]    <=  24'h007C00;
                        word1[30]    <=  24'h03FF80;
                        word1[31]    <=  24'h000000;
                        word1[32]    <=  24'h000000;
                        word1[33]    <=  24'h000000;
                        word1[34]    <=  24'h000000;
                        word1[35]    <=  24'h000000;
                        word1[36]    <=  24'h000000;
                        word1[37]    <=  24'h000000;
                        word1[38]    <=  24'h000000;
                        word1[39]    <=  24'h000000;
                        word1[40]    <=  24'h000000;
                        word1[41]    <=  24'h000000;
                        word1[42]    <=  24'h000000;
                        word1[43]    <=  24'h000000;
                        word1[44]    <=  24'h000000;
                        word1[45]    <=  24'h000000;
                        word1[46]    <=  24'h000000;
                        word1[47]    <=  24'h000000;
                    end
                    5: begin
                        word1[0]     <= 24'h000000;
                        word1[1]     <= 24'h000000;
                        word1[2]     <= 24'h000000;
                        word1[3]     <= 24'h000000;
                        word1[4]     <= 24'h000000;
                        word1[5]     <= 24'h000000;
                        word1[6]     <= 24'h1FFF00;
                        word1[7]     <= 24'h1FFF00;
                        word1[8]     <= 24'h1FFE00;
                        word1[9]     <= 24'h180000;
                        word1[10]    <= 24'h180000;
                        word1[11]    <= 24'h180000;
                        word1[12]    <= 24'h180000;
                        word1[13]    <= 24'h180000;
                        word1[14]    <= 24'h18E000;
                        word1[15]    <= 24'h1FF800;
                        word1[16]    <= 24'h1FFC00;
                        word1[17]    <= 24'h3C1E00;
                        word1[18]    <= 24'h3C0F00;
                        word1[19]    <= 24'h180F00;
                        word1[20]    <= 24'h000700;
                        word1[21]    <= 24'h000700;
                        word1[22]    <= 24'h000700;
                        word1[23]    <= 24'h180700;
                        word1[24]    <= 24'h3C0700;
                        word1[25]    <= 24'h7C0F00;
                        word1[26]    <= 24'h7C0F00;
                        word1[27]    <= 24'h380E00;
                        word1[28]    <= 24'h381E00;
                        word1[29]    <= 24'h1F3C00;
                        word1[30]    <= 24'h07F800;
                        word1[31]    <= 24'h000000;
                        word1[32]    <= 24'h000000;
                        word1[33]    <= 24'h000000;
                        word1[34]    <= 24'h000000;
                        word1[35]    <= 24'h000000;
                        word1[36]    <= 24'h000000;
                        word1[37]    <= 24'h000000;
                        word1[38]    <= 24'h000000;
                        word1[39]    <= 24'h000000;
                        word1[40]    <= 24'h000000;
                        word1[41]    <= 24'h000000;
                        word1[42]    <= 24'h000000;
                        word1[43]    <= 24'h000000;
                        word1[44]    <= 24'h000000;
                        word1[45]    <= 24'h000000;
                        word1[46]    <= 24'h000000;
                        word1[47]    <= 24'h000000;
                    end
                    6: begin
                        word1[0]     <=  24'h000000;
                        word1[1]     <=  24'h000000;
                        word1[2]     <=  24'h000000;
                        word1[3]     <=  24'h000000;
                        word1[4]     <=  24'h000000;
                        word1[5]     <=  24'h000000;
                        word1[6]     <=  24'h03FC00;
                        word1[7]     <=  24'h079E00;
                        word1[8]     <=  24'h0F1F00;
                        word1[9]     <=  24'h1E1F00;
                        word1[10]    <=  24'h1C0E00;
                        word1[11]    <=  24'h3C0000;
                        word1[12]    <=  24'h3C0000;
                        word1[13]    <=  24'h380000;
                        word1[14]    <=  24'h780000;
                        word1[15]    <=  24'h7BFC00;
                        word1[16]    <=  24'h7FFE00;
                        word1[17]    <=  24'h7F1F00;
                        word1[18]    <=  24'h7C0F00;
                        word1[19]    <=  24'h7C0700;
                        word1[20]    <=  24'h780780;
                        word1[21]    <=  24'h780780;
                        word1[22]    <=  24'h780780;
                        word1[23]    <=  24'h780780;
                        word1[24]    <=  24'h780780;
                        word1[25]    <=  24'h3C0780;
                        word1[26]    <=  24'h3C0700;
                        word1[27]    <=  24'h1E0F00;
                        word1[28]    <=  24'h1E0E00;
                        word1[29]    <=  24'h0FBC00;
                        word1[30]    <=  24'h07F800;
                        word1[31]    <=  24'h000000;
                        word1[32]    <=  24'h000000;
                        word1[33]    <=  24'h000000;
                        word1[34]    <=  24'h000000;
                        word1[35]    <=  24'h000000;
                        word1[36]    <=  24'h000000;
                        word1[37]    <=  24'h000000;
                        word1[38]    <=  24'h000000;
                        word1[39]    <=  24'h000000;
                        word1[40]    <=  24'h000000;
                        word1[41]    <=  24'h000000;
                        word1[42]    <=  24'h000000;
                        word1[43]    <=  24'h000000;
                        word1[44]    <=  24'h000000;
                        word1[45]    <=  24'h000000;
                        word1[46]    <=  24'h000000;
                        word1[47]    <=  24'h000000;
                    end
                    7: begin
                        word1[0]     <=  24'h000000;
                        word1[1]     <=  24'h000000;
                        word1[2]     <=  24'h000000;
                        word1[3]     <=  24'h000000;
                        word1[4]     <=  24'h000000;
                        word1[5]     <=  24'h000000;
                        word1[6]     <=  24'h3FFF80;
                        word1[7]     <=  24'h3FFF00;
                        word1[8]     <=  24'h3FFF00;
                        word1[9]     <=  24'h380E00;
                        word1[10]    <=  24'h300E00;
                        word1[11]    <=  24'h301C00;
                        word1[12]    <=  24'h001C00;
                        word1[13]    <=  24'h003800;
                        word1[14]    <=  24'h003800;
                        word1[15]    <=  24'h007000;
                        word1[16]    <=  24'h007000;
                        word1[17]    <=  24'h00F000;
                        word1[18]    <=  24'h00E000;
                        word1[19]    <=  24'h00E000;
                        word1[20]    <=  24'h01E000;
                        word1[21]    <=  24'h01E000;
                        word1[22]    <=  24'h01C000;
                        word1[23]    <=  24'h03C000;
                        word1[24]    <=  24'h03C000;
                        word1[25]    <=  24'h03C000;
                        word1[26]    <=  24'h03C000;
                        word1[27]    <=  24'h03C000;
                        word1[28]    <=  24'h03C000;
                        word1[29]    <=  24'h03C000;
                        word1[30]    <=  24'h03C000;
                        word1[31]    <=  24'h000000;
                        word1[32]    <=  24'h000000;
                        word1[33]    <=  24'h000000;
                        word1[34]    <=  24'h000000;
                        word1[35]    <=  24'h000000;
                        word1[36]    <=  24'h000000;
                        word1[37]    <=  24'h000000;
                        word1[38]    <=  24'h000000;
                        word1[39]    <=  24'h000000;
                        word1[40]    <=  24'h000000;
                        word1[41]    <=  24'h000000;
                        word1[42]    <=  24'h000000;
                        word1[43]    <=  24'h000000;
                        word1[44]    <=  24'h000000;
                        word1[45]    <=  24'h000000;
                        word1[46]    <=  24'h000000;
                        word1[47]    <=  24'h000000;
                    end
                    8: begin
                        word1[0]     <=  24'h000000;
                        word1[1]     <=  24'h000000;
                        word1[2]     <=  24'h000000;
                        word1[3]     <=  24'h000000;
                        word1[4]     <=  24'h000000;
                        word1[5]     <=  24'h000000;
                        word1[6]     <=  24'h07F800;
                        word1[7]     <=  24'h1F3C00;
                        word1[8]     <=  24'h3C0E00;
                        word1[9]     <=  24'h380F00;
                        word1[10]    <=  24'h380700;
                        word1[11]    <=  24'h780700;
                        word1[12]    <=  24'h780700;
                        word1[13]    <=  24'h3C0700;
                        word1[14]    <=  24'h3E0F00;
                        word1[15]    <=  24'h1F0E00;
                        word1[16]    <=  24'h1FFC00;
                        word1[17]    <=  24'h07F800;
                        word1[18]    <=  24'h0FF800;
                        word1[19]    <=  24'h1CFC00;
                        word1[20]    <=  24'h3C3E00;
                        word1[21]    <=  24'h381F00;
                        word1[22]    <=  24'h780F00;
                        word1[23]    <=  24'h700780;
                        word1[24]    <=  24'h700780;
                        word1[25]    <=  24'h700780;
                        word1[26]    <=  24'h780700;
                        word1[27]    <=  24'h380F00;
                        word1[28]    <=  24'h3C0E00;
                        word1[29]    <=  24'h1F3C00;
                        word1[30]    <=  24'h07F800;
                        word1[31]    <=  24'h000000;
                        word1[32]    <=  24'h000000;
                        word1[33]    <=  24'h000000;
                        word1[34]    <=  24'h000000;
                        word1[35]    <=  24'h000000;
                        word1[36]    <=  24'h000000;
                        word1[37]    <=  24'h000000;
                        word1[38]    <=  24'h000000;
                        word1[39]    <=  24'h000000;
                        word1[40]    <=  24'h000000;
                        word1[41]    <=  24'h000000;
                        word1[42]    <=  24'h000000;
                        word1[43]    <=  24'h000000;
                        word1[44]    <=  24'h000000;
                        word1[45]    <=  24'h000000;
                        word1[46]    <=  24'h000000;
                        word1[47]    <=  24'h000000;
                    end
                    9: begin
                        word1[0]     <=  24'h000000;
                        word1[1]     <=  24'h000000;
                        word1[2]     <=  24'h000000;
                        word1[3]     <=  24'h000000;
                        word1[4]     <=  24'h000000;
                        word1[5]     <=  24'h000000;
                        word1[6]     <=  24'h07F000;
                        word1[7]     <=  24'h1F7C00;
                        word1[8]     <=  24'h3C1E00;
                        word1[9]     <=  24'h380E00;
                        word1[10]    <=  24'h780F00;
                        word1[11]    <=  24'h780F00;
                        word1[12]    <=  24'h780F00;
                        word1[13]    <=  24'h780700;
                        word1[14]    <=  24'h780780;
                        word1[15]    <=  24'h780F80;
                        word1[16]    <=  24'h780F80;
                        word1[17]    <=  24'h781F80;
                        word1[18]    <=  24'h3C1F80;
                        word1[19]    <=  24'h3E7F80;
                        word1[20]    <=  24'h1FFF80;
                        word1[21]    <=  24'h03CF00;
                        word1[22]    <=  24'h000F00;
                        word1[23]    <=  24'h000F00;
                        word1[24]    <=  24'h000F00;
                        word1[25]    <=  24'h001E00;
                        word1[26]    <=  24'h1C1E00;
                        word1[27]    <=  24'h3C1C00;
                        word1[28]    <=  24'h3E3800;
                        word1[29]    <=  24'h1EF800;
                        word1[30]    <=  24'h0FE000;
                        word1[31]    <=  24'h000000;
                        word1[32]    <=  24'h000000;
                        word1[33]    <=  24'h000000;
                        word1[34]    <=  24'h000000;
                        word1[35]    <=  24'h000000;
                        word1[36]    <=  24'h000000;
                        word1[37]    <=  24'h000000;
                        word1[38]    <=  24'h000000;
                        word1[39]    <=  24'h000000;
                        word1[40]    <=  24'h000000;
                        word1[41]    <=  24'h000000;
                        word1[42]    <=  24'h000000;
                        word1[43]    <=  24'h000000;
                        word1[44]    <=  24'h000000;
                        word1[45]    <=  24'h000000;
                        word1[46]    <=  24'h000000;
                        word1[47]    <=  24'h000000;
                    end
                    default: 
                    begin
                        word1[0]     <=  24'h000000;
                        word1[1]     <=  24'h000000;
                        word1[2]     <=  24'h000000;
                        word1[3]     <=  24'h000000;
                        word1[4]     <=  24'h000000;
                        word1[5]     <=  24'h000000;
                        word1[6]     <=  24'h03F000;
                        word1[7]     <=  24'h0FBC00;
                        word1[8]     <=  24'h0E1C00;
                        word1[9]     <=  24'h1E1E00;
                        word1[10]    <=  24'h3C0F00;
                        word1[11]    <=  24'h3C0F00;
                        word1[12]    <=  24'h3C0F00;
                        word1[13]    <=  24'h780F00;
                        word1[14]    <=  24'h780780;
                        word1[15]    <=  24'h780780;
                        word1[16]    <=  24'h780780;
                        word1[17]    <=  24'h780780;
                        word1[18]    <=  24'h780780;
                        word1[19]    <=  24'h780780;
                        word1[20]    <=  24'h780780;
                        word1[21]    <=  24'h780780;
                        word1[22]    <=  24'h780780;
                        word1[23]    <=  24'h780F00;
                        word1[24]    <=  24'h3C0F00;
                        word1[25]    <=  24'h3C0F00;
                        word1[26]    <=  24'h3C0F00;
                        word1[27]    <=  24'h1E1E00;
                        word1[28]    <=  24'h0E1C00;
                        word1[29]    <=  24'h0FF800;
                        word1[30]    <=  24'h03F000;
                        word1[31]    <=  24'h000000;
                        word1[32]    <=  24'h000000;
                        word1[33]    <=  24'h000000;
                        word1[34]    <=  24'h000000;
                        word1[35]    <=  24'h000000;
                        word1[36]    <=  24'h000000;
                        word1[37]    <=  24'h000000;
                        word1[38]    <=  24'h000000;
                        word1[39]    <=  24'h000000;
                        word1[40]    <=  24'h000000;
                        word1[41]    <=  24'h000000;
                        word1[42]    <=  24'h000000;
                        word1[43]    <=  24'h000000;
                        word1[44]    <=  24'h000000;
                        word1[45]    <=  24'h000000;
                        word1[46]    <=  24'h000000;
                        word1[47]    <=  24'h000000;
                    end
                endcase
            end
        end
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
        always @(posedge vga_clk ) begin
            if (freq_freq_rd_en) begin
                case (ten_thousand_temp)
                0: begin
                    word0[0]     <=  24'h000000;
                    word0[1]     <=  24'h000000;
                    word0[2]     <=  24'h000000;
                    word0[3]     <=  24'h000000;
                    word0[4]     <=  24'h000000;
                    word0[5]     <=  24'h000000;
                    word0[6]     <=  24'h03F000;
                    word0[7]     <=  24'h0FBC00;
                    word0[8]     <=  24'h0E1C00;
                    word0[9]     <=  24'h1E1E00;
                    word0[10]    <=  24'h3C0F00;
                    word0[11]    <=  24'h3C0F00;
                    word0[12]    <=  24'h3C0F00;
                    word0[13]    <=  24'h780F00;
                    word0[14]    <=  24'h780780;
                    word0[15]    <=  24'h780780;
                    word0[16]    <=  24'h780780;
                    word0[17]    <=  24'h780780;
                    word0[18]    <=  24'h780780;
                    word0[19]    <=  24'h780780;
                    word0[20]    <=  24'h780780;
                    word0[21]    <=  24'h780780;
                    word0[22]    <=  24'h780780;
                    word0[23]    <=  24'h780F00;
                    word0[24]    <=  24'h3C0F00;
                    word0[25]    <=  24'h3C0F00;
                    word0[26]    <=  24'h3C0F00;
                    word0[27]    <=  24'h1E1E00;
                    word0[28]    <=  24'h0E1C00;
                    word0[29]    <=  24'h0FF800;
                    word0[30]    <=  24'h03F000;
                    word0[31]    <=  24'h000000;
                    word0[32]    <=  24'h000000;
                    word0[33]    <=  24'h000000;
                    word0[34]    <=  24'h000000;
                    word0[35]    <=  24'h000000;
                    word0[36]    <=  24'h000000;
                    word0[37]    <=  24'h000000;
                    word0[38]    <=  24'h000000;
                    word0[39]    <=  24'h000000;
                    word0[40]    <=  24'h000000;
                    word0[41]    <=  24'h000000;
                    word0[42]    <=  24'h000000;
                    word0[43]    <=  24'h000000;
                    word0[44]    <=  24'h000000;
                    word0[45]    <=  24'h000000;
                    word0[46]    <=  24'h000000;
                    word0[47]    <=  24'h000000;
                end
                1: begin
                    word0[0]     <=  24'h000000;
                    word0[1]     <=  24'h000000;
                    word0[2]     <=  24'h000000;
                    word0[3]     <=  24'h000000;
                    word0[4]     <=  24'h000000;
                    word0[5]     <=  24'h000000;
                    word0[6]     <=  24'h006000;
                    word0[7]     <=  24'h01E000;
                    word0[8]     <=  24'h1FE000;
                    word0[9]     <=  24'h0FE000;
                    word0[10]    <=  24'h01E000;
                    word0[11]    <=  24'h01E000;
                    word0[12]    <=  24'h01E000;
                    word0[13]    <=  24'h01E000;
                    word0[14]    <=  24'h01E000;
                    word0[15]    <=  24'h01E000;
                    word0[16]    <=  24'h01E000;
                    word0[17]    <=  24'h01E000;
                    word0[18]    <=  24'h01E000;
                    word0[19]    <=  24'h01E000;
                    word0[20]    <=  24'h01E000;
                    word0[21]    <=  24'h01E000;
                    word0[22]    <=  24'h01E000;
                    word0[23]    <=  24'h01E000;
                    word0[24]    <=  24'h01E000;
                    word0[25]    <=  24'h01E000;
                    word0[26]    <=  24'h01E000;
                    word0[27]    <=  24'h01E000;
                    word0[28]    <=  24'h01E000;
                    word0[29]    <=  24'h03F000;
                    word0[30]    <=  24'h1FFE00;
                    word0[31]    <=  24'h000000;
                    word0[32]    <=  24'h000000;
                    word0[33]    <=  24'h000000;
                    word0[34]    <=  24'h000000;
                    word0[35]    <=  24'h000000;
                    word0[36]    <=  24'h000000;
                    word0[37]    <=  24'h000000;
                    word0[38]    <=  24'h000000;
                    word0[39]    <=  24'h000000;
                    word0[40]    <=  24'h000000;
                    word0[41]    <=  24'h000000;
                    word0[42]    <=  24'h000000;
                    word0[43]    <=  24'h000000;
                    word0[44]    <=  24'h000000;
                    word0[45]    <=  24'h000000;
                    word0[46]    <=  24'h000000;
                    word0[47]    <=  24'h000000;
                end
                    2: begin
                        word0[0]     <=  24'h000000;
                        word0[1]     <=  24'h000000;
                        word0[2]     <=  24'h000000;
                        word0[3]     <=  24'h000000;
                        word0[4]     <=  24'h000000;
                        word0[5]     <=  24'h000000;
                        word0[6]     <=  24'h07F800;
                        word0[7]     <=  24'h0F3C00;
                        word0[8]     <=  24'h1C1E00;
                        word0[9]     <=  24'h380F00;
                        word0[10]    <=  24'h380F00;
                        word0[11]    <=  24'h3C0F00;
                        word0[12]    <=  24'h3C0F00;
                        word0[13]    <=  24'h3C0F00;
                        word0[14]    <=  24'h1C0F00;
                        word0[15]    <=  24'h000E00;
                        word0[16]    <=  24'h001E00;
                        word0[17]    <=  24'h001C00;
                        word0[18]    <=  24'h003800;
                        word0[19]    <=  24'h007000;
                        word0[20]    <=  24'h00E000;
                        word0[21]    <=  24'h01C000;
                        word0[22]    <=  24'h038000;
                        word0[23]    <=  24'h078000;
                        word0[24]    <=  24'h0F0100;
                        word0[25]    <=  24'h1E0300;
                        word0[26]    <=  24'h1C0300;
                        word0[27]    <=  24'h380700;
                        word0[28]    <=  24'h7FFF00;
                        word0[29]    <=  24'h7FFF00;
                        word0[30]    <=  24'h7FFF00;
                        word0[31]    <=  24'h000000;
                        word0[32]    <=  24'h000000;
                        word0[33]    <=  24'h000000;
                        word0[34]    <=  24'h000000;
                        word0[35]    <=  24'h000000;
                        word0[36]    <=  24'h000000;
                        word0[37]    <=  24'h000000;
                        word0[38]    <=  24'h000000;
                        word0[39]    <=  24'h000000;
                        word0[40]    <=  24'h000000;
                        word0[41]    <=  24'h000000;
                        word0[42]    <=  24'h000000;
                        word0[43]    <=  24'h000000;
                        word0[44]    <=  24'h000000;
                        word0[45]    <=  24'h000000;
                        word0[46]    <=  24'h000000;
                        word0[47]    <=  24'h000000;
                    end
                    3: begin
                        word0[0]     <=  24'h000000;
                        word0[1]     <=  24'h000000;
                        word0[2]     <=  24'h000000;
                        word0[3]     <=  24'h000000;
                        word0[4]     <=  24'h000000;
                        word0[5]     <=  24'h000000;
                        word0[6]     <=  24'h07F000;
                        word0[7]     <=  24'h1E7C00;
                        word0[8]     <=  24'h3C1C00;
                        word0[9]     <=  24'h3C1E00;
                        word0[10]    <=  24'h3C0E00;
                        word0[11]    <=  24'h3C0E00;
                        word0[12]    <=  24'h3C0E00;
                        word0[13]    <=  24'h000E00;
                        word0[14]    <=  24'h001E00;
                        word0[15]    <=  24'h003C00;
                        word0[16]    <=  24'h00F800;
                        word0[17]    <=  24'h03F000;
                        word0[18]    <=  24'h007C00;
                        word0[19]    <=  24'h001E00;
                        word0[20]    <=  24'h000E00;
                        word0[21]    <=  24'h000F00;
                        word0[22]    <=  24'h000F00;
                        word0[23]    <=  24'h000F00;
                        word0[24]    <=  24'h3C0F00;
                        word0[25]    <=  24'h3C0F00;
                        word0[26]    <=  24'h7C0F00;
                        word0[27]    <=  24'h3C0F00;
                        word0[28]    <=  24'h3C1E00;
                        word0[29]    <=  24'h1E7C00;
                        word0[30]    <=  24'h0FF800;
                        word0[31]    <=  24'h000000;
                        word0[32]    <=  24'h000000;
                        word0[33]    <=  24'h000000;
                        word0[34]    <=  24'h000000;
                        word0[35]    <=  24'h000000;
                        word0[36]    <=  24'h000000;
                        word0[37]    <=  24'h000000;
                        word0[38]    <=  24'h000000;
                        word0[39]    <=  24'h000000;
                        word0[40]    <=  24'h000000;
                        word0[41]    <=  24'h000000;
                        word0[42]    <=  24'h000000;
                        word0[43]    <=  24'h000000;
                        word0[44]    <=  24'h000000;
                        word0[45]    <=  24'h000000;
                        word0[46]    <=  24'h000000;
                        word0[47]    <=  24'h000000;
                    end
                    4: begin
                        word0[0]     <=  24'h000000;
                        word0[1]     <=  24'h000000;
                        word0[2]     <=  24'h000000;
                        word0[3]     <=  24'h000000;
                        word0[4]     <=  24'h000000;
                        word0[5]     <=  24'h000000;
                        word0[6]     <=  24'h003C00;
                        word0[7]     <=  24'h003C00;
                        word0[8]     <=  24'h007C00;
                        word0[9]     <=  24'h007C00;
                        word0[10]    <=  24'h00FC00;
                        word0[11]    <=  24'h01FC00;
                        word0[12]    <=  24'h01FC00;
                        word0[13]    <=  24'h03BC00;
                        word0[14]    <=  24'h033C00;
                        word0[15]    <=  24'h073C00;
                        word0[16]    <=  24'h0E3C00;
                        word0[17]    <=  24'h0E3C00;
                        word0[18]    <=  24'h1C3C00;
                        word0[19]    <=  24'h183C00;
                        word0[20]    <=  24'h383C00;
                        word0[21]    <=  24'h703C00;
                        word0[22]    <=  24'h703C00;
                        word0[23]    <=  24'hFFFF80;
                        word0[24]    <=  24'h003C00;
                        word0[25]    <=  24'h003C00;
                        word0[26]    <=  24'h003C00;
                        word0[27]    <=  24'h003C00;
                        word0[28]    <=  24'h003C00;
                        word0[29]    <=  24'h007C00;
                        word0[30]    <=  24'h03FF80;
                        word0[31]    <=  24'h000000;
                        word0[32]    <=  24'h000000;
                        word0[33]    <=  24'h000000;
                        word0[34]    <=  24'h000000;
                        word0[35]    <=  24'h000000;
                        word0[36]    <=  24'h000000;
                        word0[37]    <=  24'h000000;
                        word0[38]    <=  24'h000000;
                        word0[39]    <=  24'h000000;
                        word0[40]    <=  24'h000000;
                        word0[41]    <=  24'h000000;
                        word0[42]    <=  24'h000000;
                        word0[43]    <=  24'h000000;
                        word0[44]    <=  24'h000000;
                        word0[45]    <=  24'h000000;
                        word0[46]    <=  24'h000000;
                        word0[47]    <=  24'h000000;
                    end
                    5: begin
                        word0[0]     <= 24'h000000;
                        word0[1]     <= 24'h000000;
                        word0[2]     <= 24'h000000;
                        word0[3]     <= 24'h000000;
                        word0[4]     <= 24'h000000;
                        word0[5]     <= 24'h000000;
                        word0[6]     <= 24'h1FFF00;
                        word0[7]     <= 24'h1FFF00;
                        word0[8]     <= 24'h1FFE00;
                        word0[9]     <= 24'h180000;
                        word0[10]    <= 24'h180000;
                        word0[11]    <= 24'h180000;
                        word0[12]    <= 24'h180000;
                        word0[13]    <= 24'h180000;
                        word0[14]    <= 24'h18E000;
                        word0[15]    <= 24'h1FF800;
                        word0[16]    <= 24'h1FFC00;
                        word0[17]    <= 24'h3C1E00;
                        word0[18]    <= 24'h3C0F00;
                        word0[19]    <= 24'h180F00;
                        word0[20]    <= 24'h000700;
                        word0[21]    <= 24'h000700;
                        word0[22]    <= 24'h000700;
                        word0[23]    <= 24'h180700;
                        word0[24]    <= 24'h3C0700;
                        word0[25]    <= 24'h7C0F00;
                        word0[26]    <= 24'h7C0F00;
                        word0[27]    <= 24'h380E00;
                        word0[28]    <= 24'h381E00;
                        word0[29]    <= 24'h1F3C00;
                        word0[30]    <= 24'h07F800;
                        word0[31]    <= 24'h000000;
                        word0[32]    <= 24'h000000;
                        word0[33]    <= 24'h000000;
                        word0[34]    <= 24'h000000;
                        word0[35]    <= 24'h000000;
                        word0[36]    <= 24'h000000;
                        word0[37]    <= 24'h000000;
                        word0[38]    <= 24'h000000;
                        word0[39]    <= 24'h000000;
                        word0[40]    <= 24'h000000;
                        word0[41]    <= 24'h000000;
                        word0[42]    <= 24'h000000;
                        word0[43]    <= 24'h000000;
                        word0[44]    <= 24'h000000;
                        word0[45]    <= 24'h000000;
                        word0[46]    <= 24'h000000;
                        word0[47]    <= 24'h000000;
                    end
                    6: begin
                        word0[0]     <=  24'h000000;
                        word0[1]     <=  24'h000000;
                        word0[2]     <=  24'h000000;
                        word0[3]     <=  24'h000000;
                        word0[4]     <=  24'h000000;
                        word0[5]     <=  24'h000000;
                        word0[6]     <=  24'h03FC00;
                        word0[7]     <=  24'h079E00;
                        word0[8]     <=  24'h0F1F00;
                        word0[9]     <=  24'h1E1F00;
                        word0[10]    <=  24'h1C0E00;
                        word0[11]    <=  24'h3C0000;
                        word0[12]    <=  24'h3C0000;
                        word0[13]    <=  24'h380000;
                        word0[14]    <=  24'h780000;
                        word0[15]    <=  24'h7BFC00;
                        word0[16]    <=  24'h7FFE00;
                        word0[17]    <=  24'h7F1F00;
                        word0[18]    <=  24'h7C0F00;
                        word0[19]    <=  24'h7C0700;
                        word0[20]    <=  24'h780780;
                        word0[21]    <=  24'h780780;
                        word0[22]    <=  24'h780780;
                        word0[23]    <=  24'h780780;
                        word0[24]    <=  24'h780780;
                        word0[25]    <=  24'h3C0780;
                        word0[26]    <=  24'h3C0700;
                        word0[27]    <=  24'h1E0F00;
                        word0[28]    <=  24'h1E0E00;
                        word0[29]    <=  24'h0FBC00;
                        word0[30]    <=  24'h07F800;
                        word0[31]    <=  24'h000000;
                        word0[32]    <=  24'h000000;
                        word0[33]    <=  24'h000000;
                        word0[34]    <=  24'h000000;
                        word0[35]    <=  24'h000000;
                        word0[36]    <=  24'h000000;
                        word0[37]    <=  24'h000000;
                        word0[38]    <=  24'h000000;
                        word0[39]    <=  24'h000000;
                        word0[40]    <=  24'h000000;
                        word0[41]    <=  24'h000000;
                        word0[42]    <=  24'h000000;
                        word0[43]    <=  24'h000000;
                        word0[44]    <=  24'h000000;
                        word0[45]    <=  24'h000000;
                        word0[46]    <=  24'h000000;
                        word0[47]    <=  24'h000000;
                    end
                    7: begin
                        word0[0]     <=  24'h000000;
                        word0[1]     <=  24'h000000;
                        word0[2]     <=  24'h000000;
                        word0[3]     <=  24'h000000;
                        word0[4]     <=  24'h000000;
                        word0[5]     <=  24'h000000;
                        word0[6]     <=  24'h3FFF80;
                        word0[7]     <=  24'h3FFF00;
                        word0[8]     <=  24'h3FFF00;
                        word0[9]     <=  24'h380E00;
                        word0[10]    <=  24'h300E00;
                        word0[11]    <=  24'h301C00;
                        word0[12]    <=  24'h001C00;
                        word0[13]    <=  24'h003800;
                        word0[14]    <=  24'h003800;
                        word0[15]    <=  24'h007000;
                        word0[16]    <=  24'h007000;
                        word0[17]    <=  24'h00F000;
                        word0[18]    <=  24'h00E000;
                        word0[19]    <=  24'h00E000;
                        word0[20]    <=  24'h01E000;
                        word0[21]    <=  24'h01E000;
                        word0[22]    <=  24'h01C000;
                        word0[23]    <=  24'h03C000;
                        word0[24]    <=  24'h03C000;
                        word0[25]    <=  24'h03C000;
                        word0[26]    <=  24'h03C000;
                        word0[27]    <=  24'h03C000;
                        word0[28]    <=  24'h03C000;
                        word0[29]    <=  24'h03C000;
                        word0[30]    <=  24'h03C000;
                        word0[31]    <=  24'h000000;
                        word0[32]    <=  24'h000000;
                        word0[33]    <=  24'h000000;
                        word0[34]    <=  24'h000000;
                        word0[35]    <=  24'h000000;
                        word0[36]    <=  24'h000000;
                        word0[37]    <=  24'h000000;
                        word0[38]    <=  24'h000000;
                        word0[39]    <=  24'h000000;
                        word0[40]    <=  24'h000000;
                        word0[41]    <=  24'h000000;
                        word0[42]    <=  24'h000000;
                        word0[43]    <=  24'h000000;
                        word0[44]    <=  24'h000000;
                        word0[45]    <=  24'h000000;
                        word0[46]    <=  24'h000000;
                        word0[47]    <=  24'h000000;
                    end
                    8: begin
                        word0[0]     <=  24'h000000;
                        word0[1]     <=  24'h000000;
                        word0[2]     <=  24'h000000;
                        word0[3]     <=  24'h000000;
                        word0[4]     <=  24'h000000;
                        word0[5]     <=  24'h000000;
                        word0[6]     <=  24'h07F800;
                        word0[7]     <=  24'h1F3C00;
                        word0[8]     <=  24'h3C0E00;
                        word0[9]     <=  24'h380F00;
                        word0[10]    <=  24'h380700;
                        word0[11]    <=  24'h780700;
                        word0[12]    <=  24'h780700;
                        word0[13]    <=  24'h3C0700;
                        word0[14]    <=  24'h3E0F00;
                        word0[15]    <=  24'h1F0E00;
                        word0[16]    <=  24'h1FFC00;
                        word0[17]    <=  24'h07F800;
                        word0[18]    <=  24'h0FF800;
                        word0[19]    <=  24'h1CFC00;
                        word0[20]    <=  24'h3C3E00;
                        word0[21]    <=  24'h381F00;
                        word0[22]    <=  24'h780F00;
                        word0[23]    <=  24'h700780;
                        word0[24]    <=  24'h700780;
                        word0[25]    <=  24'h700780;
                        word0[26]    <=  24'h780700;
                        word0[27]    <=  24'h380F00;
                        word0[28]    <=  24'h3C0E00;
                        word0[29]    <=  24'h1F3C00;
                        word0[30]    <=  24'h07F800;
                        word0[31]    <=  24'h000000;
                        word0[32]    <=  24'h000000;
                        word0[33]    <=  24'h000000;
                        word0[34]    <=  24'h000000;
                        word0[35]    <=  24'h000000;
                        word0[36]    <=  24'h000000;
                        word0[37]    <=  24'h000000;
                        word0[38]    <=  24'h000000;
                        word0[39]    <=  24'h000000;
                        word0[40]    <=  24'h000000;
                        word0[41]    <=  24'h000000;
                        word0[42]    <=  24'h000000;
                        word0[43]    <=  24'h000000;
                        word0[44]    <=  24'h000000;
                        word0[45]    <=  24'h000000;
                        word0[46]    <=  24'h000000;
                        word0[47]    <=  24'h000000;
                    end
                    9: begin
                        word0[0]     <=  24'h000000;
                        word0[1]     <=  24'h000000;
                        word0[2]     <=  24'h000000;
                        word0[3]     <=  24'h000000;
                        word0[4]     <=  24'h000000;
                        word0[5]     <=  24'h000000;
                        word0[6]     <=  24'h07F000;
                        word0[7]     <=  24'h1F7C00;
                        word0[8]     <=  24'h3C1E00;
                        word0[9]     <=  24'h380E00;
                        word0[10]    <=  24'h780F00;
                        word0[11]    <=  24'h780F00;
                        word0[12]    <=  24'h780F00;
                        word0[13]    <=  24'h780700;
                        word0[14]    <=  24'h780780;
                        word0[15]    <=  24'h780F80;
                        word0[16]    <=  24'h780F80;
                        word0[17]    <=  24'h781F80;
                        word0[18]    <=  24'h3C1F80;
                        word0[19]    <=  24'h3E7F80;
                        word0[20]    <=  24'h1FFF80;
                        word0[21]    <=  24'h03CF00;
                        word0[22]    <=  24'h000F00;
                        word0[23]    <=  24'h000F00;
                        word0[24]    <=  24'h000F00;
                        word0[25]    <=  24'h001E00;
                        word0[26]    <=  24'h1C1E00;
                        word0[27]    <=  24'h3C1C00;
                        word0[28]    <=  24'h3E3800;
                        word0[29]    <=  24'h1EF800;
                        word0[30]    <=  24'h0FE000;
                        word0[31]    <=  24'h000000;
                        word0[32]    <=  24'h000000;
                        word0[33]    <=  24'h000000;
                        word0[34]    <=  24'h000000;
                        word0[35]    <=  24'h000000;
                        word0[36]    <=  24'h000000;
                        word0[37]    <=  24'h000000;
                        word0[38]    <=  24'h000000;
                        word0[39]    <=  24'h000000;
                        word0[40]    <=  24'h000000;
                        word0[41]    <=  24'h000000;
                        word0[42]    <=  24'h000000;
                        word0[43]    <=  24'h000000;
                        word0[44]    <=  24'h000000;
                        word0[45]    <=  24'h000000;
                        word0[46]    <=  24'h000000;
                        word0[47]    <=  24'h000000;
                    end
                    default: 
                    begin
                        word0[0]     <=  24'h000000;
                        word0[1]     <=  24'h000000;
                        word0[2]     <=  24'h000000;
                        word0[3]     <=  24'h000000;
                        word0[4]     <=  24'h000000;
                        word0[5]     <=  24'h000000;
                        word0[6]     <=  24'h03F000;
                        word0[7]     <=  24'h0FBC00;
                        word0[8]     <=  24'h0E1C00;
                        word0[9]     <=  24'h1E1E00;
                        word0[10]    <=  24'h3C0F00;
                        word0[11]    <=  24'h3C0F00;
                        word0[12]    <=  24'h3C0F00;
                        word0[13]    <=  24'h780F00;
                        word0[14]    <=  24'h780780;
                        word0[15]    <=  24'h780780;
                        word0[16]    <=  24'h780780;
                        word0[17]    <=  24'h780780;
                        word0[18]    <=  24'h780780;
                        word0[19]    <=  24'h780780;
                        word0[20]    <=  24'h780780;
                        word0[21]    <=  24'h780780;
                        word0[22]    <=  24'h780780;
                        word0[23]    <=  24'h780F00;
                        word0[24]    <=  24'h3C0F00;
                        word0[25]    <=  24'h3C0F00;
                        word0[26]    <=  24'h3C0F00;
                        word0[27]    <=  24'h1E1E00;
                        word0[28]    <=  24'h0E1C00;
                        word0[29]    <=  24'h0FF800;
                        word0[30]    <=  24'h03F000;
                        word0[31]    <=  24'h000000;
                        word0[32]    <=  24'h000000;
                        word0[33]    <=  24'h000000;
                        word0[34]    <=  24'h000000;
                        word0[35]    <=  24'h000000;
                        word0[36]    <=  24'h000000;
                        word0[37]    <=  24'h000000;
                        word0[38]    <=  24'h000000;
                        word0[39]    <=  24'h000000;
                        word0[40]    <=  24'h000000;
                        word0[41]    <=  24'h000000;
                        word0[42]    <=  24'h000000;
                        word0[43]    <=  24'h000000;
                        word0[44]    <=  24'h000000;
                        word0[45]    <=  24'h000000;
                        word0[46]    <=  24'h000000;
                        word0[47]    <=  24'h000000;
                    end
                endcase
            end
        end
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
        always @(posedge vga_clk ) begin
            if (freq_freq_rd_en) begin
                case (hundred_temp)
                0: begin
                    word2[0]     <=  24'h000000;
                    word2[1]     <=  24'h000000;
                    word2[2]     <=  24'h000000;
                    word2[3]     <=  24'h000000;
                    word2[4]     <=  24'h000000;
                    word2[5]     <=  24'h000000;
                    word2[6]     <=  24'h03F000;
                    word2[7]     <=  24'h0FBC00;
                    word2[8]     <=  24'h0E1C00;
                    word2[9]     <=  24'h1E1E00;
                    word2[10]    <=  24'h3C0F00;
                    word2[11]    <=  24'h3C0F00;
                    word2[12]    <=  24'h3C0F00;
                    word2[13]    <=  24'h780F00;
                    word2[14]    <=  24'h780780;
                    word2[15]    <=  24'h780780;
                    word2[16]    <=  24'h780780;
                    word2[17]    <=  24'h780780;
                    word2[18]    <=  24'h780780;
                    word2[19]    <=  24'h780780;
                    word2[20]    <=  24'h780780;
                    word2[21]    <=  24'h780780;
                    word2[22]    <=  24'h780780;
                    word2[23]    <=  24'h780F00;
                    word2[24]    <=  24'h3C0F00;
                    word2[25]    <=  24'h3C0F00;
                    word2[26]    <=  24'h3C0F00;
                    word2[27]    <=  24'h1E1E00;
                    word2[28]    <=  24'h0E1C00;
                    word2[29]    <=  24'h0FF800;
                    word2[30]    <=  24'h03F000;
                    word2[31]    <=  24'h000000;
                    word2[32]    <=  24'h000000;
                    word2[33]    <=  24'h000000;
                    word2[34]    <=  24'h000000;
                    word2[35]    <=  24'h000000;
                    word2[36]    <=  24'h000000;
                    word2[37]    <=  24'h000000;
                    word2[38]    <=  24'h000000;
                    word2[39]    <=  24'h000000;
                    word2[40]    <=  24'h000000;
                    word2[41]    <=  24'h000000;
                    word2[42]    <=  24'h000000;
                    word2[43]    <=  24'h000000;
                    word2[44]    <=  24'h000000;
                    word2[45]    <=  24'h000000;
                    word2[46]    <=  24'h000000;
                    word2[47]    <=  24'h000000;
                end
                1: begin
                    word2[0]     <=  24'h000000;
                    word2[1]     <=  24'h000000;
                    word2[2]     <=  24'h000000;
                    word2[3]     <=  24'h000000;
                    word2[4]     <=  24'h000000;
                    word2[5]     <=  24'h000000;
                    word2[6]     <=  24'h006000;
                    word2[7]     <=  24'h01E000;
                    word2[8]     <=  24'h1FE000;
                    word2[9]     <=  24'h0FE000;
                    word2[10]    <=  24'h01E000;
                    word2[11]    <=  24'h01E000;
                    word2[12]    <=  24'h01E000;
                    word2[13]    <=  24'h01E000;
                    word2[14]    <=  24'h01E000;
                    word2[15]    <=  24'h01E000;
                    word2[16]    <=  24'h01E000;
                    word2[17]    <=  24'h01E000;
                    word2[18]    <=  24'h01E000;
                    word2[19]    <=  24'h01E000;
                    word2[20]    <=  24'h01E000;
                    word2[21]    <=  24'h01E000;
                    word2[22]    <=  24'h01E000;
                    word2[23]    <=  24'h01E000;
                    word2[24]    <=  24'h01E000;
                    word2[25]    <=  24'h01E000;
                    word2[26]    <=  24'h01E000;
                    word2[27]    <=  24'h01E000;
                    word2[28]    <=  24'h01E000;
                    word2[29]    <=  24'h03F000;
                    word2[30]    <=  24'h1FFE00;
                    word2[31]    <=  24'h000000;
                    word2[32]    <=  24'h000000;
                    word2[33]    <=  24'h000000;
                    word2[34]    <=  24'h000000;
                    word2[35]    <=  24'h000000;
                    word2[36]    <=  24'h000000;
                    word2[37]    <=  24'h000000;
                    word2[38]    <=  24'h000000;
                    word2[39]    <=  24'h000000;
                    word2[40]    <=  24'h000000;
                    word2[41]    <=  24'h000000;
                    word2[42]    <=  24'h000000;
                    word2[43]    <=  24'h000000;
                    word2[44]    <=  24'h000000;
                    word2[45]    <=  24'h000000;
                    word2[46]    <=  24'h000000;
                    word2[47]    <=  24'h000000;
                end
                    2: begin
                        word2[0]     <=  24'h000000;
                        word2[1]     <=  24'h000000;
                        word2[2]     <=  24'h000000;
                        word2[3]     <=  24'h000000;
                        word2[4]     <=  24'h000000;
                        word2[5]     <=  24'h000000;
                        word2[6]     <=  24'h07F800;
                        word2[7]     <=  24'h0F3C00;
                        word2[8]     <=  24'h1C1E00;
                        word2[9]     <=  24'h380F00;
                        word2[10]    <=  24'h380F00;
                        word2[11]    <=  24'h3C0F00;
                        word2[12]    <=  24'h3C0F00;
                        word2[13]    <=  24'h3C0F00;
                        word2[14]    <=  24'h1C0F00;
                        word2[15]    <=  24'h000E00;
                        word2[16]    <=  24'h001E00;
                        word2[17]    <=  24'h001C00;
                        word2[18]    <=  24'h003800;
                        word2[19]    <=  24'h007000;
                        word2[20]    <=  24'h00E000;
                        word2[21]    <=  24'h01C000;
                        word2[22]    <=  24'h038000;
                        word2[23]    <=  24'h078000;
                        word2[24]    <=  24'h0F0100;
                        word2[25]    <=  24'h1E0300;
                        word2[26]    <=  24'h1C0300;
                        word2[27]    <=  24'h380700;
                        word2[28]    <=  24'h7FFF00;
                        word2[29]    <=  24'h7FFF00;
                        word2[30]    <=  24'h7FFF00;
                        word2[31]    <=  24'h000000;
                        word2[32]    <=  24'h000000;
                        word2[33]    <=  24'h000000;
                        word2[34]    <=  24'h000000;
                        word2[35]    <=  24'h000000;
                        word2[36]    <=  24'h000000;
                        word2[37]    <=  24'h000000;
                        word2[38]    <=  24'h000000;
                        word2[39]    <=  24'h000000;
                        word2[40]    <=  24'h000000;
                        word2[41]    <=  24'h000000;
                        word2[42]    <=  24'h000000;
                        word2[43]    <=  24'h000000;
                        word2[44]    <=  24'h000000;
                        word2[45]    <=  24'h000000;
                        word2[46]    <=  24'h000000;
                        word2[47]    <=  24'h000000;
                    end
                    3: begin
                        word2[0]     <=  24'h000000;
                        word2[1]     <=  24'h000000;
                        word2[2]     <=  24'h000000;
                        word2[3]     <=  24'h000000;
                        word2[4]     <=  24'h000000;
                        word2[5]     <=  24'h000000;
                        word2[6]     <=  24'h07F000;
                        word2[7]     <=  24'h1E7C00;
                        word2[8]     <=  24'h3C1C00;
                        word2[9]     <=  24'h3C1E00;
                        word2[10]    <=  24'h3C0E00;
                        word2[11]    <=  24'h3C0E00;
                        word2[12]    <=  24'h3C0E00;
                        word2[13]    <=  24'h000E00;
                        word2[14]    <=  24'h001E00;
                        word2[15]    <=  24'h003C00;
                        word2[16]    <=  24'h00F800;
                        word2[17]    <=  24'h03F000;
                        word2[18]    <=  24'h007C00;
                        word2[19]    <=  24'h001E00;
                        word2[20]    <=  24'h000E00;
                        word2[21]    <=  24'h000F00;
                        word2[22]    <=  24'h000F00;
                        word2[23]    <=  24'h000F00;
                        word2[24]    <=  24'h3C0F00;
                        word2[25]    <=  24'h3C0F00;
                        word2[26]    <=  24'h7C0F00;
                        word2[27]    <=  24'h3C0F00;
                        word2[28]    <=  24'h3C1E00;
                        word2[29]    <=  24'h1E7C00;
                        word2[30]    <=  24'h0FF800;
                        word2[31]    <=  24'h000000;
                        word2[32]    <=  24'h000000;
                        word2[33]    <=  24'h000000;
                        word2[34]    <=  24'h000000;
                        word2[35]    <=  24'h000000;
                        word2[36]    <=  24'h000000;
                        word2[37]    <=  24'h000000;
                        word2[38]    <=  24'h000000;
                        word2[39]    <=  24'h000000;
                        word2[40]    <=  24'h000000;
                        word2[41]    <=  24'h000000;
                        word2[42]    <=  24'h000000;
                        word2[43]    <=  24'h000000;
                        word2[44]    <=  24'h000000;
                        word2[45]    <=  24'h000000;
                        word2[46]    <=  24'h000000;
                        word2[47]    <=  24'h000000;
                    end
                    4: begin
                        word2[0]     <=  24'h000000;
                        word2[1]     <=  24'h000000;
                        word2[2]     <=  24'h000000;
                        word2[3]     <=  24'h000000;
                        word2[4]     <=  24'h000000;
                        word2[5]     <=  24'h000000;
                        word2[6]     <=  24'h003C00;
                        word2[7]     <=  24'h003C00;
                        word2[8]     <=  24'h007C00;
                        word2[9]     <=  24'h007C00;
                        word2[10]    <=  24'h00FC00;
                        word2[11]    <=  24'h01FC00;
                        word2[12]    <=  24'h01FC00;
                        word2[13]    <=  24'h03BC00;
                        word2[14]    <=  24'h033C00;
                        word2[15]    <=  24'h073C00;
                        word2[16]    <=  24'h0E3C00;
                        word2[17]    <=  24'h0E3C00;
                        word2[18]    <=  24'h1C3C00;
                        word2[19]    <=  24'h183C00;
                        word2[20]    <=  24'h383C00;
                        word2[21]    <=  24'h703C00;
                        word2[22]    <=  24'h703C00;
                        word2[23]    <=  24'hFFFF80;
                        word2[24]    <=  24'h003C00;
                        word2[25]    <=  24'h003C00;
                        word2[26]    <=  24'h003C00;
                        word2[27]    <=  24'h003C00;
                        word2[28]    <=  24'h003C00;
                        word2[29]    <=  24'h007C00;
                        word2[30]    <=  24'h03FF80;
                        word2[31]    <=  24'h000000;
                        word2[32]    <=  24'h000000;
                        word2[33]    <=  24'h000000;
                        word2[34]    <=  24'h000000;
                        word2[35]    <=  24'h000000;
                        word2[36]    <=  24'h000000;
                        word2[37]    <=  24'h000000;
                        word2[38]    <=  24'h000000;
                        word2[39]    <=  24'h000000;
                        word2[40]    <=  24'h000000;
                        word2[41]    <=  24'h000000;
                        word2[42]    <=  24'h000000;
                        word2[43]    <=  24'h000000;
                        word2[44]    <=  24'h000000;
                        word2[45]    <=  24'h000000;
                        word2[46]    <=  24'h000000;
                        word2[47]    <=  24'h000000;
                    end
                    5: begin
                        word2[0]     <= 24'h000000;
                        word2[1]     <= 24'h000000;
                        word2[2]     <= 24'h000000;
                        word2[3]     <= 24'h000000;
                        word2[4]     <= 24'h000000;
                        word2[5]     <= 24'h000000;
                        word2[6]     <= 24'h1FFF00;
                        word2[7]     <= 24'h1FFF00;
                        word2[8]     <= 24'h1FFE00;
                        word2[9]     <= 24'h180000;
                        word2[10]    <= 24'h180000;
                        word2[11]    <= 24'h180000;
                        word2[12]    <= 24'h180000;
                        word2[13]    <= 24'h180000;
                        word2[14]    <= 24'h18E000;
                        word2[15]    <= 24'h1FF800;
                        word2[16]    <= 24'h1FFC00;
                        word2[17]    <= 24'h3C1E00;
                        word2[18]    <= 24'h3C0F00;
                        word2[19]    <= 24'h180F00;
                        word2[20]    <= 24'h000700;
                        word2[21]    <= 24'h000700;
                        word2[22]    <= 24'h000700;
                        word2[23]    <= 24'h180700;
                        word2[24]    <= 24'h3C0700;
                        word2[25]    <= 24'h7C0F00;
                        word2[26]    <= 24'h7C0F00;
                        word2[27]    <= 24'h380E00;
                        word2[28]    <= 24'h381E00;
                        word2[29]    <= 24'h1F3C00;
                        word2[30]    <= 24'h07F800;
                        word2[31]    <= 24'h000000;
                        word2[32]    <= 24'h000000;
                        word2[33]    <= 24'h000000;
                        word2[34]    <= 24'h000000;
                        word2[35]    <= 24'h000000;
                        word2[36]    <= 24'h000000;
                        word2[37]    <= 24'h000000;
                        word2[38]    <= 24'h000000;
                        word2[39]    <= 24'h000000;
                        word2[40]    <= 24'h000000;
                        word2[41]    <= 24'h000000;
                        word2[42]    <= 24'h000000;
                        word2[43]    <= 24'h000000;
                        word2[44]    <= 24'h000000;
                        word2[45]    <= 24'h000000;
                        word2[46]    <= 24'h000000;
                        word2[47]    <= 24'h000000;
                    end
                    6: begin
                        word2[0]     <=  24'h000000;
                        word2[1]     <=  24'h000000;
                        word2[2]     <=  24'h000000;
                        word2[3]     <=  24'h000000;
                        word2[4]     <=  24'h000000;
                        word2[5]     <=  24'h000000;
                        word2[6]     <=  24'h03FC00;
                        word2[7]     <=  24'h079E00;
                        word2[8]     <=  24'h0F1F00;
                        word2[9]     <=  24'h1E1F00;
                        word2[10]    <=  24'h1C0E00;
                        word2[11]    <=  24'h3C0000;
                        word2[12]    <=  24'h3C0000;
                        word2[13]    <=  24'h380000;
                        word2[14]    <=  24'h780000;
                        word2[15]    <=  24'h7BFC00;
                        word2[16]    <=  24'h7FFE00;
                        word2[17]    <=  24'h7F1F00;
                        word2[18]    <=  24'h7C0F00;
                        word2[19]    <=  24'h7C0700;
                        word2[20]    <=  24'h780780;
                        word2[21]    <=  24'h780780;
                        word2[22]    <=  24'h780780;
                        word2[23]    <=  24'h780780;
                        word2[24]    <=  24'h780780;
                        word2[25]    <=  24'h3C0780;
                        word2[26]    <=  24'h3C0700;
                        word2[27]    <=  24'h1E0F00;
                        word2[28]    <=  24'h1E0E00;
                        word2[29]    <=  24'h0FBC00;
                        word2[30]    <=  24'h07F800;
                        word2[31]    <=  24'h000000;
                        word2[32]    <=  24'h000000;
                        word2[33]    <=  24'h000000;
                        word2[34]    <=  24'h000000;
                        word2[35]    <=  24'h000000;
                        word2[36]    <=  24'h000000;
                        word2[37]    <=  24'h000000;
                        word2[38]    <=  24'h000000;
                        word2[39]    <=  24'h000000;
                        word2[40]    <=  24'h000000;
                        word2[41]    <=  24'h000000;
                        word2[42]    <=  24'h000000;
                        word2[43]    <=  24'h000000;
                        word2[44]    <=  24'h000000;
                        word2[45]    <=  24'h000000;
                        word2[46]    <=  24'h000000;
                        word2[47]    <=  24'h000000;
                    end
                    7: begin
                        word2[0]     <=  24'h000000;
                        word2[1]     <=  24'h000000;
                        word2[2]     <=  24'h000000;
                        word2[3]     <=  24'h000000;
                        word2[4]     <=  24'h000000;
                        word2[5]     <=  24'h000000;
                        word2[6]     <=  24'h3FFF80;
                        word2[7]     <=  24'h3FFF00;
                        word2[8]     <=  24'h3FFF00;
                        word2[9]     <=  24'h380E00;
                        word2[10]    <=  24'h300E00;
                        word2[11]    <=  24'h301C00;
                        word2[12]    <=  24'h001C00;
                        word2[13]    <=  24'h003800;
                        word2[14]    <=  24'h003800;
                        word2[15]    <=  24'h007000;
                        word2[16]    <=  24'h007000;
                        word2[17]    <=  24'h00F000;
                        word2[18]    <=  24'h00E000;
                        word2[19]    <=  24'h00E000;
                        word2[20]    <=  24'h01E000;
                        word2[21]    <=  24'h01E000;
                        word2[22]    <=  24'h01C000;
                        word2[23]    <=  24'h03C000;
                        word2[24]    <=  24'h03C000;
                        word2[25]    <=  24'h03C000;
                        word2[26]    <=  24'h03C000;
                        word2[27]    <=  24'h03C000;
                        word2[28]    <=  24'h03C000;
                        word2[29]    <=  24'h03C000;
                        word2[30]    <=  24'h03C000;
                        word2[31]    <=  24'h000000;
                        word2[32]    <=  24'h000000;
                        word2[33]    <=  24'h000000;
                        word2[34]    <=  24'h000000;
                        word2[35]    <=  24'h000000;
                        word2[36]    <=  24'h000000;
                        word2[37]    <=  24'h000000;
                        word2[38]    <=  24'h000000;
                        word2[39]    <=  24'h000000;
                        word2[40]    <=  24'h000000;
                        word2[41]    <=  24'h000000;
                        word2[42]    <=  24'h000000;
                        word2[43]    <=  24'h000000;
                        word2[44]    <=  24'h000000;
                        word2[45]    <=  24'h000000;
                        word2[46]    <=  24'h000000;
                        word2[47]    <=  24'h000000;
                    end
                    8: begin
                        word2[0]     <=  24'h000000;
                        word2[1]     <=  24'h000000;
                        word2[2]     <=  24'h000000;
                        word2[3]     <=  24'h000000;
                        word2[4]     <=  24'h000000;
                        word2[5]     <=  24'h000000;
                        word2[6]     <=  24'h07F800;
                        word2[7]     <=  24'h1F3C00;
                        word2[8]     <=  24'h3C0E00;
                        word2[9]     <=  24'h380F00;
                        word2[10]    <=  24'h380700;
                        word2[11]    <=  24'h780700;
                        word2[12]    <=  24'h780700;
                        word2[13]    <=  24'h3C0700;
                        word2[14]    <=  24'h3E0F00;
                        word2[15]    <=  24'h1F0E00;
                        word2[16]    <=  24'h1FFC00;
                        word2[17]    <=  24'h07F800;
                        word2[18]    <=  24'h0FF800;
                        word2[19]    <=  24'h1CFC00;
                        word2[20]    <=  24'h3C3E00;
                        word2[21]    <=  24'h381F00;
                        word2[22]    <=  24'h780F00;
                        word2[23]    <=  24'h700780;
                        word2[24]    <=  24'h700780;
                        word2[25]    <=  24'h700780;
                        word2[26]    <=  24'h780700;
                        word2[27]    <=  24'h380F00;
                        word2[28]    <=  24'h3C0E00;
                        word2[29]    <=  24'h1F3C00;
                        word2[30]    <=  24'h07F800;
                        word2[31]    <=  24'h000000;
                        word2[32]    <=  24'h000000;
                        word2[33]    <=  24'h000000;
                        word2[34]    <=  24'h000000;
                        word2[35]    <=  24'h000000;
                        word2[36]    <=  24'h000000;
                        word2[37]    <=  24'h000000;
                        word2[38]    <=  24'h000000;
                        word2[39]    <=  24'h000000;
                        word2[40]    <=  24'h000000;
                        word2[41]    <=  24'h000000;
                        word2[42]    <=  24'h000000;
                        word2[43]    <=  24'h000000;
                        word2[44]    <=  24'h000000;
                        word2[45]    <=  24'h000000;
                        word2[46]    <=  24'h000000;
                        word2[47]    <=  24'h000000;
                    end
                    9: begin
                        word2[0]     <=  24'h000000;
                        word2[1]     <=  24'h000000;
                        word2[2]     <=  24'h000000;
                        word2[3]     <=  24'h000000;
                        word2[4]     <=  24'h000000;
                        word2[5]     <=  24'h000000;
                        word2[6]     <=  24'h07F000;
                        word2[7]     <=  24'h1F7C00;
                        word2[8]     <=  24'h3C1E00;
                        word2[9]     <=  24'h380E00;
                        word2[10]    <=  24'h780F00;
                        word2[11]    <=  24'h780F00;
                        word2[12]    <=  24'h780F00;
                        word2[13]    <=  24'h780700;
                        word2[14]    <=  24'h780780;
                        word2[15]    <=  24'h780F80;
                        word2[16]    <=  24'h780F80;
                        word2[17]    <=  24'h781F80;
                        word2[18]    <=  24'h3C1F80;
                        word2[19]    <=  24'h3E7F80;
                        word2[20]    <=  24'h1FFF80;
                        word2[21]    <=  24'h03CF00;
                        word2[22]    <=  24'h000F00;
                        word2[23]    <=  24'h000F00;
                        word2[24]    <=  24'h000F00;
                        word2[25]    <=  24'h001E00;
                        word2[26]    <=  24'h1C1E00;
                        word2[27]    <=  24'h3C1C00;
                        word2[28]    <=  24'h3E3800;
                        word2[29]    <=  24'h1EF800;
                        word2[30]    <=  24'h0FE000;
                        word2[31]    <=  24'h000000;
                        word2[32]    <=  24'h000000;
                        word2[33]    <=  24'h000000;
                        word2[34]    <=  24'h000000;
                        word2[35]    <=  24'h000000;
                        word2[36]    <=  24'h000000;
                        word2[37]    <=  24'h000000;
                        word2[38]    <=  24'h000000;
                        word2[39]    <=  24'h000000;
                        word2[40]    <=  24'h000000;
                        word2[41]    <=  24'h000000;
                        word2[42]    <=  24'h000000;
                        word2[43]    <=  24'h000000;
                        word2[44]    <=  24'h000000;
                        word2[45]    <=  24'h000000;
                        word2[46]    <=  24'h000000;
                        word2[47]    <=  24'h000000;
                    end
                    default: 
                    begin
                        word2[0]     <=  24'h000000;
                        word2[1]     <=  24'h000000;
                        word2[2]     <=  24'h000000;
                        word2[3]     <=  24'h000000;
                        word2[4]     <=  24'h000000;
                        word2[5]     <=  24'h000000;
                        word2[6]     <=  24'h03F000;
                        word2[7]     <=  24'h0FBC00;
                        word2[8]     <=  24'h0E1C00;
                        word2[9]     <=  24'h1E1E00;
                        word2[10]    <=  24'h3C0F00;
                        word2[11]    <=  24'h3C0F00;
                        word2[12]    <=  24'h3C0F00;
                        word2[13]    <=  24'h780F00;
                        word2[14]    <=  24'h780780;
                        word2[15]    <=  24'h780780;
                        word2[16]    <=  24'h780780;
                        word2[17]    <=  24'h780780;
                        word2[18]    <=  24'h780780;
                        word2[19]    <=  24'h780780;
                        word2[20]    <=  24'h780780;
                        word2[21]    <=  24'h780780;
                        word2[22]    <=  24'h780780;
                        word2[23]    <=  24'h780F00;
                        word2[24]    <=  24'h3C0F00;
                        word2[25]    <=  24'h3C0F00;
                        word2[26]    <=  24'h3C0F00;
                        word2[27]    <=  24'h1E1E00;
                        word2[28]    <=  24'h0E1C00;
                        word2[29]    <=  24'h0FF800;
                        word2[30]    <=  24'h03F000;
                        word2[31]    <=  24'h000000;
                        word2[32]    <=  24'h000000;
                        word2[33]    <=  24'h000000;
                        word2[34]    <=  24'h000000;
                        word2[35]    <=  24'h000000;
                        word2[36]    <=  24'h000000;
                        word2[37]    <=  24'h000000;
                        word2[38]    <=  24'h000000;
                        word2[39]    <=  24'h000000;
                        word2[40]    <=  24'h000000;
                        word2[41]    <=  24'h000000;
                        word2[42]    <=  24'h000000;
                        word2[43]    <=  24'h000000;
                        word2[44]    <=  24'h000000;
                        word2[45]    <=  24'h000000;
                        word2[46]    <=  24'h000000;
                        word2[47]    <=  24'h000000;
                    end
                endcase
            end
        end
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
// =========================================================================================================================================
// dynamic_number
// ========================================================================================================================================= 
        always @(posedge vga_clk ) begin
            if (freq_freq_rd_en) begin
                case (ten_temp)
                0: begin
                    word3[0]     <=  24'h000000;
                    word3[1]     <=  24'h000000;
                    word3[2]     <=  24'h000000;
                    word3[3]     <=  24'h000000;
                    word3[4]     <=  24'h000000;
                    word3[5]     <=  24'h000000;
                    word3[6]     <=  24'h03F000;
                    word3[7]     <=  24'h0FBC00;
                    word3[8]     <=  24'h0E1C00;
                    word3[9]     <=  24'h1E1E00;
                    word3[10]    <=  24'h3C0F00;
                    word3[11]    <=  24'h3C0F00;
                    word3[12]    <=  24'h3C0F00;
                    word3[13]    <=  24'h780F00;
                    word3[14]    <=  24'h780780;
                    word3[15]    <=  24'h780780;
                    word3[16]    <=  24'h780780;
                    word3[17]    <=  24'h780780;
                    word3[18]    <=  24'h780780;
                    word3[19]    <=  24'h780780;
                    word3[20]    <=  24'h780780;
                    word3[21]    <=  24'h780780;
                    word3[22]    <=  24'h780780;
                    word3[23]    <=  24'h780F00;
                    word3[24]    <=  24'h3C0F00;
                    word3[25]    <=  24'h3C0F00;
                    word3[26]    <=  24'h3C0F00;
                    word3[27]    <=  24'h1E1E00;
                    word3[28]    <=  24'h0E1C00;
                    word3[29]    <=  24'h0FF800;
                    word3[30]    <=  24'h03F000;
                    word3[31]    <=  24'h000000;
                    word3[32]    <=  24'h000000;
                    word3[33]    <=  24'h000000;
                    word3[34]    <=  24'h000000;
                    word3[35]    <=  24'h000000;
                    word3[36]    <=  24'h000000;
                    word3[37]    <=  24'h000000;
                    word3[38]    <=  24'h000000;
                    word3[39]    <=  24'h000000;
                    word3[40]    <=  24'h000000;
                    word3[41]    <=  24'h000000;
                    word3[42]    <=  24'h000000;
                    word3[43]    <=  24'h000000;
                    word3[44]    <=  24'h000000;
                    word3[45]    <=  24'h000000;
                    word3[46]    <=  24'h000000;
                    word3[47]    <=  24'h000000;
                end
                1: begin
                    word3[0]     <=  24'h000000;
                    word3[1]     <=  24'h000000;
                    word3[2]     <=  24'h000000;
                    word3[3]     <=  24'h000000;
                    word3[4]     <=  24'h000000;
                    word3[5]     <=  24'h000000;
                    word3[6]     <=  24'h006000;
                    word3[7]     <=  24'h01E000;
                    word3[8]     <=  24'h1FE000;
                    word3[9]     <=  24'h0FE000;
                    word3[10]    <=  24'h01E000;
                    word3[11]    <=  24'h01E000;
                    word3[12]    <=  24'h01E000;
                    word3[13]    <=  24'h01E000;
                    word3[14]    <=  24'h01E000;
                    word3[15]    <=  24'h01E000;
                    word3[16]    <=  24'h01E000;
                    word3[17]    <=  24'h01E000;
                    word3[18]    <=  24'h01E000;
                    word3[19]    <=  24'h01E000;
                    word3[20]    <=  24'h01E000;
                    word3[21]    <=  24'h01E000;
                    word3[22]    <=  24'h01E000;
                    word3[23]    <=  24'h01E000;
                    word3[24]    <=  24'h01E000;
                    word3[25]    <=  24'h01E000;
                    word3[26]    <=  24'h01E000;
                    word3[27]    <=  24'h01E000;
                    word3[28]    <=  24'h01E000;
                    word3[29]    <=  24'h03F000;
                    word3[30]    <=  24'h1FFE00;
                    word3[31]    <=  24'h000000;
                    word3[32]    <=  24'h000000;
                    word3[33]    <=  24'h000000;
                    word3[34]    <=  24'h000000;
                    word3[35]    <=  24'h000000;
                    word3[36]    <=  24'h000000;
                    word3[37]    <=  24'h000000;
                    word3[38]    <=  24'h000000;
                    word3[39]    <=  24'h000000;
                    word3[40]    <=  24'h000000;
                    word3[41]    <=  24'h000000;
                    word3[42]    <=  24'h000000;
                    word3[43]    <=  24'h000000;
                    word3[44]    <=  24'h000000;
                    word3[45]    <=  24'h000000;
                    word3[46]    <=  24'h000000;
                    word3[47]    <=  24'h000000;
                end
                    2: begin
                        word3[0]     <=  24'h000000;
                        word3[1]     <=  24'h000000;
                        word3[2]     <=  24'h000000;
                        word3[3]     <=  24'h000000;
                        word3[4]     <=  24'h000000;
                        word3[5]     <=  24'h000000;
                        word3[6]     <=  24'h07F800;
                        word3[7]     <=  24'h0F3C00;
                        word3[8]     <=  24'h1C1E00;
                        word3[9]     <=  24'h380F00;
                        word3[10]    <=  24'h380F00;
                        word3[11]    <=  24'h3C0F00;
                        word3[12]    <=  24'h3C0F00;
                        word3[13]    <=  24'h3C0F00;
                        word3[14]    <=  24'h1C0F00;
                        word3[15]    <=  24'h000E00;
                        word3[16]    <=  24'h001E00;
                        word3[17]    <=  24'h001C00;
                        word3[18]    <=  24'h003800;
                        word3[19]    <=  24'h007000;
                        word3[20]    <=  24'h00E000;
                        word3[21]    <=  24'h01C000;
                        word3[22]    <=  24'h038000;
                        word3[23]    <=  24'h078000;
                        word3[24]    <=  24'h0F0100;
                        word3[25]    <=  24'h1E0300;
                        word3[26]    <=  24'h1C0300;
                        word3[27]    <=  24'h380700;
                        word3[28]    <=  24'h7FFF00;
                        word3[29]    <=  24'h7FFF00;
                        word3[30]    <=  24'h7FFF00;
                        word3[31]    <=  24'h000000;
                        word3[32]    <=  24'h000000;
                        word3[33]    <=  24'h000000;
                        word3[34]    <=  24'h000000;
                        word3[35]    <=  24'h000000;
                        word3[36]    <=  24'h000000;
                        word3[37]    <=  24'h000000;
                        word3[38]    <=  24'h000000;
                        word3[39]    <=  24'h000000;
                        word3[40]    <=  24'h000000;
                        word3[41]    <=  24'h000000;
                        word3[42]    <=  24'h000000;
                        word3[43]    <=  24'h000000;
                        word3[44]    <=  24'h000000;
                        word3[45]    <=  24'h000000;
                        word3[46]    <=  24'h000000;
                        word3[47]    <=  24'h000000;
                    end
                    3: begin
                        word3[0]     <=  24'h000000;
                        word3[1]     <=  24'h000000;
                        word3[2]     <=  24'h000000;
                        word3[3]     <=  24'h000000;
                        word3[4]     <=  24'h000000;
                        word3[5]     <=  24'h000000;
                        word3[6]     <=  24'h07F000;
                        word3[7]     <=  24'h1E7C00;
                        word3[8]     <=  24'h3C1C00;
                        word3[9]     <=  24'h3C1E00;
                        word3[10]    <=  24'h3C0E00;
                        word3[11]    <=  24'h3C0E00;
                        word3[12]    <=  24'h3C0E00;
                        word3[13]    <=  24'h000E00;
                        word3[14]    <=  24'h001E00;
                        word3[15]    <=  24'h003C00;
                        word3[16]    <=  24'h00F800;
                        word3[17]    <=  24'h03F000;
                        word3[18]    <=  24'h007C00;
                        word3[19]    <=  24'h001E00;
                        word3[20]    <=  24'h000E00;
                        word3[21]    <=  24'h000F00;
                        word3[22]    <=  24'h000F00;
                        word3[23]    <=  24'h000F00;
                        word3[24]    <=  24'h3C0F00;
                        word3[25]    <=  24'h3C0F00;
                        word3[26]    <=  24'h7C0F00;
                        word3[27]    <=  24'h3C0F00;
                        word3[28]    <=  24'h3C1E00;
                        word3[29]    <=  24'h1E7C00;
                        word3[30]    <=  24'h0FF800;
                        word3[31]    <=  24'h000000;
                        word3[32]    <=  24'h000000;
                        word3[33]    <=  24'h000000;
                        word3[34]    <=  24'h000000;
                        word3[35]    <=  24'h000000;
                        word3[36]    <=  24'h000000;
                        word3[37]    <=  24'h000000;
                        word3[38]    <=  24'h000000;
                        word3[39]    <=  24'h000000;
                        word3[40]    <=  24'h000000;
                        word3[41]    <=  24'h000000;
                        word3[42]    <=  24'h000000;
                        word3[43]    <=  24'h000000;
                        word3[44]    <=  24'h000000;
                        word3[45]    <=  24'h000000;
                        word3[46]    <=  24'h000000;
                        word3[47]    <=  24'h000000;
                    end
                    4: begin
                        word3[0]     <=  24'h000000;
                        word3[1]     <=  24'h000000;
                        word3[2]     <=  24'h000000;
                        word3[3]     <=  24'h000000;
                        word3[4]     <=  24'h000000;
                        word3[5]     <=  24'h000000;
                        word3[6]     <=  24'h003C00;
                        word3[7]     <=  24'h003C00;
                        word3[8]     <=  24'h007C00;
                        word3[9]     <=  24'h007C00;
                        word3[10]    <=  24'h00FC00;
                        word3[11]    <=  24'h01FC00;
                        word3[12]    <=  24'h01FC00;
                        word3[13]    <=  24'h03BC00;
                        word3[14]    <=  24'h033C00;
                        word3[15]    <=  24'h073C00;
                        word3[16]    <=  24'h0E3C00;
                        word3[17]    <=  24'h0E3C00;
                        word3[18]    <=  24'h1C3C00;
                        word3[19]    <=  24'h183C00;
                        word3[20]    <=  24'h383C00;
                        word3[21]    <=  24'h703C00;
                        word3[22]    <=  24'h703C00;
                        word3[23]    <=  24'hFFFF80;
                        word3[24]    <=  24'h003C00;
                        word3[25]    <=  24'h003C00;
                        word3[26]    <=  24'h003C00;
                        word3[27]    <=  24'h003C00;
                        word3[28]    <=  24'h003C00;
                        word3[29]    <=  24'h007C00;
                        word3[30]    <=  24'h03FF80;
                        word3[31]    <=  24'h000000;
                        word3[32]    <=  24'h000000;
                        word3[33]    <=  24'h000000;
                        word3[34]    <=  24'h000000;
                        word3[35]    <=  24'h000000;
                        word3[36]    <=  24'h000000;
                        word3[37]    <=  24'h000000;
                        word3[38]    <=  24'h000000;
                        word3[39]    <=  24'h000000;
                        word3[40]    <=  24'h000000;
                        word3[41]    <=  24'h000000;
                        word3[42]    <=  24'h000000;
                        word3[43]    <=  24'h000000;
                        word3[44]    <=  24'h000000;
                        word3[45]    <=  24'h000000;
                        word3[46]    <=  24'h000000;
                        word3[47]    <=  24'h000000;
                    end
                    5: begin
                        word3[0]     <= 24'h000000;
                        word3[1]     <= 24'h000000;
                        word3[2]     <= 24'h000000;
                        word3[3]     <= 24'h000000;
                        word3[4]     <= 24'h000000;
                        word3[5]     <= 24'h000000;
                        word3[6]     <= 24'h1FFF00;
                        word3[7]     <= 24'h1FFF00;
                        word3[8]     <= 24'h1FFE00;
                        word3[9]     <= 24'h180000;
                        word3[10]    <= 24'h180000;
                        word3[11]    <= 24'h180000;
                        word3[12]    <= 24'h180000;
                        word3[13]    <= 24'h180000;
                        word3[14]    <= 24'h18E000;
                        word3[15]    <= 24'h1FF800;
                        word3[16]    <= 24'h1FFC00;
                        word3[17]    <= 24'h3C1E00;
                        word3[18]    <= 24'h3C0F00;
                        word3[19]    <= 24'h180F00;
                        word3[20]    <= 24'h000700;
                        word3[21]    <= 24'h000700;
                        word3[22]    <= 24'h000700;
                        word3[23]    <= 24'h180700;
                        word3[24]    <= 24'h3C0700;
                        word3[25]    <= 24'h7C0F00;
                        word3[26]    <= 24'h7C0F00;
                        word3[27]    <= 24'h380E00;
                        word3[28]    <= 24'h381E00;
                        word3[29]    <= 24'h1F3C00;
                        word3[30]    <= 24'h07F800;
                        word3[31]    <= 24'h000000;
                        word3[32]    <= 24'h000000;
                        word3[33]    <= 24'h000000;
                        word3[34]    <= 24'h000000;
                        word3[35]    <= 24'h000000;
                        word3[36]    <= 24'h000000;
                        word3[37]    <= 24'h000000;
                        word3[38]    <= 24'h000000;
                        word3[39]    <= 24'h000000;
                        word3[40]    <= 24'h000000;
                        word3[41]    <= 24'h000000;
                        word3[42]    <= 24'h000000;
                        word3[43]    <= 24'h000000;
                        word3[44]    <= 24'h000000;
                        word3[45]    <= 24'h000000;
                        word3[46]    <= 24'h000000;
                        word3[47]    <= 24'h000000;
                    end
                    6: begin
                        word3[0]     <=  24'h000000;
                        word3[1]     <=  24'h000000;
                        word3[2]     <=  24'h000000;
                        word3[3]     <=  24'h000000;
                        word3[4]     <=  24'h000000;
                        word3[5]     <=  24'h000000;
                        word3[6]     <=  24'h03FC00;
                        word3[7]     <=  24'h079E00;
                        word3[8]     <=  24'h0F1F00;
                        word3[9]     <=  24'h1E1F00;
                        word3[10]    <=  24'h1C0E00;
                        word3[11]    <=  24'h3C0000;
                        word3[12]    <=  24'h3C0000;
                        word3[13]    <=  24'h380000;
                        word3[14]    <=  24'h780000;
                        word3[15]    <=  24'h7BFC00;
                        word3[16]    <=  24'h7FFE00;
                        word3[17]    <=  24'h7F1F00;
                        word3[18]    <=  24'h7C0F00;
                        word3[19]    <=  24'h7C0700;
                        word3[20]    <=  24'h780780;
                        word3[21]    <=  24'h780780;
                        word3[22]    <=  24'h780780;
                        word3[23]    <=  24'h780780;
                        word3[24]    <=  24'h780780;
                        word3[25]    <=  24'h3C0780;
                        word3[26]    <=  24'h3C0700;
                        word3[27]    <=  24'h1E0F00;
                        word3[28]    <=  24'h1E0E00;
                        word3[29]    <=  24'h0FBC00;
                        word3[30]    <=  24'h07F800;
                        word3[31]    <=  24'h000000;
                        word3[32]    <=  24'h000000;
                        word3[33]    <=  24'h000000;
                        word3[34]    <=  24'h000000;
                        word3[35]    <=  24'h000000;
                        word3[36]    <=  24'h000000;
                        word3[37]    <=  24'h000000;
                        word3[38]    <=  24'h000000;
                        word3[39]    <=  24'h000000;
                        word3[40]    <=  24'h000000;
                        word3[41]    <=  24'h000000;
                        word3[42]    <=  24'h000000;
                        word3[43]    <=  24'h000000;
                        word3[44]    <=  24'h000000;
                        word3[45]    <=  24'h000000;
                        word3[46]    <=  24'h000000;
                        word3[47]    <=  24'h000000;
                    end
                    7: begin
                        word3[0]     <=  24'h000000;
                        word3[1]     <=  24'h000000;
                        word3[2]     <=  24'h000000;
                        word3[3]     <=  24'h000000;
                        word3[4]     <=  24'h000000;
                        word3[5]     <=  24'h000000;
                        word3[6]     <=  24'h3FFF80;
                        word3[7]     <=  24'h3FFF00;
                        word3[8]     <=  24'h3FFF00;
                        word3[9]     <=  24'h380E00;
                        word3[10]    <=  24'h300E00;
                        word3[11]    <=  24'h301C00;
                        word3[12]    <=  24'h001C00;
                        word3[13]    <=  24'h003800;
                        word3[14]    <=  24'h003800;
                        word3[15]    <=  24'h007000;
                        word3[16]    <=  24'h007000;
                        word3[17]    <=  24'h00F000;
                        word3[18]    <=  24'h00E000;
                        word3[19]    <=  24'h00E000;
                        word3[20]    <=  24'h01E000;
                        word3[21]    <=  24'h01E000;
                        word3[22]    <=  24'h01C000;
                        word3[23]    <=  24'h03C000;
                        word3[24]    <=  24'h03C000;
                        word3[25]    <=  24'h03C000;
                        word3[26]    <=  24'h03C000;
                        word3[27]    <=  24'h03C000;
                        word3[28]    <=  24'h03C000;
                        word3[29]    <=  24'h03C000;
                        word3[30]    <=  24'h03C000;
                        word3[31]    <=  24'h000000;
                        word3[32]    <=  24'h000000;
                        word3[33]    <=  24'h000000;
                        word3[34]    <=  24'h000000;
                        word3[35]    <=  24'h000000;
                        word3[36]    <=  24'h000000;
                        word3[37]    <=  24'h000000;
                        word3[38]    <=  24'h000000;
                        word3[39]    <=  24'h000000;
                        word3[40]    <=  24'h000000;
                        word3[41]    <=  24'h000000;
                        word3[42]    <=  24'h000000;
                        word3[43]    <=  24'h000000;
                        word3[44]    <=  24'h000000;
                        word3[45]    <=  24'h000000;
                        word3[46]    <=  24'h000000;
                        word3[47]    <=  24'h000000;
                    end
                    8: begin
                        word3[0]     <=  24'h000000;
                        word3[1]     <=  24'h000000;
                        word3[2]     <=  24'h000000;
                        word3[3]     <=  24'h000000;
                        word3[4]     <=  24'h000000;
                        word3[5]     <=  24'h000000;
                        word3[6]     <=  24'h07F800;
                        word3[7]     <=  24'h1F3C00;
                        word3[8]     <=  24'h3C0E00;
                        word3[9]     <=  24'h380F00;
                        word3[10]    <=  24'h380700;
                        word3[11]    <=  24'h780700;
                        word3[12]    <=  24'h780700;
                        word3[13]    <=  24'h3C0700;
                        word3[14]    <=  24'h3E0F00;
                        word3[15]    <=  24'h1F0E00;
                        word3[16]    <=  24'h1FFC00;
                        word3[17]    <=  24'h07F800;
                        word3[18]    <=  24'h0FF800;
                        word3[19]    <=  24'h1CFC00;
                        word3[20]    <=  24'h3C3E00;
                        word3[21]    <=  24'h381F00;
                        word3[22]    <=  24'h780F00;
                        word3[23]    <=  24'h700780;
                        word3[24]    <=  24'h700780;
                        word3[25]    <=  24'h700780;
                        word3[26]    <=  24'h780700;
                        word3[27]    <=  24'h380F00;
                        word3[28]    <=  24'h3C0E00;
                        word3[29]    <=  24'h1F3C00;
                        word3[30]    <=  24'h07F800;
                        word3[31]    <=  24'h000000;
                        word3[32]    <=  24'h000000;
                        word3[33]    <=  24'h000000;
                        word3[34]    <=  24'h000000;
                        word3[35]    <=  24'h000000;
                        word3[36]    <=  24'h000000;
                        word3[37]    <=  24'h000000;
                        word3[38]    <=  24'h000000;
                        word3[39]    <=  24'h000000;
                        word3[40]    <=  24'h000000;
                        word3[41]    <=  24'h000000;
                        word3[42]    <=  24'h000000;
                        word3[43]    <=  24'h000000;
                        word3[44]    <=  24'h000000;
                        word3[45]    <=  24'h000000;
                        word3[46]    <=  24'h000000;
                        word3[47]    <=  24'h000000;
                    end
                    9: begin
                        word3[0]     <=  24'h000000;
                        word3[1]     <=  24'h000000;
                        word3[2]     <=  24'h000000;
                        word3[3]     <=  24'h000000;
                        word3[4]     <=  24'h000000;
                        word3[5]     <=  24'h000000;
                        word3[6]     <=  24'h07F000;
                        word3[7]     <=  24'h1F7C00;
                        word3[8]     <=  24'h3C1E00;
                        word3[9]     <=  24'h380E00;
                        word3[10]    <=  24'h780F00;
                        word3[11]    <=  24'h780F00;
                        word3[12]    <=  24'h780F00;
                        word3[13]    <=  24'h780700;
                        word3[14]    <=  24'h780780;
                        word3[15]    <=  24'h780F80;
                        word3[16]    <=  24'h780F80;
                        word3[17]    <=  24'h781F80;
                        word3[18]    <=  24'h3C1F80;
                        word3[19]    <=  24'h3E7F80;
                        word3[20]    <=  24'h1FFF80;
                        word3[21]    <=  24'h03CF00;
                        word3[22]    <=  24'h000F00;
                        word3[23]    <=  24'h000F00;
                        word3[24]    <=  24'h000F00;
                        word3[25]    <=  24'h001E00;
                        word3[26]    <=  24'h1C1E00;
                        word3[27]    <=  24'h3C1C00;
                        word3[28]    <=  24'h3E3800;
                        word3[29]    <=  24'h1EF800;
                        word3[30]    <=  24'h0FE000;
                        word3[31]    <=  24'h000000;
                        word3[32]    <=  24'h000000;
                        word3[33]    <=  24'h000000;
                        word3[34]    <=  24'h000000;
                        word3[35]    <=  24'h000000;
                        word3[36]    <=  24'h000000;
                        word3[37]    <=  24'h000000;
                        word3[38]    <=  24'h000000;
                        word3[39]    <=  24'h000000;
                        word3[40]    <=  24'h000000;
                        word3[41]    <=  24'h000000;
                        word3[42]    <=  24'h000000;
                        word3[43]    <=  24'h000000;
                        word3[44]    <=  24'h000000;
                        word3[45]    <=  24'h000000;
                        word3[46]    <=  24'h000000;
                        word3[47]    <=  24'h000000;
                    end
                    default: 
                    begin
                        word3[0]     <=  24'h000000;
                        word3[1]     <=  24'h000000;
                        word3[2]     <=  24'h000000;
                        word3[3]     <=  24'h000000;
                        word3[4]     <=  24'h000000;
                        word3[5]     <=  24'h000000;
                        word3[6]     <=  24'h03F000;
                        word3[7]     <=  24'h0FBC00;
                        word3[8]     <=  24'h0E1C00;
                        word3[9]     <=  24'h1E1E00;
                        word3[10]    <=  24'h3C0F00;
                        word3[11]    <=  24'h3C0F00;
                        word3[12]    <=  24'h3C0F00;
                        word3[13]    <=  24'h780F00;
                        word3[14]    <=  24'h780780;
                        word3[15]    <=  24'h780780;
                        word3[16]    <=  24'h780780;
                        word3[17]    <=  24'h780780;
                        word3[18]    <=  24'h780780;
                        word3[19]    <=  24'h780780;
                        word3[20]    <=  24'h780780;
                        word3[21]    <=  24'h780780;
                        word3[22]    <=  24'h780780;
                        word3[23]    <=  24'h780F00;
                        word3[24]    <=  24'h3C0F00;
                        word3[25]    <=  24'h3C0F00;
                        word3[26]    <=  24'h3C0F00;
                        word3[27]    <=  24'h1E1E00;
                        word3[28]    <=  24'h0E1C00;
                        word3[29]    <=  24'h0FF800;
                        word3[30]    <=  24'h03F000;
                        word3[31]    <=  24'h000000;
                        word3[32]    <=  24'h000000;
                        word3[33]    <=  24'h000000;
                        word3[34]    <=  24'h000000;
                        word3[35]    <=  24'h000000;
                        word3[36]    <=  24'h000000;
                        word3[37]    <=  24'h000000;
                        word3[38]    <=  24'h000000;
                        word3[39]    <=  24'h000000;
                        word3[40]    <=  24'h000000;
                        word3[41]    <=  24'h000000;
                        word3[42]    <=  24'h000000;
                        word3[43]    <=  24'h000000;
                        word3[44]    <=  24'h000000;
                        word3[45]    <=  24'h000000;
                        word3[46]    <=  24'h000000;
                        word3[47]    <=  24'h000000;
                    end
                endcase
            end
        end
        
endmodule



