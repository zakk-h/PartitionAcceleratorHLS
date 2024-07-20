set moduleName makeHalfLaplacian
set isTopModule 0
set isCombinational 1
set isDatapathOnly 0
set isPipelined 0
set pipeline_type function
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set C_modelName {makeHalfLaplacian}
set C_modelType { int 1024 }
set C_modelArgList {
	{ nodeList_0_0_read int 32 regular  }
	{ nodeList_0_1_read int 32 regular  }
	{ nodeList_1_0_read int 32 regular  }
	{ nodeList_1_1_read int 32 regular  }
	{ nodeList_2_0_read int 32 regular  }
	{ nodeList_2_1_read int 32 regular  }
	{ nodeList_3_0_read int 32 regular  }
	{ nodeList_3_1_read int 32 regular  }
	{ nodeList_4_0_read int 32 regular  }
	{ nodeList_4_1_read int 32 regular  }
	{ nodeList_5_0_read int 32 regular  }
	{ nodeList_5_1_read int 32 regular  }
	{ nodeList_6_0_read int 32 regular  }
	{ nodeList_6_1_read int 32 regular  }
	{ nodeList_7_0_read int 32 regular  }
	{ nodeList_7_1_read int 32 regular  }
	{ nodeList_8_0_read int 32 regular  }
	{ nodeList_8_1_read int 32 regular  }
	{ nodeList_9_0_read int 32 regular  }
	{ nodeList_9_1_read int 32 regular  }
	{ nodeList_10_0_read int 32 regular  }
	{ nodeList_10_1_read int 32 regular  }
	{ nodeList_11_0_read int 32 regular  }
	{ nodeList_11_1_read int 32 regular  }
	{ nodeList_12_0_read int 32 regular  }
	{ nodeList_12_1_read int 32 regular  }
	{ nodeList_13_0_read int 32 regular  }
	{ nodeList_13_1_read int 32 regular  }
	{ nodeList_14_0_read int 32 regular  }
	{ nodeList_14_1_read int 32 regular  }
	{ nodeList_15_0_read int 32 regular  }
	{ nodeList_15_1_read int 32 regular  }
	{ p_read32 int 32 regular  }
	{ p_read33 int 32 regular  }
	{ p_read34 int 32 regular  }
	{ p_read35 int 32 regular  }
	{ p_read36 int 32 regular  }
	{ p_read37 int 32 regular  }
	{ p_read38 int 32 regular  }
	{ p_read39 int 32 regular  }
	{ p_read40 int 32 regular  }
	{ p_read41 int 32 regular  }
	{ p_read42 int 32 regular  }
	{ p_read43 int 32 regular  }
	{ p_read44 int 32 regular  }
	{ p_read45 int 32 regular  }
	{ p_read46 int 32 regular  }
	{ p_read47 int 32 regular  }
	{ p_read48 int 32 regular  }
	{ p_read49 int 32 regular  }
	{ p_read50 int 32 regular  }
	{ p_read51 int 32 regular  }
	{ p_read52 int 32 regular  }
	{ p_read53 int 32 regular  }
	{ p_read54 int 32 regular  }
	{ p_read55 int 32 regular  }
	{ p_read56 int 32 regular  }
	{ p_read57 int 32 regular  }
	{ p_read58 int 32 regular  }
	{ p_read59 int 32 regular  }
	{ p_read60 int 32 regular  }
	{ p_read61 int 32 regular  }
	{ p_read62 int 32 regular  }
	{ p_read63 int 32 regular  }
	{ inputNode_offset int 4 regular  }
}
set C_modelArgMapList {[ 
	{ "Name" : "nodeList_0_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "nodeList_0_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "nodeList_1_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "nodeList_1_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "nodeList_2_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "nodeList_2_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "nodeList_3_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "nodeList_3_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "nodeList_4_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "nodeList_4_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "nodeList_5_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "nodeList_5_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "nodeList_6_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "nodeList_6_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "nodeList_7_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "nodeList_7_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "nodeList_8_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "nodeList_8_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "nodeList_9_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "nodeList_9_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "nodeList_10_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "nodeList_10_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "nodeList_11_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "nodeList_11_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "nodeList_12_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "nodeList_12_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "nodeList_13_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "nodeList_13_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "nodeList_14_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "nodeList_14_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "nodeList_15_0_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "nodeList_15_1_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_read32", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_read33", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_read34", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_read35", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_read36", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_read37", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_read38", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_read39", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_read40", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_read41", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_read42", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_read43", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_read44", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_read45", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_read46", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_read47", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_read48", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_read49", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_read50", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_read51", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_read52", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_read53", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_read54", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_read55", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_read56", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_read57", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_read58", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_read59", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_read60", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_read61", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_read62", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_read63", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "inputNode_offset", "interface" : "wire", "bitwidth" : 4, "direction" : "READONLY"} , 
 	{ "Name" : "ap_return", "interface" : "wire", "bitwidth" : 1024} ]}
