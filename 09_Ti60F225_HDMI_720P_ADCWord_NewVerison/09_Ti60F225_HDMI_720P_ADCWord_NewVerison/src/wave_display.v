`timescale 1ns / 1ps
module wave_display (
  //    27MHz PLL
    input             clk27m                  ,
    input             pll_27m_LOCKED          ,//rst_n
    input             clk_adc                 ,//40Mhz
  //ADC Input
    input      [7:0]  DAM                     ,
    input      [7:0]  DBN                     ,
  //LVDS PLL
    output            sys_pll_RSTN            ,
    input             clk_pixel               ,
    input             sys_pll_LOCKED          ,
    output     [9:0]  tmds_lvds_tx_clk_o      ,
    output     [9:0]  tmds_lvds_tx_data0      ,
    output     [9:0]  tmds_lvds_tx_data1      ,
    output     [9:0]  tmds_lvds_tx_data2      ,
    output            tmds_lvds_tx_clk_oe     ,
    output            tmds_lvds_tx_data0_oe   ,
    output            tmds_lvds_tx_data1_oe   ,
    output            tmds_lvds_tx_data2_oe   ,
    output            tmds_lvds_tx_clk_rst    ,
    output            tmds_lvds_tx_data0_rst  ,
    output            tmds_lvds_tx_data1_rst  ,
    output            tmds_lvds_tx_data2_rst  ,

    input             key_change,

    output     [7:0]  led_o                    

);
// =========================================================================================================================================
//key ctrl
// ========================================================================================================================================= 

wire change_flag;
key_filter key_filter_U0(
    .Clk                               (clk_adc                   ),
    .Reset_n                           (w_adc_rstn                ),//~i_rst
    .Key                               (key_change                ),//default:high,press down : low 
    .Key_P_Flag                        (change_flag               )
);

// =========================================================================================================================================
// sys clk and reset
// ========================================================================================================================================= 
assign sys_pll_RSTN = pll_27m_LOCKED; 
wire          sys_rst_n = pll_27m_LOCKED ;

//adc reset
wire             w_adc_rst, w_adc_rstn; 
Reset adc_sync (.clk_i(clk_adc), .locked_i(sys_rst_n), .rstn_o(w_adc_rstn), .rst_o(w_adc_rst)); 
//vga reset
wire             w_pixel_rst, w_pixel_rstn; 
Reset pixel_sync (.clk_i(clk_pixel), .locked_i(sys_rst_n), .rstn_o(w_pixel_rstn), .rst_o(w_pixel_rst)); 
// =========================================================================================================================================
// register data
// ========================================================================================================================================= 
    reg  [   7:0] r_dataA                    ;
    reg  [   7:0] r_dataB                    ;
always@(posedge clk_adc or negedge w_adc_rstn)
begin
    if(!w_adc_rstn)
        begin
             r_dataA    <=  'd0 ;
             r_dataB    <=  'd0 ;
        end

    else
        begin
            r_dataA    <=  DAM ;
            r_dataB    <=  DBN ;
        end
end

reg kepp_state;
always@(posedge clk_adc or negedge w_adc_rstn)
begin
    if(!w_adc_rstn)
        begin
            kepp_state   <=  'd0 ;
        end
    else if(change_flag)
        begin
            kepp_state   <=  ~kepp_state;
        end
    else
        begin
            kepp_state   <=  kepp_state ;
        end
end




wire                   [  31:0]         freq_value                 ;
wire                   [   3:0]         units                      ;
wire                   [   3:0]         tens                       ;
wire                   [   3:0]         hundreds                   ;
wire                   [   3:0]         thousands                  ;
wire                   [   3:0]         ten_thousands              ;
wire done;
 frequency_measure  u_frequency_measure(
    .clk         (clk_adc)               ,// FPGA 主时钟
    .reset       (w_adc_rst)               ,// 复位信号
    .adc_data    (r_dataA)               ,// ADC 采样数据
    .freq_value  (freq_value)                // 波形频率值 (kHz)
);

//  decimal_decoder u_decimal_decoder (
//     .binary_input       (freq_value)        ,// 输入的32位二进制数
//     .units              (units        )        ,// 个位
//     .tens               (tens         )        ,// 十位
//     .hundreds           (hundreds     )        ,// 百位
//     .thousands          (thousands    )        ,// 千位
//     .ten_thousands      (ten_thousands)         // 万位
// );

 decimal_decoder_seq u_decimal_decoder_seq (
    .clk                (clk_adc)        ,// 时钟信号
    .reset              (w_adc_rst)        ,// 复位信号
    .binary_input       (freq_value)        ,// 输入的32位二进制数
    .start              (trigger_signal)        ,// 开始信号
    .units              (units          )        ,// 个位
    .tens               (tens           )        ,// 十位
    .hundreds           (hundreds       )        ,// 百位
    .thousands          (thousands      )        ,// 千位
    .ten_thousands      (ten_thousands  )        ,// 万位
    .done               (done)         // 完成信号
);

wire [  19:0]     freq_data = {ten_thousands,thousands,hundreds,tens,units};
wire              freq_data_en = done        ;
wire              number_empty               ;
wire              freq_rd_en = ~number_empty ;
wire [  19:0]     freq_rd_data                ;

afifo_w20d16 u_afifo_w20d16
(
    .wr_clk_i                          (clk_adc        ),

    .wdata                             (freq_data      ),
    .wr_en_i                           (freq_data_en   ),
   
    .full_o                            (               ),
    .empty_o                           (number_empty   ),
    
    .rd_clk_i                          (clk_pixel      ),
    .rd_en_i                           (freq_rd_en     ),
    .rdata                             (freq_rd_data    ),
    .rst_busy                          (               ),
    .a_rst_i                           (w_adc_rst      ),
   
    .wr_datacount_o                    (               ),
    .rd_datacount_o                    (               ) 
);



// =========================================================================================================================================
// auto trigger
// ========================================================================================================================================= 
wire                                    adc_data_enable            ;
wire                                    trigger_signal             ;
wire                      [11:0]              wr_addr                    ;
auto_trigger u_auto_trigger
(
    .clk_40mhz                         (clk_adc                   ),
    .reset                             (w_adc_rst                 ),
   
    .addr                              (wr_addr                   ),
    .enable                            (adc_data_enable           ),
    .flag_1s                           (trigger_signal            ) 
);

wire [11:0] wr_datacount_o;
wire [11:0] rd_datacount_o;
reg   rd_en;
reg  [11:0] rd_cnt;
wire  [7:0] rd_data;

wire [7:0] final_disp = kepp_state?r_dataB:r_dataA;
afifo_w8d2048 u_afifo_w8d2048
(
    .wr_clk_i                          (clk_adc                   ),

    .wdata                             (final_disp                   ),
    .wr_en_i                           (adc_data_enable           ),
   
    .full_o                            (                          ),
    .empty_o                           (                          ),
    .rd_clk_i                          (clk_pixel                 ),
    .rd_en_i                           (rd_en                     ),
    .rdata                             (rd_data                   ),
    .rst_busy                          (                          ),
    .a_rst_i                           (w_adc_rst                 ),
   
    .wr_datacount_o                    (wr_datacount_o            ),
    .rd_datacount_o                    (rd_datacount_o            ) 
);

always@(posedge clk_pixel or negedge w_pixel_rstn)
begin
    if(!w_pixel_rstn)
        begin
            rd_cnt   <=  'd0 ;
        end
    else if (rd_cnt == 1279) begin
        rd_cnt <= 0;
    end
    else if(rd_en == 1)
        begin
            rd_cnt   <=  rd_cnt +1 ;
        end
    else
        begin
            rd_cnt   <=  rd_cnt ;
        end
end

always@(posedge clk_pixel or negedge w_pixel_rstn)
begin
    if(!w_pixel_rstn)
        begin
            rd_en   <=  'd0 ;
        end
    else if (rd_cnt == 1279) begin
        rd_en <= 0; 
    end
    else if(rd_datacount_o >= 1280)
        begin
            rd_en   <=  1 ;
        end
    else
        begin
            rd_en   <=  rd_en ;
        end
end

// // =========================================================================================================================================
// // vga_display
// // ========================================================================================================================================= 
wire        lcd_hs;
wire        lcd_vs;
wire        lcd_de;
wire[7:0]   lcd_red;
wire[7:0]   lcd_green;
wire[7:0]   lcd_blue;

wire [23:0] wave_displaydata;
wire [23:0] word_displaydata;
wire [23:0] number_displaydata;
wire [23:0] pix_data_number;
wire [23:0] pix_data;
wire [11:0] pix_x;
wire [11:0] pix_y;
 vga_ctrl u_vga_ctrl
(
    .vga_clk                           (clk_pixel                 ),
    .sys_rst_n                         (w_pixel_rstn              ),

    .bram_en                           (rd_en                     ),
    .bram_data                         (rd_data                   ),
    
    .pix_x                             (pix_x                     ),
    .pix_y                             (pix_y                     ),
    .pix_data                          (pix_data                  ),
    .rgb                               (word_displaydata          ), 
   
    .pix_data_number                   (pix_data_number                  ),
    .rgb_number                        (number_displaydata          ), 

    .hsync                             (lcd_hs                    ),
    .vsync                             (lcd_vs                    ),
    .rgb_valid                         (lcd_de                    ),
    .wave_displaydata                  (wave_displaydata          )
);

vga_pic vga_pic_inst
(
    .vga_clk                           (clk_pixel                 ),
    .sys_rst_n                         (w_pixel_rstn              ),
    .pix_x                             (pix_x                     ),
    .pix_y                             (pix_y                     ),

    .pix_data                          (pix_data                  ) 

);

vga_number u_vga_number
(
    .vga_clk                           (clk_pixel                 ),
    .sys_rst_n                         (w_pixel_rstn              ),
    .pix_x                             (pix_x                     ),
    .pix_y                             (pix_y                     ),

    .freq_freq_rd_en (freq_rd_en),
    .freq_rd_data    (freq_rd_data),

    .pix_data                          (pix_data_number                  ) 

);

wire [23:0] display_data = (pix_y <= 231)?  word_displaydata:((pix_y >= 490 && pix_y<= 720)?number_displaydata:wave_displaydata);
// =========================================================================================================================================
// output
// ========================================================================================================================================= 
// assign wave_displaydata = 24'hff00ff;
assign 		tmds_lvds_tx_clk_rst	= 'b0;
assign 		tmds_lvds_tx_data0_rst	= 'b0;
assign 		tmds_lvds_tx_data1_rst	= 'b0;
assign 		tmds_lvds_tx_data2_rst	= 'b0;
assign 		tmds_lvds_tx_clk_oe		= 'b1;
assign 		tmds_lvds_tx_data0_oe	= 'b1;
assign 		tmds_lvds_tx_data1_oe	= 'b1;
assign 		tmds_lvds_tx_data2_oe	= 'b1;
assign led_o = r_dataA;
rgb2dvi #(.ENABLE_OSERDES(0)) u_rgb2dvi
(
    .oe_i                              (1                  ),//	Always enable output
    .bitflip_i                         (4'b0000            ),//	Reverse clock & data lanes. 

    .aRst                              (1'b0               ),
    .aRst_n                            (w_pixel_rstn       ),

    .PixelClk                          (clk_pixel          ),//pixel clk = 74.25M
    .SerialClk                         (                   ),//pixel clk *5 = 371.25M

    .vid_pHSync                        (lcd_hs             ),
    .vid_pVSync                        (lcd_vs             ),
    .vid_pVDE                          (lcd_de             ),
    .vid_pData                         (display_data   ),

    .txc_o                             (tmds_lvds_tx_clk_o ),
    .txd0_o                            (tmds_lvds_tx_data0 ),
    .txd1_o                            (tmds_lvds_tx_data1 ),
    .txd2_o                            (tmds_lvds_tx_data2 ) 
);


endmodule

