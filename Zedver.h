#define GPIO_DEVICE_ID  XPAR_AXI_GPIO_0_DEVICE_ID	/* GPIO device that LEDs are connected to */
#define LED 0xFF									/* Initial LED value - XX0000XX */
#define LED_DELAY 10000000							/* Software delay length */
#define LED_CHANNEL 1								/* GPIO port for LEDs */
#define THREAD_STACKSIZE 1024
#define CABECERA_SIZE_16b 4
#define DATA_SIZE_16b 5000
#define PAYLOAD_SIZE_16b DATA_SIZE_16b + CABECERA_SIZE_16b
#define HISTOGRAM_LEVELS 256
#define PROCESS_SIZE_16b 3
#define RECV_BUF_BYTES 1500
#include "xil_printf.h"
#include <stdio.h>
#include <time.h>
//GPIO includes (leds):
#include "xgpio.h"
#include "xstatus.h"
//lwip includes
#include <sleep.h>
#include "netif/xadapter.h" //x_t variables
#include "platform_config.h"
#include "lwip/init.h"
#include "lwip/inet.h"
/*
 * Com struct
 * mode: 1 for write in simulation buffers, 2 for read of buffers
 * petition: Type of data to process
 * bytes_raw: Length in bytes of raw data
 * bytesRAW: Length in bytes of raw data
 * bytesRAW: Length in bytes of raw data
 */
typedef struct{
	u8_t mode;   //Mode: Write/Read request from the server
	u8_t petic; //Data type
	u16_t lengthRAW;
	u16_t lengthHisto;
	u16_t lengthProcess;
	u16_t pay [PAYLOAD_SIZE_16b];
	u16_t raw_in_buffer;
	u16_t histo_in_buffer;
	u16_t process_in_buffer;
	u8_t ready_to_send;
}Com_struct;

void histogram (u16_t sim_array[], u16_t histo_array[], u16_t data_length);
void bytes_to_buffer(u16_t data[] , u8_t bytes[] , u16_t buffer_length, u16_t offset);
unsigned short uchars_to_ushort (u8_t ByteMSV, u8_t ByteLSV);
/*Inicializamiento y visualizacion*/
Com_struct init_struct(u8_t mode, u8 petic, u16_t, u16_t, u16_t);
void print_Com_struct_head(Com_struct);
void print_Com_struct(Com_struct);
/*Modificaciones*/
u16_t write_in_pay (Com_struct *, u8_t [],u16_t);
u16_t set_raw_data(Com_struct * in, u8_t data[], u16_t bytes_data, u16_t bytes_offset);
u16_t set_histo_data(Com_struct * in, u8_t data[], u16_t bytes_data, u16_t bytes_offset);
u16_t set_process_data(Com_struct * in, u8_t data[], u16_t bytes_data, u16_t bytes_offset);
Com_struct process_Com_struct(Com_struct, Com_struct *);
void write_simulation_buffer(Com_struct, Com_struct *);
Com_struct process_simulation_buffer(Com_struct simulation);
void get_RAW_data (Com_struct , u16_t []);
void set_histogram(Com_struct* Com, u16_t histo_data []);


