/***************************************************************************//**
 *   @file   Main.c
 *   @brief  Implementation of the program's main function.
********************************************************************************
******************************************************************************/
#include "Zedver.h"
/***************************************************************************
 * @brief Main function.
 *
 * @return 0.
****************************************************************************/
int main()
{
	struct ad9467_dev *ad9467_device;
	struct ad9517_dev *ad9517_device;
	struct ad9467_init_param ad9467_init;
	struct ad9517_init_param ad9517_init;
	adc_core ad9467_core;
	dmac_core ad9467_dma;
	dmac_xfer rx_xfer;
	uint32_t mode;
	uint8_t ret_val;
	uint32_t ret_val_32;
	int32_t status;
	uint32_t i;

	Xil_ICacheEnable();
	Xil_DCacheEnable();

	/* base addresses */
	ad9467_core.base_address = XPAR_AXI_AD9467_BASEADDR;
	ad9467_dma.base_address = XPAR_AXI_AD9467_DMA_BASEADDR;

	rx_xfer.start_address = XPAR_DDR_MEM_BASEADDR + 0x800000;

	ad9467_core.no_of_channels = 1;
	ad9467_core.resolution = 16;
	ad9467_dma.transfer = &rx_xfer;
	ad9467_dma.type = DMAC_RX;
	rx_xfer.id = 0;
	rx_xfer.no_of_samples = 8192;

	ad9467_init.spi_init.type = ZYNQ_PS7_SPI;
	ad9517_init.spi_init.type = ZYNQ_PS7_SPI;

	ad9467_init.spi_init.chip_select = SPI_CHIP_SELECT(0);
	ad9467_init.spi_init.cpha = 0;
	ad9467_init.spi_init.cpol = 0;
	ad9517_init.spi_init.chip_select = SPI_CHIP_SELECT(1);
	ad9517_init.spi_init.cpha = 0;
	ad9517_init.spi_init.cpol = 0;

	/* AD9467 Setup. */
	ad9467_setup(&ad9467_device, ad9467_init);

	/* AD9517 Setup. */
	/* Initialize device. */
	ad9517_setup(&ad9517_device, ad9517_init);
	/* Set channel 3 for normal operation */
	ad9517_power_mode(ad9517_device, 3, 0);
	/* Set the channel 3 frequency to 250Mhz */
	ad9517_frequency(ad9517_device, 3, 250000000);
	/* Update registers */
	ad9517_update(ad9517_device);

	/* Read the device ID for AD9467 and AD9517. */
	xil_printf("\n\r*****************************************************\r\n");
	xil_printf("  ADI AD9467-FMC-EBZ Reference Design\n\r");
	ad9467_read(ad9467_device, AD9467_REG_CHIP_ID, &ret_val);
	xil_printf("  AD9467 CHIP ID: 0x%02x\n\r", ret_val);
	ad9467_read(ad9467_device, AD9467_REG_CHIP_GRADE, &ret_val);
	xil_printf("  AD9467 CHIP GRADE: 0x%02x\n\r", ret_val);
	ad9517_read(ad9517_device, AD9517_REG_PART_ID, &ret_val_32);
	xil_printf("  AD9517 CHIP ID: 0x%02x", ret_val_32);
	xil_printf("\n\r*****************************************************\r\n");

	/* AD9467 test. */
	adc_setup(ad9467_core);

	// setup device
	ad9467_write(ad9467_device, AD9467_REG_TEST_IO, 0x05); // pn23
	ad9467_write(ad9467_device, AD9467_REG_DEVICE_UPDATE, 0x01); // update
	ad9467_write(ad9467_device, AD9467_REG_DEVICE_UPDATE, 0x00);

	ad9467_read(ad9467_device, AD9467_REG_OUT_PHASE, &ret_val);
	xil_printf("AD9467[0x016]: %02x\n\r", ret_val);
	// setup adc core
	adc_write(ad9467_core, ADC_REG_CNTRL, 0x2);
	for(i = 0; i < ad9467_core.no_of_channels; i++) {
		adc_write(ad9467_core, ADC_REG_CHAN_CNTRL(i), 0x03);
	}
	adc_write(ad9467_core, ADC_REG_DELAY_CNTRL, 0x0);
	adc_write(ad9467_core, ADC_REG_DELAY_CNTRL, 0x20F1F);

	mdelay(10);
	if (adc_delay_calibrate(ad9467_core, 8, 1)) {
		ad9467_read(ad9467_device, 0x16, &ret_val);
		xil_printf("AD9467[0x016]: %02x\n\r", ret_val);
		ad9467_write(ad9467_device, AD9467_REG_OUT_PHASE, 0x80);
		ad9467_write(ad9467_device, AD9467_REG_DEVICE_UPDATE, 0x01);
		ad9467_write(ad9467_device, AD9467_REG_DEVICE_UPDATE, 0x00);
		ad9467_read(ad9467_device, 0x16, &ret_val);
		xil_printf("AD9467[0x016]: %02x\n\r", ret_val);
		mdelay(10);
		if (adc_delay_calibrate(ad9467_core, 16, 1)) {
			xil_printf("adc_setup: can not set a zero error delay!\n\r");
		}
	}

	/* Data pattern checks */
	for (mode = MIDSCALE; mode <= ONE_ZERO_TOGGLE; mode++) {
		/* Data format is offset binary */
		adc_test(ad9467_core, ad9467_dma, ad9467_device, mode, OFFSET_BINARY);
		/* Data format is twos complement */
		adc_test(ad9467_core, ad9467_dma, ad9467_device, mode, TWOS_COMPLEMENT);
	}
	xil_printf("Testing done.\n\r");
	/* AD9467 Setup for data acquisition */
	ad9467_output_invert(ad9467_device, 0, &status);	// Output invert Off
	ad9467_transfer(ad9467_device);				// Synchronously update registers
	ad9467_output_format(ad9467_device, 1, &status);	// Twos complement
	ad9467_transfer(ad9467_device);				// Synchronously update registers
	ad9467_reset_pn9(ad9467_device, 0, &status);		// Clear PN9 bit
	ad9467_transfer(ad9467_device);				// Synchronously update registers
	ad9467_reset_pn23(ad9467_device, 0, &status);		// Clear PN23 bit
	ad9467_transfer(ad9467_device);				// Synchronously update registers
	ad9467_test_mode(ad9467_device, 0, &status);		// Test mode Off
	ad9467_transfer(ad9467_device);				// Synchronously update registers

	xil_printf("Start capturing data...\n\r");

	dmac_start_transaction(ad9467_dma);

	xil_printf("Done.\n\r");

	ad9467_remove(ad9467_device);
	ad9517_remove(ad9517_device);

	Xil_DCacheDisable();
	Xil_ICacheDisable();

	return 0;
}
