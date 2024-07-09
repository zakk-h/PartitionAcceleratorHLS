set moduleName patch_buffer_add_patch2
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 0
set pipeline_type none
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set C_modelName {patch_buffer_add_patch2}
set C_modelType { void 0 }
set C_modelArgList {
	{ new_patch int 96 regular {array 80 { 1 1 } 1 1 }  }
	{ patch_buffer int 32 regular {array 240 { 0 0 } 0 1 }  }
	{ latest_patch_index_constprop int 2 regular {pointer 2} {global 2}  }
	{ num_patches_constprop int 32 regular {pointer 2} {global 2}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "new_patch", "interface" : "memory", "bitwidth" : 96, "direction" : "READONLY"} , 
 	{ "Name" : "patch_buffer", "interface" : "memory", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "latest_patch_index_constprop", "interface" : "wire", "bitwidth" : 2, "direction" : "READWRITE", "extern" : 0} , 
 	{ "Name" : "num_patches_constprop", "interface" : "wire", "bitwidth" : 32, "direction" : "READWRITE", "extern" : 0} ]}
# RTL Port declarations: 
set portNum 26
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ new_patch_address0 sc_out sc_lv 7 signal 0 } 
	{ new_patch_ce0 sc_out sc_logic 1 signal 0 } 
	{ new_patch_q0 sc_in sc_lv 96 signal 0 } 
	{ new_patch_address1 sc_out sc_lv 7 signal 0 } 
	{ new_patch_ce1 sc_out sc_logic 1 signal 0 } 
	{ new_patch_q1 sc_in sc_lv 96 signal 0 } 
	{ patch_buffer_address0 sc_out sc_lv 8 signal 1 } 
	{ patch_buffer_ce0 sc_out sc_logic 1 signal 1 } 
	{ patch_buffer_we0 sc_out sc_logic 1 signal 1 } 
	{ patch_buffer_d0 sc_out sc_lv 32 signal 1 } 
	{ patch_buffer_address1 sc_out sc_lv 8 signal 1 } 
	{ patch_buffer_ce1 sc_out sc_logic 1 signal 1 } 
	{ patch_buffer_we1 sc_out sc_logic 1 signal 1 } 
	{ patch_buffer_d1 sc_out sc_lv 32 signal 1 } 
	{ latest_patch_index_constprop_i sc_in sc_lv 2 signal 2 } 
	{ latest_patch_index_constprop_o sc_out sc_lv 2 signal 2 } 
	{ latest_patch_index_constprop_o_ap_vld sc_out sc_logic 1 outvld 2 } 
	{ num_patches_constprop_i sc_in sc_lv 32 signal 3 } 
	{ num_patches_constprop_o sc_out sc_lv 32 signal 3 } 
	{ num_patches_constprop_o_ap_vld sc_out sc_logic 1 outvld 3 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "new_patch_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":7, "type": "signal", "bundle":{"name": "new_patch", "role": "address0" }} , 
 	{ "name": "new_patch_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "new_patch", "role": "ce0" }} , 
 	{ "name": "new_patch_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":96, "type": "signal", "bundle":{"name": "new_patch", "role": "q0" }} , 
 	{ "name": "new_patch_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":7, "type": "signal", "bundle":{"name": "new_patch", "role": "address1" }} , 
 	{ "name": "new_patch_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "new_patch", "role": "ce1" }} , 
 	{ "name": "new_patch_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":96, "type": "signal", "bundle":{"name": "new_patch", "role": "q1" }} , 
 	{ "name": "patch_buffer_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "patch_buffer", "role": "address0" }} , 
 	{ "name": "patch_buffer_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "patch_buffer", "role": "ce0" }} , 
 	{ "name": "patch_buffer_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "patch_buffer", "role": "we0" }} , 
 	{ "name": "patch_buffer_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "patch_buffer", "role": "d0" }} , 
 	{ "name": "patch_buffer_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "patch_buffer", "role": "address1" }} , 
 	{ "name": "patch_buffer_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "patch_buffer", "role": "ce1" }} , 
 	{ "name": "patch_buffer_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "patch_buffer", "role": "we1" }} , 
 	{ "name": "patch_buffer_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "patch_buffer", "role": "d1" }} , 
 	{ "name": "latest_patch_index_constprop_i", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "latest_patch_index_constprop", "role": "i" }} , 
 	{ "name": "latest_patch_index_constprop_o", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "latest_patch_index_constprop", "role": "o" }} , 
 	{ "name": "latest_patch_index_constprop_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "latest_patch_index_constprop", "role": "o_ap_vld" }} , 
 	{ "name": "num_patches_constprop_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "num_patches_constprop", "role": "i" }} , 
 	{ "name": "num_patches_constprop_o", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "num_patches_constprop", "role": "o" }} , 
 	{ "name": "num_patches_constprop_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "num_patches_constprop", "role": "o_ap_vld" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "",
		"CDFG" : "patch_buffer_add_patch2",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "40", "EstimateLatencyMax" : "40",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "new_patch", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "patch_buffer", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "latest_patch_index_constprop", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "num_patches_constprop", "Type" : "OVld", "Direction" : "IO"}]}]}


set ArgLastReadFirstWriteLatency {
	patch_buffer_add_patch2 {
		new_patch {Type I LastRead 40 FirstWrite -1}
		patch_buffer {Type O LastRead -1 FirstWrite 1}
		latest_patch_index_constprop {Type IO LastRead 1 FirstWrite 1}
		num_patches_constprop {Type IO LastRead 0 FirstWrite 0}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "40", "Max" : "40"}
	, {"Name" : "Interval", "Min" : "40", "Max" : "40"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	new_patch { ap_memory {  { new_patch_address0 mem_address 1 7 }  { new_patch_ce0 mem_ce 1 1 }  { new_patch_q0 mem_dout 0 96 }  { new_patch_address1 MemPortADDR2 1 7 }  { new_patch_ce1 MemPortCE2 1 1 }  { new_patch_q1 MemPortDOUT2 0 96 } } }
	patch_buffer { ap_memory {  { patch_buffer_address0 mem_address 1 8 }  { patch_buffer_ce0 mem_ce 1 1 }  { patch_buffer_we0 mem_we 1 1 }  { patch_buffer_d0 mem_din 1 32 }  { patch_buffer_address1 MemPortADDR2 1 8 }  { patch_buffer_ce1 MemPortCE2 1 1 }  { patch_buffer_we1 MemPortWE2 1 1 }  { patch_buffer_d1 MemPortDIN2 1 32 } } }
	latest_patch_index_constprop { ap_ovld {  { latest_patch_index_constprop_i in_data 0 2 }  { latest_patch_index_constprop_o out_data 1 2 }  { latest_patch_index_constprop_o_ap_vld out_vld 1 1 } } }
	num_patches_constprop { ap_ovld {  { num_patches_constprop_i in_data 0 32 }  { num_patches_constprop_o out_data 1 32 }  { num_patches_constprop_o_ap_vld out_vld 1 1 } } }
}
