/*!
 * @file gpio.c
 * ----------
 * @brief
 *
 */

#include "efm32gg12b810f1024gm64.h"

#define COUNT_UP_VALUE              (1000000)

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
unsigned long gpio_init (
                         int led0r_enabled,
                         int led0b_enabled,
                         int led0g_enabled,
                         int led1r_enabled,
                         int led1b_enabled,
                         int led1g_enabled,
                         int button_selection
                        ) {

    return COUNT_UP_VALUE;
}

/**
 * gpio_operation
 * ----------
 * @brief Assembly function to perform the gpio logic.
 */
void gpio_operation (void) {

}