# RTL Port declarations: 
set portNum 98
set portList { 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ nodeList_0_0_read sc_in sc_lv 32 signal 0 } 
	{ nodeList_0_1_read sc_in sc_lv 32 signal 1 } 
	{ nodeList_1_0_read sc_in sc_lv 32 signal 2 } 
	{ nodeList_1_1_read sc_in sc_lv 32 signal 3 } 
	{ nodeList_2_0_read sc_in sc_lv 32 signal 4 } 
	{ nodeList_2_1_read sc_in sc_lv 32 signal 5 } 
	{ nodeList_3_0_read sc_in sc_lv 32 signal 6 } 
	{ nodeList_3_1_read sc_in sc_lv 32 signal 7 } 
	{ nodeList_4_0_read sc_in sc_lv 32 signal 8 } 
	{ nodeList_4_1_read sc_in sc_lv 32 signal 9 } 
	{ nodeList_5_0_read sc_in sc_lv 32 signal 10 } 
	{ nodeList_5_1_read sc_in sc_lv 32 signal 11 } 
	{ nodeList_6_0_read sc_in sc_lv 32 signal 12 } 
	{ nodeList_6_1_read sc_in sc_lv 32 signal 13 } 
	{ nodeList_7_0_read sc_in sc_lv 32 signal 14 } 
	{ nodeList_7_1_read sc_in sc_lv 32 signal 15 } 
	{ nodeList_8_0_read sc_in sc_lv 32 signal 16 } 
	{ nodeList_8_1_read sc_in sc_lv 32 signal 17 } 
	{ nodeList_9_0_read sc_in sc_lv 32 signal 18 } 
	{ nodeList_9_1_read sc_in sc_lv 32 signal 19 } 
	{ nodeList_10_0_read sc_in sc_lv 32 signal 20 } 
	{ nodeList_10_1_read sc_in sc_lv 32 signal 21 } 
	{ nodeList_11_0_read sc_in sc_lv 32 signal 22 } 
	{ nodeList_11_1_read sc_in sc_lv 32 signal 23 } 
	{ nodeList_12_0_read sc_in sc_lv 32 signal 24 } 
	{ nodeList_12_1_read sc_in sc_lv 32 signal 25 } 
	{ nodeList_13_0_read sc_in sc_lv 32 signal 26 } 
	{ nodeList_13_1_read sc_in sc_lv 32 signal 27 } 
	{ nodeList_14_0_read sc_in sc_lv 32 signal 28 } 
	{ nodeList_14_1_read sc_in sc_lv 32 signal 29 } 
	{ nodeList_15_0_read sc_in sc_lv 32 signal 30 } 
	{ nodeList_15_1_read sc_in sc_lv 32 signal 31 } 
	{ p_read32 sc_in sc_lv 32 signal 32 } 
	{ p_read33 sc_in sc_lv 32 signal 33 } 
	{ p_read34 sc_in sc_lv 32 signal 34 } 
	{ p_read35 sc_in sc_lv 32 signal 35 } 
	{ p_read36 sc_in sc_lv 32 signal 36 } 
	{ p_read37 sc_in sc_lv 32 signal 37 } 
	{ p_read38 sc_in sc_lv 32 signal 38 } 
	{ p_read39 sc_in sc_lv 32 signal 39 } 
	{ p_read40 sc_in sc_lv 32 signal 40 } 
	{ p_read41 sc_in sc_lv 32 signal 41 } 
	{ p_read42 sc_in sc_lv 32 signal 42 } 
	{ p_read43 sc_in sc_lv 32 signal 43 } 
	{ p_read44 sc_in sc_lv 32 signal 44 } 
	{ p_read45 sc_in sc_lv 32 signal 45 } 
	{ p_read46 sc_in sc_lv 32 signal 46 } 
	{ p_read47 sc_in sc_lv 32 signal 47 } 
	{ p_read48 sc_in sc_lv 32 signal 48 } 
	{ p_read49 sc_in sc_lv 32 signal 49 } 
	{ p_read50 sc_in sc_lv 32 signal 50 } 
	{ p_read51 sc_in sc_lv 32 signal 51 } 
	{ p_read52 sc_in sc_lv 32 signal 52 } 
	{ p_read53 sc_in sc_lv 32 signal 53 } 
	{ p_read54 sc_in sc_lv 32 signal 54 } 
	{ p_read55 sc_in sc_lv 32 signal 55 } 
	{ p_read56 sc_in sc_lv 32 signal 56 } 
	{ p_read57 sc_in sc_lv 32 signal 57 } 
	{ p_read58 sc_in sc_lv 32 signal 58 } 
	{ p_read59 sc_in sc_lv 32 signal 59 } 
	{ p_read60 sc_in sc_lv 32 signal 60 } 
	{ p_read61 sc_in sc_lv 32 signal 61 } 
	{ p_read62 sc_in sc_lv 32 signal 62 } 
	{ p_read63 sc_in sc_lv 32 signal 63 } 
	{ inputNode_offset sc_in sc_lv 4 signal 64 } 
	{ ap_return_0 sc_out sc_lv 32 signal -1 } 
	{ ap_return_1 sc_out sc_lv 32 signal -1 } 
	{ ap_return_2 sc_out sc_lv 32 signal -1 } 
	{ ap_return_3 sc_out sc_lv 32 signal -1 } 
	{ ap_return_4 sc_out sc_lv 32 signal -1 } 
	{ ap_return_5 sc_out sc_lv 32 signal -1 } 
	{ ap_return_6 sc_out sc_lv 32 signal -1 } 
	{ ap_return_7 sc_out sc_lv 32 signal -1 } 
	{ ap_return_8 sc_out sc_lv 32 signal -1 } 
	{ ap_return_9 sc_out sc_lv 32 signal -1 } 
	{ ap_return_10 sc_out sc_lv 32 signal -1 } 
	{ ap_return_11 sc_out sc_lv 32 signal -1 } 
	{ ap_return_12 sc_out sc_lv 32 signal -1 } 
	{ ap_return_13 sc_out sc_lv 32 signal -1 } 
	{ ap_return_14 sc_out sc_lv 32 signal -1 } 
	{ ap_return_15 sc_out sc_lv 32 signal -1 } 
	{ ap_return_16 sc_out sc_lv 32 signal -1 } 
	{ ap_return_17 sc_out sc_lv 32 signal -1 } 
	{ ap_return_18 sc_out sc_lv 32 signal -1 } 
	{ ap_return_19 sc_out sc_lv 32 signal -1 } 
	{ ap_return_20 sc_out sc_lv 32 signal -1 } 
	{ ap_return_21 sc_out sc_lv 32 signal -1 } 
	{ ap_return_22 sc_out sc_lv 32 signal -1 } 
	{ ap_return_23 sc_out sc_lv 32 signal -1 } 
	{ ap_return_24 sc_out sc_lv 32 signal -1 } 
	{ ap_return_25 sc_out sc_lv 32 signal -1 } 
	{ ap_return_26 sc_out sc_lv 32 signal -1 } 
	{ ap_return_27 sc_out sc_lv 32 signal -1 } 
	{ ap_return_28 sc_out sc_lv 32 signal -1 } 
	{ ap_return_29 sc_out sc_lv 32 signal -1 } 
	{ ap_return_30 sc_out sc_lv 32 signal -1 } 
	{ ap_return_31 sc_out sc_lv 32 signal -1 } 
}
set NewPortList {[ 
	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "nodeList_0_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "nodeList_0_0_read", "role": "default" }} , 
 	{ "name": "nodeList_0_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "nodeList_0_1_read", "role": "default" }} , 
 	{ "name": "nodeList_1_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "nodeList_1_0_read", "role": "default" }} , 
 	{ "name": "nodeList_1_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "nodeList_1_1_read", "role": "default" }} , 
 	{ "name": "nodeList_2_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "nodeList_2_0_read", "role": "default" }} , 
 	{ "name": "nodeList_2_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "nodeList_2_1_read", "role": "default" }} , 
 	{ "name": "nodeList_3_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "nodeList_3_0_read", "role": "default" }} , 
 	{ "name": "nodeList_3_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "nodeList_3_1_read", "role": "default" }} , 
 	{ "name": "nodeList_4_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "nodeList_4_0_read", "role": "default" }} , 
 	{ "name": "nodeList_4_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "nodeList_4_1_read", "role": "default" }} , 
 	{ "name": "nodeList_5_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "nodeList_5_0_read", "role": "default" }} , 
 	{ "name": "nodeList_5_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "nodeList_5_1_read", "role": "default" }} , 
 	{ "name": "nodeList_6_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "nodeList_6_0_read", "role": "default" }} , 
 	{ "name": "nodeList_6_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "nodeList_6_1_read", "role": "default" }} , 
 	{ "name": "nodeList_7_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "nodeList_7_0_read", "role": "default" }} , 
 	{ "name": "nodeList_7_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "nodeList_7_1_read", "role": "default" }} , 
 	{ "name": "nodeList_8_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "nodeList_8_0_read", "role": "default" }} , 
 	{ "name": "nodeList_8_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "nodeList_8_1_read", "role": "default" }} , 
 	{ "name": "nodeList_9_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "nodeList_9_0_read", "role": "default" }} , 
 	{ "name": "nodeList_9_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "nodeList_9_1_read", "role": "default" }} , 
 	{ "name": "nodeList_10_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "nodeList_10_0_read", "role": "default" }} , 
 	{ "name": "nodeList_10_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "nodeList_10_1_read", "role": "default" }} , 
 	{ "name": "nodeList_11_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "nodeList_11_0_read", "role": "default" }} , 
 	{ "name": "nodeList_11_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "nodeList_11_1_read", "role": "default" }} , 
 	{ "name": "nodeList_12_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "nodeList_12_0_read", "role": "default" }} , 
 	{ "name": "nodeList_12_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "nodeList_12_1_read", "role": "default" }} , 
 	{ "name": "nodeList_13_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "nodeList_13_0_read", "role": "default" }} , 
 	{ "name": "nodeList_13_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "nodeList_13_1_read", "role": "default" }} , 
 	{ "name": "nodeList_14_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "nodeList_14_0_read", "role": "default" }} , 
 	{ "name": "nodeList_14_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "nodeList_14_1_read", "role": "default" }} , 
 	{ "name": "nodeList_15_0_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "nodeList_15_0_read", "role": "default" }} , 
 	{ "name": "nodeList_15_1_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "nodeList_15_1_read", "role": "default" }} , 
 	{ "name": "p_read32", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read32", "role": "default" }} , 
 	{ "name": "p_read33", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read33", "role": "default" }} , 
 	{ "name": "p_read34", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read34", "role": "default" }} , 
 	{ "name": "p_read35", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read35", "role": "default" }} , 
 	{ "name": "p_read36", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read36", "role": "default" }} , 
 	{ "name": "p_read37", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read37", "role": "default" }} , 
 	{ "name": "p_read38", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read38", "role": "default" }} , 
 	{ "name": "p_read39", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read39", "role": "default" }} , 
 	{ "name": "p_read40", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read40", "role": "default" }} , 
 	{ "name": "p_read41", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read41", "role": "default" }} , 
 	{ "name": "p_read42", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read42", "role": "default" }} , 
 	{ "name": "p_read43", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read43", "role": "default" }} , 
 	{ "name": "p_read44", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read44", "role": "default" }} , 
 	{ "name": "p_read45", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read45", "role": "default" }} , 
 	{ "name": "p_read46", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read46", "role": "default" }} , 
 	{ "name": "p_read47", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read47", "role": "default" }} , 
 	{ "name": "p_read48", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read48", "role": "default" }} , 
 	{ "name": "p_read49", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read49", "role": "default" }} , 
 	{ "name": "p_read50", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read50", "role": "default" }} , 
 	{ "name": "p_read51", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read51", "role": "default" }} , 
 	{ "name": "p_read52", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read52", "role": "default" }} , 
 	{ "name": "p_read53", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read53", "role": "default" }} , 
 	{ "name": "p_read54", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read54", "role": "default" }} , 
 	{ "name": "p_read55", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read55", "role": "default" }} , 
 	{ "name": "p_read56", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read56", "role": "default" }} , 
 	{ "name": "p_read57", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read57", "role": "default" }} , 
 	{ "name": "p_read58", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read58", "role": "default" }} , 
 	{ "name": "p_read59", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read59", "role": "default" }} , 
 	{ "name": "p_read60", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read60", "role": "default" }} , 
 	{ "name": "p_read61", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read61", "role": "default" }} , 
 	{ "name": "p_read62", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read62", "role": "default" }} , 
 	{ "name": "p_read63", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read63", "role": "default" }} , 
 	{ "name": "inputNode_offset", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "inputNode_offset", "role": "default" }} , 
 	{ "name": "ap_return_0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_0", "role": "default" }} , 
 	{ "name": "ap_return_1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_1", "role": "default" }} , 
 	{ "name": "ap_return_2", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_2", "role": "default" }} , 
 	{ "name": "ap_return_3", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_3", "role": "default" }} , 
 	{ "name": "ap_return_4", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_4", "role": "default" }} , 
 	{ "name": "ap_return_5", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_5", "role": "default" }} , 
 	{ "name": "ap_return_6", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_6", "role": "default" }} , 
 	{ "name": "ap_return_7", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_7", "role": "default" }} , 
 	{ "name": "ap_return_8", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_8", "role": "default" }} , 
 	{ "name": "ap_return_9", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_9", "role": "default" }} , 
 	{ "name": "ap_return_10", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_10", "role": "default" }} , 
 	{ "name": "ap_return_11", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_11", "role": "default" }} , 
 	{ "name": "ap_return_12", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_12", "role": "default" }} , 
 	{ "name": "ap_return_13", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_13", "role": "default" }} , 
 	{ "name": "ap_return_14", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_14", "role": "default" }} , 
 	{ "name": "ap_return_15", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_15", "role": "default" }} , 
 	{ "name": "ap_return_16", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_16", "role": "default" }} , 
 	{ "name": "ap_return_17", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_17", "role": "default" }} , 
 	{ "name": "ap_return_18", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_18", "role": "default" }} , 
 	{ "name": "ap_return_19", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_19", "role": "default" }} , 
 	{ "name": "ap_return_20", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_20", "role": "default" }} , 
 	{ "name": "ap_return_21", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_21", "role": "default" }} , 
 	{ "name": "ap_return_22", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_22", "role": "default" }} , 
 	{ "name": "ap_return_23", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_23", "role": "default" }} , 
 	{ "name": "ap_return_24", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_24", "role": "default" }} , 
 	{ "name": "ap_return_25", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_25", "role": "default" }} , 
 	{ "name": "ap_return_26", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_26", "role": "default" }} , 
 	{ "name": "ap_return_27", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_27", "role": "default" }} , 
 	{ "name": "ap_return_28", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_28", "role": "default" }} , 
 	{ "name": "ap_return_29", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_29", "role": "default" }} , 
 	{ "name": "ap_return_30", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_30", "role": "default" }} , 
 	{ "name": "ap_return_31", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_31", "role": "default" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2"],
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
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mux_326_32_1_1_U2", "Parent" : "0"},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mux_326_32_1_1_U3", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
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
	{"Name" : "Latency", "Min" : "0", "Max" : "0"}
	, {"Name" : "Interval", "Min" : "1", "Max" : "1"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	nodeList_0_0_read { ap_none {  { nodeList_0_0_read in_data 0 32 } } }
	nodeList_0_1_read { ap_none {  { nodeList_0_1_read in_data 0 32 } } }
	nodeList_1_0_read { ap_none {  { nodeList_1_0_read in_data 0 32 } } }
	nodeList_1_1_read { ap_none {  { nodeList_1_1_read in_data 0 32 } } }
	nodeList_2_0_read { ap_none {  { nodeList_2_0_read in_data 0 32 } } }
	nodeList_2_1_read { ap_none {  { nodeList_2_1_read in_data 0 32 } } }
	nodeList_3_0_read { ap_none {  { nodeList_3_0_read in_data 0 32 } } }
	nodeList_3_1_read { ap_none {  { nodeList_3_1_read in_data 0 32 } } }
	nodeList_4_0_read { ap_none {  { nodeList_4_0_read in_data 0 32 } } }
	nodeList_4_1_read { ap_none {  { nodeList_4_1_read in_data 0 32 } } }
	nodeList_5_0_read { ap_none {  { nodeList_5_0_read in_data 0 32 } } }
	nodeList_5_1_read { ap_none {  { nodeList_5_1_read in_data 0 32 } } }
	nodeList_6_0_read { ap_none {  { nodeList_6_0_read in_data 0 32 } } }
	nodeList_6_1_read { ap_none {  { nodeList_6_1_read in_data 0 32 } } }
	nodeList_7_0_read { ap_none {  { nodeList_7_0_read in_data 0 32 } } }
	nodeList_7_1_read { ap_none {  { nodeList_7_1_read in_data 0 32 } } }
	nodeList_8_0_read { ap_none {  { nodeList_8_0_read in_data 0 32 } } }
	nodeList_8_1_read { ap_none {  { nodeList_8_1_read in_data 0 32 } } }
	nodeList_9_0_read { ap_none {  { nodeList_9_0_read in_data 0 32 } } }
	nodeList_9_1_read { ap_none {  { nodeList_9_1_read in_data 0 32 } } }
	nodeList_10_0_read { ap_none {  { nodeList_10_0_read in_data 0 32 } } }
	nodeList_10_1_read { ap_none {  { nodeList_10_1_read in_data 0 32 } } }
	nodeList_11_0_read { ap_none {  { nodeList_11_0_read in_data 0 32 } } }
	nodeList_11_1_read { ap_none {  { nodeList_11_1_read in_data 0 32 } } }
	nodeList_12_0_read { ap_none {  { nodeList_12_0_read in_data 0 32 } } }
	nodeList_12_1_read { ap_none {  { nodeList_12_1_read in_data 0 32 } } }
	nodeList_13_0_read { ap_none {  { nodeList_13_0_read in_data 0 32 } } }
	nodeList_13_1_read { ap_none {  { nodeList_13_1_read in_data 0 32 } } }
	nodeList_14_0_read { ap_none {  { nodeList_14_0_read in_data 0 32 } } }
	nodeList_14_1_read { ap_none {  { nodeList_14_1_read in_data 0 32 } } }
	nodeList_15_0_read { ap_none {  { nodeList_15_0_read in_data 0 32 } } }
	nodeList_15_1_read { ap_none {  { nodeList_15_1_read in_data 0 32 } } }
	p_read32 { ap_none {  { p_read32 in_data 0 32 } } }
	p_read33 { ap_none {  { p_read33 in_data 0 32 } } }
	p_read34 { ap_none {  { p_read34 in_data 0 32 } } }
	p_read35 { ap_none {  { p_read35 in_data 0 32 } } }
	p_read36 { ap_none {  { p_read36 in_data 0 32 } } }
	p_read37 { ap_none {  { p_read37 in_data 0 32 } } }
	p_read38 { ap_none {  { p_read38 in_data 0 32 } } }
	p_read39 { ap_none {  { p_read39 in_data 0 32 } } }
	p_read40 { ap_none {  { p_read40 in_data 0 32 } } }
	p_read41 { ap_none {  { p_read41 in_data 0 32 } } }
	p_read42 { ap_none {  { p_read42 in_data 0 32 } } }
	p_read43 { ap_none {  { p_read43 in_data 0 32 } } }
	p_read44 { ap_none {  { p_read44 in_data 0 32 } } }
	p_read45 { ap_none {  { p_read45 in_data 0 32 } } }
	p_read46 { ap_none {  { p_read46 in_data 0 32 } } }
	p_read47 { ap_none {  { p_read47 in_data 0 32 } } }
	p_read48 { ap_none {  { p_read48 in_data 0 32 } } }
	p_read49 { ap_none {  { p_read49 in_data 0 32 } } }
	p_read50 { ap_none {  { p_read50 in_data 0 32 } } }
	p_read51 { ap_none {  { p_read51 in_data 0 32 } } }
	p_read52 { ap_none {  { p_read52 in_data 0 32 } } }
	p_read53 { ap_none {  { p_read53 in_data 0 32 } } }
	p_read54 { ap_none {  { p_read54 in_data 0 32 } } }
	p_read55 { ap_none {  { p_read55 in_data 0 32 } } }
	p_read56 { ap_none {  { p_read56 in_data 0 32 } } }
	p_read57 { ap_none {  { p_read57 in_data 0 32 } } }
	p_read58 { ap_none {  { p_read58 in_data 0 32 } } }
	p_read59 { ap_none {  { p_read59 in_data 0 32 } } }
	p_read60 { ap_none {  { p_read60 in_data 0 32 } } }
	p_read61 { ap_none {  { p_read61 in_data 0 32 } } }
	p_read62 { ap_none {  { p_read62 in_data 0 32 } } }
	p_read63 { ap_none {  { p_read63 in_data 0 32 } } }
	inputNode_offset { ap_none {  { inputNode_offset in_data 0 4 } } }
}
