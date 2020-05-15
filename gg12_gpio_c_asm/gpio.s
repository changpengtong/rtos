/*
 * @file gpio.s
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
    /* Application Macros */
	.equ COUNT_UP_VALUE,            		(1000000)
    /* Global Functions */
	.global gpio_init
	.global gpio_operation

gpio_init:

    BX          LR

gpio_operation:

    BX          LR
