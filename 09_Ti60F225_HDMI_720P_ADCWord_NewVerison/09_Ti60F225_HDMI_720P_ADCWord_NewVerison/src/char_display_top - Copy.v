

`timescale 1ns / 1ps
module char_display_top (
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

    output     [7:0]  led_o                    

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

// wire                    [7:0]                rd_data_channela           ;
// wire align_rden;
// bram_read_test u_bram_read_test
// (

//     .clk                               (clk_adc                   ),
//     .reset                             (w_adc_rst                 ),
   
//     .wr_enable                         (adc_data_enable           ),
//     .wr_addr                           (wr_addr                   ),
//     .wr_data                           (r_dataA                   ),

//     .align_rden                        (align_rden                ),
//     .rd_data                           (rd_data_channela          ) 

// );

wire [11:0] wr_datacount_o;
wire [11:0] rd_datacount_o;
reg   rd_en;
reg  [11:0] rd_cnt;
wire  [7:0] rd_data;
afifo_w8d2048 u_afifo_w8d2048
(
    .wr_clk_i                          (clk_adc                   ),
    // .wr_en_i                           (align_rden                ),
    // .wdata                             (rd_data_channela          ),
    .wdata                             (r_dataA          ),
    .wr_en_i                           (adc_data_enable                ),
   
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
 vga_ctrl u_vga_ctrl
(
    .vga_clk                           (clk_pixel                 ),
    .sys_rst_n                         (w_pixel_rstn              ),

    .bram_en                           (rd_en                     ),
    .bram_data                         (rd_data                   ),
    
    .hsync                             (lcd_hs                    ),
    .vsync                             (lcd_vs                    ),
    .rgb_valid                         (lcd_de                    ),
    .wave_displaydata                  (wave_displaydata          )
);

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

rgb2dvi #(.ENABLE_OSERDES(0)) u_rgb2dvi
(
.oe_i                              (1                         ),//	Always enable output
.bitflip_i                         (4'b0000                   ),//	Reverse clock & data lanes. 
    
.aRst                              (1'b0                      ),
.aRst_n                            (w_pixel_rstn                     ),
    
.PixelClk                          (clk_pixel                 ),//pixel clk = 74.25M
.SerialClk                         (                          ),//pixel clk *5 = 371.25M
    
.vid_pHSync                        (lcd_hs                                ),
.vid_pVSync                        (lcd_vs                                ),
.vid_pVDE                          (lcd_de                                   ),
.vid_pData                         (wave_displaydata    ),
    
.txc_o                             (tmds_lvds_tx_clk_o        ),
.txd0_o                            (tmds_lvds_tx_data0        ),
.txd1_o                            (tmds_lvds_tx_data1        ),
.txd2_o                            (tmds_lvds_tx_data2        ) 
);


assign led_o = r_dataA;
endmodule

