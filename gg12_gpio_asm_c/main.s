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

    .equ GPIO_PD_MODEL_OFFSET,      (0x094)
    .equ GPIO_PD_MODEL,				(GPIO_BASE + GPIO_PD_MODEL_OFFSET)
    .equ GPIO_PD_MODEH_OFFSET,      (0x098)
    .equ GPIO_PD_MODEH,				(GPIO_BASE + GPIO_PD_MODEH_OFFSET)

    .equ GPIO_PD_DIN_OFFSET,		(0x0AC)
    .equ GPIO_PD_DIN,				(GPIO_BASE + GPIO_PD_DIN_OFFSET)
    .equ GPIO_PD_DOUT_OFFSET,       (0x09C)
    .equ GPIO_PD_DOUT,              (GPIO_BASE + GPIO_PD_DOUT_OFFSET)

    .equ GPIO_PE_MODEH_OFFSET,      (0x0C8)
    .equ GPIO_PE_MODEH,				(GPIO_BASE + GPIO_PE_MODEH_OFFSET)
    .equ GPIO_PE_DOUT_OFFSET,       (0x0CC)
    .equ GPIO_PE_DOUT,              (GPIO_BASE + GPIO_PE_DOUT_OFFSET)

    .equ GPIO_PF_MODEH_OFFSET,      (0x0F8)
    .equ GPIO_PF_MODEH,				(GPIO_BASE + GPIO_PF_MODEH_OFFSET)
    .equ GPIO_PF_DOUT_OFFSET,       (0x0FC)
    .equ GPIO_PF_DOUT,              (GPIO_BASE + GPIO_PF_DOUT_OFFSET)

    .equ BUTTON, 					(0x20030008)
    .equ LEG1G,						(0x20030004)
    /* Global Functions */
    .global main
    .global gpio_init
    .global gpio_operation

// Main function
main:
	/* LDR			R0, =BUTTON
	LDR			R1, [R0]
	AND			R1, 0x00000000
	ORR			R1, 0x00000001
	STR			R1, [R0] */
	/* POP			{R0}
	POP			{R0}
	POP			{R0} */

	LDR			R0, =0x1
	LDR			R1, =0x1
	LDR			R2, =0x0
	PUSH		{R0-R2}

	//LDR			R7, =0x20030000
	//MOV 		R1, SP
	//LDR			R0, =0x20030000
	LDR			R0, =1
	LDR			R1, =1
	LDR			R2, =1
	LDR			R3, =1

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
