/*!
 * @file main.c
 * ----------
 * @brief
 *
 */

#include "efm32gg12b810f1024gm64.h"

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
 * @brief  Assembly function to initialize GPIO pins with 7 input parameters and 1 return value.
 */
extern unsigned long gpio_init (
                                int led0r_enabled,
                                int led0b_enabled,
                                int led0g_enabled,
                                int led1r_enabled,
                                int led1b_enabled,
                                int led1g_enabled,
                                int button_selection
                               );

/**
 * gpio_operation
 * ----------
 * @brief Assembly function to perform the gpio logic.
 */
extern void gpio_operation (void);

/**
 * delay
 * ----------
 * @param  count_value  Value to be count up to.
 * ----------
 * @brief  Delay by counting up to a input value.
 */
void delay (unsigned long count_value) {
    for (volatile int i = 0; i < count_value; i++);
}

/**
 * main
 * ----------
 * @brief Main function.
 */
int main (void) {
    // Initialize desired GPIO ports.
    unsigned long count_value = gpio_init(1, 1, 1, 1, 1, 1, 0);
    // Loop
    while(1) {
        // Delay before doing anything with GPIO.
        delay(count_value);
        // Perform GPIO logic.
        gpio_operation();
    }
}
