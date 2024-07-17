################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
OBJS += \
./testbench/DummyGlobalCommunication_Test.o 

CPP_DEPS += \
./testbench/DummyGlobalCommunication_Test.d 


# Each subdirectory must supply rules for building sources it contributes
testbench/DummyGlobalCommunication_Test.o: C:/Users/bkunj/test-project/My_Stuff/test_looiking_at_stuff/src/DummyGlobalCommunication_Test.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	g++ -IC:/Xilinx/Vitis_HLS/2020.2/include/ap_sysc -IC:/Xilinx/Vitis_HLS/2020.2/win64/tools/systemc/include -IC:/Xilinx/Vitis_HLS/2020.2/include/etc -IC:/Xilinx/Vitis_HLS/2020.2/include -IC:/Users/bkunj/test-project/My_Stuff -IC:/Xilinx/Vitis_HLS/2020.2/win64/tools/auto_cc/include -O0 -g3 -Wall -Wno-unknown-pragmas -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"testbench/DummyGlobalCommunication_Test.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


