export XILINXD_LICENSE_FILE=27000@simplex.cs.duke.edu
source /opt/vivado-2019/Vivado/2019.1/settings64.sh
which vivado_hls
sleep 10
vivado_hls -f run_simple_algo.tcl
more proj0/solution1/syn/report/simple_algo_hw_csynth.rpt

