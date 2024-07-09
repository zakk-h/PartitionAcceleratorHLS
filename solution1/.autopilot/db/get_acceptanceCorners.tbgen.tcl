set moduleName get_acceptanceCorners
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
set C_modelName {get_acceptanceCorners}
set C_modelType { void 0 }
set C_modelArgList {
	{ shadow_bottomL_jR int 32 regular {array 15 { 1 1 } 1 1 }  }
	{ shadow_bottomR_jR int 32 regular {array 15 { 1 1 } 1 1 }  }
	{ shadow_bottomL_jL int 32 regular {array 15 { 1 1 } 1 1 }  }
	{ shadow_bottomR_jL int 32 regular {array 15 { 1 1 } 1 1 }  }
	{ z1_min int 26 regular {array 15 { 1 3 } 1 1 }  }
	{ z1_max int 26 regular {array 15 { 1 3 } 1 1 }  }
	{ a_corner_0 int 26 regular {array 3 { 0 3 } 0 1 }  }
	{ a_corner_1 int 32 regular {array 3 { 0 3 } 0 1 }  }
	{ b_corner_0 int 26 regular {array 3 { 0 3 } 0 1 }  }
	{ b_corner_1 int 32 regular {array 3 { 0 3 } 0 1 }  }
	{ c_corner_0 int 26 regular {array 3 { 0 3 } 0 1 }  }
	{ c_corner_1 int 32 regular {array 3 { 0 3 } 0 1 }  }
	{ d_corner_0 int 26 regular {array 3 { 0 3 } 0 1 }  }
	{ d_corner_1 int 32 regular {array 3 { 0 3 } 0 1 }  }
	{ squareAcceptance int 1 regular {array 3 { 0 3 } 0 1 }  }
	{ flatTop int 1 regular {array 3 { 0 3 } 0 1 }  }
	{ flatBottom int 1 regular {array 3 { 0 3 } 0 1 }  }
	{ triangleAcceptance int 1 regular {array 3 { 0 3 } 0 1 }  }
	{ latest_patch_index_constprop int 2 regular {pointer 0} {global 0}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "shadow_bottomL_jR", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "shadow_bottomR_jR", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "shadow_bottomL_jL", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "shadow_bottomR_jL", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "z1_min", "interface" : "memory", "bitwidth" : 26, "direction" : "READONLY"} , 
 	{ "Name" : "z1_max", "interface" : "memory", "bitwidth" : 26, "direction" : "READONLY"} , 
 	{ "Name" : "a_corner_0", "interface" : "memory", "bitwidth" : 26, "direction" : "WRITEONLY"} , 
 	{ "Name" : "a_corner_1", "interface" : "memory", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "b_corner_0", "interface" : "memory", "bitwidth" : 26, "direction" : "WRITEONLY"} , 
 	{ "Name" : "b_corner_1", "interface" : "memory", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "c_corner_0", "interface" : "memory", "bitwidth" : 26, "direction" : "WRITEONLY"} , 
 	{ "Name" : "c_corner_1", "interface" : "memory", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "d_corner_0", "interface" : "memory", "bitwidth" : 26, "direction" : "WRITEONLY"} , 
 	{ "Name" : "d_corner_1", "interface" : "memory", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "squareAcceptance", "interface" : "memory", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "flatTop", "interface" : "memory", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "flatBottom", "interface" : "memory", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "triangleAcceptance", "interface" : "memory", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "latest_patch_index_constprop", "interface" : "wire", "bitwidth" : 2, "direction" : "READONLY", "extern" : 0} ]}
