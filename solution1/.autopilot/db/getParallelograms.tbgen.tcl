set moduleName getParallelograms
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
set C_modelName {getParallelograms}
set C_modelType { void 0 }
set C_modelArgList {
	{ superpoints int 32 regular {array 240 { 1 1 } 1 1 }  }
	{ superpoints_offset int 2 regular  }
	{ pSlope int 32 regular {array 15 { 0 3 } 0 1 }  }
	{ pSlope_offset int 2 regular  }
	{ shadow_bottomL_jR int 32 regular {array 15 { 0 3 } 0 1 }  }
	{ shadow_bottomL_jR_offset int 2 regular  }
	{ shadow_bottomR_jR int 32 regular {array 15 { 0 3 } 0 1 }  }
	{ shadow_bottomR_jR_offset int 2 regular  }
	{ shadow_bottomL_jL int 32 regular {array 15 { 0 3 } 0 1 }  }
	{ shadow_bottomL_jL_offset int 2 regular  }
	{ shadow_bottomR_jL int 32 regular {array 15 { 0 3 } 0 1 }  }
	{ shadow_bottomR_jL_offset int 2 regular  }
	{ z1_min int 26 regular {array 15 { 0 3 } 0 1 }  }
	{ z1_min_offset int 2 regular  }
	{ z1_max int 26 regular {array 15 { 0 3 } 0 1 }  }
	{ z1_max_offset int 2 regular  }
}
set C_modelArgMapList {[ 
	{ "Name" : "superpoints", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "superpoints_offset", "interface" : "wire", "bitwidth" : 2, "direction" : "READONLY"} , 
 	{ "Name" : "pSlope", "interface" : "memory", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "pSlope_offset", "interface" : "wire", "bitwidth" : 2, "direction" : "READONLY"} , 
 	{ "Name" : "shadow_bottomL_jR", "interface" : "memory", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "shadow_bottomL_jR_offset", "interface" : "wire", "bitwidth" : 2, "direction" : "READONLY"} , 
 	{ "Name" : "shadow_bottomR_jR", "interface" : "memory", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "shadow_bottomR_jR_offset", "interface" : "wire", "bitwidth" : 2, "direction" : "READONLY"} , 
 	{ "Name" : "shadow_bottomL_jL", "interface" : "memory", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "shadow_bottomL_jL_offset", "interface" : "wire", "bitwidth" : 2, "direction" : "READONLY"} , 
 	{ "Name" : "shadow_bottomR_jL", "interface" : "memory", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "shadow_bottomR_jL_offset", "interface" : "wire", "bitwidth" : 2, "direction" : "READONLY"} , 
 	{ "Name" : "z1_min", "interface" : "memory", "bitwidth" : 26, "direction" : "WRITEONLY"} , 
 	{ "Name" : "z1_min_offset", "interface" : "wire", "bitwidth" : 2, "direction" : "READONLY"} , 
 	{ "Name" : "z1_max", "interface" : "memory", "bitwidth" : 26, "direction" : "WRITEONLY"} , 
 	{ "Name" : "z1_max_offset", "interface" : "wire", "bitwidth" : 2, "direction" : "READONLY"} ]}
