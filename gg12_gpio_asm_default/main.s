/*
 * @file main.s
 */
    .section .text, "ax"                    // allocatable and executable
    .balign 4                               // 4 bytes alignment, why?
    .syntax unified                         // Unified syntax between ARM and THUMB
    .thumb                                  // THUMB instructions

    /* Register Address Macros */
    .equ CMU_BASE,                  (0x400E4000UL)
    .equ CMU_HFBUSCLKEN0_OFFSET,    (0x0B0)
    .equ CMU_HFBUSCLKEN0,           (CMU_BASE + CMU_HFBUSCLKEN0_OFFSET)
    .equ GPIO_BASE,					(0x40088000UL)
    .equ GPIO_PA_MODEH_OFFSET,      (0x008)
    .equ GPIO_PA_MODEH,				(GPIO_BASE + GPIO_PA_MODEH_OFFSET)
    .equ GPIO_PA_DOUT_OFFSET,       (0x00C)
    .equ GPIO_PA_DOUT,              (GPIO_BASE + GPIO_PA_DOUT_OFFSET)
    /* Application Macros */
	.equ COUNT_UP_VALUE,            (1000000)
    /* Global Functions */
    .global main

// initialize buttons and LEDs
gpio_init:
    /* Enable High Frequency Bus Clock for GPIO. */
    LDR         R0, =CMU_HFBUSCLKEN0        // Get address of CMU HFBUSCLKEN0 register.
    LDR         R1, [R0]                    // Get value of CMU HFBUSCLKEN0 register.
    ORR         R1, 0x10                    // Enable GPIO HFBUSCLK.
    STR			R1, [R0]                    // Write result back to CMU HFBUSCLKEN0 register.
    /* enable LED0R (PA12). */
    LDR         R0, =GPIO_PA_MODEH          // Get address of GPIO Port A MODEH register.
    LDR         R1, [R0]                    // Get value of GPIO Port A MODEH register.
    AND         R1, 0xFFF0FFFF              // Clear PA12 bit field.
    ORR         R1, 0x00040000              // Set PA12 to Push-pull output.
    STR         R1, [R0]                    // Write result back to GPIO Port A MODEH register.

	LDR			R0, =GPIO_PA_DOUT
	LDR			R1, [R0]
	ORR			R1, 0xFFFFFFFF
	STR			R1, [R0]
    /* Enable LED0B (PA13). */

    /* Enable LED0G (PA14). */

    /* Enable LED1R (PD6). */

    /* Enable LED1B (PE12). */

    /* Enable LED1G (PF12). */

    /* Enable Push Button 0 (PD5). */

    /* Enable Push Button 1 (PD8). */

    BX          LR

// Main function
main:
    BL          gpio_init                   // Initialize GPIO.
    /* GPIO Operations. */
    LDR         R0, =GPIO_PA_DOUT           // Get address of GPIO Port A DOUT register.
    LDR         R1, [R0]                    // Get value of GPIO Port A DOUT register.
    LDR         R3, =COUNT_UP_VALUE         // Set count up value.
loop:                                       // Main loop.
    EOR         R1, 0x1000                  // Toggle LED value.
    MOVS        R2, #0x0                    // Clear R2.
delay:                                      // Delay by counting up.
    ADDS        R2, #0x1                    // R2 += 1.
    CMP         R2, R3                      // Set condition by comparing R2 to R3.
	BNE         delay                       // If still counting, back to delay label.
    STR         R1, [R0]                    // Set LED0.
    B           loop                        // Back to loop.

    .align
    .end
