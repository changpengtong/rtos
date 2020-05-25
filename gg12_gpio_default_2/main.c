/*
 * @file main.c
 */

#include "efm32gg12b810f1024gm64.h"

#define COUNT_UP_VALUE              (1000000)

int main (void) {
    // Enable GPIO HFBUSCLK.
    CMU->HFBUSCLKEN0 |= 0x10;
    // Clear PA12 bit field.
//    GPIO_PD_MODEL
    GPIO->P[3].MODEL &= ~0x0F000000;
    // Set PA12 to Push-pull output.
    GPIO->P[3].MODEL |= 0x04000000;
    // Loop
    while (1) {
        // Delay.
        for(volatile int i = 0; i < COUNT_UP_VALUE; i++);
        // Toggle PA12.
        GPIO->P[3].DOUT ^= 0x0040;
    }
}
