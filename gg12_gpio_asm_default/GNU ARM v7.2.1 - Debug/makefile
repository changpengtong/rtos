################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include lib/efm32gg12b/src/subdir.mk
-include subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 

# All Target
all: gg12_gpio_asm_default.axf

# Tool invocations
gg12_gpio_asm_default.axf: $(OBJS) $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: GNU ARM C Linker'
	arm-none-eabi-gcc -g3 -gdwarf-2 -mcpu=cortex-m4 -mthumb -T "gg12_gpio_asm_default.ld" -Xlinker --gc-sections -Xlinker -Map="gg12_gpio_asm_default.map" -mfpu=fpv4-sp-d16 -mfloat-abi=softfp --specs=nano.specs -o gg12_gpio_asm_default.axf "./lib/efm32gg12b/src/startup_gcc_efm32gg12b.o" "./lib/efm32gg12b/src/system_efm32gg12b.o" "./main.o" -Wl,--start-group -lgcc -lc -lnosys -Wl,--end-group
	@echo 'Finished building target: $@'
	@echo ' '

	@echo 'Building hex file: gg12_gpio_asm_default.hex'
	arm-none-eabi-objcopy -O ihex "gg12_gpio_asm_default.axf" "gg12_gpio_asm_default.hex"
	@echo ' '

	@echo 'Building bin file: gg12_gpio_asm_default.bin'
	arm-none-eabi-objcopy -O binary "gg12_gpio_asm_default.axf" "gg12_gpio_asm_default.bin"
	@echo ' '

	@echo 'Building s37 file: gg12_gpio_asm_default.s37'
	arm-none-eabi-objcopy -O srec "gg12_gpio_asm_default.axf" "gg12_gpio_asm_default.s37"
	@echo ' '

	@echo 'Running size tool'
	arm-none-eabi-size "gg12_gpio_asm_default.axf" -A
	@echo ' '

# Other Targets
clean:
	-$(RM) $(EXECUTABLES)$(OBJS)$(C_DEPS) gg12_gpio_asm_default.axf
	-@echo ' '

.PHONY: all clean dependents
.SECONDARY:

-include ../makefile.targets
