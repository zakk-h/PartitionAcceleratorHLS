# open the project, don't forget to reset
open_project -reset proj_diff
set_top CalculateLaplacian
add_files differenceEngine.cpp
add_files -tb differenceEngine_test.cpp 
# add_files -tb input_data.dat
# add_files -tb correct_data.gold.dat

# reset the solution
open_solution -reset "solution_differenceEngine"
# part options:
#	xcku9p-ffve900-2-i-EVAL
#	xc7vx690tffg1927-2
#	xcku5p-sfvb784-3-e
#	xcku115-flvf1924-2-i
#	xcvu9p-flga2104-2l-e
set_part {xcvu9p-flga2104-2l-e}
create_clock -period 3.125 -name default

# do stuff
csim_design
csynth_design
#cosim_design -trace_level all
#export_design -format ip_catalog  -vendor "cern-cms"

# exit Vivado HLS
exit

