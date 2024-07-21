############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
############################################################
open_project SimplifiedTrackFinder
set_top laplacianCalculator
add_files ../simplified.cpp
open_solution "solution1" -flow_target vivado
set_part {xcvu11p-flga2577-1-e}
create_clock -period 10 -name default
config_export -format ip_catalog -output C:/Users/zakkh/Dark_Matter/PartitionAcceleratorHLS/Zakk/laplacianCalculator.zip -rtl verilog
source "./SimplifiedTrackFinder/solution1/directives.tcl"
#csim_design
csynth_design
#cosim_design
export_design -rtl verilog -format ip_catalog -output C:/Users/zakkh/Dark_Matter/PartitionAcceleratorHLS/Zakk/laplacianCalculator.zip
