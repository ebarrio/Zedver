/******************************************************************************/
/********************** Zedver Include Files **********************************/
/******************************************************************************/
#include "Zedver_AnalogDevices.h"

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

//void init_spi_devices();
void zedver_dma_test1(dmac_core);
