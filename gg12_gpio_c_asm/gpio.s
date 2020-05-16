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
	.equ COUNT_UP_VALUE,            (1000000)
    /* Global Functions */
	.global gpio_init
	.global gpio_operation

gpio_init:

    /* Enable High Frequency Bus Clock for GPIO. */
    LDR         R4, =CMU_HFBUSCLKEN0        // Get address of CMU HFBUSCLKEN0 register.
    LDR         R5, [R4]                    // Get value of CMU HFBUSCLKEN0 register.
    ORR         R5, 0x10                    // Enable GPIO HFBUSCLK.
    STR			R5, [R4]                    // Write result back to CMU HFBUSCLKEN0 register.

enablepa12:   /* enable LED0R (PA12). */
    CMP			R0, #0x1
    BNE			enablepa13

    LDR         R4, =GPIO_PA_MODEH          // Get address of GPIO Port A MODEH register.
    LDR         R5, [R4]                    // Get value of GPIO Port A MODEH register.
    AND         R5, 0xFFF0FFFF              // Clear PA12 bit field.
    ORR         R5, 0x00040000              // Set PA12 to Push-pull output.
    STR         R5, [R4]        //R1, 0x1000           // Write result back to GPIO Port A MODEH register.

enablepa13:
	CMP			R1, #0x1
	BNE			enablepa14

	LDR         R4, =GPIO_PA_MODEH
	LDR         R5, [R4]
	AND			R5, 0xFF0FFFFF
	ORR			R5, 0x00400000
	STR         R5, [R4]		//R1, 0x2000


enablepa14:
	CMP			R2, #0x1
	BNE			enablepd6

	LDR         R4, =GPIO_PA_MODEH
	LDR         R5, [R4]
	AND			R5, 0xF0FFFFFF
	ORR			R5, 0x04000000
	STR         R5, [R4]		//R1, 0x4000

enablepd6:
	CMP			R3, #0x1
	BNE			enablepe12

	LDR         R4, =GPIO_PD_MODEL
	LDR         R5, [R4]
	AND			R5, 0xF0FFFFFF
	ORR			R5, 0x04000000
	STR         R5, [R4]		//R1, 0x0040

enablepe12:
	POP			{R0}
	CMP			R0, #0x1
	BNE			enablepf12

	LDR         R4, =GPIO_PE_MODEH
	LDR         R5, [R4]
	AND			R5, 0xFFF0FFFF
	ORR			R5, 0x00040000
	STR         R5, [R4]		//R1, 0x1000

enablepf12:
	POP			{R0}
	CMP			R0, #0x1
	BNE			enablepd5

	LDR         R4, =GPIO_PF_MODEH
	LDR         R5, [R4]
	AND			R5, 0xFFF0FFFF
	ORR			R5, 0x00040000
	STR         R5, [R4]		//R1, 0x1000

enablepd5:
	POP			{R12}
	CMP			R12, #0x0
	BNE			enablepd8

	LDR         R4, =GPIO_PD_MODEL
	LDR         R5, [R4]
	AND			R5, 0xFF0FFFFF
	ORR			R5, 0x00100000
	STR         R5, [R4]		//R1, 0x0020
	B			clear

enablepd8:
	LDR         R4, =GPIO_PD_MODEH
	LDR         R5, [R4]
	AND			R5, 0xFFFFFFF0
	ORR			R5, 0x00000001
	STR         R5, [R4]		//R1, 0x0100

clear:
	LDR			R0, =GPIO_PA_DOUT
	LDR			R1, [R0]
	ORR			R1, 0xFFFFFFFF
	STR			R1, [R0]

	LDR			R0, =GPIO_PD_DOUT
	LDR			R1, [R0]
	ORR			R1, 0xFFFFFFFF
	STR			R1, [R0]

	LDR			R0, =GPIO_PE_DOUT
	LDR			R1, [R0]
	ORR			R1, 0xFFFFFFFF
	STR			R1, [R0]

	LDR			R0, =GPIO_PF_DOUT
	LDR			R1, [R0]
	ORR			R1, 0xFFFFFFFF
	STR			R1, [R0]

	LDR			R0, =COUNT_UP_VALUE

    BX          LR

gpio_operation:

    /* GPIO Operations. */
    LDR         R0, =GPIO_PA_DOUT           // Get address of GPIO Port A DOUT register.
    LDR         R1, [R0]                    // Get value of GPIO Port A DOUT register.
    LDR			R2, =GPIO_PD_DOUT
    LDR         R3, [R2]
    LDR			R4, =GPIO_PE_DOUT
    LDR         R5, [R4]
    LDR			R6, =GPIO_PF_DOUT
    LDR         R9, [R6]
	//MOV			R8, #0x0
	LDR			R10, =GPIO_PD_DIN
	LDR			R11, [R10]

	CMP			R12, 0x0
	BNE			button1

