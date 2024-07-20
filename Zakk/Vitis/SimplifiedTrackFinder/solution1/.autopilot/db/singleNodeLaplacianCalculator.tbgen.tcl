set moduleName singleNodeLaplacianCalculator
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
set C_modelName {singleNodeLaplacianCalculator}
set C_modelType { void 0 }
set C_modelArgList {
	{ nodeTriplets int 16 regular {array 12288 { 0 0 } 0 1 }  }
	{ aboveNodeList_0_0_read int 32 regular  }
	{ aboveNodeList_0_1_read int 32 regular  }
	{ aboveNodeList_1_0_read int 32 regular  }
	{ aboveNodeList_1_1_read int 32 regular  }
	{ aboveNodeList_2_0_read int 32 regular  }
	{ aboveNodeList_2_1_read int 32 regular  }
	{ aboveNodeList_3_0_read int 32 regular  }
	{ aboveNodeList_3_1_read int 32 regular  }
	{ aboveNodeList_4_0_read int 32 regular  }
	{ aboveNodeList_4_1_read int 32 regular  }
	{ aboveNodeList_5_0_read int 32 regular  }
	{ aboveNodeList_5_1_read int 32 regular  }
	{ aboveNodeList_6_0_read int 32 regular  }
	{ aboveNodeList_6_1_read int 32 regular  }
	{ aboveNodeList_7_0_read int 32 regular  }
	{ aboveNodeList_7_1_read int 32 regular  }
	{ aboveNodeList_8_0_read int 32 regular  }
	{ aboveNodeList_8_1_read int 32 regular  }
	{ aboveNodeList_9_0_read int 32 regular  }
	{ aboveNodeList_9_1_read int 32 regular  }
	{ aboveNodeList_10_0_read int 32 regular  }
	{ aboveNodeList_10_1_read int 32 regular  }
	{ aboveNodeList_11_0_read int 32 regular  }
	{ aboveNodeList_11_1_read int 32 regular  }
	{ aboveNodeList_12_0_read int 32 regular  }
	{ aboveNodeList_12_1_read int 32 regular  }
	{ aboveNodeList_13_0_read int 32 regular  }
	{ aboveNodeList_13_1_read int 32 regular  }
	{ aboveNodeList_14_0_read int 32 regular  }
	{ aboveNodeList_14_1_read int 32 regular  }
	{ aboveNodeList_15_0_read int 32 regular  }
	{ aboveNodeList_15_1_read int 32 regular  }
	{ belowNodeList_0_0_read int 32 regular  }
	{ belowNodeList_0_1_read int 32 regular  }
	{ belowNodeList_1_0_read int 32 regular  }
	{ belowNodeList_1_1_read int 32 regular  }
	{ belowNodeList_2_0_read int 32 regular  }
	{ belowNodeList_2_1_read int 32 regular  }
	{ belowNodeList_3_0_read int 32 regular  }
	{ belowNodeList_3_1_read int 32 regular  }
	{ belowNodeList_4_0_read int 32 regular  }
	{ belowNodeList_4_1_read int 32 regular  }
	{ belowNodeList_5_0_read int 32 regular  }
	{ belowNodeList_5_1_read int 32 regular  }
	{ belowNodeList_6_0_read int 32 regular  }
	{ belowNodeList_6_1_read int 32 regular  }
	{ belowNodeList_7_0_read int 32 regular  }
	{ belowNodeList_7_1_read int 32 regular  }
	{ belowNodeList_8_0_read int 32 regular  }
	{ belowNodeList_8_1_read int 32 regular  }
	{ belowNodeList_9_0_read int 32 regular  }
	{ belowNodeList_9_1_read int 32 regular  }
	{ belowNodeList_10_0_read int 32 regular  }
	{ belowNodeList_10_1_read int 32 regular  }
	{ belowNodeList_11_0_read int 32 regular  }
	{ belowNodeList_11_1_read int 32 regular  }
	{ belowNodeList_12_0_read int 32 regular  }
	{ belowNodeList_12_1_read int 32 regular  }
	{ belowNodeList_13_0_read int 32 regular  }
	{ belowNodeList_13_1_read int 32 regular  }
	{ belowNodeList_14_0_read int 32 regular  }
	{ belowNodeList_14_1_read int 32 regular  }
	{ belowNodeList_15_0_read int 32 regular  }
	{ belowNodeList_15_1_read int 32 regular  }
	{ inputNode_0_read int 32 regular  }
	{ inputNode_1_read int 32 regular  }
	{ nodeTriplets_offset int 2 regular  }
	{ nodeTriplets1_offset int 4 regular  }
}
set C_modelArgMapList {[ 
	{ "Name" : "nodeTriplets", "interface" : "memory", "bitwidth" : 16, "direction" : "WRITEONLY"} , 
 	{ "Name" : "aboveNodeList_0_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "aboveNodeList_0_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "aboveNodeList_1_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "aboveNodeList_1_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "aboveNodeList_2_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "aboveNodeList_2_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "aboveNodeList_3_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "aboveNodeList_3_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "aboveNodeList_4_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "aboveNodeList_4_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "aboveNodeList_5_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "aboveNodeList_5_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "aboveNodeList_6_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "aboveNodeList_6_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "aboveNodeList_7_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "aboveNodeList_7_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "aboveNodeList_8_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "aboveNodeList_8_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "aboveNodeList_9_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "aboveNodeList_9_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "aboveNodeList_10_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "aboveNodeList_10_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "aboveNodeList_11_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "aboveNodeList_11_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "aboveNodeList_12_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "aboveNodeList_12_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "aboveNodeList_13_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "aboveNodeList_13_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "aboveNodeList_14_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "aboveNodeList_14_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "aboveNodeList_15_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "aboveNodeList_15_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "belowNodeList_0_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "belowNodeList_0_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "belowNodeList_1_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "belowNodeList_1_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "belowNodeList_2_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "belowNodeList_2_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "belowNodeList_3_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "belowNodeList_3_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "belowNodeList_4_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "belowNodeList_4_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "belowNodeList_5_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "belowNodeList_5_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "belowNodeList_6_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "belowNodeList_6_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "belowNodeList_7_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "belowNodeList_7_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "belowNodeList_8_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "belowNodeList_8_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "belowNodeList_9_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "belowNodeList_9_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "belowNodeList_10_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "belowNodeList_10_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "belowNodeList_11_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "belowNodeList_11_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "belowNodeList_12_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "belowNodeList_12_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "belowNodeList_13_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "belowNodeList_13_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "belowNodeList_14_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "belowNodeList_14_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "belowNodeList_15_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "belowNodeList_15_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "inputNode_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "inputNode_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "nodeTriplets_offset", "interface" : "wire", "bitwidth" : 2, "direction" : "READONLY"} , 
 	{ "Name" : "nodeTriplets1_offset", "interface" : "wire", "bitwidth" : 4, "direction" : "READONLY"} ]}
