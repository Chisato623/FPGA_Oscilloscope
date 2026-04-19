`timescale 1ns/1ns
module LED_8bit_Test
(
//from the pll of interface designer
    input                               pll_inst1_CLKOUT0          ,
    input                               pll_inst1_LOCKED           ,
    input                               clk_pixel_parallel         ,
    // input                               clk_pixel_serial         ,
//jtag config
    input                               jtag_inst2_CAPTURE         ,
    input                               jtag_inst2_DRCK            ,
    input                               jtag_inst2_RESET           ,
    input                               jtag_inst2_RUNTEST         ,
    input                               jtag_inst2_SEL             ,
    input                               jtag_inst2_SHIFT           ,
    input                               jtag_inst2_TCK             ,
    input                               jtag_inst2_TDI             ,
    input                               jtag_inst2_TMS             ,
    input                               jtag_inst2_UPDATE          ,
    output                              jtag_inst2_TDO             ,
//uart interface
    input                               uart_rx                    ,
    output                              uart_tx          		   ,           
//led interface
    output             [   7:0]         led_data                   ,
//HDMI Interface
    output             [   9:0]         tmds_lvds_tx_clk_o         ,
    output             [   9:0]         tmds_lvds_tx_data0         ,
    output             [   9:0]         tmds_lvds_tx_data1         ,
    output             [   9:0]         tmds_lvds_tx_data2         ,
    output                              tmds_lvds_tx_clk_oe        ,
    output                              tmds_lvds_tx_data0_oe      ,
    output                              tmds_lvds_tx_data1_oe      ,
    output                              tmds_lvds_tx_data2_oe      ,
    output                              tmds_lvds_tx_clk_rst       ,
    output                              tmds_lvds_tx_data0_rst     ,
    output                              tmds_lvds_tx_data1_rst     ,
    output                              tmds_lvds_tx_data2_rst      

);
wire    clk_ref = pll_inst1_CLKOUT0;    //96MHz
wire    sys_rst_n = pll_inst1_LOCKED;   
assign 		tmds_lvds_tx_clk_rst	= 'b0;
assign 		tmds_lvds_tx_data0_rst	= 'b0;
assign 		tmds_lvds_tx_data1_rst	= 'b0;
assign 		tmds_lvds_tx_data2_rst	= 'b0;
assign 		tmds_lvds_tx_clk_oe		= 'b1;
assign 		tmds_lvds_tx_data0_oe	= 'b1;
assign 		tmds_lvds_tx_data1_oe	= 'b1;
assign 		tmds_lvds_tx_data2_oe	= 'b1;
// =========================================================================================================================================
// soc inst
// ========================================================================================================================================= 
parameter                           ADDR_WIDTH  = 16           ;
parameter                           DATA_WIDTH  = 8           ;
parameter                           NUM_REG    = 4             ;
wire                   [ADDR_WIDTH-1:0] PADDR                      ;
wire                                    PSEL                       ;
wire                                    PENABLE                    ;
wire                                    PREADY                     ;
wire                                    PWRITE                     ;
wire                   [DATA_WIDTH-1:0] PWDATA                     ;
wire                   [DATA_WIDTH-1:0] PRDATA                     ;
wire                                    PSLVERRO                   ;
soc_test u_soc_test
(
.io_systemClk                      (clk_ref           ),
.io_asyncReset                     (~sys_rst_n        ),


.jtagCtrl_tck                      (jtag_inst2_TCK    ),
.jtagCtrl_tdi                      (jtag_inst2_TDI    ),
.jtagCtrl_tdo                      (jtag_inst2_TDO    ),
.jtagCtrl_enable                   (jtag_inst2_SEL    ),
.jtagCtrl_capture                  (jtag_inst2_CAPTURE),
.jtagCtrl_shift                    (jtag_inst2_SHIFT  ),
.jtagCtrl_update                   (jtag_inst2_UPDATE ),
.jtagCtrl_reset                    (jtag_inst2_RESET  ),

.system_gpio_0_io_write            (          ),
.system_gpio_0_io_writeEnable      (                  ),
.system_gpio_0_io_read             (                  ),

.system_uart_0_io_txd              (uart_tx           ),
.system_uart_0_io_rxd              (uart_rx           ),

.io_apbSlave_0_PADDR               (   PADDR    ),
.io_apbSlave_0_PSEL                (   PSEL     ),
.io_apbSlave_0_PENABLE             (   PENABLE  ),
.io_apbSlave_0_PREADY              (   PREADY   ),
.io_apbSlave_0_PWRITE              (   PWRITE   ),
.io_apbSlave_0_PWDATA              (   PWDATA   ),
.io_apbSlave_0_PRDATA              (   PRDATA   ),
.io_apbSlave_0_PSLVERROR           (   PSLVERROR),




.system_spi_0_io_data_0_read       (                  ),
.system_spi_0_io_data_0_write      (                  ),
.system_spi_0_io_data_0_writeEnable(                  ),
.system_spi_0_io_data_1_read       (                  ),
.system_spi_0_io_data_1_write      (                  ),
.system_spi_0_io_data_1_writeEnable(                  ),
.system_spi_0_io_data_2_read       (                  ),
.system_spi_0_io_data_2_write      (                  ),
.system_spi_0_io_data_2_writeEnable(                  ),
.system_spi_0_io_data_3_read       (                  ),
.system_spi_0_io_data_3_write      (                  ),
.system_spi_0_io_data_3_writeEnable(                  ),
.system_spi_0_io_sclk_write        (                  ),
.userInterruptA                    (                  ),

.io_systemReset                    (                  ),
.system_spi_0_io_ss                (                  ) 
);

// =========================================================================================================================================
// HDMI Display
// ========================================================================================================================================= 
wire                                    lcd_hs                     ;
wire                                    lcd_vs                     ;
wire                                    lcd_en                     ;
wire                   [  23:0]         lcd_rgb                    ;
wire                                    lcd_request                ;
wire                   [  11:0]         lcd_xpos                   ;
wire                   [  11:0]         lcd_ypos                   ;
wire                   [  23:0]         pix_data_out               ;
vga_pic  u_vga_pic (
    .vga_clk                           (clk_pixel_parallel        ),
    .sys_clk                           (clk_ref                   ),
    .sys_rst_n                         (sys_rst_n                 ),


    .PADDR                             (PADDR                     ),
    .PSEL                              (PSEL                      ),
    .PENABLE                           (PENABLE                   ),
    .PREADY                            (PREADY                    ),
    .PWRITE                            (PWRITE                    ),
    .PWDATA                            (PWDATA                    ),
    .PRDATA                            (PRDATA                    ),
    .PRDATA_EN                         (                          ),
    .PSLVERROR                         (                          ),
    
    .pix_x                             (lcd_xpos         [11:0]   ),
    .pix_y                             (lcd_ypos         [11:0]   ),

    .pix_data_out                      (pix_data_out              ) 
);

  
lcd_driver  u_lcd_driver (
    .clk                               (clk_pixel_parallel        ),
    .rst_n                             (sys_rst_n                 ),
    .lcd_data                          (pix_data_out              ),



    .lcd_hs                            (lcd_hs                    ),
    .lcd_vs                            (lcd_vs                    ),
    .lcd_en                            (lcd_en                    ),
    .lcd_rgb                           (lcd_rgb      [23:0]       ),
    .lcd_request                       (lcd_request               ),
    .lcd_xpos                          (lcd_xpos     [11:0]       ),
    .lcd_ypos                          (lcd_ypos     [11:0]       ) 
);


// =========================================================================================================================================
// HDMI interface
// ========================================================================================================================================= 
    rgb2dvi #(.ENABLE_OSERDES(0)) u_rgb2dvi
    (
    .oe_i                              (1                         ),//	Always enable output
    .bitflip_i                         (4'b0000                   ),//	Reverse clock & data lanes. 
		
    .aRst                              (1'b0                      ),
    .aRst_n                            (sys_rst_n                 ),
		
    .PixelClk                          (clk_pixel_parallel        ),//pixel clk = 74.25M
    .SerialClk                         (                          ),//pixel clk *5 = 371.25M
		
    .vid_pVSync                        (lcd_vs                    ),
    .vid_pHSync                        (lcd_hs                    ),
    .vid_pVDE                          (lcd_en                    ),
    // .vid_pData                         ({lcd_red, lcd_green, lcd_blue}),
    .vid_pData                         (lcd_rgb),
		
    .txc_o                             (tmds_lvds_tx_clk_o        ),
    .txd0_o                            (tmds_lvds_tx_data0        ),
    .txd1_o                            (tmds_lvds_tx_data1        ),
    .txd2_o                            (tmds_lvds_tx_data2        ) 
    );
	

endmodule


