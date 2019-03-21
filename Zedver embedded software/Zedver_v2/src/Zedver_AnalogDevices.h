/******************************************************************************/
/***************************** Include Files **********************************/
/******************************************************************************/
#include <stdio.h>
#include "xil_cache.h"
#include "xparameters.h"
#include "AnalogDevicesDrivers\adc_core.h"
#include "AnalogDevicesDrivers\ad9467.h"
#include "AnalogDevicesDrivers\ad9517.h"
#include "AnalogDevicesDrivers\dmac_core.h"
#include "AnalogDevicesDrivers\platform_drivers.h"

/* ADC registers */
#define CF_REG_DELAY_CTRL			0x60
#define CF_REG_DELAY_STATUS			0x20
#define CF_REG_DATA_MONITOR			0x404

/* CF_REG_DATA_MONITOR bit definition. */
#define CF_DATA_MONITOR_PN_ERR		(1 << 2) // (Write 1 to clear)
#define CF_DATA_MONITOR_PN_SYNC		(1 << 1) // (Write 1 to clear)
#define CF_DATA_MONITOR_PN_OVER_RNG	(1 << 0) // (Write 1 to clear)

typedef enum typeOutputModes {
	OFFSET_BINARY = 0,
	TWOS_COMPLEMENT,
	GRAY_CODE,
} typeOutputModes;

typedef enum typeTestModes {
	TEST_DISABLE = 0,
	MIDSCALE,
	POS_FULLSCALE,
	NEG_FULLSCALE,
	CHECKERBOARD,
	PN_23_SEQUENCE,
	PN_9_SEQUENCE,
	ONE_ZERO_TOGGLE
} typeTestModes;

void adc_test(adc_core adc,
	      dmac_core dma,
	      struct ad9467_dev *dev,
	      uint32_t mode,
	      uint32_t format);
void DisplayTestMode(uint32_t mode, uint32_t format);
