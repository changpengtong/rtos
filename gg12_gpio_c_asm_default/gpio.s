/*
 * @file gpio.s
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
    /* Application Macros */
	.equ COUNT_UP_VALUE,            (10000)
    /* Global Functions */
	.global gpio_init
	.global gpio_operation

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
    STR         R1, [R0]        //R1, 0x1000           // Write result back to GPIO Port A MODEH register.

	MOV			R0, #0x10000
    BX          LR

gpio_operation:

    LDR			R0, =GPIO_PA_DOUT
	LDR			R8, [R0]
	EOR         R8, 0x1000
	STR			R8, [R0]

    BX          LR
