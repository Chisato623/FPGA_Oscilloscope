
// Efinity Top-level template
// Version: 2024.2.294.1.19
// Date: 2024-06-21 16:33

// Copyright (C) 2013 - 2024 Efinix Inc. All rights reserved.

// This file may be used as a starting point for Efinity synthesis top-level target.
// The port list here matches what is expected by Efinity constraint files generated
// by the Efinity Interface Designer.

// To use this:
//     #1)  Save this file with a different name to a different directory, where source files are kept.
//              Example: you may wish to save as Ti60_HDMI_CharDsiplay720P.v
//     #2)  Add the newly saved file into Efinity project as design file
//     #3)  Edit the top level entity in Efinity project to:  Ti60_HDMI_CharDsiplay720P
//     #4)  Insert design content.


module Ti60_HDMI_CharDsiplay720P
(
  (* syn_peri_port = 0 *) input clk_24M,
  (* syn_peri_port = 0 *) input pll_27m_LOCKED,
  (* syn_peri_port = 0 *) input sys_pll_LOCKED,
  (* syn_peri_port = 0 *) input clk27m,
  (* syn_peri_port = 0 *) input pll_inst2_CLKOUT0,
  (* syn_peri_port = 0 *) input clk_adc,
  (* syn_peri_port = 0 *) input clk_pixel,
  (* syn_peri_port = 0 *) input clk_ref,
  (* syn_peri_port = 0 *) input clk_pixel_5x,
  (* syn_peri_port = 0 *) input [7:0] DAM,
  (* syn_peri_port = 0 *) input [7:0] DBN,
  (* syn_peri_port = 0 *) input key_change,
  (* syn_peri_port = 0 *) output [5:0] led_o,
  (* syn_peri_port = 0 *) output sys_pll_RSTN,
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
  (* syn_peri_port = 0 *) output tmds_lvds_tx_data2_rst
);


endmodule

