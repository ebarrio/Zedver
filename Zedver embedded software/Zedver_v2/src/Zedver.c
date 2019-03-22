#include "Zedver.h"
/***************************************************************************//**
 * @brief Zedver dma test nº1
 *
 * @param ad9467_dma - AD9467 DMA Core.
 *	Note:
 *		Reads all values of dma and calculates histogram
 * @return 0.
*******************************************************************************/
void zedver_dma_test1(dmac_core ad9467_dma){
	uint32_t reg_data [ad9467_dma.transfer->no_of_samples];
	//Read data
	for (int i = 0 ; i < ad9467_dma.transfer->no_of_samples ; i++){
		dmac_read( ad9467_dma , ad9467_dma.base_address + i , &reg_data[i]);
	}
	//Calculate histogram with 256 bins
}
