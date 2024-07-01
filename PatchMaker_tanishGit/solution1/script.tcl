############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
############################################################
open_project PatchMaker_tanishGit
set_top makePatches_ShadowQuilt_fromEdges
add_files patchMaker.cpp -cflags "-IC:/Users/rapiduser/Desktop/tanishGitHub/tanishPatchMakerHLS/patchMakerHeader"
add_files -tb tanishTestBench/cppOutput.txt
add_files -tb tanishTestBench/cppOutputRef.txt
add_files -tb tanishTestBench/test_bench.cpp
add_files -tb tanishTestBench/wedgeData_v3_128.txt
open_solution "solution1" -flow_target vivado
set_part {xcvu19p-fsvb3824-2-e}
create_clock -period 10 -name default
#source "./PatchMaker_tanishGit/solution1/directives.tcl"
csim_design
csynth_design
cosim_design
export_design -format ip_catalog
