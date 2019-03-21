#include "Zedver_AnalogDevices.h"

void adc_test(adc_core adc,
	      dmac_core dma,
	      struct ad9467_dev *dev,
	      uint32_t mode,
	      uint32_t format)
{
	uint32_t n = 0;
	uint32_t rdata;
	uint32_t edata = 0;
	uint32_t error = 0;
	int32_t read;

	ad9467_output_format(dev, format, &read);
	ad9467_test_mode(dev, mode, &read);
	ad9467_transfer(dev);
	dmac_start_transaction(dma);
	DisplayTestMode(mode, format);
	if ((mode == PN_23_SEQUENCE) || (mode == PN_9_SEQUENCE)) {
		if (format == TWOS_COMPLEMENT) {
			xil_printf("          Test skipped\r\n");
			return;
		}

		adc_set_pnsel(adc, 0, ((mode == PN_23_SEQUENCE) ? ADC_PN23A : ADC_PN9));
		mdelay(10);
		adc_write(adc,
			  CF_REG_DATA_MONITOR,
			  CF_DATA_MONITOR_PN_ERR |
			  CF_DATA_MONITOR_PN_SYNC |
			  CF_DATA_MONITOR_PN_OVER_RNG); // write ones to clear bits
		mdelay(100);
		adc_read(adc, CF_REG_DATA_MONITOR, &rdata);
		if ((rdata & (CF_DATA_MONITOR_PN_ERR |
			      CF_DATA_MONITOR_PN_SYNC |
			      CF_DATA_MONITOR_PN_OVER_RNG)) != 0) {
			adc_read(adc, CF_REG_DATA_MONITOR, &rdata);
			xil_printf("  ERROR: PN status(%04x).\n\r", rdata);
		} else {
			xil_printf("          Test passed\r\n");
		}
		return;
	}

	for (n = 0; n < 32; n++) {
		rdata = Xil_In32(dma.transfer->start_address+(n*4));
		if ((mode == MIDSCALE) && (format == OFFSET_BINARY))
			edata = 0x80008000;
		if ((mode == POS_FULLSCALE) && (format == OFFSET_BINARY))
			edata = 0xffffffff;
		if ((mode == NEG_FULLSCALE) && (format == OFFSET_BINARY))
			edata = 0x00000000;
		if ((mode == MIDSCALE) && (format == TWOS_COMPLEMENT))
			edata = 0x00000000;
		if ((mode == POS_FULLSCALE) && (format == TWOS_COMPLEMENT))
			edata = 0x7fff7fff;
		if ((mode == NEG_FULLSCALE) && (format == TWOS_COMPLEMENT))
			edata = 0x80008000;
		if (((mode == CHECKERBOARD) || (mode == ONE_ZERO_TOGGLE)) && (n == 0)) {
			edata = (rdata & 0xffff);
		}
		if ((mode == CHECKERBOARD) && (n == 0))
			edata = (edata == 0xaaaa) ? 0x5555aaaa : 0xaaaa5555;
		if ((mode == ONE_ZERO_TOGGLE) && (n == 0))
			edata = (edata == 0xffff) ? 0x0000ffff : 0xffff0000;
		if (rdata != edata) {
			xil_printf("  ERROR[%2u]: rcv(%08x), exp(%08x)\n\r", n, rdata,
			       edata);
			error = 1;
		}
	}
	if(error == 0) {
		xil_printf("		Test passed\r\n");
	}
}

void DisplayTestMode(uint32_t mode, uint32_t format)
{
	char *sMode;
	char *sFormat;

	switch(format) {
	case OFFSET_BINARY:
		sFormat = "OFFSET BINARY";
		break;
	case TWOS_COMPLEMENT:
		sFormat = "TWOS_COMPLEMENT";
		break;
	case GRAY_CODE:
		sFormat = "GRAY_CODE";
		break;
	default:
		sFormat = "";
		break;
	}
	switch(mode) {
	case TEST_DISABLE:
		sMode = "TEST_DISABLE BINARY";
		break;
	case MIDSCALE:
		sMode = "MIDSCALE";
		break;
	case POS_FULLSCALE:
		sMode = "POS_FULLSCALE";
		break;
	case NEG_FULLSCALE:
		sMode = "NEG_FULLSCALE BINARY";
		break;
	case CHECKERBOARD:
		sMode = "CHECKERBOARD";
		break;
	case PN_23_SEQUENCE:
		sMode = "PN_23_SEQUENCE";
		break;
	case PN_9_SEQUENCE:
		sMode = "PN_9_SEQUENCE";
		break;
	case ONE_ZERO_TOGGLE:
		sMode = "ONE_ZERO_TOGGLE";
		break;
	default:
		sMode = "";
		break;
	}
	xil_printf("ADC Test: mode - %s\r\n          format - %s\n\r",
	       sMode,
	       sFormat);
}
