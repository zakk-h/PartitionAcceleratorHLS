set moduleName system_top
set isTopModule 1
set isCombinational 0
set isDatapathOnly 0
set isPipelined 0
set pipeline_type none
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set C_modelName {system_top}
set C_modelType { void 0 }
set C_modelArgList {
	{ points int 128 regular {array 2560 { 1 1 } 1 1 }  }
	{ num_points int 32 regular {array 5 { 1 1 } 1 1 }  }
	{ patch_stream_V int 96 regular {fifo 1 volatile }  }
}
set C_modelArgMapList {[ 
	{ "Name" : "points", "interface" : "memory", "bitwidth" : 128, "direction" : "READONLY", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "points","cData": "int128","bit_use": { "low": 0,"up": 0},"cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}]} , 
 	{ "Name" : "num_points", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "num_points","cData": "int","bit_use": { "low": 0,"up": 0},"cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}]} , 
 	{ "Name" : "patch_stream_V", "interface" : "fifo", "bitwidth" : 96, "direction" : "WRITEONLY", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "patch_stream.V","cData": "int96","bit_use": { "low": 0,"up": 0},"cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}]} ]}
# RTL Port declarations: 
set portNum 21
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ points_address0 sc_out sc_lv 12 signal 0 } 
	{ points_ce0 sc_out sc_logic 1 signal 0 } 
	{ points_q0 sc_in sc_lv 128 signal 0 } 
	{ points_address1 sc_out sc_lv 12 signal 0 } 
	{ points_ce1 sc_out sc_logic 1 signal 0 } 
	{ points_q1 sc_in sc_lv 128 signal 0 } 
	{ num_points_address0 sc_out sc_lv 3 signal 1 } 
	{ num_points_ce0 sc_out sc_logic 1 signal 1 } 
	{ num_points_q0 sc_in sc_lv 32 signal 1 } 
	{ num_points_address1 sc_out sc_lv 3 signal 1 } 
	{ num_points_ce1 sc_out sc_logic 1 signal 1 } 
	{ num_points_q1 sc_in sc_lv 32 signal 1 } 
	{ patch_stream_V_din sc_out sc_lv 96 signal 2 } 
	{ patch_stream_V_full_n sc_in sc_logic 1 signal 2 } 
	{ patch_stream_V_write sc_out sc_logic 1 signal 2 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "points_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":12, "type": "signal", "bundle":{"name": "points", "role": "address0" }} , 
 	{ "name": "points_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "points", "role": "ce0" }} , 
 	{ "name": "points_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":128, "type": "signal", "bundle":{"name": "points", "role": "q0" }} , 
 	{ "name": "points_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":12, "type": "signal", "bundle":{"name": "points", "role": "address1" }} , 
 	{ "name": "points_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "points", "role": "ce1" }} , 
 	{ "name": "points_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":128, "type": "signal", "bundle":{"name": "points", "role": "q1" }} , 
 	{ "name": "num_points_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "num_points", "role": "address0" }} , 
 	{ "name": "num_points_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "num_points", "role": "ce0" }} , 
 	{ "name": "num_points_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "num_points", "role": "q0" }} , 
 	{ "name": "num_points_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "num_points", "role": "address1" }} , 
 	{ "name": "num_points_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "num_points", "role": "ce1" }} , 
 	{ "name": "num_points_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "num_points", "role": "q1" }} , 
 	{ "name": "patch_stream_V_din", "direction": "out", "datatype": "sc_lv", "bitwidth":96, "type": "signal", "bundle":{"name": "patch_stream_V", "role": "din" }} , 
 	{ "name": "patch_stream_V_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "patch_stream_V", "role": "full_n" }} , 
 	{ "name": "patch_stream_V_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "patch_stream_V", "role": "write" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24"],
		"CDFG" : "system_top",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "1",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "points", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "24", "SubInstance" : "grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283", "Port" : "points"}]},
			{"Name" : "num_points", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "24", "SubInstance" : "grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283", "Port" : "num_points"}]},
			{"Name" : "patch_stream_V", "Type" : "Fifo", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "24", "SubInstance" : "grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283", "Port" : "patch_stream_V"}]},
			{"Name" : "latest_patch_index_constprop", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "24", "SubInstance" : "grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283", "Port" : "latest_patch_index_constprop"}]},
			{"Name" : "num_patches_constprop", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "24", "SubInstance" : "grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283", "Port" : "num_patches_constprop"}]},
			{"Name" : "system_top_ap_uint_96_512_unsigned_int_stream_ap_uint_96_0_squareAcceptance", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "system_top_ap_uint_96_512_unsigned_int_stream_ap_uint_96_0_flatTop", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "system_top_ap_uint_96_512_unsigned_int_stream_ap_uint_96_0_flatBottom", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "get_radiiradii", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "24", "SubInstance" : "grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283", "Port" : "get_radiiradii"}]},
			{"Name" : "lbVal_constprop", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "24", "SubInstance" : "grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283", "Port" : "lbVal_constprop"}]},
			{"Name" : "rbVal_constprop", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "24", "SubInstance" : "grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283", "Port" : "rbVal_constprop"}]},
			{"Name" : "get_trapezoid_edgestrapezoid_edges", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "24", "SubInstance" : "grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283", "Port" : "get_trapezoid_edgestrapezoid_edges"}]},
			{"Name" : "get_parallelogram_slopesparallelogram_slopes", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "24", "SubInstance" : "grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283", "Port" : "get_parallelogram_slopesparallelogram_slopes"}]}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.system_top_ap_uint_96_512_unsigned_int_stream_ap_uint_96_0_squareAcceptance_U", "Parent" : "0"},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.system_top_ap_uint_96_512_unsigned_int_stream_ap_uint_96_0_flatTop_U", "Parent" : "0"},
	{"ID" : "3", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.system_top_ap_uint_96_512_unsigned_int_stream_ap_uint_96_0_flatBottom_U", "Parent" : "0"},
	{"ID" : "4", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.patch_buffer_U", "Parent" : "0"},
	{"ID" : "5", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.pSlope_U", "Parent" : "0"},
	{"ID" : "6", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.shadow_bottomL_jR_U", "Parent" : "0"},
	{"ID" : "7", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.shadow_bottomR_jR_U", "Parent" : "0"},
	{"ID" : "8", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.shadow_bottomL_jL_U", "Parent" : "0"},
	{"ID" : "9", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.shadow_bottomR_jL_U", "Parent" : "0"},
	{"ID" : "10", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.z1_min_U", "Parent" : "0"},
	{"ID" : "11", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.z1_max_U", "Parent" : "0"},
	{"ID" : "12", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.a_corner_0_U", "Parent" : "0"},
	{"ID" : "13", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.a_corner_1_U", "Parent" : "0"},
	{"ID" : "14", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.b_corner_0_U", "Parent" : "0"},
	{"ID" : "15", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.b_corner_1_U", "Parent" : "0"},
	{"ID" : "16", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.c_corner_0_U", "Parent" : "0"},
	{"ID" : "17", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.c_corner_1_U", "Parent" : "0"},
	{"ID" : "18", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.d_corner_0_U", "Parent" : "0"},
	{"ID" : "19", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.d_corner_1_U", "Parent" : "0"},
	{"ID" : "20", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.squareAcceptance_U", "Parent" : "0"},
	{"ID" : "21", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.flatTop_U", "Parent" : "0"},
	{"ID" : "22", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.flatBottom_U", "Parent" : "0"},
	{"ID" : "23", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.triangleAcceptance_U", "Parent" : "0"},
	{"ID" : "24", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283", "Parent" : "0", "Child" : ["25", "26", "27", "28", "29", "30", "31", "32", "50", "57", "61", "62", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76"],
		"CDFG" : "p_shadowquilt_main_loop_make_verticle_strip",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "1",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "points", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "57", "SubInstance" : "grp_get_index_from_z_fu_1317", "Port" : "points"},
					{"ID" : "32", "SubInstance" : "grp_alignedtoline_per_layer_loop3_fu_1250", "Port" : "points"}]},
			{"Name" : "num_points", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "57", "SubInstance" : "grp_get_index_from_z_fu_1317", "Port" : "num_points"},
					{"ID" : "32", "SubInstance" : "grp_alignedtoline_per_layer_loop3_fu_1250", "Port" : "num_points"}]},
			{"Name" : "patch_stream_V", "Type" : "Fifo", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "patch_stream_V_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "patch_buffer", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "50", "SubInstance" : "grp_getParallelograms_fu_1285", "Port" : "superpoints"},
					{"ID" : "61", "SubInstance" : "grp_patch_buffer_add_patch2_fu_1330", "Port" : "patch_buffer"}]},
			{"Name" : "pSlope", "Type" : "Memory", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "50", "SubInstance" : "grp_getParallelograms_fu_1285", "Port" : "pSlope"}]},
			{"Name" : "shadow_bottomL_jR", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "50", "SubInstance" : "grp_getParallelograms_fu_1285", "Port" : "shadow_bottomL_jR"},
					{"ID" : "62", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "shadow_bottomL_jR"}]},
			{"Name" : "shadow_bottomR_jR", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "50", "SubInstance" : "grp_getParallelograms_fu_1285", "Port" : "shadow_bottomR_jR"},
					{"ID" : "62", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "shadow_bottomR_jR"}]},
			{"Name" : "shadow_bottomL_jL", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "50", "SubInstance" : "grp_getParallelograms_fu_1285", "Port" : "shadow_bottomL_jL"},
					{"ID" : "62", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "shadow_bottomL_jL"}]},
			{"Name" : "shadow_bottomR_jL", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "50", "SubInstance" : "grp_getParallelograms_fu_1285", "Port" : "shadow_bottomR_jL"},
					{"ID" : "62", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "shadow_bottomR_jL"}]},
			{"Name" : "z1_min", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "50", "SubInstance" : "grp_getParallelograms_fu_1285", "Port" : "z1_min"},
					{"ID" : "62", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "z1_min"}]},
			{"Name" : "z1_max", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "50", "SubInstance" : "grp_getParallelograms_fu_1285", "Port" : "z1_max"},
					{"ID" : "62", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "z1_max"}]},
			{"Name" : "a_corner_0", "Type" : "Memory", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "62", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "a_corner_0"}]},
			{"Name" : "a_corner_1", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "62", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "a_corner_1"}]},
			{"Name" : "b_corner_0", "Type" : "Memory", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "62", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "b_corner_0"}]},
			{"Name" : "b_corner_1", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "62", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "b_corner_1"}]},
			{"Name" : "c_corner_0", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "62", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "c_corner_0"}]},
			{"Name" : "c_corner_1", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "62", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "c_corner_1"}]},
			{"Name" : "d_corner_0", "Type" : "Memory", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "62", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "d_corner_0"}]},
			{"Name" : "d_corner_1", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "62", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "d_corner_1"}]},
			{"Name" : "squareAcceptance", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "62", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "squareAcceptance"}]},
			{"Name" : "flatTop", "Type" : "Memory", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "62", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "flatTop"}]},
			{"Name" : "flatBottom", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "62", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "flatBottom"}]},
			{"Name" : "triangleAcceptance", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "62", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "triangleAcceptance"}]},
			{"Name" : "get_radiiradii", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "50", "SubInstance" : "grp_getParallelograms_fu_1285", "Port" : "get_radiiradii"},
					{"ID" : "32", "SubInstance" : "grp_alignedtoline_per_layer_loop3_fu_1250", "Port" : "get_radiiradii"}]},
			{"Name" : "lbVal_constprop", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "32", "SubInstance" : "grp_alignedtoline_per_layer_loop3_fu_1250", "Port" : "lbVal_constprop"}]},
			{"Name" : "rbVal_constprop", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "32", "SubInstance" : "grp_alignedtoline_per_layer_loop3_fu_1250", "Port" : "rbVal_constprop"}]},
			{"Name" : "get_trapezoid_edgestrapezoid_edges", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "32", "SubInstance" : "grp_alignedtoline_per_layer_loop3_fu_1250", "Port" : "get_trapezoid_edgestrapezoid_edges"}]},
			{"Name" : "latest_patch_index_constprop", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "61", "SubInstance" : "grp_patch_buffer_add_patch2_fu_1330", "Port" : "latest_patch_index_constprop"},
					{"ID" : "62", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "latest_patch_index_constprop"}]},
			{"Name" : "num_patches_constprop", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "61", "SubInstance" : "grp_patch_buffer_add_patch2_fu_1330", "Port" : "num_patches_constprop"}]},
			{"Name" : "get_parallelogram_slopesparallelogram_slopes", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "50", "SubInstance" : "grp_getParallelograms_fu_1285", "Port" : "get_parallelogram_slopesparallelogram_slopes"}]}]},
	{"ID" : "25", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.get_radiiradii_U", "Parent" : "24"},
	{"ID" : "26", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.init_patch_V_U", "Parent" : "24"},
	{"ID" : "27", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.init_patch_V_1_U", "Parent" : "24"},
	{"ID" : "28", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.current_z_i_index_V_U", "Parent" : "24"},
	{"ID" : "29", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.new_z_i_index_V_U", "Parent" : "24"},
	{"ID" : "30", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.new_z_i_V_U", "Parent" : "24"},
	{"ID" : "31", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.new_z_i_atTop_V_U", "Parent" : "24"},
	{"ID" : "32", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.grp_alignedtoline_per_layer_loop3_fu_1250", "Parent" : "24", "Child" : ["33", "34", "47", "48", "49"],
		"CDFG" : "alignedtoline_per_layer_loop3",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "1",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "points", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "34", "SubInstance" : "grp_p_find_boundaries_and_starting_index_and_value7_fu_922", "Port" : "points"}]},
			{"Name" : "num_points", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "34", "SubInstance" : "grp_p_find_boundaries_and_starting_index_and_value7_fu_922", "Port" : "num_points"}]},
			{"Name" : "p_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "z_top", "Type" : "None", "Direction" : "I"},
			{"Name" : "leftRight_offset", "Type" : "None", "Direction" : "I"},
			{"Name" : "init_patch", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "i_offset", "Type" : "None", "Direction" : "I"},
			{"Name" : "get_radiiradii", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "lbVal_constprop", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "34", "SubInstance" : "grp_p_find_boundaries_and_starting_index_and_value7_fu_922", "Port" : "lbVal_constprop"}]},
			{"Name" : "rbVal_constprop", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "34", "SubInstance" : "grp_p_find_boundaries_and_starting_index_and_value7_fu_922", "Port" : "rbVal_constprop"}]},
			{"Name" : "get_trapezoid_edgestrapezoid_edges", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "34", "SubInstance" : "grp_p_find_boundaries_and_starting_index_and_value7_fu_922", "Port" : "get_trapezoid_edgestrapezoid_edges"}]}]},
	{"ID" : "33", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.grp_alignedtoline_per_layer_loop3_fu_1250.get_radiiradii_U", "Parent" : "32"},
	{"ID" : "34", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.grp_alignedtoline_per_layer_loop3_fu_1250.grp_p_find_boundaries_and_starting_index_and_value7_fu_922", "Parent" : "32", "Child" : ["35", "36", "41", "44", "45", "46"],
		"CDFG" : "p_find_boundaries_and_starting_index_and_value7",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "Dataflow", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "1",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "1",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"InputProcess" : [
			{"ID" : "35", "Name" : "p_find_boundaries_and_starting_index_and_value_entry25_U0"},
			{"ID" : "36", "Name" : "p_find_left_and_right_boundaries9_U0"},
			{"ID" : "41", "Name" : "p_find_starting_index_and_value8_U0"}],
		"OutputProcess" : [
			{"ID" : "36", "Name" : "p_find_left_and_right_boundaries9_U0"},
			{"ID" : "41", "Name" : "p_find_starting_index_and_value8_U0"}],
		"Port" : [
			{"Name" : "num_points", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "41", "SubInstance" : "p_find_starting_index_and_value8_U0", "Port" : "num_points"},
					{"ID" : "36", "SubInstance" : "p_find_left_and_right_boundaries9_U0", "Port" : "num_points"}]},
			{"Name" : "points", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "41", "SubInstance" : "p_find_starting_index_and_value8_U0", "Port" : "points"},
					{"ID" : "36", "SubInstance" : "p_find_left_and_right_boundaries9_U0", "Port" : "points"}]},
			{"Name" : "left_bound", "Type" : "Vld", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "36", "SubInstance" : "p_find_left_and_right_boundaries9_U0", "Port" : "left_bound"}]},
			{"Name" : "right_bound", "Type" : "Vld", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "36", "SubInstance" : "p_find_left_and_right_boundaries9_U0", "Port" : "right_bound"}]},
			{"Name" : "projectionToRow", "Type" : "None", "Direction" : "I"},
			{"Name" : "start_index", "Type" : "Vld", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "41", "SubInstance" : "p_find_starting_index_and_value8_U0", "Port" : "start_index"}]},
			{"Name" : "start_value", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "41", "SubInstance" : "p_find_starting_index_and_value8_U0", "Port" : "start_value"}]},
			{"Name" : "i", "Type" : "None", "Direction" : "I"},
			{"Name" : "get_trapezoid_edgestrapezoid_edges", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "36", "SubInstance" : "p_find_left_and_right_boundaries9_U0", "Port" : "get_trapezoid_edgestrapezoid_edges"}]},
			{"Name" : "lbVal_constprop", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "36", "SubInstance" : "p_find_left_and_right_boundaries9_U0", "Port" : "lbVal_constprop"}]},
			{"Name" : "rbVal_constprop", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "36", "SubInstance" : "p_find_left_and_right_boundaries9_U0", "Port" : "rbVal_constprop"}]}]},
	{"ID" : "35", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.grp_alignedtoline_per_layer_loop3_fu_1250.grp_p_find_boundaries_and_starting_index_and_value7_fu_922.p_find_boundaries_and_starting_index_and_value_entry25_U0", "Parent" : "34",
		"CDFG" : "p_find_boundaries_and_starting_index_and_value_entry25",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "1",
		"VariableLatency" : "0", "ExactLatency" : "0", "EstimateLatencyMin" : "0", "EstimateLatencyMax" : "0",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "projectionToRow", "Type" : "None", "Direction" : "I"},
			{"Name" : "i", "Type" : "None", "Direction" : "I"},
			{"Name" : "projectionToRow_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "41", "DependentChan" : "44", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "projectionToRow_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "i_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "36", "DependentChan" : "45", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "i_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "i_out1", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "41", "DependentChan" : "46", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "i_out1_blk_n", "Type" : "RtlSignal"}]}]},
	{"ID" : "36", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.grp_alignedtoline_per_layer_loop3_fu_1250.grp_p_find_boundaries_and_starting_index_and_value7_fu_922.p_find_left_and_right_boundaries9_U0", "Parent" : "34", "Child" : ["37", "38", "39", "40"],
		"CDFG" : "p_find_left_and_right_boundaries9",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "num_points", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "points", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "left_bound", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "right_bound", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "i", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "35", "DependentChan" : "45", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "i_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "get_trapezoid_edgestrapezoid_edges", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "lbVal_constprop", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "rbVal_constprop", "Type" : "OVld", "Direction" : "IO"}]},
	{"ID" : "37", "Level" : "5", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.grp_alignedtoline_per_layer_loop3_fu_1250.grp_p_find_boundaries_and_starting_index_and_value7_fu_922.p_find_left_and_right_boundaries9_U0.get_trapezoid_edgestrapezoid_edges_U", "Parent" : "36"},
	{"ID" : "38", "Level" : "5", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.grp_alignedtoline_per_layer_loop3_fu_1250.grp_p_find_boundaries_and_starting_index_and_value7_fu_922.p_find_left_and_right_boundaries9_U0.faddfsub_32ns_32ns_32_3_full_dsp_1_U6", "Parent" : "36"},
	{"ID" : "39", "Level" : "5", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.grp_alignedtoline_per_layer_loop3_fu_1250.grp_p_find_boundaries_and_starting_index_and_value7_fu_922.p_find_left_and_right_boundaries9_U0.fpext_32ns_64_2_no_dsp_1_U7", "Parent" : "36"},
	{"ID" : "40", "Level" : "5", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.grp_alignedtoline_per_layer_loop3_fu_1250.grp_p_find_boundaries_and_starting_index_and_value7_fu_922.p_find_left_and_right_boundaries9_U0.fpext_32ns_64_2_no_dsp_1_U8", "Parent" : "36"},
	{"ID" : "41", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.grp_alignedtoline_per_layer_loop3_fu_1250.grp_p_find_boundaries_and_starting_index_and_value7_fu_922.p_find_starting_index_and_value8_U0", "Parent" : "34", "Child" : ["42", "43"],
		"CDFG" : "p_find_starting_index_and_value8",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "num_points", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "points", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "projectionToRow", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "35", "DependentChan" : "44", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "projectionToRow_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "start_index", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "start_value", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "i", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "35", "DependentChan" : "46", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "i_blk_n", "Type" : "RtlSignal"}]}]},
	{"ID" : "42", "Level" : "5", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.grp_alignedtoline_per_layer_loop3_fu_1250.grp_p_find_boundaries_and_starting_index_and_value7_fu_922.p_find_starting_index_and_value8_U0.fsub_32ns_32ns_32_3_full_dsp_1_U19", "Parent" : "41"},
	{"ID" : "43", "Level" : "5", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.grp_alignedtoline_per_layer_loop3_fu_1250.grp_p_find_boundaries_and_starting_index_and_value7_fu_922.p_find_starting_index_and_value8_U0.fcmp_32ns_32ns_1_2_no_dsp_1_U20", "Parent" : "41"},
	{"ID" : "44", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.grp_alignedtoline_per_layer_loop3_fu_1250.grp_p_find_boundaries_and_starting_index_and_value7_fu_922.projectionToRow_c_U", "Parent" : "34"},
	{"ID" : "45", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.grp_alignedtoline_per_layer_loop3_fu_1250.grp_p_find_boundaries_and_starting_index_and_value7_fu_922.i_c_U", "Parent" : "34"},
	{"ID" : "46", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.grp_alignedtoline_per_layer_loop3_fu_1250.grp_p_find_boundaries_and_starting_index_and_value7_fu_922.i_c7_U", "Parent" : "34"},
	{"ID" : "47", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.grp_alignedtoline_per_layer_loop3_fu_1250.dcmp_64ns_64ns_1_2_no_dsp_1_U42", "Parent" : "32"},
	{"ID" : "48", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.grp_alignedtoline_per_layer_loop3_fu_1250.mul_33s_25ns_58_1_1_U43", "Parent" : "32"},
	{"ID" : "49", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.grp_alignedtoline_per_layer_loop3_fu_1250.mul_78s_108ns_185_1_1_U44", "Parent" : "32"},
	{"ID" : "50", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.grp_getParallelograms_fu_1285", "Parent" : "24", "Child" : ["51", "52", "56"],
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
					{"ID" : "52", "SubInstance" : "grp_straightLineProjectorFromLayerIJtoK_fu_541", "Port" : "get_radiiradii"}]},
			{"Name" : "get_parallelogram_slopesparallelogram_slopes", "Type" : "Memory", "Direction" : "I"}]},
	{"ID" : "51", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.grp_getParallelograms_fu_1285.get_parallelogram_slopesparallelogram_slopes_U", "Parent" : "50"},
	{"ID" : "52", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.grp_getParallelograms_fu_1285.grp_straightLineProjectorFromLayerIJtoK_fu_541", "Parent" : "50", "Child" : ["53", "54", "55"],
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
	{"ID" : "53", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.grp_getParallelograms_fu_1285.grp_straightLineProjectorFromLayerIJtoK_fu_541.get_radiiradii_U", "Parent" : "52"},
	{"ID" : "54", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.grp_getParallelograms_fu_1285.grp_straightLineProjectorFromLayerIJtoK_fu_541.sdiv_46ns_26s_32_50_1_U60", "Parent" : "52"},
	{"ID" : "55", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.grp_getParallelograms_fu_1285.grp_straightLineProjectorFromLayerIJtoK_fu_541.mul_33s_32s_52_1_1_U61", "Parent" : "52"},
	{"ID" : "56", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.grp_getParallelograms_fu_1285.fpext_32ns_64_1_no_dsp_1_U67", "Parent" : "50"},
	{"ID" : "57", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.grp_get_index_from_z_fu_1317", "Parent" : "24", "Child" : ["58", "59", "60"],
		"CDFG" : "get_index_from_z",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "points", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "num_points", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "layer", "Type" : "None", "Direction" : "I"},
			{"Name" : "z_value", "Type" : "None", "Direction" : "I"}]},
	{"ID" : "58", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.grp_get_index_from_z_fu_1317.fsub_32ns_32ns_32_3_full_dsp_1_U106", "Parent" : "57"},
	{"ID" : "59", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.grp_get_index_from_z_fu_1317.fpext_32ns_64_1_no_dsp_1_U107", "Parent" : "57"},
	{"ID" : "60", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.grp_get_index_from_z_fu_1317.fcmp_32ns_32ns_1_2_no_dsp_1_U108", "Parent" : "57"},
	{"ID" : "61", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.grp_patch_buffer_add_patch2_fu_1330", "Parent" : "24",
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
			{"Name" : "num_patches_constprop", "Type" : "OVld", "Direction" : "IO"}]},
	{"ID" : "62", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.grp_get_acceptanceCorners_fu_1341", "Parent" : "24", "Child" : ["63", "64", "65", "66"],
		"CDFG" : "get_acceptanceCorners",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "13", "EstimateLatencyMax" : "13",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "shadow_bottomL_jR", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "shadow_bottomR_jR", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "shadow_bottomL_jL", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "shadow_bottomR_jL", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "z1_min", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "z1_max", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "a_corner_0", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "a_corner_1", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "b_corner_0", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "b_corner_1", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "c_corner_0", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "c_corner_1", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "d_corner_0", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "d_corner_1", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "squareAcceptance", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "flatTop", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "flatBottom", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "triangleAcceptance", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "latest_patch_index_constprop", "Type" : "None", "Direction" : "I"}]},
	{"ID" : "63", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.grp_get_acceptanceCorners_fu_1341.a_corner_list_V_U", "Parent" : "62"},
	{"ID" : "64", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.grp_get_acceptanceCorners_fu_1341.b_corner_list_V_U", "Parent" : "62"},
	{"ID" : "65", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.grp_get_acceptanceCorners_fu_1341.c_corner_list_V_U", "Parent" : "62"},
	{"ID" : "66", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.grp_get_acceptanceCorners_fu_1341.d_corner_list_V_U", "Parent" : "62"},
	{"ID" : "67", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.fsub_32ns_32ns_32_3_full_dsp_1_U113", "Parent" : "24"},
	{"ID" : "68", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.uitofp_32ns_32_2_no_dsp_1_U114", "Parent" : "24"},
	{"ID" : "69", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.fpext_32ns_64_2_no_dsp_1_U115", "Parent" : "24"},
	{"ID" : "70", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.fcmp_32ns_32ns_1_2_no_dsp_1_U116", "Parent" : "24"},
	{"ID" : "71", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.dcmp_64ns_64ns_1_2_no_dsp_1_U117", "Parent" : "24"},
	{"ID" : "72", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.mul_46s_55ns_100_1_1_U118", "Parent" : "24"},
	{"ID" : "73", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.mul_33s_24s_52_1_1_U119", "Parent" : "24"},
	{"ID" : "74", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.sdiv_46ns_26s_32_50_1_U120", "Parent" : "24"},
	{"ID" : "75", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.mul_33s_32s_52_1_1_U121", "Parent" : "24"},
	{"ID" : "76", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_p_shadowquilt_main_loop_make_verticle_strip_fu_283.mul_33s_32s_64_1_1_U122", "Parent" : "24"}]}


set ArgLastReadFirstWriteLatency {
	system_top {
		points {Type I LastRead 88 FirstWrite -1}
		num_points {Type I LastRead 54 FirstWrite -1}
		patch_stream_V {Type O LastRead -1 FirstWrite 13}
		latest_patch_index_constprop {Type IO LastRead -1 FirstWrite -1}
		num_patches_constprop {Type IO LastRead -1 FirstWrite -1}
		system_top_ap_uint_96_512_unsigned_int_stream_ap_uint_96_0_squareAcceptance {Type I LastRead -1 FirstWrite -1}
		system_top_ap_uint_96_512_unsigned_int_stream_ap_uint_96_0_flatTop {Type I LastRead -1 FirstWrite -1}
		system_top_ap_uint_96_512_unsigned_int_stream_ap_uint_96_0_flatBottom {Type I LastRead -1 FirstWrite -1}
		get_radiiradii {Type I LastRead -1 FirstWrite -1}
		lbVal_constprop {Type IO LastRead -1 FirstWrite -1}
		rbVal_constprop {Type IO LastRead -1 FirstWrite -1}
		get_trapezoid_edgestrapezoid_edges {Type I LastRead -1 FirstWrite -1}
		get_parallelogram_slopesparallelogram_slopes {Type I LastRead -1 FirstWrite -1}}
	p_shadowquilt_main_loop_make_verticle_strip {
		points {Type I LastRead 88 FirstWrite -1}
		num_points {Type I LastRead 54 FirstWrite -1}
		patch_stream_V {Type O LastRead -1 FirstWrite 13}
		patch_buffer {Type IO LastRead 24 FirstWrite -1}
		pSlope {Type O LastRead -1 FirstWrite 9}
		shadow_bottomL_jR {Type IO LastRead 2 FirstWrite -1}
		shadow_bottomR_jR {Type IO LastRead 2 FirstWrite -1}
		shadow_bottomL_jL {Type IO LastRead 2 FirstWrite -1}
		shadow_bottomR_jL {Type IO LastRead 2 FirstWrite -1}
		z1_min {Type IO LastRead 4 FirstWrite -1}
		z1_max {Type IO LastRead 4 FirstWrite -1}
		a_corner_0 {Type O LastRead -1 FirstWrite 5}
		a_corner_1 {Type IO LastRead 45 FirstWrite 5}
		b_corner_0 {Type O LastRead -1 FirstWrite 5}
		b_corner_1 {Type IO LastRead 45 FirstWrite 5}
		c_corner_0 {Type IO LastRead 17 FirstWrite 5}
		c_corner_1 {Type IO LastRead 17 FirstWrite 5}
		d_corner_0 {Type O LastRead -1 FirstWrite 5}
		d_corner_1 {Type IO LastRead 17 FirstWrite 5}
		squareAcceptance {Type IO LastRead 17 FirstWrite 5}
		flatTop {Type O LastRead -1 FirstWrite 5}
		flatBottom {Type IO LastRead 17 FirstWrite 6}
		triangleAcceptance {Type IO LastRead 22 FirstWrite 8}
		get_radiiradii {Type I LastRead -1 FirstWrite -1}
		lbVal_constprop {Type IO LastRead -1 FirstWrite -1}
		rbVal_constprop {Type IO LastRead -1 FirstWrite -1}
		get_trapezoid_edgestrapezoid_edges {Type I LastRead -1 FirstWrite -1}
		latest_patch_index_constprop {Type IO LastRead 45 FirstWrite -1}
		num_patches_constprop {Type IO LastRead 41 FirstWrite 0}
		get_parallelogram_slopesparallelogram_slopes {Type I LastRead -1 FirstWrite -1}}
	alignedtoline_per_layer_loop3 {
		points {Type I LastRead 17 FirstWrite -1}
		num_points {Type I LastRead 5 FirstWrite -1}
		p_read {Type I LastRead 1 FirstWrite -1}
		z_top {Type I LastRead 1 FirstWrite -1}
		leftRight_offset {Type I LastRead 5 FirstWrite -1}
		init_patch {Type O LastRead -1 FirstWrite 9}
		i_offset {Type I LastRead 0 FirstWrite -1}
		get_radiiradii {Type I LastRead -1 FirstWrite -1}
		lbVal_constprop {Type IO LastRead -1 FirstWrite -1}
		rbVal_constprop {Type IO LastRead -1 FirstWrite -1}
		get_trapezoid_edgestrapezoid_edges {Type I LastRead -1 FirstWrite -1}}
	p_find_boundaries_and_starting_index_and_value7 {
		num_points {Type I LastRead 0 FirstWrite -1}
		points {Type I LastRead 2 FirstWrite -1}
		left_bound {Type O LastRead -1 FirstWrite 16}
		right_bound {Type O LastRead -1 FirstWrite 14}
		projectionToRow {Type I LastRead 0 FirstWrite -1}
		start_index {Type O LastRead -1 FirstWrite 9}
		start_value {Type IO LastRead 7 FirstWrite 9}
		i {Type I LastRead 0 FirstWrite -1}
		get_trapezoid_edgestrapezoid_edges {Type I LastRead -1 FirstWrite -1}
		lbVal_constprop {Type IO LastRead 9 FirstWrite 17}
		rbVal_constprop {Type IO LastRead 7 FirstWrite 15}}
	p_find_boundaries_and_starting_index_and_value_entry25 {
		projectionToRow {Type I LastRead 0 FirstWrite -1}
		i {Type I LastRead 0 FirstWrite -1}
		projectionToRow_out {Type O LastRead -1 FirstWrite 0}
		i_out {Type O LastRead -1 FirstWrite 0}
		i_out1 {Type O LastRead -1 FirstWrite 0}}
	p_find_left_and_right_boundaries9 {
		num_points {Type I LastRead 0 FirstWrite -1}
		points {Type I LastRead 2 FirstWrite -1}
		left_bound {Type O LastRead -1 FirstWrite 16}
		right_bound {Type O LastRead -1 FirstWrite 14}
		i {Type I LastRead 0 FirstWrite -1}
		get_trapezoid_edgestrapezoid_edges {Type I LastRead -1 FirstWrite -1}
		lbVal_constprop {Type IO LastRead 9 FirstWrite 17}
		rbVal_constprop {Type IO LastRead 7 FirstWrite 15}}
	p_find_starting_index_and_value8 {
		num_points {Type I LastRead 0 FirstWrite -1}
		points {Type I LastRead 2 FirstWrite -1}
		projectionToRow {Type I LastRead 0 FirstWrite -1}
		start_index {Type O LastRead -1 FirstWrite 9}
		start_value {Type IO LastRead 7 FirstWrite 9}
		i {Type I LastRead 0 FirstWrite -1}}
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
		get_radiiradii {Type I LastRead -1 FirstWrite -1}}
	get_index_from_z {
		points {Type I LastRead 2 FirstWrite -1}
		num_points {Type I LastRead 0 FirstWrite -1}
		layer {Type I LastRead 0 FirstWrite -1}
		z_value {Type I LastRead 1 FirstWrite -1}}
	patch_buffer_add_patch2 {
		new_patch {Type I LastRead 40 FirstWrite -1}
		patch_buffer {Type O LastRead -1 FirstWrite 1}
		latest_patch_index_constprop {Type IO LastRead 1 FirstWrite 1}
		num_patches_constprop {Type IO LastRead 0 FirstWrite 0}}
	get_acceptanceCorners {
		shadow_bottomL_jR {Type I LastRead 2 FirstWrite -1}
		shadow_bottomR_jR {Type I LastRead 2 FirstWrite -1}
		shadow_bottomL_jL {Type I LastRead 2 FirstWrite -1}
		shadow_bottomR_jL {Type I LastRead 2 FirstWrite -1}
		z1_min {Type I LastRead 4 FirstWrite -1}
		z1_max {Type I LastRead 4 FirstWrite -1}
		a_corner_0 {Type O LastRead -1 FirstWrite 5}
		a_corner_1 {Type O LastRead -1 FirstWrite 5}
		b_corner_0 {Type O LastRead -1 FirstWrite 5}
		b_corner_1 {Type O LastRead -1 FirstWrite 5}
		c_corner_0 {Type O LastRead -1 FirstWrite 5}
		c_corner_1 {Type O LastRead -1 FirstWrite 5}
		d_corner_0 {Type O LastRead -1 FirstWrite 5}
		d_corner_1 {Type O LastRead -1 FirstWrite 5}
		squareAcceptance {Type O LastRead -1 FirstWrite 5}
		flatTop {Type O LastRead -1 FirstWrite 5}
		flatBottom {Type O LastRead -1 FirstWrite 6}
		triangleAcceptance {Type O LastRead -1 FirstWrite 8}
		latest_patch_index_constprop {Type I LastRead 0 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "-1", "Max" : "-1"}
	, {"Name" : "Interval", "Min" : "0", "Max" : "0"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
	{"Pipeline" : "1", "EnableSignal" : "ap_enable_pp1"}
	{"Pipeline" : "2", "EnableSignal" : "ap_enable_pp2"}
]}

set Spec2ImplPortList { 
	points { ap_memory {  { points_address0 mem_address 1 12 }  { points_ce0 mem_ce 1 1 }  { points_q0 mem_dout 0 128 }  { points_address1 MemPortADDR2 1 12 }  { points_ce1 MemPortCE2 1 1 }  { points_q1 MemPortDOUT2 0 128 } } }
	num_points { ap_memory {  { num_points_address0 mem_address 1 3 }  { num_points_ce0 mem_ce 1 1 }  { num_points_q0 mem_dout 0 32 }  { num_points_address1 MemPortADDR2 1 3 }  { num_points_ce1 MemPortCE2 1 1 }  { num_points_q1 MemPortDOUT2 0 32 } } }
	patch_stream_V { ap_fifo {  { patch_stream_V_din fifo_data 1 96 }  { patch_stream_V_full_n fifo_status 0 1 }  { patch_stream_V_write fifo_update 1 1 } } }
}

set busDeadlockParameterList { 
}

# RTL port scheduling information:
set fifoSchedulingInfoList { 
	patch_stream_V { fifo_write 1 no_conditional }
}

# RTL bus port read request latency information:
set busReadReqLatencyList { 
}

# RTL bus port write response latency information:
set busWriteResLatencyList { 
}

# RTL array port load latency information:
set memoryLoadLatencyList { 
}
