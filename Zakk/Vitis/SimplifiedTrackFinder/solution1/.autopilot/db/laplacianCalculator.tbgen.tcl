set moduleName laplacianCalculator
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
set C_modelName {laplacianCalculator}
set C_modelType { void 0 }
set C_modelArgList {
	{ coordinates int 32 regular {array 400 { 1 1 } 1 1 }  }
	{ tripletMatrix int 16 regular {array 12288 { 0 0 } 0 1 }  }
}
set C_modelArgMapList {[ 
	{ "Name" : "coordinates", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "coordinates","cData": "int","bit_use": { "low": 0,"up": 0},"cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}]} , 
 	{ "Name" : "tripletMatrix", "interface" : "memory", "bitwidth" : 16, "direction" : "WRITEONLY", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "tripletMatrix","cData": "short","bit_use": { "low": 0,"up": 0},"cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}]} ]}
# RTL Port declarations: 
set portNum 20
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ coordinates_address0 sc_out sc_lv 9 signal 0 } 
	{ coordinates_ce0 sc_out sc_logic 1 signal 0 } 
	{ coordinates_q0 sc_in sc_lv 32 signal 0 } 
	{ coordinates_address1 sc_out sc_lv 9 signal 0 } 
	{ coordinates_ce1 sc_out sc_logic 1 signal 0 } 
	{ coordinates_q1 sc_in sc_lv 32 signal 0 } 
	{ tripletMatrix_address0 sc_out sc_lv 14 signal 1 } 
	{ tripletMatrix_ce0 sc_out sc_logic 1 signal 1 } 
	{ tripletMatrix_we0 sc_out sc_logic 1 signal 1 } 
	{ tripletMatrix_d0 sc_out sc_lv 16 signal 1 } 
	{ tripletMatrix_address1 sc_out sc_lv 14 signal 1 } 
	{ tripletMatrix_ce1 sc_out sc_logic 1 signal 1 } 
	{ tripletMatrix_we1 sc_out sc_logic 1 signal 1 } 
	{ tripletMatrix_d1 sc_out sc_lv 16 signal 1 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "coordinates_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "coordinates", "role": "address0" }} , 
 	{ "name": "coordinates_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "coordinates", "role": "ce0" }} , 
 	{ "name": "coordinates_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "coordinates", "role": "q0" }} , 
 	{ "name": "coordinates_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "coordinates", "role": "address1" }} , 
 	{ "name": "coordinates_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "coordinates", "role": "ce1" }} , 
 	{ "name": "coordinates_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "coordinates", "role": "q1" }} , 
 	{ "name": "tripletMatrix_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":14, "type": "signal", "bundle":{"name": "tripletMatrix", "role": "address0" }} , 
 	{ "name": "tripletMatrix_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "tripletMatrix", "role": "ce0" }} , 
 	{ "name": "tripletMatrix_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "tripletMatrix", "role": "we0" }} , 
 	{ "name": "tripletMatrix_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "tripletMatrix", "role": "d0" }} , 
 	{ "name": "tripletMatrix_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":14, "type": "signal", "bundle":{"name": "tripletMatrix", "role": "address1" }} , 
 	{ "name": "tripletMatrix_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "tripletMatrix", "role": "ce1" }} , 
 	{ "name": "tripletMatrix_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "tripletMatrix", "role": "we1" }} , 
 	{ "name": "tripletMatrix_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "tripletMatrix", "role": "d1" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "7"],
		"CDFG" : "laplacianCalculator",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "7128", "EstimateLatencyMax" : "7128",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "coordinates", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "7", "SubInstance" : "grp_decodeCoordinates_3ul_s_fu_155", "Port" : "coordinatesIn"}]},
			{"Name" : "tripletMatrix", "Type" : "Memory", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_singleNodeLaplacianCalculator_fu_62", "Port" : "nodeTriplets"}]}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.grp_singleNodeLaplacianCalculator_fu_62", "Parent" : "0", "Child" : ["2", "5", "6"],
		"CDFG" : "singleNodeLaplacianCalculator",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "145", "EstimateLatencyMax" : "145",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "nodeTriplets", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "aboveNodeList_0_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "aboveNodeList_0_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "aboveNodeList_1_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "aboveNodeList_1_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "aboveNodeList_2_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "aboveNodeList_2_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "aboveNodeList_3_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "aboveNodeList_3_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "aboveNodeList_4_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "aboveNodeList_4_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "aboveNodeList_5_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "aboveNodeList_5_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "aboveNodeList_6_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "aboveNodeList_6_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "aboveNodeList_7_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "aboveNodeList_7_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "aboveNodeList_8_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "aboveNodeList_8_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "aboveNodeList_9_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "aboveNodeList_9_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "aboveNodeList_10_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "aboveNodeList_10_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "aboveNodeList_11_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "aboveNodeList_11_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "aboveNodeList_12_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "aboveNodeList_12_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "aboveNodeList_13_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "aboveNodeList_13_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "aboveNodeList_14_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "aboveNodeList_14_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "aboveNodeList_15_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "aboveNodeList_15_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "belowNodeList_0_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "belowNodeList_0_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "belowNodeList_1_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "belowNodeList_1_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "belowNodeList_2_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "belowNodeList_2_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "belowNodeList_3_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "belowNodeList_3_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "belowNodeList_4_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "belowNodeList_4_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "belowNodeList_5_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "belowNodeList_5_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "belowNodeList_6_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "belowNodeList_6_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "belowNodeList_7_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "belowNodeList_7_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "belowNodeList_8_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "belowNodeList_8_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "belowNodeList_9_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "belowNodeList_9_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "belowNodeList_10_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "belowNodeList_10_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "belowNodeList_11_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "belowNodeList_11_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "belowNodeList_12_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "belowNodeList_12_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "belowNodeList_13_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "belowNodeList_13_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "belowNodeList_14_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "belowNodeList_14_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "belowNodeList_15_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "belowNodeList_15_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "inputNode_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "inputNode_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "nodeTriplets_offset", "Type" : "None", "Direction" : "I"},
			{"Name" : "nodeTriplets1_offset", "Type" : "None", "Direction" : "I"}]},
	{"ID" : "2", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_singleNodeLaplacianCalculator_fu_62.call_ret_makeHalfLaplacian_fu_4610", "Parent" : "1", "Child" : ["3", "4"],
		"CDFG" : "makeHalfLaplacian",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "0", "ap_start" : "0", "ap_ready" : "1", "ap_done" : "0", "ap_continue" : "0", "ap_idle" : "0", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "1",
		"VariableLatency" : "0", "ExactLatency" : "0", "EstimateLatencyMin" : "0", "EstimateLatencyMax" : "0",
		"Combinational" : "1",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "nodeList_0_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "nodeList_0_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "nodeList_1_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "nodeList_1_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "nodeList_2_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "nodeList_2_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "nodeList_3_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "nodeList_3_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "nodeList_4_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "nodeList_4_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "nodeList_5_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "nodeList_5_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "nodeList_6_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "nodeList_6_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "nodeList_7_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "nodeList_7_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "nodeList_8_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "nodeList_8_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "nodeList_9_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "nodeList_9_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "nodeList_10_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "nodeList_10_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "nodeList_11_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "nodeList_11_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "nodeList_12_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "nodeList_12_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "nodeList_13_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "nodeList_13_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "nodeList_14_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "nodeList_14_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "nodeList_15_0_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "nodeList_15_1_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read32", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read33", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read34", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read35", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read36", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read37", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read38", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read39", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read40", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read41", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read42", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read43", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read44", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read45", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read46", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read47", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read48", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read49", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read50", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read51", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read52", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read53", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read54", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read55", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read56", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read57", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read58", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read59", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read60", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read61", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read62", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read63", "Type" : "None", "Direction" : "I"},
			{"Name" : "inputNode_offset", "Type" : "None", "Direction" : "I"}]},
	{"ID" : "3", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_singleNodeLaplacianCalculator_fu_62.call_ret_makeHalfLaplacian_fu_4610.mux_326_32_1_1_U2", "Parent" : "2"},
	{"ID" : "4", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_singleNodeLaplacianCalculator_fu_62.call_ret_makeHalfLaplacian_fu_4610.mux_326_32_1_1_U3", "Parent" : "2"},
	{"ID" : "5", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_singleNodeLaplacianCalculator_fu_62.mux_164_32_1_1_U70", "Parent" : "1"},
	{"ID" : "6", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_singleNodeLaplacianCalculator_fu_62.mux_164_32_1_1_U71", "Parent" : "1"},
	{"ID" : "7", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.grp_decodeCoordinates_3ul_s_fu_155", "Parent" : "0",
		"CDFG" : "decodeCoordinates_3ul_s",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "72", "EstimateLatencyMax" : "72",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "coordinatesIn", "Type" : "Memory", "Direction" : "I"}]}]}


set ArgLastReadFirstWriteLatency {
	laplacianCalculator {
		coordinates {Type I LastRead 72 FirstWrite -1}
		tripletMatrix {Type O LastRead -1 FirstWrite 2}}
	singleNodeLaplacianCalculator {
		nodeTriplets {Type O LastRead -1 FirstWrite 2}
		aboveNodeList_0_0_read {Type I LastRead 0 FirstWrite -1}
		aboveNodeList_0_1_read {Type I LastRead 0 FirstWrite -1}
		aboveNodeList_1_0_read {Type I LastRead 0 FirstWrite -1}
		aboveNodeList_1_1_read {Type I LastRead 0 FirstWrite -1}
		aboveNodeList_2_0_read {Type I LastRead 0 FirstWrite -1}
		aboveNodeList_2_1_read {Type I LastRead 0 FirstWrite -1}
		aboveNodeList_3_0_read {Type I LastRead 0 FirstWrite -1}
		aboveNodeList_3_1_read {Type I LastRead 0 FirstWrite -1}
		aboveNodeList_4_0_read {Type I LastRead 0 FirstWrite -1}
		aboveNodeList_4_1_read {Type I LastRead 0 FirstWrite -1}
		aboveNodeList_5_0_read {Type I LastRead 0 FirstWrite -1}
		aboveNodeList_5_1_read {Type I LastRead 0 FirstWrite -1}
		aboveNodeList_6_0_read {Type I LastRead 0 FirstWrite -1}
		aboveNodeList_6_1_read {Type I LastRead 0 FirstWrite -1}
		aboveNodeList_7_0_read {Type I LastRead 0 FirstWrite -1}
		aboveNodeList_7_1_read {Type I LastRead 0 FirstWrite -1}
		aboveNodeList_8_0_read {Type I LastRead 0 FirstWrite -1}
		aboveNodeList_8_1_read {Type I LastRead 0 FirstWrite -1}
		aboveNodeList_9_0_read {Type I LastRead 0 FirstWrite -1}
		aboveNodeList_9_1_read {Type I LastRead 0 FirstWrite -1}
		aboveNodeList_10_0_read {Type I LastRead 0 FirstWrite -1}
		aboveNodeList_10_1_read {Type I LastRead 0 FirstWrite -1}
		aboveNodeList_11_0_read {Type I LastRead 0 FirstWrite -1}
		aboveNodeList_11_1_read {Type I LastRead 0 FirstWrite -1}
		aboveNodeList_12_0_read {Type I LastRead 0 FirstWrite -1}
		aboveNodeList_12_1_read {Type I LastRead 0 FirstWrite -1}
		aboveNodeList_13_0_read {Type I LastRead 0 FirstWrite -1}
		aboveNodeList_13_1_read {Type I LastRead 0 FirstWrite -1}
		aboveNodeList_14_0_read {Type I LastRead 0 FirstWrite -1}
		aboveNodeList_14_1_read {Type I LastRead 0 FirstWrite -1}
		aboveNodeList_15_0_read {Type I LastRead 0 FirstWrite -1}
		aboveNodeList_15_1_read {Type I LastRead 0 FirstWrite -1}
		belowNodeList_0_0_read {Type I LastRead 0 FirstWrite -1}
		belowNodeList_0_1_read {Type I LastRead 0 FirstWrite -1}
		belowNodeList_1_0_read {Type I LastRead 0 FirstWrite -1}
		belowNodeList_1_1_read {Type I LastRead 0 FirstWrite -1}
		belowNodeList_2_0_read {Type I LastRead 0 FirstWrite -1}
		belowNodeList_2_1_read {Type I LastRead 0 FirstWrite -1}
		belowNodeList_3_0_read {Type I LastRead 0 FirstWrite -1}
		belowNodeList_3_1_read {Type I LastRead 0 FirstWrite -1}
		belowNodeList_4_0_read {Type I LastRead 0 FirstWrite -1}
		belowNodeList_4_1_read {Type I LastRead 0 FirstWrite -1}
		belowNodeList_5_0_read {Type I LastRead 0 FirstWrite -1}
		belowNodeList_5_1_read {Type I LastRead 0 FirstWrite -1}
		belowNodeList_6_0_read {Type I LastRead 0 FirstWrite -1}
		belowNodeList_6_1_read {Type I LastRead 0 FirstWrite -1}
		belowNodeList_7_0_read {Type I LastRead 0 FirstWrite -1}
		belowNodeList_7_1_read {Type I LastRead 0 FirstWrite -1}
		belowNodeList_8_0_read {Type I LastRead 0 FirstWrite -1}
		belowNodeList_8_1_read {Type I LastRead 0 FirstWrite -1}
		belowNodeList_9_0_read {Type I LastRead 0 FirstWrite -1}
		belowNodeList_9_1_read {Type I LastRead 0 FirstWrite -1}
		belowNodeList_10_0_read {Type I LastRead 0 FirstWrite -1}
		belowNodeList_10_1_read {Type I LastRead 0 FirstWrite -1}
		belowNodeList_11_0_read {Type I LastRead 0 FirstWrite -1}
		belowNodeList_11_1_read {Type I LastRead 0 FirstWrite -1}
		belowNodeList_12_0_read {Type I LastRead 0 FirstWrite -1}
		belowNodeList_12_1_read {Type I LastRead 0 FirstWrite -1}
		belowNodeList_13_0_read {Type I LastRead 0 FirstWrite -1}
		belowNodeList_13_1_read {Type I LastRead 0 FirstWrite -1}
		belowNodeList_14_0_read {Type I LastRead 0 FirstWrite -1}
		belowNodeList_14_1_read {Type I LastRead 0 FirstWrite -1}
		belowNodeList_15_0_read {Type I LastRead 0 FirstWrite -1}
		belowNodeList_15_1_read {Type I LastRead 0 FirstWrite -1}
		inputNode_0_read {Type I LastRead 0 FirstWrite -1}
		inputNode_1_read {Type I LastRead 0 FirstWrite -1}
		nodeTriplets_offset {Type I LastRead 0 FirstWrite -1}
		nodeTriplets1_offset {Type I LastRead 0 FirstWrite -1}}
	makeHalfLaplacian {
		nodeList_0_0_read {Type I LastRead 0 FirstWrite -1}
		nodeList_0_1_read {Type I LastRead 0 FirstWrite -1}
		nodeList_1_0_read {Type I LastRead 0 FirstWrite -1}
		nodeList_1_1_read {Type I LastRead 0 FirstWrite -1}
		nodeList_2_0_read {Type I LastRead 0 FirstWrite -1}
		nodeList_2_1_read {Type I LastRead 0 FirstWrite -1}
		nodeList_3_0_read {Type I LastRead 0 FirstWrite -1}
		nodeList_3_1_read {Type I LastRead 0 FirstWrite -1}
		nodeList_4_0_read {Type I LastRead 0 FirstWrite -1}
		nodeList_4_1_read {Type I LastRead 0 FirstWrite -1}
		nodeList_5_0_read {Type I LastRead 0 FirstWrite -1}
		nodeList_5_1_read {Type I LastRead 0 FirstWrite -1}
		nodeList_6_0_read {Type I LastRead 0 FirstWrite -1}
		nodeList_6_1_read {Type I LastRead 0 FirstWrite -1}
		nodeList_7_0_read {Type I LastRead 0 FirstWrite -1}
		nodeList_7_1_read {Type I LastRead 0 FirstWrite -1}
		nodeList_8_0_read {Type I LastRead 0 FirstWrite -1}
		nodeList_8_1_read {Type I LastRead 0 FirstWrite -1}
		nodeList_9_0_read {Type I LastRead 0 FirstWrite -1}
		nodeList_9_1_read {Type I LastRead 0 FirstWrite -1}
		nodeList_10_0_read {Type I LastRead 0 FirstWrite -1}
		nodeList_10_1_read {Type I LastRead 0 FirstWrite -1}
		nodeList_11_0_read {Type I LastRead 0 FirstWrite -1}
		nodeList_11_1_read {Type I LastRead 0 FirstWrite -1}
		nodeList_12_0_read {Type I LastRead 0 FirstWrite -1}
		nodeList_12_1_read {Type I LastRead 0 FirstWrite -1}
		nodeList_13_0_read {Type I LastRead 0 FirstWrite -1}
		nodeList_13_1_read {Type I LastRead 0 FirstWrite -1}
		nodeList_14_0_read {Type I LastRead 0 FirstWrite -1}
		nodeList_14_1_read {Type I LastRead 0 FirstWrite -1}
		nodeList_15_0_read {Type I LastRead 0 FirstWrite -1}
		nodeList_15_1_read {Type I LastRead 0 FirstWrite -1}
		p_read32 {Type I LastRead 0 FirstWrite -1}
		p_read33 {Type I LastRead 0 FirstWrite -1}
		p_read34 {Type I LastRead 0 FirstWrite -1}
		p_read35 {Type I LastRead 0 FirstWrite -1}
		p_read36 {Type I LastRead 0 FirstWrite -1}
		p_read37 {Type I LastRead 0 FirstWrite -1}
		p_read38 {Type I LastRead 0 FirstWrite -1}
		p_read39 {Type I LastRead 0 FirstWrite -1}
		p_read40 {Type I LastRead 0 FirstWrite -1}
		p_read41 {Type I LastRead 0 FirstWrite -1}
		p_read42 {Type I LastRead 0 FirstWrite -1}
		p_read43 {Type I LastRead 0 FirstWrite -1}
		p_read44 {Type I LastRead 0 FirstWrite -1}
		p_read45 {Type I LastRead 0 FirstWrite -1}
		p_read46 {Type I LastRead 0 FirstWrite -1}
		p_read47 {Type I LastRead 0 FirstWrite -1}
		p_read48 {Type I LastRead 0 FirstWrite -1}
		p_read49 {Type I LastRead 0 FirstWrite -1}
		p_read50 {Type I LastRead 0 FirstWrite -1}
		p_read51 {Type I LastRead 0 FirstWrite -1}
		p_read52 {Type I LastRead 0 FirstWrite -1}
		p_read53 {Type I LastRead 0 FirstWrite -1}
		p_read54 {Type I LastRead 0 FirstWrite -1}
		p_read55 {Type I LastRead 0 FirstWrite -1}
		p_read56 {Type I LastRead 0 FirstWrite -1}
		p_read57 {Type I LastRead 0 FirstWrite -1}
		p_read58 {Type I LastRead 0 FirstWrite -1}
		p_read59 {Type I LastRead 0 FirstWrite -1}
		p_read60 {Type I LastRead 0 FirstWrite -1}
		p_read61 {Type I LastRead 0 FirstWrite -1}
		p_read62 {Type I LastRead 0 FirstWrite -1}
		p_read63 {Type I LastRead 0 FirstWrite -1}
		inputNode_offset {Type I LastRead 0 FirstWrite -1}}
	decodeCoordinates_3ul_s {
		coordinatesIn {Type I LastRead 72 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "7128", "Max" : "7128"}
	, {"Name" : "Interval", "Min" : "7129", "Max" : "7129"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	coordinates { ap_memory {  { coordinates_address0 mem_address 1 9 }  { coordinates_ce0 mem_ce 1 1 }  { coordinates_q0 mem_dout 0 32 }  { coordinates_address1 MemPortADDR2 1 9 }  { coordinates_ce1 MemPortCE2 1 1 }  { coordinates_q1 MemPortDOUT2 0 32 } } }
	tripletMatrix { ap_memory {  { tripletMatrix_address0 mem_address 1 14 }  { tripletMatrix_ce0 mem_ce 1 1 }  { tripletMatrix_we0 mem_we 1 1 }  { tripletMatrix_d0 mem_din 1 16 }  { tripletMatrix_address1 MemPortADDR2 1 14 }  { tripletMatrix_ce1 MemPortCE2 1 1 }  { tripletMatrix_we1 MemPortWE2 1 1 }  { tripletMatrix_d1 MemPortDIN2 1 16 } } }
}

set busDeadlockParameterList { 
}

# RTL port scheduling information:
set fifoSchedulingInfoList { 
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