# RTL Port declarations: 
set portNum 85
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ shadow_bottomL_jR_address0 sc_out sc_lv 4 signal 0 } 
	{ shadow_bottomL_jR_ce0 sc_out sc_logic 1 signal 0 } 
	{ shadow_bottomL_jR_q0 sc_in sc_lv 32 signal 0 } 
	{ shadow_bottomL_jR_address1 sc_out sc_lv 4 signal 0 } 
	{ shadow_bottomL_jR_ce1 sc_out sc_logic 1 signal 0 } 
	{ shadow_bottomL_jR_q1 sc_in sc_lv 32 signal 0 } 
	{ shadow_bottomR_jR_address0 sc_out sc_lv 4 signal 1 } 
	{ shadow_bottomR_jR_ce0 sc_out sc_logic 1 signal 1 } 
	{ shadow_bottomR_jR_q0 sc_in sc_lv 32 signal 1 } 
	{ shadow_bottomR_jR_address1 sc_out sc_lv 4 signal 1 } 
	{ shadow_bottomR_jR_ce1 sc_out sc_logic 1 signal 1 } 
	{ shadow_bottomR_jR_q1 sc_in sc_lv 32 signal 1 } 
	{ shadow_bottomL_jL_address0 sc_out sc_lv 4 signal 2 } 
	{ shadow_bottomL_jL_ce0 sc_out sc_logic 1 signal 2 } 
	{ shadow_bottomL_jL_q0 sc_in sc_lv 32 signal 2 } 
	{ shadow_bottomL_jL_address1 sc_out sc_lv 4 signal 2 } 
	{ shadow_bottomL_jL_ce1 sc_out sc_logic 1 signal 2 } 
	{ shadow_bottomL_jL_q1 sc_in sc_lv 32 signal 2 } 
	{ shadow_bottomR_jL_address0 sc_out sc_lv 4 signal 3 } 
	{ shadow_bottomR_jL_ce0 sc_out sc_logic 1 signal 3 } 
	{ shadow_bottomR_jL_q0 sc_in sc_lv 32 signal 3 } 
	{ shadow_bottomR_jL_address1 sc_out sc_lv 4 signal 3 } 
	{ shadow_bottomR_jL_ce1 sc_out sc_logic 1 signal 3 } 
	{ shadow_bottomR_jL_q1 sc_in sc_lv 32 signal 3 } 
	{ z1_min_address0 sc_out sc_lv 4 signal 4 } 
	{ z1_min_ce0 sc_out sc_logic 1 signal 4 } 
	{ z1_min_q0 sc_in sc_lv 26 signal 4 } 
	{ z1_max_address0 sc_out sc_lv 4 signal 5 } 
	{ z1_max_ce0 sc_out sc_logic 1 signal 5 } 
	{ z1_max_q0 sc_in sc_lv 26 signal 5 } 
	{ a_corner_0_address0 sc_out sc_lv 2 signal 6 } 
	{ a_corner_0_ce0 sc_out sc_logic 1 signal 6 } 
	{ a_corner_0_we0 sc_out sc_logic 1 signal 6 } 
	{ a_corner_0_d0 sc_out sc_lv 26 signal 6 } 
	{ a_corner_1_address0 sc_out sc_lv 2 signal 7 } 
	{ a_corner_1_ce0 sc_out sc_logic 1 signal 7 } 
	{ a_corner_1_we0 sc_out sc_logic 1 signal 7 } 
	{ a_corner_1_d0 sc_out sc_lv 32 signal 7 } 
	{ b_corner_0_address0 sc_out sc_lv 2 signal 8 } 
	{ b_corner_0_ce0 sc_out sc_logic 1 signal 8 } 
	{ b_corner_0_we0 sc_out sc_logic 1 signal 8 } 
	{ b_corner_0_d0 sc_out sc_lv 26 signal 8 } 
	{ b_corner_1_address0 sc_out sc_lv 2 signal 9 } 
	{ b_corner_1_ce0 sc_out sc_logic 1 signal 9 } 
	{ b_corner_1_we0 sc_out sc_logic 1 signal 9 } 
	{ b_corner_1_d0 sc_out sc_lv 32 signal 9 } 
	{ c_corner_0_address0 sc_out sc_lv 2 signal 10 } 
	{ c_corner_0_ce0 sc_out sc_logic 1 signal 10 } 
	{ c_corner_0_we0 sc_out sc_logic 1 signal 10 } 
	{ c_corner_0_d0 sc_out sc_lv 26 signal 10 } 
	{ c_corner_1_address0 sc_out sc_lv 2 signal 11 } 
	{ c_corner_1_ce0 sc_out sc_logic 1 signal 11 } 
	{ c_corner_1_we0 sc_out sc_logic 1 signal 11 } 
	{ c_corner_1_d0 sc_out sc_lv 32 signal 11 } 
	{ d_corner_0_address0 sc_out sc_lv 2 signal 12 } 
	{ d_corner_0_ce0 sc_out sc_logic 1 signal 12 } 
	{ d_corner_0_we0 sc_out sc_logic 1 signal 12 } 
	{ d_corner_0_d0 sc_out sc_lv 26 signal 12 } 
	{ d_corner_1_address0 sc_out sc_lv 2 signal 13 } 
	{ d_corner_1_ce0 sc_out sc_logic 1 signal 13 } 
	{ d_corner_1_we0 sc_out sc_logic 1 signal 13 } 
	{ d_corner_1_d0 sc_out sc_lv 32 signal 13 } 
	{ squareAcceptance_address0 sc_out sc_lv 2 signal 14 } 
	{ squareAcceptance_ce0 sc_out sc_logic 1 signal 14 } 
	{ squareAcceptance_we0 sc_out sc_logic 1 signal 14 } 
	{ squareAcceptance_d0 sc_out sc_lv 1 signal 14 } 
	{ flatTop_address0 sc_out sc_lv 2 signal 15 } 
	{ flatTop_ce0 sc_out sc_logic 1 signal 15 } 
	{ flatTop_we0 sc_out sc_logic 1 signal 15 } 
	{ flatTop_d0 sc_out sc_lv 1 signal 15 } 
	{ flatBottom_address0 sc_out sc_lv 2 signal 16 } 
	{ flatBottom_ce0 sc_out sc_logic 1 signal 16 } 
	{ flatBottom_we0 sc_out sc_logic 1 signal 16 } 
	{ flatBottom_d0 sc_out sc_lv 1 signal 16 } 
	{ triangleAcceptance_address0 sc_out sc_lv 2 signal 17 } 
	{ triangleAcceptance_ce0 sc_out sc_logic 1 signal 17 } 
	{ triangleAcceptance_we0 sc_out sc_logic 1 signal 17 } 
	{ triangleAcceptance_d0 sc_out sc_lv 1 signal 17 } 
	{ latest_patch_index_constprop sc_in sc_lv 2 signal 18 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "shadow_bottomL_jR_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "shadow_bottomL_jR", "role": "address0" }} , 
 	{ "name": "shadow_bottomL_jR_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "shadow_bottomL_jR", "role": "ce0" }} , 
 	{ "name": "shadow_bottomL_jR_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "shadow_bottomL_jR", "role": "q0" }} , 
 	{ "name": "shadow_bottomL_jR_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "shadow_bottomL_jR", "role": "address1" }} , 
 	{ "name": "shadow_bottomL_jR_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "shadow_bottomL_jR", "role": "ce1" }} , 
 	{ "name": "shadow_bottomL_jR_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "shadow_bottomL_jR", "role": "q1" }} , 
 	{ "name": "shadow_bottomR_jR_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "shadow_bottomR_jR", "role": "address0" }} , 
 	{ "name": "shadow_bottomR_jR_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "shadow_bottomR_jR", "role": "ce0" }} , 
 	{ "name": "shadow_bottomR_jR_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "shadow_bottomR_jR", "role": "q0" }} , 
 	{ "name": "shadow_bottomR_jR_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "shadow_bottomR_jR", "role": "address1" }} , 
 	{ "name": "shadow_bottomR_jR_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "shadow_bottomR_jR", "role": "ce1" }} , 
 	{ "name": "shadow_bottomR_jR_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "shadow_bottomR_jR", "role": "q1" }} , 
 	{ "name": "shadow_bottomL_jL_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "shadow_bottomL_jL", "role": "address0" }} , 
 	{ "name": "shadow_bottomL_jL_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "shadow_bottomL_jL", "role": "ce0" }} , 
 	{ "name": "shadow_bottomL_jL_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "shadow_bottomL_jL", "role": "q0" }} , 
 	{ "name": "shadow_bottomL_jL_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "shadow_bottomL_jL", "role": "address1" }} , 
 	{ "name": "shadow_bottomL_jL_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "shadow_bottomL_jL", "role": "ce1" }} , 
 	{ "name": "shadow_bottomL_jL_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "shadow_bottomL_jL", "role": "q1" }} , 
 	{ "name": "shadow_bottomR_jL_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "shadow_bottomR_jL", "role": "address0" }} , 
 	{ "name": "shadow_bottomR_jL_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "shadow_bottomR_jL", "role": "ce0" }} , 
 	{ "name": "shadow_bottomR_jL_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "shadow_bottomR_jL", "role": "q0" }} , 
 	{ "name": "shadow_bottomR_jL_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "shadow_bottomR_jL", "role": "address1" }} , 
 	{ "name": "shadow_bottomR_jL_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "shadow_bottomR_jL", "role": "ce1" }} , 
 	{ "name": "shadow_bottomR_jL_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "shadow_bottomR_jL", "role": "q1" }} , 
 	{ "name": "z1_min_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "z1_min", "role": "address0" }} , 
 	{ "name": "z1_min_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "z1_min", "role": "ce0" }} , 
 	{ "name": "z1_min_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":26, "type": "signal", "bundle":{"name": "z1_min", "role": "q0" }} , 
 	{ "name": "z1_max_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "z1_max", "role": "address0" }} , 
 	{ "name": "z1_max_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "z1_max", "role": "ce0" }} , 
 	{ "name": "z1_max_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":26, "type": "signal", "bundle":{"name": "z1_max", "role": "q0" }} , 
 	{ "name": "a_corner_0_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "a_corner_0", "role": "address0" }} , 
 	{ "name": "a_corner_0_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "a_corner_0", "role": "ce0" }} , 
 	{ "name": "a_corner_0_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "a_corner_0", "role": "we0" }} , 
 	{ "name": "a_corner_0_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":26, "type": "signal", "bundle":{"name": "a_corner_0", "role": "d0" }} , 
 	{ "name": "a_corner_1_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "a_corner_1", "role": "address0" }} , 
 	{ "name": "a_corner_1_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "a_corner_1", "role": "ce0" }} , 
 	{ "name": "a_corner_1_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "a_corner_1", "role": "we0" }} , 
 	{ "name": "a_corner_1_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "a_corner_1", "role": "d0" }} , 
 	{ "name": "b_corner_0_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "b_corner_0", "role": "address0" }} , 
 	{ "name": "b_corner_0_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "b_corner_0", "role": "ce0" }} , 
 	{ "name": "b_corner_0_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "b_corner_0", "role": "we0" }} , 
 	{ "name": "b_corner_0_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":26, "type": "signal", "bundle":{"name": "b_corner_0", "role": "d0" }} , 
 	{ "name": "b_corner_1_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "b_corner_1", "role": "address0" }} , 
 	{ "name": "b_corner_1_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "b_corner_1", "role": "ce0" }} , 
 	{ "name": "b_corner_1_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "b_corner_1", "role": "we0" }} , 
 	{ "name": "b_corner_1_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "b_corner_1", "role": "d0" }} , 
 	{ "name": "c_corner_0_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "c_corner_0", "role": "address0" }} , 
 	{ "name": "c_corner_0_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "c_corner_0", "role": "ce0" }} , 
 	{ "name": "c_corner_0_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "c_corner_0", "role": "we0" }} , 
 	{ "name": "c_corner_0_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":26, "type": "signal", "bundle":{"name": "c_corner_0", "role": "d0" }} , 
 	{ "name": "c_corner_1_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "c_corner_1", "role": "address0" }} , 
 	{ "name": "c_corner_1_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "c_corner_1", "role": "ce0" }} , 
 	{ "name": "c_corner_1_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "c_corner_1", "role": "we0" }} , 
 	{ "name": "c_corner_1_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "c_corner_1", "role": "d0" }} , 
 	{ "name": "d_corner_0_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "d_corner_0", "role": "address0" }} , 
 	{ "name": "d_corner_0_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "d_corner_0", "role": "ce0" }} , 
 	{ "name": "d_corner_0_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "d_corner_0", "role": "we0" }} , 
 	{ "name": "d_corner_0_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":26, "type": "signal", "bundle":{"name": "d_corner_0", "role": "d0" }} , 
 	{ "name": "d_corner_1_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "d_corner_1", "role": "address0" }} , 
 	{ "name": "d_corner_1_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "d_corner_1", "role": "ce0" }} , 
 	{ "name": "d_corner_1_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "d_corner_1", "role": "we0" }} , 
 	{ "name": "d_corner_1_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "d_corner_1", "role": "d0" }} , 
 	{ "name": "squareAcceptance_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "squareAcceptance", "role": "address0" }} , 
 	{ "name": "squareAcceptance_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "squareAcceptance", "role": "ce0" }} , 
 	{ "name": "squareAcceptance_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "squareAcceptance", "role": "we0" }} , 
 	{ "name": "squareAcceptance_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "squareAcceptance", "role": "d0" }} , 
 	{ "name": "flatTop_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "flatTop", "role": "address0" }} , 
 	{ "name": "flatTop_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "flatTop", "role": "ce0" }} , 
 	{ "name": "flatTop_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "flatTop", "role": "we0" }} , 
 	{ "name": "flatTop_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "flatTop", "role": "d0" }} , 
 	{ "name": "flatBottom_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "flatBottom", "role": "address0" }} , 
 	{ "name": "flatBottom_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "flatBottom", "role": "ce0" }} , 
 	{ "name": "flatBottom_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "flatBottom", "role": "we0" }} , 
 	{ "name": "flatBottom_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "flatBottom", "role": "d0" }} , 
 	{ "name": "triangleAcceptance_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "triangleAcceptance", "role": "address0" }} , 
 	{ "name": "triangleAcceptance_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "triangleAcceptance", "role": "ce0" }} , 
 	{ "name": "triangleAcceptance_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "triangleAcceptance", "role": "we0" }} , 
 	{ "name": "triangleAcceptance_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "triangleAcceptance", "role": "d0" }} , 
 	{ "name": "latest_patch_index_constprop", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "latest_patch_index_constprop", "role": "default" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2", "3", "4"],
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
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.a_corner_list_V_U", "Parent" : "0"},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.b_corner_list_V_U", "Parent" : "0"},
	{"ID" : "3", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.c_corner_list_V_U", "Parent" : "0"},
	{"ID" : "4", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.d_corner_list_V_U", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
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
	{"Name" : "Latency", "Min" : "13", "Max" : "13"}
	, {"Name" : "Interval", "Min" : "13", "Max" : "13"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	shadow_bottomL_jR { ap_memory {  { shadow_bottomL_jR_address0 mem_address 1 4 }  { shadow_bottomL_jR_ce0 mem_ce 1 1 }  { shadow_bottomL_jR_q0 mem_dout 0 32 }  { shadow_bottomL_jR_address1 MemPortADDR2 1 4 }  { shadow_bottomL_jR_ce1 MemPortCE2 1 1 }  { shadow_bottomL_jR_q1 MemPortDOUT2 0 32 } } }
	shadow_bottomR_jR { ap_memory {  { shadow_bottomR_jR_address0 mem_address 1 4 }  { shadow_bottomR_jR_ce0 mem_ce 1 1 }  { shadow_bottomR_jR_q0 mem_dout 0 32 }  { shadow_bottomR_jR_address1 MemPortADDR2 1 4 }  { shadow_bottomR_jR_ce1 MemPortCE2 1 1 }  { shadow_bottomR_jR_q1 MemPortDOUT2 0 32 } } }
	shadow_bottomL_jL { ap_memory {  { shadow_bottomL_jL_address0 mem_address 1 4 }  { shadow_bottomL_jL_ce0 mem_ce 1 1 }  { shadow_bottomL_jL_q0 mem_dout 0 32 }  { shadow_bottomL_jL_address1 MemPortADDR2 1 4 }  { shadow_bottomL_jL_ce1 MemPortCE2 1 1 }  { shadow_bottomL_jL_q1 MemPortDOUT2 0 32 } } }
	shadow_bottomR_jL { ap_memory {  { shadow_bottomR_jL_address0 mem_address 1 4 }  { shadow_bottomR_jL_ce0 mem_ce 1 1 }  { shadow_bottomR_jL_q0 mem_dout 0 32 }  { shadow_bottomR_jL_address1 MemPortADDR2 1 4 }  { shadow_bottomR_jL_ce1 MemPortCE2 1 1 }  { shadow_bottomR_jL_q1 MemPortDOUT2 0 32 } } }
	z1_min { ap_memory {  { z1_min_address0 mem_address 1 4 }  { z1_min_ce0 mem_ce 1 1 }  { z1_min_q0 mem_dout 0 26 } } }
	z1_max { ap_memory {  { z1_max_address0 mem_address 1 4 }  { z1_max_ce0 mem_ce 1 1 }  { z1_max_q0 mem_dout 0 26 } } }
	a_corner_0 { ap_memory {  { a_corner_0_address0 mem_address 1 2 }  { a_corner_0_ce0 mem_ce 1 1 }  { a_corner_0_we0 mem_we 1 1 }  { a_corner_0_d0 mem_din 1 26 } } }
	a_corner_1 { ap_memory {  { a_corner_1_address0 mem_address 1 2 }  { a_corner_1_ce0 mem_ce 1 1 }  { a_corner_1_we0 mem_we 1 1 }  { a_corner_1_d0 mem_din 1 32 } } }
	b_corner_0 { ap_memory {  { b_corner_0_address0 mem_address 1 2 }  { b_corner_0_ce0 mem_ce 1 1 }  { b_corner_0_we0 mem_we 1 1 }  { b_corner_0_d0 mem_din 1 26 } } }
	b_corner_1 { ap_memory {  { b_corner_1_address0 mem_address 1 2 }  { b_corner_1_ce0 mem_ce 1 1 }  { b_corner_1_we0 mem_we 1 1 }  { b_corner_1_d0 mem_din 1 32 } } }
	c_corner_0 { ap_memory {  { c_corner_0_address0 mem_address 1 2 }  { c_corner_0_ce0 mem_ce 1 1 }  { c_corner_0_we0 mem_we 1 1 }  { c_corner_0_d0 mem_din 1 26 } } }
	c_corner_1 { ap_memory {  { c_corner_1_address0 mem_address 1 2 }  { c_corner_1_ce0 mem_ce 1 1 }  { c_corner_1_we0 mem_we 1 1 }  { c_corner_1_d0 mem_din 1 32 } } }
	d_corner_0 { ap_memory {  { d_corner_0_address0 mem_address 1 2 }  { d_corner_0_ce0 mem_ce 1 1 }  { d_corner_0_we0 mem_we 1 1 }  { d_corner_0_d0 mem_din 1 26 } } }
	d_corner_1 { ap_memory {  { d_corner_1_address0 mem_address 1 2 }  { d_corner_1_ce0 mem_ce 1 1 }  { d_corner_1_we0 mem_we 1 1 }  { d_corner_1_d0 mem_din 1 32 } } }
	squareAcceptance { ap_memory {  { squareAcceptance_address0 mem_address 1 2 }  { squareAcceptance_ce0 mem_ce 1 1 }  { squareAcceptance_we0 mem_we 1 1 }  { squareAcceptance_d0 mem_din 1 1 } } }
	flatTop { ap_memory {  { flatTop_address0 mem_address 1 2 }  { flatTop_ce0 mem_ce 1 1 }  { flatTop_we0 mem_we 1 1 }  { flatTop_d0 mem_din 1 1 } } }
	flatBottom { ap_memory {  { flatBottom_address0 mem_address 1 2 }  { flatBottom_ce0 mem_ce 1 1 }  { flatBottom_we0 mem_we 1 1 }  { flatBottom_d0 mem_din 1 1 } } }
	triangleAcceptance { ap_memory {  { triangleAcceptance_address0 mem_address 1 2 }  { triangleAcceptance_ce0 mem_ce 1 1 }  { triangleAcceptance_we0 mem_we 1 1 }  { triangleAcceptance_d0 mem_din 1 1 } } }
	latest_patch_index_constprop { ap_none {  { latest_patch_index_constprop in_data 0 2 } } }
}
