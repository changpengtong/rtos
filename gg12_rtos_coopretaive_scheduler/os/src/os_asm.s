/*
 * @file os_asm.s
 */
    .section .text, "ax"                    // allocatable and executable
    //.balign 4                               // 4 bytes alignment, why?
    .syntax unified                         // Unified syntax between ARM and THUMB
    .thumb                                  // THUMB instructions

	.global os_start
	.global context_switch
	.global running_thread

os_start:
	LDR			R0, =running_thread
	LDR			R1, [R0]
	LDR			SP, [R1, #4]		// os boot

	POP			{LR}
	POP			{R0-R11, R12}

	BX			LR


context_switch:
	PUSH		{R0-R11, R12}
	PUSH		{LR}

	LDR			R0, =running_thread
	LDR			R1, [R0]

	STR			SP, [R1, #4]
	LDR			R1, [R1, #12] 		// next
	STR			R1, [R0]

	LDR			SP, [R1, #4]		//next's stack address

	POP			{LR}
	POP			{R0-R11, R12}

	BX			LR


    .align
    .end