# RTL Port declarations: 
set portNum 82
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ nodeTriplets_address0 sc_out sc_lv 14 signal 0 } 
	{ nodeTriplets_ce0 sc_out sc_logic 1 signal 0 } 
	{ nodeTriplets_we0 sc_out sc_logic 1 signal 0 } 
	{ nodeTriplets_d0 sc_out sc_lv 16 signal 0 } 
	{ nodeTriplets_address1 sc_out sc_lv 14 signal 0 } 
	{ nodeTriplets_ce1 sc_out sc_logic 1 signal 0 } 
	{ nodeTriplets_we1 sc_out sc_logic 1 signal 0 } 
	{ nodeTriplets_d1 sc_out sc_lv 16 signal 0 } 
	{ aboveNodeList_0_0_read sc_in sc_lv 32 signal 1 } 
	{ aboveNodeList_0_1_read sc_in sc_lv 32 signal 2 } 
	{ aboveNodeList_1_0_read sc_in sc_lv 32 signal 3 } 
	{ aboveNodeList_1_1_read sc_in sc_lv 32 signal 4 } 
	{ aboveNodeList_2_0_read sc_in sc_lv 32 signal 5 } 
	{ aboveNodeList_2_1_read sc_in sc_lv 32 signal 6 } 
	{ aboveNodeList_3_0_read sc_in sc_lv 32 signal 7 } 
	{ aboveNodeList_3_1_read sc_in sc_lv 32 signal 8 } 
	{ aboveNodeList_4_0_read sc_in sc_lv 32 signal 9 } 
	{ aboveNodeList_4_1_read sc_in sc_lv 32 signal 10 } 
	{ aboveNodeList_5_0_read sc_in sc_lv 32 signal 11 } 
	{ aboveNodeList_5_1_read sc_in sc_lv 32 signal 12 } 
	{ aboveNodeList_6_0_read sc_in sc_lv 32 signal 13 } 
	{ aboveNodeList_6_1_read sc_in sc_lv 32 signal 14 } 
	{ aboveNodeList_7_0_read sc_in sc_lv 32 signal 15 } 
	{ aboveNodeList_7_1_read sc_in sc_lv 32 signal 16 } 
	{ aboveNodeList_8_0_read sc_in sc_lv 32 signal 17 } 
	{ aboveNodeList_8_1_read sc_in sc_lv 32 signal 18 } 
	{ aboveNodeList_9_0_read sc_in sc_lv 32 signal 19 } 
	{ aboveNodeList_9_1_read sc_in sc_lv 32 signal 20 } 
	{ aboveNodeList_10_0_read sc_in sc_lv 32 signal 21 } 
	{ aboveNodeList_10_1_read sc_in sc_lv 32 signal 22 } 
	{ aboveNodeList_11_0_read sc_in sc_lv 32 signal 23 } 
	{ aboveNodeList_11_1_read sc_in sc_lv 32 signal 24 } 
	{ aboveNodeList_12_0_read sc_in sc_lv 32 signal 25 } 
	{ aboveNodeList_12_1_read sc_in sc_lv 32 signal 26 } 
	{ aboveNodeList_13_0_read sc_in sc_lv 32 signal 27 } 
	{ aboveNodeList_13_1_read sc_in sc_lv 32 signal 28 } 
	{ aboveNodeList_14_0_read sc_in sc_lv 32 signal 29 } 
	{ aboveNodeList_14_1_read sc_in sc_lv 32 signal 30 } 
	{ aboveNodeList_15_0_read sc_in sc_lv 32 signal 31 } 
	{ aboveNodeList_15_1_read sc_in sc_lv 32 signal 32 } 
	{ belowNodeList_0_0_read sc_in sc_lv 32 signal 33 } 
	{ belowNodeList_0_1_read sc_in sc_lv 32 signal 34 } 
	{ belowNodeList_1_0_read sc_in sc_lv 32 signal 35 } 
	{ belowNodeList_1_1_read sc_in sc_lv 32 signal 36 } 
	{ belowNodeList_2_0_read sc_in sc_lv 32 signal 37 } 
	{ belowNodeList_2_1_read sc_in sc_lv 32 signal 38 } 
	{ belowNodeList_3_0_read sc_in sc_lv 32 signal 39 } 
	{ belowNodeList_3_1_read sc_in sc_lv 32 signal 40 } 
	{ belowNodeList_4_0_read sc_in sc_lv 32 signal 41 } 
	{ belowNodeList_4_1_read sc_in sc_lv 32 signal 42 } 
	{ belowNodeList_5_0_read sc_in sc_lv 32 signal 43 } 
	{ belowNodeList_5_1_read sc_in sc_lv 32 signal 44 } 
	{ belowNodeList_6_0_read sc_in sc_lv 32 signal 45 } 
	{ belowNodeList_6_1_read sc_in sc_lv 32 signal 46 } 
	{ belowNodeList_7_0_read sc_in sc_lv 32 signal 47 } 
	{ belowNodeList_7_1_read sc_in sc_lv 32 signal 48 } 
	{ belowNodeList_8_0_read sc_in sc_lv 32 signal 49 } 
	{ belowNodeList_8_1_read sc_in sc_lv 32 signal 50 } 
	{ belowNodeList_9_0_read sc_in sc_lv 32 signal 51 } 
	{ belowNodeList_9_1_read sc_in sc_lv 32 signal 52 } 
	{ belowNodeList_10_0_read sc_in sc_lv 32 signal 53 } 
	{ belowNodeList_10_1_read sc_in sc_lv 32 signal 54 } 
	{ belowNodeList_11_0_read sc_in sc_lv 32 signal 55 } 
	{ belowNodeList_11_1_read sc_in sc_lv 32 signal 56 } 
	{ belowNodeList_12_0_read sc_in sc_lv 32 signal 57 } 
	{ belowNodeList_12_1_read sc_in sc_lv 32 signal 58 } 
	{ belowNodeList_13_0_read sc_in sc_lv 32 signal 59 } 
	{ belowNodeList_13_1_read sc_in sc_lv 32 signal 60 } 
	{ belowNodeList_14_0_read sc_in sc_lv 32 signal 61 } 
	{ belowNodeList_14_1_read sc_in sc_lv 32 signal 62 } 
	{ belowNodeList_15_0_read sc_in sc_lv 32 signal 63 } 
	{ belowNodeList_15_1_read sc_in sc_lv 32 signal 64 } 
	{ inputNode_0_read sc_in sc_lv 32 signal 65 } 
	{ inputNode_1_read sc_in sc_lv 32 signal 66 } 
	{ nodeTriplets_offset sc_in sc_lv 2 signal 67 } 
	{ nodeTriplets1_offset sc_in sc_lv 4 signal 68 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "nodeTriplets_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":14, "type": "signal", "bundle":{"name": "nodeTriplets", "role": "address0" }} , 
 	{ "name": "nodeTriplets_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "nodeTriplets", "role": "ce0" }} , 
 	{ "name": "nodeTriplets_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "nodeTriplets", "role": "we0" }} , 
 	{ "name": "nodeTriplets_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "nodeTriplets", "role": "d0" }} , 
 	{ "name": "nodeTriplets_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":14, "type": "signal", "bundle":{"name": "nodeTriplets", "role": "address1" }} , 
 	{ "name": "nodeTriplets_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "nodeTriplets", "role": "ce1" }} , 
 	{ "name": "nodeTriplets_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "nodeTriplets", "role": "we1" }} , 
 	{ "name": "nodeTriplets_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "nodeTriplets", "role": "d1" }} , 
 	{ "name": "aboveNodeList_0_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "aboveNodeList_0_0_read", "role": "default" }} , 
 	{ "name": "aboveNodeList_0_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "aboveNodeList_0_1_read", "role": "default" }} , 
 	{ "name": "aboveNodeList_1_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "aboveNodeList_1_0_read", "role": "default" }} , 
 	{ "name": "aboveNodeList_1_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "aboveNodeList_1_1_read", "role": "default" }} , 
 	{ "name": "aboveNodeList_2_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "aboveNodeList_2_0_read", "role": "default" }} , 
 	{ "name": "aboveNodeList_2_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "aboveNodeList_2_1_read", "role": "default" }} , 
 	{ "name": "aboveNodeList_3_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "aboveNodeList_3_0_read", "role": "default" }} , 
 	{ "name": "aboveNodeList_3_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "aboveNodeList_3_1_read", "role": "default" }} , 
 	{ "name": "aboveNodeList_4_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "aboveNodeList_4_0_read", "role": "default" }} , 
 	{ "name": "aboveNodeList_4_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "aboveNodeList_4_1_read", "role": "default" }} , 
 	{ "name": "aboveNodeList_5_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "aboveNodeList_5_0_read", "role": "default" }} , 
 	{ "name": "aboveNodeList_5_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "aboveNodeList_5_1_read", "role": "default" }} , 
 	{ "name": "aboveNodeList_6_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "aboveNodeList_6_0_read", "role": "default" }} , 
 	{ "name": "aboveNodeList_6_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "aboveNodeList_6_1_read", "role": "default" }} , 
 	{ "name": "aboveNodeList_7_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "aboveNodeList_7_0_read", "role": "default" }} , 
 	{ "name": "aboveNodeList_7_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "aboveNodeList_7_1_read", "role": "default" }} , 
 	{ "name": "aboveNodeList_8_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "aboveNodeList_8_0_read", "role": "default" }} , 
 	{ "name": "aboveNodeList_8_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "aboveNodeList_8_1_read", "role": "default" }} , 
 	{ "name": "aboveNodeList_9_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "aboveNodeList_9_0_read", "role": "default" }} , 
 	{ "name": "aboveNodeList_9_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "aboveNodeList_9_1_read", "role": "default" }} , 
 	{ "name": "aboveNodeList_10_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "aboveNodeList_10_0_read", "role": "default" }} , 
 	{ "name": "aboveNodeList_10_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "aboveNodeList_10_1_read", "role": "default" }} , 
 	{ "name": "aboveNodeList_11_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "aboveNodeList_11_0_read", "role": "default" }} , 
 	{ "name": "aboveNodeList_11_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "aboveNodeList_11_1_read", "role": "default" }} , 
 	{ "name": "aboveNodeList_12_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "aboveNodeList_12_0_read", "role": "default" }} , 
 	{ "name": "aboveNodeList_12_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "aboveNodeList_12_1_read", "role": "default" }} , 
 	{ "name": "aboveNodeList_13_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "aboveNodeList_13_0_read", "role": "default" }} , 
 	{ "name": "aboveNodeList_13_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "aboveNodeList_13_1_read", "role": "default" }} , 
 	{ "name": "aboveNodeList_14_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "aboveNodeList_14_0_read", "role": "default" }} , 
 	{ "name": "aboveNodeList_14_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "aboveNodeList_14_1_read", "role": "default" }} , 
 	{ "name": "aboveNodeList_15_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "aboveNodeList_15_0_read", "role": "default" }} , 
 	{ "name": "aboveNodeList_15_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "aboveNodeList_15_1_read", "role": "default" }} , 
 	{ "name": "belowNodeList_0_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "belowNodeList_0_0_read", "role": "default" }} , 
 	{ "name": "belowNodeList_0_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "belowNodeList_0_1_read", "role": "default" }} , 
 	{ "name": "belowNodeList_1_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "belowNodeList_1_0_read", "role": "default" }} , 
 	{ "name": "belowNodeList_1_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "belowNodeList_1_1_read", "role": "default" }} , 
 	{ "name": "belowNodeList_2_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "belowNodeList_2_0_read", "role": "default" }} , 
 	{ "name": "belowNodeList_2_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "belowNodeList_2_1_read", "role": "default" }} , 
 	{ "name": "belowNodeList_3_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "belowNodeList_3_0_read", "role": "default" }} , 
 	{ "name": "belowNodeList_3_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "belowNodeList_3_1_read", "role": "default" }} , 
 	{ "name": "belowNodeList_4_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "belowNodeList_4_0_read", "role": "default" }} , 
 	{ "name": "belowNodeList_4_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "belowNodeList_4_1_read", "role": "default" }} , 
 	{ "name": "belowNodeList_5_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "belowNodeList_5_0_read", "role": "default" }} , 
 	{ "name": "belowNodeList_5_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "belowNodeList_5_1_read", "role": "default" }} , 
 	{ "name": "belowNodeList_6_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "belowNodeList_6_0_read", "role": "default" }} , 
 	{ "name": "belowNodeList_6_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "belowNodeList_6_1_read", "role": "default" }} , 
 	{ "name": "belowNodeList_7_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "belowNodeList_7_0_read", "role": "default" }} , 
 	{ "name": "belowNodeList_7_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "belowNodeList_7_1_read", "role": "default" }} , 
 	{ "name": "belowNodeList_8_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "belowNodeList_8_0_read", "role": "default" }} , 
 	{ "name": "belowNodeList_8_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "belowNodeList_8_1_read", "role": "default" }} , 
 	{ "name": "belowNodeList_9_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "belowNodeList_9_0_read", "role": "default" }} , 
 	{ "name": "belowNodeList_9_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "belowNodeList_9_1_read", "role": "default" }} , 
 	{ "name": "belowNodeList_10_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "belowNodeList_10_0_read", "role": "default" }} , 
 	{ "name": "belowNodeList_10_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "belowNodeList_10_1_read", "role": "default" }} , 
 	{ "name": "belowNodeList_11_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "belowNodeList_11_0_read", "role": "default" }} , 
 	{ "name": "belowNodeList_11_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "belowNodeList_11_1_read", "role": "default" }} , 
 	{ "name": "belowNodeList_12_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "belowNodeList_12_0_read", "role": "default" }} , 
 	{ "name": "belowNodeList_12_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "belowNodeList_12_1_read", "role": "default" }} , 
 	{ "name": "belowNodeList_13_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "belowNodeList_13_0_read", "role": "default" }} , 
 	{ "name": "belowNodeList_13_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "belowNodeList_13_1_read", "role": "default" }} , 
 	{ "name": "belowNodeList_14_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "belowNodeList_14_0_read", "role": "default" }} , 
 	{ "name": "belowNodeList_14_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "belowNodeList_14_1_read", "role": "default" }} , 
 	{ "name": "belowNodeList_15_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "belowNodeList_15_0_read", "role": "default" }} , 
 	{ "name": "belowNodeList_15_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "belowNodeList_15_1_read", "role": "default" }} , 
 	{ "name": "inputNode_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "inputNode_0_read", "role": "default" }} , 
 	{ "name": "inputNode_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "inputNode_1_read", "role": "default" }} , 
 	{ "name": "nodeTriplets_offset", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "nodeTriplets_offset", "role": "default" }} , 
 	{ "name": "nodeTriplets1_offset", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "nodeTriplets1_offset", "role": "default" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "4", "5"],
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
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.call_ret_makeHalfLaplacian_fu_4610", "Parent" : "0", "Child" : ["2", "3"],
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
	{"ID" : "2", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.call_ret_makeHalfLaplacian_fu_4610.mux_326_32_1_1_U2", "Parent" : "1"},
	{"ID" : "3", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.call_ret_makeHalfLaplacian_fu_4610.mux_326_32_1_1_U3", "Parent" : "1"},
	{"ID" : "4", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mux_164_32_1_1_U70", "Parent" : "0"},
	{"ID" : "5", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mux_164_32_1_1_U71", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
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
		inputNode_offset {Type I LastRead 0 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "145", "Max" : "145"}
	, {"Name" : "Interval", "Min" : "145", "Max" : "145"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	nodeTriplets { ap_memory {  { nodeTriplets_address0 mem_address 1 14 }  { nodeTriplets_ce0 mem_ce 1 1 }  { nodeTriplets_we0 mem_we 1 1 }  { nodeTriplets_d0 mem_din 1 16 }  { nodeTriplets_address1 MemPortADDR2 1 14 }  { nodeTriplets_ce1 MemPortCE2 1 1 }  { nodeTriplets_we1 MemPortWE2 1 1 }  { nodeTriplets_d1 MemPortDIN2 1 16 } } }
	aboveNodeList_0_0_read { ap_none {  { aboveNodeList_0_0_read in_data 0 32 } } }
	aboveNodeList_0_1_read { ap_none {  { aboveNodeList_0_1_read in_data 0 32 } } }
	aboveNodeList_1_0_read { ap_none {  { aboveNodeList_1_0_read in_data 0 32 } } }
	aboveNodeList_1_1_read { ap_none {  { aboveNodeList_1_1_read in_data 0 32 } } }
	aboveNodeList_2_0_read { ap_none {  { aboveNodeList_2_0_read in_data 0 32 } } }
	aboveNodeList_2_1_read { ap_none {  { aboveNodeList_2_1_read in_data 0 32 } } }
	aboveNodeList_3_0_read { ap_none {  { aboveNodeList_3_0_read in_data 0 32 } } }
	aboveNodeList_3_1_read { ap_none {  { aboveNodeList_3_1_read in_data 0 32 } } }
	aboveNodeList_4_0_read { ap_none {  { aboveNodeList_4_0_read in_data 0 32 } } }
	aboveNodeList_4_1_read { ap_none {  { aboveNodeList_4_1_read in_data 0 32 } } }
	aboveNodeList_5_0_read { ap_none {  { aboveNodeList_5_0_read in_data 0 32 } } }
	aboveNodeList_5_1_read { ap_none {  { aboveNodeList_5_1_read in_data 0 32 } } }
	aboveNodeList_6_0_read { ap_none {  { aboveNodeList_6_0_read in_data 0 32 } } }
	aboveNodeList_6_1_read { ap_none {  { aboveNodeList_6_1_read in_data 0 32 } } }
	aboveNodeList_7_0_read { ap_none {  { aboveNodeList_7_0_read in_data 0 32 } } }
	aboveNodeList_7_1_read { ap_none {  { aboveNodeList_7_1_read in_data 0 32 } } }
	aboveNodeList_8_0_read { ap_none {  { aboveNodeList_8_0_read in_data 0 32 } } }
	aboveNodeList_8_1_read { ap_none {  { aboveNodeList_8_1_read in_data 0 32 } } }
	aboveNodeList_9_0_read { ap_none {  { aboveNodeList_9_0_read in_data 0 32 } } }
	aboveNodeList_9_1_read { ap_none {  { aboveNodeList_9_1_read in_data 0 32 } } }
	aboveNodeList_10_0_read { ap_none {  { aboveNodeList_10_0_read in_data 0 32 } } }
	aboveNodeList_10_1_read { ap_none {  { aboveNodeList_10_1_read in_data 0 32 } } }
	aboveNodeList_11_0_read { ap_none {  { aboveNodeList_11_0_read in_data 0 32 } } }
	aboveNodeList_11_1_read { ap_none {  { aboveNodeList_11_1_read in_data 0 32 } } }
	aboveNodeList_12_0_read { ap_none {  { aboveNodeList_12_0_read in_data 0 32 } } }
	aboveNodeList_12_1_read { ap_none {  { aboveNodeList_12_1_read in_data 0 32 } } }
	aboveNodeList_13_0_read { ap_none {  { aboveNodeList_13_0_read in_data 0 32 } } }
	aboveNodeList_13_1_read { ap_none {  { aboveNodeList_13_1_read in_data 0 32 } } }
	aboveNodeList_14_0_read { ap_none {  { aboveNodeList_14_0_read in_data 0 32 } } }
	aboveNodeList_14_1_read { ap_none {  { aboveNodeList_14_1_read in_data 0 32 } } }
	aboveNodeList_15_0_read { ap_none {  { aboveNodeList_15_0_read in_data 0 32 } } }
	aboveNodeList_15_1_read { ap_none {  { aboveNodeList_15_1_read in_data 0 32 } } }
	belowNodeList_0_0_read { ap_none {  { belowNodeList_0_0_read in_data 0 32 } } }
	belowNodeList_0_1_read { ap_none {  { belowNodeList_0_1_read in_data 0 32 } } }
	belowNodeList_1_0_read { ap_none {  { belowNodeList_1_0_read in_data 0 32 } } }
	belowNodeList_1_1_read { ap_none {  { belowNodeList_1_1_read in_data 0 32 } } }
	belowNodeList_2_0_read { ap_none {  { belowNodeList_2_0_read in_data 0 32 } } }
	belowNodeList_2_1_read { ap_none {  { belowNodeList_2_1_read in_data 0 32 } } }
	belowNodeList_3_0_read { ap_none {  { belowNodeList_3_0_read in_data 0 32 } } }
	belowNodeList_3_1_read { ap_none {  { belowNodeList_3_1_read in_data 0 32 } } }
	belowNodeList_4_0_read { ap_none {  { belowNodeList_4_0_read in_data 0 32 } } }
	belowNodeList_4_1_read { ap_none {  { belowNodeList_4_1_read in_data 0 32 } } }
	belowNodeList_5_0_read { ap_none {  { belowNodeList_5_0_read in_data 0 32 } } }
	belowNodeList_5_1_read { ap_none {  { belowNodeList_5_1_read in_data 0 32 } } }
	belowNodeList_6_0_read { ap_none {  { belowNodeList_6_0_read in_data 0 32 } } }
	belowNodeList_6_1_read { ap_none {  { belowNodeList_6_1_read in_data 0 32 } } }
	belowNodeList_7_0_read { ap_none {  { belowNodeList_7_0_read in_data 0 32 } } }
	belowNodeList_7_1_read { ap_none {  { belowNodeList_7_1_read in_data 0 32 } } }
	belowNodeList_8_0_read { ap_none {  { belowNodeList_8_0_read in_data 0 32 } } }
	belowNodeList_8_1_read { ap_none {  { belowNodeList_8_1_read in_data 0 32 } } }
	belowNodeList_9_0_read { ap_none {  { belowNodeList_9_0_read in_data 0 32 } } }
	belowNodeList_9_1_read { ap_none {  { belowNodeList_9_1_read in_data 0 32 } } }
	belowNodeList_10_0_read { ap_none {  { belowNodeList_10_0_read in_data 0 32 } } }
	belowNodeList_10_1_read { ap_none {  { belowNodeList_10_1_read in_data 0 32 } } }
	belowNodeList_11_0_read { ap_none {  { belowNodeList_11_0_read in_data 0 32 } } }
	belowNodeList_11_1_read { ap_none {  { belowNodeList_11_1_read in_data 0 32 } } }
	belowNodeList_12_0_read { ap_none {  { belowNodeList_12_0_read in_data 0 32 } } }
	belowNodeList_12_1_read { ap_none {  { belowNodeList_12_1_read in_data 0 32 } } }
	belowNodeList_13_0_read { ap_none {  { belowNodeList_13_0_read in_data 0 32 } } }
	belowNodeList_13_1_read { ap_none {  { belowNodeList_13_1_read in_data 0 32 } } }
	belowNodeList_14_0_read { ap_none {  { belowNodeList_14_0_read in_data 0 32 } } }
	belowNodeList_14_1_read { ap_none {  { belowNodeList_14_1_read in_data 0 32 } } }
	belowNodeList_15_0_read { ap_none {  { belowNodeList_15_0_read in_data 0 32 } } }
	belowNodeList_15_1_read { ap_none {  { belowNodeList_15_1_read in_data 0 32 } } }
	inputNode_0_read { ap_none {  { inputNode_0_read in_data 0 32 } } }
	inputNode_1_read { ap_none {  { inputNode_1_read in_data 0 32 } } }
	nodeTriplets_offset { ap_none {  { nodeTriplets_offset in_data 0 2 } } }
	nodeTriplets1_offset { ap_none {  { nodeTriplets1_offset in_data 0 4 } } }
}
