/*
 * @file main.c
 */

#include "efm32gg12b810f1024gm64.h"

#define COUNT_UP_VALUE              (1000000)

int main (void) {
    // Enable GPIO HFBUSCLK.
    CMU->HFBUSCLKEN0 |= 0x10;
    // Clear PA12 bit field.
    GPIO->P[0].MODEH &= ~0x000F0000;
    // Set PA12 to Push-pull output.
    GPIO->P[0].MODEH |= 0x00040000;
    // Loop
    while (1) {
        // Delay.
        for(volatile int i = 0; i < COUNT_UP_VALUE; i++);
        // Toggle PA12.
        GPIO->P[0].DOUT ^= 0x1000;
    }
}
