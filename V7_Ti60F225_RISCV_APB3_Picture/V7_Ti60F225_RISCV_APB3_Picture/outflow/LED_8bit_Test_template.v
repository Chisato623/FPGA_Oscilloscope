
// Efinity Top-level template
// Version: 2024.2.294.1.19
// Date: 2024-06-21 16:44

// Copyright (C) 2013 - 2024 Efinix Inc. All rights reserved.

// This file may be used as a starting point for Efinity synthesis top-level target.
// The port list here matches what is expected by Efinity constraint files generated
// by the Efinity Interface Designer.

// To use this:
//     #1)  Save this file with a different name to a different directory, where source files are kept.
//              Example: you may wish to save as LED_8bit_Test.v
//     #2)  Add the newly saved file into Efinity project as design file
//     #3)  Edit the top level entity in Efinity project to:  LED_8bit_Test
//     #4)  Insert design content.


module LED_8bit_Test
(
  (* syn_peri_port = 0 *) input clk,
  (* syn_peri_port = 0 *) input pll_inst1_LOCKED,
  (* syn_peri_port = 0 *) input clk_pixel_parallel,
  (* syn_peri_port = 0 *) input pll_inst1_CLKOUT0,
  (* syn_peri_port = 0 *) input clk_pixel_serial,
  (* syn_peri_port = 0 *) input jtag_inst2_CAPTURE,
  (* syn_peri_port = 0 *) input jtag_inst2_DRCK,
  (* syn_peri_port = 0 *) input jtag_inst2_RESET,
  (* syn_peri_port = 0 *) input jtag_inst2_RUNTEST,
  (* syn_peri_port = 0 *) input jtag_inst2_SEL,
  (* syn_peri_port = 0 *) input jtag_inst2_SHIFT,
  (* syn_peri_port = 0 *) input jtag_inst2_TCK,
  (* syn_peri_port = 0 *) input jtag_inst2_TDI,
  (* syn_peri_port = 0 *) input jtag_inst2_TMS,
  (* syn_peri_port = 0 *) input jtag_inst2_UPDATE,
  (* syn_peri_port = 0 *) input uart_rx,
  (* syn_peri_port = 0 *) output [7:0] led_data,
  (* syn_peri_port = 0 *) output jtag_inst2_TDO,
  (* syn_peri_port = 0 *) output tmds_lvds_tx_clk_oe,
  (* syn_peri_port = 0 *) output [9:0] tmds_lvds_tx_clk_o,
  (* syn_peri_port = 0 *) output tmds_lvds_tx_clk_rst,
  (* syn_peri_port = 0 *) output tmds_lvds_tx_data0_oe,
  (* syn_peri_port = 0 *) output [9:0] tmds_lvds_tx_data0,
  (* syn_peri_port = 0 *) output tmds_lvds_tx_data0_rst,
  (* syn_peri_port = 0 *) output tmds_lvds_tx_data1_oe,
  (* syn_peri_port = 0 *) output [9:0] tmds_lvds_tx_data1,
  (* syn_peri_port = 0 *) output tmds_lvds_tx_data1_rst,
  (* syn_peri_port = 0 *) output tmds_lvds_tx_data2_oe,
  (* syn_peri_port = 0 *) output [9:0] tmds_lvds_tx_data2,
  (* syn_peri_port = 0 *) output tmds_lvds_tx_data2_rst,
  (* syn_peri_port = 0 *) output uart_tx
);


endmodule

