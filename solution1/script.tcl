############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
############################################################
open_project PartitionAcceleratorHLS
set_top system_top
add_files file_reader.cpp -cflags "-IPartitionAcceleratorHLS/include -Wno-unknown-pragmas"
add_files PartitionAcceleratorHLS/src/patch_buffer.cpp -cflags "-IPartitionAcceleratorHLS/include -Wno-unknown-pragmas"
add_files PartitionAcceleratorHLS/src/system.cpp -cflags "-IPartitionAcceleratorHLS/include -Wno-unknown-pragmas"
add_files PartitionAcceleratorHLS/src/types.cpp -cflags "-IPartitionAcceleratorHLS/include -Wno-unknown-pragmas"
add_files -tb PartitionAcceleratorHLS/test/test_system.cpp -cflags "-IPartitionAcceleratorHLS/include -Wno-unknown-pragmas" -csimflags "-Wno-unknown-pragmas"
open_solution "solution1" -flow_target vivado
set_part {xcvu11p-flga2577-1-e}
create_clock -period 10 -name default
config_export -format ip_catalog -rtl verilog
source "./PartitionAcceleratorHLS/solution1/directives.tcl"
csim_design -clean
csynth_design
cosim_design
export_design -flow syn -rtl verilog -format ip_catalog -output C:/Users/zakkh/Dark_Matter/PartitionAcceleratorHLS/system_top.zip
