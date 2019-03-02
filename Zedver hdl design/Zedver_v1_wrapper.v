//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
//Date        : Sat Mar  2 13:16:56 2019
//Host        : MSI running 64-bit major release  (build 9200)
//Command     : generate_target Zedver_v1_wrapper.bd
//Design      : Zedver_v1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module Zedver_v1_wrapper
   (DDR_addr,
    DDR_ba,
    DDR_cas_n,
    DDR_ck_n,
    DDR_ck_p,
    DDR_cke,
    DDR_cs_n,
    DDR_dm,
    DDR_dq,
    DDR_dqs_n,
    DDR_dqs_p,
    DDR_odt,
    DDR_ras_n,
    DDR_reset_n,
    DDR_we_n,
    FIXED_IO_ddr_vrn,
    FIXED_IO_ddr_vrp,
    FIXED_IO_mio,
    FIXED_IO_ps_clk,
    FIXED_IO_ps_porb,
    FIXED_IO_ps_srstb,
    SPI1_MISO_O_0,
    adc_clk_in_n_0,
    adc_clk_in_p_0,
    adc_data_in_n_0,
    adc_data_in_p_0,
    adc_or_in_n_0,
    adc_or_in_p_0,
    gpio_i,
    gpio_o,
    gpio_t,
    i2s_mclk,
    iic2intc_irpt_0,
    iic_fmc_scl_io,
    iic_fmc_sda_io,
    iic_mux_scl_i,
    iic_mux_scl_o,
    iic_mux_scl_t,
    iic_mux_sda_i,
    iic_mux_sda_o,
    iic_mux_sda_t,
    spi0_clk_i,
    spi0_clk_o,
    spi0_csn_0_o,
    spi0_csn_1_o,
    spi0_sdi_i,
    spi0_sdo_i,
    spi0_sdo_o,
    spi1_clk_i,
    spi1_clk_o,
    spi1_csn_0_o,
    spi1_csn_i,
    spi1_sdi_i,
    spi1_sdo_i,
    spi1_sdo_o,
    spi_csn_1_o,
    spi_csn_2_o,
    spi_csn_i,
    spio0_csn_0_o,
    spio0_csn_2_o);
  inout [14:0]DDR_addr;
  inout [2:0]DDR_ba;
  inout DDR_cas_n;
  inout DDR_ck_n;
  inout DDR_ck_p;
  inout DDR_cke;
  inout DDR_cs_n;
  inout [3:0]DDR_dm;
  inout [31:0]DDR_dq;
  inout [3:0]DDR_dqs_n;
  inout [3:0]DDR_dqs_p;
  inout DDR_odt;
  inout DDR_ras_n;
  inout DDR_reset_n;
  inout DDR_we_n;
  inout FIXED_IO_ddr_vrn;
  inout FIXED_IO_ddr_vrp;
  inout [53:0]FIXED_IO_mio;
  inout FIXED_IO_ps_clk;
  inout FIXED_IO_ps_porb;
  inout FIXED_IO_ps_srstb;
  output SPI1_MISO_O_0;
  input adc_clk_in_n_0;
  input adc_clk_in_p_0;
  input [7:0]adc_data_in_n_0;
  input [7:0]adc_data_in_p_0;
  input adc_or_in_n_0;
  input adc_or_in_p_0;
  input [63:0]gpio_i;
  output [63:0]gpio_o;
  output [63:0]gpio_t;
  output i2s_mclk;
  output iic2intc_irpt_0;
  inout iic_fmc_scl_io;
  inout iic_fmc_sda_io;
  input [1:0]iic_mux_scl_i;
  output [1:0]iic_mux_scl_o;
  output iic_mux_scl_t;
  input [1:0]iic_mux_sda_i;
  output [1:0]iic_mux_sda_o;
  output iic_mux_sda_t;
  input spi0_clk_i;
  output spi0_clk_o;
  output spi0_csn_0_o;
  output spi0_csn_1_o;
  input spi0_sdi_i;
  input spi0_sdo_i;
  output spi0_sdo_o;
  input spi1_clk_i;
  output spi1_clk_o;
  output spi1_csn_0_o;
  input spi1_csn_i;
  input spi1_sdi_i;
  input spi1_sdo_i;
  output spi1_sdo_o;
  output spi_csn_1_o;
  output spi_csn_2_o;
  input spi_csn_i;
  output spio0_csn_0_o;
  output spio0_csn_2_o;

  wire [14:0]DDR_addr;
  wire [2:0]DDR_ba;
  wire DDR_cas_n;
  wire DDR_ck_n;
  wire DDR_ck_p;
  wire DDR_cke;
  wire DDR_cs_n;
  wire [3:0]DDR_dm;
  wire [31:0]DDR_dq;
  wire [3:0]DDR_dqs_n;
  wire [3:0]DDR_dqs_p;
  wire DDR_odt;
  wire DDR_ras_n;
  wire DDR_reset_n;
  wire DDR_we_n;
  wire FIXED_IO_ddr_vrn;
  wire FIXED_IO_ddr_vrp;
  wire [53:0]FIXED_IO_mio;
  wire FIXED_IO_ps_clk;
  wire FIXED_IO_ps_porb;
  wire FIXED_IO_ps_srstb;
  wire SPI1_MISO_O_0;
  wire adc_clk_in_n_0;
  wire adc_clk_in_p_0;
  wire [7:0]adc_data_in_n_0;
  wire [7:0]adc_data_in_p_0;
  wire adc_or_in_n_0;
  wire adc_or_in_p_0;
  wire [63:0]gpio_i;
  wire [63:0]gpio_o;
  wire [63:0]gpio_t;
  wire i2s_mclk;
  wire iic2intc_irpt_0;
  wire iic_fmc_scl_i;
  wire iic_fmc_scl_io;
  wire iic_fmc_scl_o;
  wire iic_fmc_scl_t;
  wire iic_fmc_sda_i;
  wire iic_fmc_sda_io;
  wire iic_fmc_sda_o;
  wire iic_fmc_sda_t;
  wire [1:0]iic_mux_scl_i;
  wire [1:0]iic_mux_scl_o;
  wire iic_mux_scl_t;
  wire [1:0]iic_mux_sda_i;
  wire [1:0]iic_mux_sda_o;
  wire iic_mux_sda_t;
  wire spi0_clk_i;
  wire spi0_clk_o;
  wire spi0_csn_0_o;
  wire spi0_csn_1_o;
  wire spi0_sdi_i;
  wire spi0_sdo_i;
  wire spi0_sdo_o;
  wire spi1_clk_i;
  wire spi1_clk_o;
  wire spi1_csn_0_o;
  wire spi1_csn_i;
  wire spi1_sdi_i;
  wire spi1_sdo_i;
  wire spi1_sdo_o;
  wire spi_csn_1_o;
  wire spi_csn_2_o;
  wire spi_csn_i;
  wire spio0_csn_0_o;
  wire spio0_csn_2_o;

  Zedver_v1 Zedver_v1_i
       (.DDR_addr(DDR_addr),
        .DDR_ba(DDR_ba),
        .DDR_cas_n(DDR_cas_n),
        .DDR_ck_n(DDR_ck_n),
        .DDR_ck_p(DDR_ck_p),
        .DDR_cke(DDR_cke),
        .DDR_cs_n(DDR_cs_n),
        .DDR_dm(DDR_dm),
        .DDR_dq(DDR_dq),
        .DDR_dqs_n(DDR_dqs_n),
        .DDR_dqs_p(DDR_dqs_p),
        .DDR_odt(DDR_odt),
        .DDR_ras_n(DDR_ras_n),
        .DDR_reset_n(DDR_reset_n),
        .DDR_we_n(DDR_we_n),
        .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
        .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
        .FIXED_IO_mio(FIXED_IO_mio),
        .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
        .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
        .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
        .SPI1_MISO_O_0(SPI1_MISO_O_0),
        .adc_clk_in_n_0(adc_clk_in_n_0),
        .adc_clk_in_p_0(adc_clk_in_p_0),
        .adc_data_in_n_0(adc_data_in_n_0),
        .adc_data_in_p_0(adc_data_in_p_0),
        .adc_or_in_n_0(adc_or_in_n_0),
        .adc_or_in_p_0(adc_or_in_p_0),
        .gpio_i(gpio_i),
        .gpio_o(gpio_o),
        .gpio_t(gpio_t),
        .i2s_mclk(i2s_mclk),
        .iic2intc_irpt_0(iic2intc_irpt_0),
        .iic_fmc_scl_i(iic_fmc_scl_i),
        .iic_fmc_scl_o(iic_fmc_scl_o),
        .iic_fmc_scl_t(iic_fmc_scl_t),
        .iic_fmc_sda_i(iic_fmc_sda_i),
        .iic_fmc_sda_o(iic_fmc_sda_o),
        .iic_fmc_sda_t(iic_fmc_sda_t),
        .iic_mux_scl_i(iic_mux_scl_i),
        .iic_mux_scl_o(iic_mux_scl_o),
        .iic_mux_scl_t(iic_mux_scl_t),
        .iic_mux_sda_i(iic_mux_sda_i),
        .iic_mux_sda_o(iic_mux_sda_o),
        .iic_mux_sda_t(iic_mux_sda_t),
        .spi0_clk_i(spi0_clk_i),
        .spi0_clk_o(spi0_clk_o),
        .spi0_csn_0_o(spi0_csn_0_o),
        .spi0_csn_1_o(spi0_csn_1_o),
        .spi0_sdi_i(spi0_sdi_i),
        .spi0_sdo_i(spi0_sdo_i),
        .spi0_sdo_o(spi0_sdo_o),
        .spi1_clk_i(spi1_clk_i),
        .spi1_clk_o(spi1_clk_o),
        .spi1_csn_0_o(spi1_csn_0_o),
        .spi1_csn_i(spi1_csn_i),
        .spi1_sdi_i(spi1_sdi_i),
        .spi1_sdo_i(spi1_sdo_i),
        .spi1_sdo_o(spi1_sdo_o),
        .spi_csn_1_o(spi_csn_1_o),
        .spi_csn_2_o(spi_csn_2_o),
        .spi_csn_i(spi_csn_i),
        .spio0_csn_0_o(spio0_csn_0_o),
        .spio0_csn_2_o(spio0_csn_2_o));
  IOBUF iic_fmc_scl_iobuf
       (.I(iic_fmc_scl_o),
        .IO(iic_fmc_scl_io),
        .O(iic_fmc_scl_i),
        .T(iic_fmc_scl_t));
  IOBUF iic_fmc_sda_iobuf
       (.I(iic_fmc_sda_o),
        .IO(iic_fmc_sda_io),
        .O(iic_fmc_sda_i),
        .T(iic_fmc_sda_t));
endmodule
