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