button0:
	CMP			R11, #0x40
	BNE			led0
	B 			mov00

led0:
	CMP			R11, #0x100
	BEQ			mov00
	B			store

mov00:
	CMP			R8, #0x0
	BEQ			state00
mov01:
	CMP			R8, #0x1
	BEQ			state01
mov02:
	CMP			R8, #0x2
	BEQ			state02
mov03:
	CMP			R8, #0x3
	BEQ			state03
mov04:
	CMP			R8, #0x4
	BEQ			state04
mov05:
	CMP			R8, #0x5
	BEQ			state05
mov06:
	CMP			R8, #0x6
	BEQ			state06
mov07:
	CMP			R8, #0x7
	BEQ			state07

aftermov0:
	ADDS		R8, #0x1
	CMP			R8, #0x8
	BEQ			resetr0
	B			store

state00:
	ORR			R1, 0xFFFF
 	B			aftermov0					// Empty

state01:
	ORR			R1, 0xFFFF
	EOR			R1, 0x1000
	B			aftermov0					// R

state02:
	ORR			R1, 0xFFFF
	EOR			R1, 0x2000
	B			aftermov0					// B

state03:
	ORR			R1, 0xFFFF
	EOR			R1, 0x3000
	B			aftermov0					// R + B

state04:
	ORR			R1, 0xFFFF
	EOR			R1, 0x4000
	B			aftermov0					// G

state05:
	ORR			R1, 0xFFFF
	EOR			R1, 0x5000
	B			aftermov0					// R + G

state06:
	ORR			R1, 0xFFFF
	EOR			R1, 0x6000
	B			aftermov0					// B + G

state07:
	ORR			R1, 0xFFFF
	EOR			R1, 0x7000
	B			aftermov0					// R + B + G

resetr0:
	MOVS		R8, #0x0
	B			store

button1:
	CMP			R11, #0x40
	BNE			led1
	B			mov10

led1:
	CMP			R11, #0x0
	BEQ			mov10
	B			store

mov10:
	CMP			R8, #0x0
	BEQ			state10
mov11:
	CMP			R8, #0x1
	BEQ			state11
mov12:
	CMP			R8, #0x2
	BEQ			state12
mov13:
	CMP			R8, #0x3
	BEQ			state13
mov14:
	CMP			R8, #0x4
	BEQ			state14
mov15:
	CMP			R8, #0x5
	BEQ			state15
mov16:
	CMP			R8, #0x6
	BEQ			state16
mov17:
	CMP			R8, #0x7
	BEQ			state17

aftermov1:
	ADDS		R8, #0x1
	CMP			R8, #0x8
	BEQ			resetr1
	B			store


state10:
	ORR			R3, 0xFFFF
	ORR			R5, 0xFFFF
	ORR			R9, 0xFFFF
 	EOR         R3, 0x0040
 	B			aftermov1					// R

state11:
	ORR			R3, 0xFFFF
	ORR			R5, 0xFFFF
	ORR			R9, 0xFFFF
	EOR			R5, 0x1000
	B			aftermov1					// B

state12:
	ORR			R3, 0xFFFF
	ORR			R5, 0xFFFF
	ORR			R9, 0xFFFF
	EOR			R9, 0x1000
	B			aftermov1					// G

state13:
	ORR			R3, 0xFFFF					// 10 + 11
	ORR			R5, 0xFFFF
	ORR			R9, 0xFFFF
	EOR         R3, 0x0040
	EOR			R5, 0x1000
	B			aftermov1

state14:
	ORR			R3, 0xFFFF					// 10 + 12
	ORR			R5, 0xFFFF
	ORR			R9, 0xFFFF
	EOR         R3, 0x0040
	EOR			R9, 0x1000
	B			aftermov1

state15:
	ORR			R3, 0xFFFF					// 11 + 12
	ORR			R5, 0xFFFF
	ORR			R9, 0xFFFF
	EOR			R5, 0x1000
	EOR			R9, 0x1000
	B			aftermov1

state16:
	ORR			R3, 0xFFFF					// 10 + 11 + 12
	ORR			R5, 0xFFFF
	ORR			R9, 0xFFFF
	EOR         R3, 0x0040
	EOR			R5, 0x1000
	EOR			R9, 0x1000
	B			aftermov1

state17:
	ORR			R3, 0xFFFF
	ORR			R5, 0xFFFF
	ORR			R9, 0xFFFF
	B			aftermov1					// Empty

resetr1:
	MOVS		R8, #0x0
	B			store

store:

    STR         R1, [R0]
    STR			R3, [R2]
    STR			R5, [R4]
    STR			R9, [R6]


    BX          LR
