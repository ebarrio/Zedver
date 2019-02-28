/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 *	Algorithm probes
 */
#include "Zedver.h"

void bytes_to_buffer_test();
void histogram_test();
void struct_test();
int main()
{
    init_platform();
    struct_test();
    cleanup_platform();
    return 0;
}
void struct_test() {
	Com_struct Task1;
	u16_t remaining = 0;
	u16_t data[10] = {1,1,1,1,1,1,1,1,1,1};
	Task1 = init_struct(/*Mode:*/1 ,/*Peti:*/7, /*RAW bytes*/10*sizeof(u8_t), /*Histo bytes:*/ 0, /*Process bytes:*/ 0);
	remaining = set_RAW_data(Task1, data, 10);
	xil_printf("Remaining bytes: %u", remaining);
	print_Com_struct(Task1);
	reset_RAW_data(Task1);
	print_Com_struct(Task1);
}
void histogram_test(){
	int i = 0;
	u16_t sim_array [SIM_HIST_ARRAY_SIZE];
	u16_t his_array [HISTOGRAM_LEVELS];
	srand(0);
	for (i = 0; i<SIM_HIST_ARRAY_SIZE; i++){
		if(i != 0)
		sim_array[i] = i*13;
		else
		sim_array[i] = (rand()+rand()) % 256;
	}
	for (i = 0; i<SIM_HIST_ARRAY_SIZE; i++){
		sim_array[i] = sim_array [i]/256;
	}
	histogram(sim_array , his_array);
	xil_printf("Valores del array \r\n");
	for (i = 0 ; i < SIM_HIST_ARRAY_SIZE ; i++){
		xil_printf("%d ", sim_array[i]);
		if ((i%10 == 0) & (i!=0)){
			xil_printf("\r\n");
		}
	}
	xil_printf("\r\n");
	xil_printf("Valores histograma \r\n");
	for (i = 0 ; i < HISTOGRAM_LEVELS ; i++){
		xil_printf("N%d: %d ", i, his_array[i]);
		if ((i%6 == 0) & (i!=0)){
			xil_printf("\r\n");
		}
	}
	xil_printf("\r\n");
}
void bytes_to_buffer_test(){

}
