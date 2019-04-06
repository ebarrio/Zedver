typedef struct{
	u8_t mode; 
	u8_t petic;
	u16_t lengthRAW;
	u16_t lengthHisto;
	u16_t lengthProcess;
	u16_t pay [PAYLOAD_SIZE_16b];
	u16_t raw_in_buffer;
	u16_t histo_in_buffer;
	u16_t process_in_buffer;
	u8_t ready_to_send;
}Com_struct;
void histogram (u16_t sim_array[], u16_t histo_array[]);
void bytes_to_buffer(u16_t data[] , u8_t bytes[] , u16_t buffer_length, u16_t offset);
unsigned short uchars_to_ushort (u8_t ByteMSV, u8_t ByteLSV);
/*Inicializamiento y visualizacion*/
Com_struct init_struct(u8_t mode, u8 petic, u16_t, u16_t, u16_t);
void print_Com_struct_head(Com_struct);
void print_Com_struct(Com_struct);
/*Modificaciones*/
u16_t write_in_pay (Com_struct *, u8_t [],u16_t);
Com_struct process_Com_struct(Com_struct);
u16_t set_raw_data(Com_struct * in, u8_t data[], u16_t bytes_data, u16_t bytes_offset);
u16_t set_histo_data(Com_struct * in, u8_t data[], u16_t bytes_data, u16_t bytes_offset);
u16_t set_process_data(Com_struct * in, u8_t data[], u16_t bytes_data, u16_t bytes_offset);
