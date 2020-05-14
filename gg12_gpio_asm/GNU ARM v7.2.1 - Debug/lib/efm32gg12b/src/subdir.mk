################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_SRCS += \
../lib/efm32gg12b/src/startup_gcc_efm32gg12b.s 

C_SRCS += \
../lib/efm32gg12b/src/system_efm32gg12b.c 

OBJS += \
./lib/efm32gg12b/src/startup_gcc_efm32gg12b.o \
./lib/efm32gg12b/src/system_efm32gg12b.o 

C_DEPS += \
./lib/efm32gg12b/src/system_efm32gg12b.d 


# Each subdirectory must supply rules for building sources it contributes
lib/efm32gg12b/src/%.o: ../lib/efm32gg12b/src/%.s
	@echo 'Building file: $<'
	@echo 'Invoking: GNU ARM Assembler'
	arm-none-eabi-gcc -g3 -gdwarf-2 -mcpu=cortex-m4 -mthumb -c -x assembler-with-cpp -I"/Users/changpengtong/SimplicityStudio/v4_workspace/gg12_gpio_asm/lib/efm32gg12b/inc" -I"/Users/changpengtong/SimplicityStudio/v4_workspace/gg12_gpio_asm/lib/cmsis/inc" '-DEFM32GG12B810F1024GM64=1' -mfpu=fpv4-sp-d16 -mfloat-abi=softfp -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

lib/efm32gg12b/src/system_efm32gg12b.o: ../lib/efm32gg12b/src/system_efm32gg12b.c
	@echo 'Building file: $<'
	@echo 'Invoking: GNU ARM C Compiler'
	arm-none-eabi-gcc -g3 -gdwarf-2 -mcpu=cortex-m4 -mthumb -std=c99 '-DEFM32GG12B810F1024GM64=1' -I"/Users/changpengtong/SimplicityStudio/v4_workspace/gg12_gpio_asm/lib/efm32gg12b/inc" -I"/Users/changpengtong/SimplicityStudio/v4_workspace/gg12_gpio_asm/lib/cmsis/inc" -O0 -Wall -c -fmessage-length=0 -mno-sched-prolog -fno-builtin -ffunction-sections -fdata-sections -mfpu=fpv4-sp-d16 -mfloat-abi=softfp -MMD -MP -MF"lib/efm32gg12b/src/system_efm32gg12b.d" -MT"lib/efm32gg12b/src/system_efm32gg12b.o" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


