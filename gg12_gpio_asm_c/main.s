/*
 * @file main.s
 */
    .section .text, "ax"                    // allocatable and executable
    .balign 4                               // 4 bytes alignment, why?
    .syntax unified                         // Unified syntax between ARM and THUMB
    .thumb                                  // THUMB instructions

    /* Register Address Macros */
    .equ CMU_BASE,                  		(0x400E4000UL)
    .equ CMU_HFBUSCLKEN0_OFFSET,    		(0x0B0)
    .equ CMU_HFBUSCLKEN0,           		(CMU_BASE + CMU_HFBUSCLKEN0_OFFSET)
    .equ GPIO_BASE,							(0x40088000UL)
    .equ GPIO_PA_MODEH_OFFSET,      		(0x008)
    .equ GPIO_PA_MODEH,						(GPIO_BASE + GPIO_PA_MODEH_OFFSET)
    .equ GPIO_PA_DOUT_OFFSET,       		(0x00C)
    .equ GPIO_PA_DOUT,              		(GPIO_BASE + GPIO_PA_DOUT_OFFSET)
    /* Global Functions */
    .global main
    .global gpio_init
    .global gpio_operation

// Main function
main:
    BL          gpio_init                   // Initialize GPIO.
loop:                                       // Main loop.
    MOVS        R1, #0x0                    // Clear R1.
delay:                                      // Delay by counting up.
    ADDS        R1, #0x1                    // R1 += 1.
    CMP         R1, R0                      // Set condition by comparing R1 to R0.
	BNE         delay                       // If still counting, back to delay label.
    BL          gpio_operation				// Perform GPIO logic.
    B           loop                        // Back to loop.

    .align
    .end
