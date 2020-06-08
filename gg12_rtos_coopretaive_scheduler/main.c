/*
 * file main.c
 */

#include "efm32gg12b810f1024gm64.h"
#include "os.h"

#define COUNT_UP_VALUE              (1000000)

extern void os_start (void);
extern void context_switch ();


void task0(void);
void task1(void);

int main (void) {

	os_init();

	os_add(task0);
	os_add(task1);

	os_start();

}

void state00 () {
	GPIO->P[0].DOUT |= 0xFFFF;
	GPIO->P[0].DOUT ^= 0x1000;             // R
}

void state01 () {
	GPIO->P[0].DOUT |= 0xFFFF;
	GPIO->P[0].DOUT ^= 0x2000;             // B
}

void state02 () {
	GPIO->P[0].DOUT |= 0xFFFF;
	GPIO->P[0].DOUT ^= 0x4000;             // G
}

void state10 () {
	GPIO->P[3].DOUT |= 0xFFFF;
	GPIO->P[4].DOUT |= 0xFFFF;
	GPIO->P[5].DOUT |= 0xFFFF;
	GPIO->P[3].DOUT ^= 0x0040;             // R
}

void state11 () {
	GPIO->P[3].DOUT |= 0xFFFF;
	GPIO->P[4].DOUT |= 0xFFFF;
	GPIO->P[5].DOUT |= 0xFFFF;
	GPIO->P[4].DOUT ^= 0x1000;             // B
}

void state12 () {
	GPIO->P[3].DOUT |= 0xFFFF;
	GPIO->P[4].DOUT |= 0xFFFF;
	GPIO->P[5].DOUT |= 0xFFFF;
	GPIO->P[5].DOUT ^= 0x1000;             // G
}


void task0 (void) {
    // Enable GPIO HFBUSCLK.
    CMU->HFBUSCLKEN0 |= 0x10;
    // Clear PA12 bit field.
    GPIO->P[0].MODEH &= 0xFFF0FFFF;
    GPIO->P[0].MODEH |= 0x00040000;

    GPIO->P[0].MODEH &= 0xFF0FFFFF;
    GPIO->P[0].MODEH |= 0x00400000;

    GPIO->P[0].MODEH &= 0xF0FFFFFF;
    GPIO->P[0].MODEH |= 0x04000000;

    GPIO->P[3].MODEL &= 0xF0FFFFFF;
    GPIO->P[3].MODEL |= 0x04000000;

    GPIO->P[4].MODEH &= 0xFFF0FFFF;
    GPIO->P[4].MODEH |= 0x00040000;

    GPIO->P[5].MODEH &= 0xFFF0FFFF;
    GPIO->P[5].MODEH |= 0x00040000;

    GPIO->P[3].MODEL &= 0xFF0FFFFF;
    GPIO->P[3].MODEL |= 0x00100000;

    GPIO->P[3].MODEH &= 0xFFFFFFF0;
    GPIO->P[3].MODEH |= 0x00000001;

    GPIO->P[0].DOUT |= 0xFFFFFFFF;
    GPIO->P[3].DOUT |= 0xFFFFFFFF;
    GPIO->P[4].DOUT |= 0xFFFFFFFF;
    GPIO->P[5].DOUT |= 0xFFFFFFFF;
    // Loop

    // set the timer to break
    int time = 0;

    // set the initial state
    int state = 0;

    while (1) {
        // Delay.
        for(volatile int i = 0; i < COUNT_UP_VALUE; i++);

        // Toggle PA12.
        if (state == 0) state00();
        else if (state == 1) state01();
        else state02();

        state++;
        if (state == 3) state = 0;

        time++;
        if (time > 1) {
        	time = 0;
        	context_switch();
        }
    }
}

void task1 (void) {
    // Enable GPIO HFBUSCLK.
//    CMU->HFBUSCLKEN0 |= 0x10;
//    // Clear PA12 bit field.
//    // GPIO_PD_MODEL
//    GPIO->P[0].MODEH &= 0xFFF0FFFF;
//    GPIO->P[0].MODEH |= 0x00040000;
//
//    GPIO->P[0].MODEH &= 0xFF0FFFFF;
//    GPIO->P[0].MODEH |= 0x00400000;
//
//    GPIO->P[0].MODEH &= 0xF0FFFFFF;
//    GPIO->P[0].MODEH |= 0x04000000;
//
//    GPIO->P[3].MODEL &= 0xF0FFFFFF;
//    GPIO->P[3].MODEL |= 0x04000000;
//
//    GPIO->P[4].MODEH &= 0xFFF0FFFF;
//    GPIO->P[4].MODEH |= 0x00040000;
//
//    GPIO->P[5].MODEH &= 0xFFF0FFFF;
//    GPIO->P[5].MODEH |= 0x00040000;
//
//    GPIO->P[3].MODEL &= 0xFF0FFFFF;
//    GPIO->P[3].MODEL |= 0x00100000;
//
//    GPIO->P[3].MODEH &= 0xFFFFFFF0;
//    GPIO->P[3].MODEH |= 0x00000001;
//
//    GPIO->P[0].DOUT |= 0xFFFFFFFF;
//    GPIO->P[3].DOUT |= 0xFFFFFFFF;
//    GPIO->P[4].DOUT |= 0xFFFFFFFF;
//    GPIO->P[5].DOUT |= 0xFFFFFFFF;
    // Loop

    // set timer to break;
    int time = 0;

    // set the initial state
    int state = 0;

    while (1) {
        // Delay.
        for(volatile int i = 0; i < COUNT_UP_VALUE; i++);
        // Toggle PA12.
        if (state == 0) state10();
        else if (state == 1) state11();
        else state12();

        state++;
        if (state == 3) state = 0;


        time++;
        if (time > 1) {
        	time = 0;
        	context_switch();
        }
    }
}
