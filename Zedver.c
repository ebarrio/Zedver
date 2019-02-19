#include "Zedver.h"
void histogram (u16_t sim_array[], u16_t histo_array[]){
    for (int i = 0; i < HISTOGRAM_LEVELS ; i++){
        histo_array [i] = 0;
    }
    for (int i = 0; i < SIMU_BUF_SIZE_16b; i++){
        histo_array[(sim_array[i])]++;
    }
}
unsigned short uchars_to_ushort (unsigned char byteMSV, unsigned char byteLSV){
	unsigned short out = 0;
	out = byteLSV | (((unsigned short) byteMSV << 8) & 0xFF00);
	return out;
}
/*
 * init_struct
 * Set the parameters and put them in the headboard of payload vector
 * Return Com_struct with fixed parameters
 */
Com_struct init_struct(u8_t mode, u8 petic, u16_t bytesRAW, u16_t bytesHisto, u16_t bytesProcess){
	Com_struct out;
	out.mode = mode;
	out.petic = petic;
	if (bytesRAW + bytesHisto + bytesProcess + 4*sizeof(u16_t) < (PAYLOAD_SIZE_16b*2)){
		out.lengthRAW = bytesRAW/2;
		out.lengthHisto = bytesHisto/2;
		out.lengthProcess = bytesProcess/2;
		out.pay[0] = uchars_to_ushort(mode,petic);
		out.pay[1] = bytesRAW;
		out.pay[2] = bytesHisto;
		out.pay[3] = bytesProcess;
	}
	else{
		out.lengthRAW = 0;
		out.lengthHisto = 0;
		out.lengthProcess = 0;
	}
	out.raw_in_buffer = 0;
	out.histo_in_buffer = 0;
	out.process_in_buffer = 0;
	out.ready_to_send = 0;
	return out;
}
/*
 * print_Com_struct_head
 * Print in terminal head parameters of Com_struct
 */
void print_Com_struct_head(Com_struct in){
	xil_printf("\r\n Mode: %u ; Peticion: %u\r\n; lengthRAW: %u; lengthHisto: %u lengthProcess: %u \r\n"
			, in.mode, in.petic, in.lengthRAW, in.lengthHisto, in.lengthProcess);
}
/*
 * print_Com_struct
 * Print in terminal head parameters of Com_struct and all payload
 */
void print_Com_struct(Com_struct in){
	xil_printf("\r\n Mode: %u ; Peticion: %u\r\n; lengthRAW: %u; lengthHisto: %u lengthProcess: %u \r\n"
			, in.mode, in.petic, in.lengthRAW, in.lengthHisto, in.lengthProcess);
	xil_printf("	RAW data: \r\n");
	for(int i = 4; i < (4 + in.lengthRAW) ; i++){
		if(i%6 == 0)
			xil_printf("\r\n");
		xil_printf("%u ", in.pay[i]);
	}
	xil_printf("	Histogram data: \r\n");
	for(int i = (4 + in.lengthRAW); i < (4 + in.lengthRAW + in.lengthHisto) ; i++){
		if(i%6 == 0)
			xil_printf("\r\n");
		xil_printf("%u ", in.pay[i]);
	}
	xil_printf("	Process data: \r\n");
	for(int i = (4 + in.lengthRAW + in.lengthHisto) ; i < (4 + in.lengthRAW + in.lengthHisto + in.lengthProcess) ; i++){
		if(i%6 == 0)
			xil_printf("\r\n");
		xil_printf("%u ", in.pay[i]);
	}
}
void check_if_ready_to_send(Com_struct * in){
	if((in -> raw_in_buffer >= in -> lengthRAW)
		&& (in -> histo_in_buffer >= in -> lengthHisto)
		&& (in -> process_in_buffer >= in -> lengthProcess)){
		in->ready_to_send = 1; }
}
u16_t write_in_pay (Com_struct * in, u8_t data [], u16_t bytes_data){
	u16_t bytes_left = bytes_data;
	if(bytes_data > 0){
		bytes_left = set_raw_data(in, data, bytes_left);
	}
	if(bytes_data > 0){
		bytes_left = set_histo_data(in, data, bytes_left);
	}
	if(bytes_data > 0){
		bytes_left = set_process_data(in, data, bytes_left);
	}
	check_if_ready_to_send(in);
	return bytes_left;
}
u16_t set_raw_data(Com_struct * in, u8_t data[], u16_t bytes_data){
	u16_t space_in_buffer_bytes = sizeof(u16_t) * (in ->lengthRAW - in->raw_in_buffer);
	u16_t remaining_bytes = 0, bytes_to_write = bytes_data;
	if(bytes_to_write > space_in_buffer_bytes){
		remaining_bytes = bytes_to_write - space_in_buffer_bytes;
		bytes_to_write = space_in_buffer_bytes;
	}
	for(int i = 0; i < bytes_to_write; i++){
		in->pay[(CABECERA_SIZE_16b + in->raw_in_buffer + i)/2] = uchars_to_ushort(data[i],data[i+1]); }
	in->raw_in_buffer += bytes_to_write;
	return remaining_bytes;
}
u16_t set_histo_data(Com_struct * in, u8_t data[], u16_t bytes_data){
	u16_t space_in_buffer_bytes = sizeof(u16_t) * (in ->lengthHisto - in->histo_in_buffer);
	u16_t remaining_bytes = 0, bytes_to_write = bytes_data;
	if(bytes_to_write > space_in_buffer_bytes){
		remaining_bytes = bytes_to_write - space_in_buffer_bytes;
		bytes_to_write = space_in_buffer_bytes;
	}
	for(int i = 0; i < bytes_to_write; i++){
		in->pay[(CABECERA_SIZE_16b + in->lengthRAW + in->histo_in_buffer + i)/2] =
				uchars_to_ushort(data[i],data[i+1]); }
	in->histo_in_buffer += bytes_to_write;
	return remaining_bytes;
}
u16_t set_process_data(Com_struct * in, u8_t data[], u16_t bytes_data){
	u16_t space_in_buffer_bytes = sizeof(u16_t) * (in ->lengthProcess - in->process_in_buffer);
	u16_t remaining_bytes = 0, bytes_to_write = bytes_data;
	if(bytes_to_write > space_in_buffer_bytes){
		remaining_bytes = bytes_to_write - space_in_buffer_bytes;
		bytes_to_write = space_in_buffer_bytes;
	}
	for(int i = 0; i < bytes_to_write; i++){
		in->pay[(CABECERA_SIZE_16b + in->lengthRAW + in->lengthHisto + in->process_in_buffer + i)/2] =
				uchars_to_ushort(data[i],data[i+1]); }
	in->process_in_buffer += bytes_to_write;
	return remaining_bytes;
}
Com_struct process_Com_struct(Com_struct in){
	Com_struct out;
	if(in.mode == 9){
		out = in;
	}
	else{
		out = in;
	}
	return out;
}