# RTL Port declarations: 
set portNum 48
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ superpoints_address0 sc_out sc_lv 8 signal 0 } 
	{ superpoints_ce0 sc_out sc_logic 1 signal 0 } 
	{ superpoints_q0 sc_in sc_lv 32 signal 0 } 
	{ superpoints_address1 sc_out sc_lv 8 signal 0 } 
	{ superpoints_ce1 sc_out sc_logic 1 signal 0 } 
	{ superpoints_q1 sc_in sc_lv 32 signal 0 } 
	{ superpoints_offset sc_in sc_lv 2 signal 1 } 
	{ pSlope_address0 sc_out sc_lv 4 signal 2 } 
	{ pSlope_ce0 sc_out sc_logic 1 signal 2 } 
	{ pSlope_we0 sc_out sc_logic 1 signal 2 } 
	{ pSlope_d0 sc_out sc_lv 32 signal 2 } 
	{ pSlope_offset sc_in sc_lv 2 signal 3 } 
	{ shadow_bottomL_jR_address0 sc_out sc_lv 4 signal 4 } 
	{ shadow_bottomL_jR_ce0 sc_out sc_logic 1 signal 4 } 
	{ shadow_bottomL_jR_we0 sc_out sc_logic 1 signal 4 } 
	{ shadow_bottomL_jR_d0 sc_out sc_lv 32 signal 4 } 
	{ shadow_bottomL_jR_offset sc_in sc_lv 2 signal 5 } 
	{ shadow_bottomR_jR_address0 sc_out sc_lv 4 signal 6 } 
	{ shadow_bottomR_jR_ce0 sc_out sc_logic 1 signal 6 } 
	{ shadow_bottomR_jR_we0 sc_out sc_logic 1 signal 6 } 
	{ shadow_bottomR_jR_d0 sc_out sc_lv 32 signal 6 } 
	{ shadow_bottomR_jR_offset sc_in sc_lv 2 signal 7 } 
	{ shadow_bottomL_jL_address0 sc_out sc_lv 4 signal 8 } 
	{ shadow_bottomL_jL_ce0 sc_out sc_logic 1 signal 8 } 
	{ shadow_bottomL_jL_we0 sc_out sc_logic 1 signal 8 } 
	{ shadow_bottomL_jL_d0 sc_out sc_lv 32 signal 8 } 
	{ shadow_bottomL_jL_offset sc_in sc_lv 2 signal 9 } 
	{ shadow_bottomR_jL_address0 sc_out sc_lv 4 signal 10 } 
	{ shadow_bottomR_jL_ce0 sc_out sc_logic 1 signal 10 } 
	{ shadow_bottomR_jL_we0 sc_out sc_logic 1 signal 10 } 
	{ shadow_bottomR_jL_d0 sc_out sc_lv 32 signal 10 } 
	{ shadow_bottomR_jL_offset sc_in sc_lv 2 signal 11 } 
	{ z1_min_address0 sc_out sc_lv 4 signal 12 } 
	{ z1_min_ce0 sc_out sc_logic 1 signal 12 } 
	{ z1_min_we0 sc_out sc_logic 1 signal 12 } 
	{ z1_min_d0 sc_out sc_lv 26 signal 12 } 
	{ z1_min_offset sc_in sc_lv 2 signal 13 } 
	{ z1_max_address0 sc_out sc_lv 4 signal 14 } 
	{ z1_max_ce0 sc_out sc_logic 1 signal 14 } 
	{ z1_max_we0 sc_out sc_logic 1 signal 14 } 
	{ z1_max_d0 sc_out sc_lv 26 signal 14 } 
	{ z1_max_offset sc_in sc_lv 2 signal 15 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "superpoints_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "superpoints", "role": "address0" }} , 
 	{ "name": "superpoints_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "superpoints", "role": "ce0" }} , 
 	{ "name": "superpoints_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "superpoints", "role": "q0" }} , 
 	{ "name": "superpoints_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "superpoints", "role": "address1" }} , 
 	{ "name": "superpoints_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "superpoints", "role": "ce1" }} , 
 	{ "name": "superpoints_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "superpoints", "role": "q1" }} , 
 	{ "name": "superpoints_offset", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "superpoints_offset", "role": "default" }} , 
 	{ "name": "pSlope_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "pSlope", "role": "address0" }} , 
 	{ "name": "pSlope_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pSlope", "role": "ce0" }} , 
 	{ "name": "pSlope_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pSlope", "role": "we0" }} , 
 	{ "name": "pSlope_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "pSlope", "role": "d0" }} , 
 	{ "name": "pSlope_offset", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "pSlope_offset", "role": "default" }} , 
 	{ "name": "shadow_bottomL_jR_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "shadow_bottomL_jR", "role": "address0" }} , 
 	{ "name": "shadow_bottomL_jR_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "shadow_bottomL_jR", "role": "ce0" }} , 
 	{ "name": "shadow_bottomL_jR_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "shadow_bottomL_jR", "role": "we0" }} , 
 	{ "name": "shadow_bottomL_jR_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "shadow_bottomL_jR", "role": "d0" }} , 
 	{ "name": "shadow_bottomL_jR_offset", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "shadow_bottomL_jR_offset", "role": "default" }} , 
 	{ "name": "shadow_bottomR_jR_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "shadow_bottomR_jR", "role": "address0" }} , 
 	{ "name": "shadow_bottomR_jR_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "shadow_bottomR_jR", "role": "ce0" }} , 
 	{ "name": "shadow_bottomR_jR_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "shadow_bottomR_jR", "role": "we0" }} , 
 	{ "name": "shadow_bottomR_jR_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "shadow_bottomR_jR", "role": "d0" }} , 
 	{ "name": "shadow_bottomR_jR_offset", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "shadow_bottomR_jR_offset", "role": "default" }} , 
 	{ "name": "shadow_bottomL_jL_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "shadow_bottomL_jL", "role": "address0" }} , 
 	{ "name": "shadow_bottomL_jL_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "shadow_bottomL_jL", "role": "ce0" }} , 
 	{ "name": "shadow_bottomL_jL_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "shadow_bottomL_jL", "role": "we0" }} , 
 	{ "name": "shadow_bottomL_jL_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "shadow_bottomL_jL", "role": "d0" }} , 
 	{ "name": "shadow_bottomL_jL_offset", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "shadow_bottomL_jL_offset", "role": "default" }} , 
 	{ "name": "shadow_bottomR_jL_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "shadow_bottomR_jL", "role": "address0" }} , 
 	{ "name": "shadow_bottomR_jL_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "shadow_bottomR_jL", "role": "ce0" }} , 
 	{ "name": "shadow_bottomR_jL_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "shadow_bottomR_jL", "role": "we0" }} , 
 	{ "name": "shadow_bottomR_jL_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "shadow_bottomR_jL", "role": "d0" }} , 
 	{ "name": "shadow_bottomR_jL_offset", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "shadow_bottomR_jL_offset", "role": "default" }} , 
 	{ "name": "z1_min_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "z1_min", "role": "address0" }} , 
 	{ "name": "z1_min_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "z1_min", "role": "ce0" }} , 
 	{ "name": "z1_min_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "z1_min", "role": "we0" }} , 
 	{ "name": "z1_min_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":26, "type": "signal", "bundle":{"name": "z1_min", "role": "d0" }} , 
 	{ "name": "z1_min_offset", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "z1_min_offset", "role": "default" }} , 
 	{ "name": "z1_max_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "z1_max", "role": "address0" }} , 
 	{ "name": "z1_max_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "z1_max", "role": "ce0" }} , 
 	{ "name": "z1_max_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "z1_max", "role": "we0" }} , 
 	{ "name": "z1_max_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":26, "type": "signal", "bundle":{"name": "z1_max", "role": "d0" }} , 
 	{ "name": "z1_max_offset", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "z1_max_offset", "role": "default" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2", "6"],
		"CDFG" : "getParallelograms",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "124", "EstimateLatencyMax" : "124",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "superpoints", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "superpoints_offset", "Type" : "None", "Direction" : "I"},
			{"Name" : "pSlope", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "pSlope_offset", "Type" : "None", "Direction" : "I"},
			{"Name" : "shadow_bottomL_jR", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "shadow_bottomL_jR_offset", "Type" : "None", "Direction" : "I"},
			{"Name" : "shadow_bottomR_jR", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "shadow_bottomR_jR_offset", "Type" : "None", "Direction" : "I"},
			{"Name" : "shadow_bottomL_jL", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "shadow_bottomL_jL_offset", "Type" : "None", "Direction" : "I"},
			{"Name" : "shadow_bottomR_jL", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "shadow_bottomR_jL_offset", "Type" : "None", "Direction" : "I"},
			{"Name" : "z1_min", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "z1_min_offset", "Type" : "None", "Direction" : "I"},
			{"Name" : "z1_max", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "z1_max_offset", "Type" : "None", "Direction" : "I"},
			{"Name" : "get_radiiradii", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "2", "SubInstance" : "grp_straightLineProjectorFromLayerIJtoK_fu_541", "Port" : "get_radiiradii"}]},
			{"Name" : "get_parallelogram_slopesparallelogram_slopes", "Type" : "Memory", "Direction" : "I"}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.get_parallelogram_slopesparallelogram_slopes_U", "Parent" : "0"},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.grp_straightLineProjectorFromLayerIJtoK_fu_541", "Parent" : "0", "Child" : ["3", "4", "5"],
		"CDFG" : "straightLineProjectorFromLayerIJtoK",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "Aligned", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "1",
		"VariableLatency" : "0", "ExactLatency" : "50", "EstimateLatencyMin" : "50", "EstimateLatencyMax" : "50",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "1",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "z_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "z_j", "Type" : "None", "Direction" : "I"},
			{"Name" : "j", "Type" : "None", "Direction" : "I"},
			{"Name" : "get_radiiradii", "Type" : "Memory", "Direction" : "I"}]},
	{"ID" : "3", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_straightLineProjectorFromLayerIJtoK_fu_541.get_radiiradii_U", "Parent" : "2"},
	{"ID" : "4", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_straightLineProjectorFromLayerIJtoK_fu_541.sdiv_46ns_26s_32_50_1_U60", "Parent" : "2"},
	{"ID" : "5", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_straightLineProjectorFromLayerIJtoK_fu_541.mul_33s_32s_52_1_1_U61", "Parent" : "2"},
	{"ID" : "6", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.fpext_32ns_64_1_no_dsp_1_U67", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	getParallelograms {
		superpoints {Type I LastRead 13 FirstWrite -1}
		superpoints_offset {Type I LastRead 0 FirstWrite -1}
		pSlope {Type O LastRead -1 FirstWrite 9}
		pSlope_offset {Type I LastRead 0 FirstWrite -1}
		shadow_bottomL_jR {Type O LastRead -1 FirstWrite 64}
		shadow_bottomL_jR_offset {Type I LastRead 0 FirstWrite -1}
		shadow_bottomR_jR {Type O LastRead -1 FirstWrite 65}
		shadow_bottomR_jR_offset {Type I LastRead 0 FirstWrite -1}
		shadow_bottomL_jL {Type O LastRead -1 FirstWrite 66}
		shadow_bottomL_jL_offset {Type I LastRead 0 FirstWrite -1}
		shadow_bottomR_jL {Type O LastRead -1 FirstWrite 67}
		shadow_bottomR_jL_offset {Type I LastRead 0 FirstWrite -1}
		z1_min {Type O LastRead -1 FirstWrite 5}
		z1_min_offset {Type I LastRead 0 FirstWrite -1}
		z1_max {Type O LastRead -1 FirstWrite 5}
		z1_max_offset {Type I LastRead 0 FirstWrite -1}
		get_radiiradii {Type I LastRead -1 FirstWrite -1}
		get_parallelogram_slopesparallelogram_slopes {Type I LastRead -1 FirstWrite -1}}
	straightLineProjectorFromLayerIJtoK {
		z_i {Type I LastRead 0 FirstWrite -1}
		z_j {Type I LastRead 0 FirstWrite -1}
		j {Type I LastRead 0 FirstWrite -1}
		get_radiiradii {Type I LastRead -1 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "124", "Max" : "124"}
	, {"Name" : "Interval", "Min" : "124", "Max" : "124"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
	{"Pipeline" : "1", "EnableSignal" : "ap_enable_pp1"}
	{"Pipeline" : "2", "EnableSignal" : "ap_enable_pp2"}
]}

set Spec2ImplPortList { 
	superpoints { ap_memory {  { superpoints_address0 mem_address 1 8 }  { superpoints_ce0 mem_ce 1 1 }  { superpoints_q0 mem_dout 0 32 }  { superpoints_address1 MemPortADDR2 1 8 }  { superpoints_ce1 MemPortCE2 1 1 }  { superpoints_q1 MemPortDOUT2 0 32 } } }
	superpoints_offset { ap_none {  { superpoints_offset in_data 0 2 } } }
	pSlope { ap_memory {  { pSlope_address0 mem_address 1 4 }  { pSlope_ce0 mem_ce 1 1 }  { pSlope_we0 mem_we 1 1 }  { pSlope_d0 mem_din 1 32 } } }
	pSlope_offset { ap_none {  { pSlope_offset in_data 0 2 } } }
	shadow_bottomL_jR { ap_memory {  { shadow_bottomL_jR_address0 mem_address 1 4 }  { shadow_bottomL_jR_ce0 mem_ce 1 1 }  { shadow_bottomL_jR_we0 mem_we 1 1 }  { shadow_bottomL_jR_d0 mem_din 1 32 } } }
	shadow_bottomL_jR_offset { ap_none {  { shadow_bottomL_jR_offset in_data 0 2 } } }
	shadow_bottomR_jR { ap_memory {  { shadow_bottomR_jR_address0 mem_address 1 4 }  { shadow_bottomR_jR_ce0 mem_ce 1 1 }  { shadow_bottomR_jR_we0 mem_we 1 1 }  { shadow_bottomR_jR_d0 mem_din 1 32 } } }
	shadow_bottomR_jR_offset { ap_none {  { shadow_bottomR_jR_offset in_data 0 2 } } }
	shadow_bottomL_jL { ap_memory {  { shadow_bottomL_jL_address0 mem_address 1 4 }  { shadow_bottomL_jL_ce0 mem_ce 1 1 }  { shadow_bottomL_jL_we0 mem_we 1 1 }  { shadow_bottomL_jL_d0 mem_din 1 32 } } }
	shadow_bottomL_jL_offset { ap_none {  { shadow_bottomL_jL_offset in_data 0 2 } } }
	shadow_bottomR_jL { ap_memory {  { shadow_bottomR_jL_address0 mem_address 1 4 }  { shadow_bottomR_jL_ce0 mem_ce 1 1 }  { shadow_bottomR_jL_we0 mem_we 1 1 }  { shadow_bottomR_jL_d0 mem_din 1 32 } } }
	shadow_bottomR_jL_offset { ap_none {  { shadow_bottomR_jL_offset in_data 0 2 } } }
	z1_min { ap_memory {  { z1_min_address0 mem_address 1 4 }  { z1_min_ce0 mem_ce 1 1 }  { z1_min_we0 mem_we 1 1 }  { z1_min_d0 mem_din 1 26 } } }
	z1_min_offset { ap_none {  { z1_min_offset in_data 0 2 } } }
	z1_max { ap_memory {  { z1_max_address0 mem_address 1 4 }  { z1_max_ce0 mem_ce 1 1 }  { z1_max_we0 mem_we 1 1 }  { z1_max_d0 mem_din 1 26 } } }
	z1_max_offset { ap_none {  { z1_max_offset in_data 0 2 } } }
}
