/*
 * @file main.c
 */

#include "efm32gg12b810f1024gm64.h"

#define COUNT_UP_VALUE              (1000000)

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

void state03 () {
	GPIO->P[0].DOUT |= 0xFFFF;
	GPIO->P[0].DOUT ^= 0x3000;             // R + B
}

void state04 () {
	GPIO->P[0].DOUT |= 0xFFFF;
	GPIO->P[0].DOUT ^= 0x5000;             // R + G
}

void state05 () {
	GPIO->P[0].DOUT |= 0xFFFF;
	GPIO->P[0].DOUT ^= 0x6000;             // B + G
}

void state06 () {
	GPIO->P[0].DOUT |= 0xFFFF;
	GPIO->P[0].DOUT ^= 0x7000;             // R + B + G
}

void state07 () {
	GPIO->P[0].DOUT |= 0xFFFF;
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

void state13 () {
	GPIO->P[3].DOUT |= 0xFFFF;
	GPIO->P[4].DOUT |= 0xFFFF;
	GPIO->P[5].DOUT |= 0xFFFF;
	GPIO->P[3].DOUT ^= 0x0040;
	GPIO->P[4].DOUT ^= 0x1000;
}

void state14 () {
	GPIO->P[3].DOUT |= 0xFFFF;
	GPIO->P[4].DOUT |= 0xFFFF;
	GPIO->P[5].DOUT |= 0xFFFF;
	GPIO->P[3].DOUT ^= 0x0040;
	GPIO->P[5].DOUT ^= 0x1000;
}

void state15 () {
	GPIO->P[3].DOUT |= 0xFFFF;
	GPIO->P[4].DOUT |= 0xFFFF;
	GPIO->P[5].DOUT |= 0xFFFF;
	GPIO->P[4].DOUT ^= 0x1000;
	GPIO->P[5].DOUT ^= 0x1000;
}

void state16 () {
	GPIO->P[3].DOUT |= 0xFFFF;
	GPIO->P[4].DOUT |= 0xFFFF;
	GPIO->P[5].DOUT |= 0xFFFF;
	GPIO->P[3].DOUT ^= 0x0040;
	GPIO->P[4].DOUT ^= 0x1000;
	GPIO->P[5].DOUT ^= 0x1000;
}

void state17 () {
	GPIO->P[3].DOUT |= 0xFFFF;
	GPIO->P[4].DOUT |= 0xFFFF;
	GPIO->P[5].DOUT |= 0xFFFF;
}

int main (void) {
    // Enable GPIO HFBUSCLK.
    CMU->HFBUSCLKEN0 |= 0x10;
    // Clear PA12 bit field.
    // Set PA12 to Push-pull output.
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


    int count1 = 0;
    int count2 = 0;
    // Loop
    while (1) {
        // Delay.
        for(volatile int i = 0; i < COUNT_UP_VALUE; i++);
        // Toggle PA12.
        if (GPIO->P[3].DIN == 0x140 || GPIO->P[3].DIN == 0x100) {
        	if (count1 == 0) {
        		state00();
        	} else if (count1 == 1) {
        		state01();
        	} else if (count1 == 2) {
        		state02();
        	} else if (count1 == 3) {
        		state03();
        	} else if (count1 == 4) {
        		state04();
        	} else if (count1 == 5) {
        		state05();
        	} else if (count1 == 6) {
        		state06();
        	} else if (count1 == 7) {
        		state07();
        		count1 = -1;
        	}
        	count1++;
        }
        if (GPIO->P[3].DIN == 0x60 || GPIO->P[3].DIN == 0x20) {
        	if (count2 == 0) {
        		state10();
        	} else if (count2 == 1) {
        		state11();
        	} else if (count2 == 2) {
        		state12();
        	} else if (count2 == 3) {
        		state13();
        	} else if (count2 == 4) {
        		state14();
        	} else if (count2 == 5) {
        		state15();
        	} else if (count2 == 6) {
        		state16();
        	} else if (count2 == 7) {
        		state17();
        		count2 = -1;
        	}
        	count2++;
        }
    }
}
