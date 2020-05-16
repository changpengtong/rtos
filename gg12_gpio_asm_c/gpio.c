/*!
 * @file gpio.c
 * ----------
 * @brief
 *
 */

#include "efm32gg12b810f1024gm64.h"

#define COUNT_UP_VALUE              (3000000)

/**
 * gpio_init
 * ----------
 * @param  led0r_enabled     Set 0 to disable led0r and 1 to enable led0r.
 * @param  led0b_enabled     Set 0 to disable led0b and 1 to enable led0b.
 * @param  led0g_enabled     Set 0 to disable led0g and 1 to enable led0g.
 * @param  led1r_enabled     Set 0 to disable led1r and 1 to enable led1r.
 * @param  led1b_enabled     Set 0 to disable led1b and 1 to enable led1b.
 * @param  led1g_enabled     Set 0 to disable led1g and 1 to enable led1g.
 * @param  button_selection  Set 0 to select button 0 and 1 to select button 1.
 * ----------
 * @return The desired delay count up value to be used in delay function.
 * ----------
 * @brief  C function to initialize GPIO pins with 7 input parameters and 1 return value.
 */
int myswitch = 2;

unsigned long gpio_init (
                         int led0r_enabled,
                         int led0b_enabled,
                         int led0g_enabled,
                         int led1r_enabled,
                         int led1b_enabled,
                         int led1g_enabled,
                         int button_selection
                        ) {

	CMU->HFBUSCLKEN0 |= 0x10;

	if (led0r_enabled == 1) {
	    GPIO->P[0].MODEH &= 0xFFF0FFFF;
	    GPIO->P[0].MODEH |= 0x00040000;
	}
	if (led0b_enabled == 1) {
	    GPIO->P[0].MODEH &= 0xFF0FFFFF;
	    GPIO->P[0].MODEH |= 0x00400000;
	}
	if (led0g_enabled == 1) {
	    GPIO->P[0].MODEH &= 0xF0FFFFFF;
	    GPIO->P[0].MODEH |= 0x04000000;
	}
	if (led1r_enabled == 1) {
	    GPIO->P[3].MODEL &= 0xF0FFFFFF;
	    GPIO->P[3].MODEL |= 0x04000000;
	}
	if (led1b_enabled == 1) {
	    GPIO->P[4].MODEH &= 0xFFF0FFFF;
	    GPIO->P[4].MODEH |= 0x00040000;
	}
	if (led1g_enabled == 1) {
	    GPIO->P[5].MODEH &= 0xFFF0FFFF;
	    GPIO->P[5].MODEH |= 0x00040000;
	}
	if (button_selection == 0) {
		myswitch = 0;
	    GPIO->P[3].MODEL &= 0xFF0FFFFF;
	    GPIO->P[3].MODEL |= 0x00100000;
	}
	if (button_selection == 1) {
		myswitch = 1;
	    GPIO->P[3].MODEH &= 0xFFFFFFF0;
	    GPIO->P[3].MODEH |= 0x00000001;
	}
    GPIO->P[0].DOUT |= 0xFFFFFFFF;
    GPIO->P[3].DOUT |= 0xFFFFFFFF;
    GPIO->P[4].DOUT |= 0xFFFFFFFF;
    GPIO->P[5].DOUT |= 0xFFFFFFFF;
    return COUNT_UP_VALUE;
}

/**
 * gpio_operation
 * ----------
 * @brief Assembly function to perform the gpio logic.
 */

int count1 = 0;
int count2 = 0;

void state00 () {
	GPIO->P[0].DOUT |= 0xFFFF;
	GPIO->P[0].DOUT ^= 0x1000;
}

void state01 () {
	GPIO->P[0].DOUT |= 0xFFFF;
	GPIO->P[0].DOUT ^= 0x2000;
}

void state02 () {
	GPIO->P[0].DOUT |= 0xFFFF;
	GPIO->P[0].DOUT ^= 0x4000;
}

void state03 () {
	GPIO->P[0].DOUT |= 0xFFFF;
	GPIO->P[0].DOUT ^= 0x3000;
}

void state04 () {
	GPIO->P[0].DOUT |= 0xFFFF;
	GPIO->P[0].DOUT ^= 0x5000;
}

void state05 () {
	GPIO->P[0].DOUT |= 0xFFFF;
	GPIO->P[0].DOUT ^= 0x6000;
}

void state06 () {
	GPIO->P[0].DOUT |= 0xFFFF;
	GPIO->P[0].DOUT ^= 0x7000;
}

void state07 () {
	GPIO->P[0].DOUT |= 0xFFFF;
}



void state10 () {
	GPIO->P[3].DOUT |= 0xFFFF;
	GPIO->P[4].DOUT |= 0xFFFF;
	GPIO->P[5].DOUT |= 0xFFFF;
	GPIO->P[3].DOUT ^= 0x0040;
}

void state11 () {
	GPIO->P[3].DOUT |= 0xFFFF;
	GPIO->P[4].DOUT |= 0xFFFF;
	GPIO->P[5].DOUT |= 0xFFFF;
	GPIO->P[4].DOUT ^= 0x1000;
}

void state12 () {
	GPIO->P[3].DOUT |= 0xFFFF;
	GPIO->P[4].DOUT |= 0xFFFF;
	GPIO->P[5].DOUT |= 0xFFFF;
	GPIO->P[5].DOUT ^= 0x1000;
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

void gpio_operation (void) {
    if (myswitch == 0 && GPIO->P[3].DIN == 0x40) {
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
    if (myswitch == 1 && (GPIO->P[3].DIN == 0x40 || GPIO->P[3].DIN == 0x0)) {
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
