/*
 * file main.c
 */

#include "efm32gg12b810f1024gm64.h"
#include "os.h"

#define COUNT_UP_VALUE              (1000000)

extern void os_start (void);
extern void context_switch (void);

void task0(void);
void task1(void);

int main (void) {

	os_init();

	os_add(task0);
	os_add(task1);

	os_start();

}



void task0 (void) {
	// TODO
    // Enable GPIO HFBUSCLK.
    CMU->HFBUSCLKEN0 |= 0x10;
    // Clear PA12 bit field.
    GPIO->P[0].MODEH &= ~0x000F0000;
    // Set PA12 to Push-pull output.
    GPIO->P[0].MODEH |= 0x00040000;
    // Loop
    int time = 0;
    while (1) {
        // Delay.
        for(volatile int i = 0; i < COUNT_UP_VALUE; i++);
        // Toggle PA12.
        GPIO->P[0].DOUT ^= 0x1000;
        time++;
        if (time > 5) break;
    }
    context_switch();
}

void task1 (void) {
    // Enable GPIO HFBUSCLK.
    CMU->HFBUSCLKEN0 |= 0x10;
    // Clear PA12 bit field.
    // GPIO_PD_MODEL
    GPIO->P[3].MODEL &= ~0x0F000000;
    // Set PA12 to Push-pull output.
    GPIO->P[3].MODEL |= 0x04000000;
    // Loop
    int time = 0;
    while (1) {
        // Delay.
        for(volatile int i = 0; i < COUNT_UP_VALUE; i++);
        // Toggle PA12.
        GPIO->P[3].DOUT ^= 0x0040;
        time++;
        if (time > 5) break;
    }
    context_switch();
}
