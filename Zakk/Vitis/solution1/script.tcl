############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
############################################################
open_project Vitis
set_top fullSystem
add_files simplified.cpp
open_solution "solution1" -flow_target vivado
set_part {xcvu19p-fsva3824-1-e}
create_clock -period 10 -name default
#source "./Vitis/solution1/directives.tcl"
#csim_design
csynth_design
#cosim_design
export_design -format ip_catalog
