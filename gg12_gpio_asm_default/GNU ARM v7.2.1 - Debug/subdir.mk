################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_SRCS += \
../main.s 

OBJS += \
./main.o 


# Each subdirectory must supply rules for building sources it contributes
%.o: ../%.s
	@echo 'Building file: $<'
	@echo 'Invoking: GNU ARM Assembler'
	arm-none-eabi-gcc -g3 -gdwarf-2 -mcpu=cortex-m4 -mthumb -c -x assembler-with-cpp -I"/Users/changpengtong/SimplicityStudio/v4_workspace/gg12_gpio_asm_default/lib/efm32gg12b/inc" -I"/Users/changpengtong/SimplicityStudio/v4_workspace/gg12_gpio_asm_default/lib/cmsis/inc" '-DEFM32GG12B810F1024GM64=1' -mfpu=fpv4-sp-d16 -mfloat-abi=softfp -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


