set moduleName p_shadowquilt_main_loop_make_verticle_strip
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
set C_modelName {_shadowquilt_main_loop_make_verticle_strip}
set C_modelType { void 0 }
set C_modelArgList {
	{ points int 128 regular {array 2560 { 1 1 } 1 1 }  }
	{ num_points int 32 regular {array 5 { 1 1 } 1 1 }  }
	{ patch_stream_V int 96 regular {fifo 1 volatile }  }
	{ patch_buffer int 32 regular {array 240 { 2 2 } 1 1 }  }
	{ pSlope int 32 regular {array 15 { 0 3 } 0 1 }  }
	{ shadow_bottomL_jR int 32 regular {array 15 { 2 1 } 1 1 }  }
	{ shadow_bottomR_jR int 32 regular {array 15 { 2 1 } 1 1 }  }
	{ shadow_bottomL_jL int 32 regular {array 15 { 2 1 } 1 1 }  }
	{ shadow_bottomR_jL int 32 regular {array 15 { 2 1 } 1 1 }  }
	{ z1_min int 26 regular {array 15 { 2 3 } 1 1 }  }
	{ z1_max int 26 regular {array 15 { 2 3 } 1 1 }  }
	{ a_corner_0 int 26 regular {array 3 { 0 3 } 0 1 }  }
	{ a_corner_1 int 32 regular {array 3 { 2 3 } 1 1 }  }
	{ b_corner_0 int 26 regular {array 3 { 0 3 } 0 1 }  }
	{ b_corner_1 int 32 regular {array 3 { 2 3 } 1 1 }  }
	{ c_corner_0 int 26 regular {array 3 { 2 3 } 1 1 }  }
	{ c_corner_1 int 32 regular {array 3 { 2 3 } 1 1 }  }
	{ d_corner_0 int 26 regular {array 3 { 0 3 } 0 1 }  }
	{ d_corner_1 int 32 regular {array 3 { 2 3 } 1 1 }  }
	{ squareAcceptance int 1 regular {array 3 { 2 3 } 1 1 }  }
	{ flatTop int 1 regular {array 3 { 0 3 } 0 1 }  }
	{ flatBottom int 1 regular {array 3 { 2 3 } 1 1 }  }
	{ triangleAcceptance int 1 regular {array 3 { 2 3 } 1 1 }  }
	{ latest_patch_index_constprop int 2 regular {pointer 2} {global 2}  }
	{ num_patches_constprop int 32 regular {pointer 2} {global 2}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "points", "interface" : "memory", "bitwidth" : 128, "direction" : "READONLY"} , 
 	{ "Name" : "num_points", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "patch_stream_V", "interface" : "fifo", "bitwidth" : 96, "direction" : "WRITEONLY"} , 
 	{ "Name" : "patch_buffer", "interface" : "memory", "bitwidth" : 32, "direction" : "READWRITE"} , 
 	{ "Name" : "pSlope", "interface" : "memory", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "shadow_bottomL_jR", "interface" : "memory", "bitwidth" : 32, "direction" : "READWRITE"} , 
 	{ "Name" : "shadow_bottomR_jR", "interface" : "memory", "bitwidth" : 32, "direction" : "READWRITE"} , 
 	{ "Name" : "shadow_bottomL_jL", "interface" : "memory", "bitwidth" : 32, "direction" : "READWRITE"} , 
 	{ "Name" : "shadow_bottomR_jL", "interface" : "memory", "bitwidth" : 32, "direction" : "READWRITE"} , 
 	{ "Name" : "z1_min", "interface" : "memory", "bitwidth" : 26, "direction" : "READWRITE"} , 
 	{ "Name" : "z1_max", "interface" : "memory", "bitwidth" : 26, "direction" : "READWRITE"} , 
 	{ "Name" : "a_corner_0", "interface" : "memory", "bitwidth" : 26, "direction" : "WRITEONLY"} , 
 	{ "Name" : "a_corner_1", "interface" : "memory", "bitwidth" : 32, "direction" : "READWRITE"} , 
 	{ "Name" : "b_corner_0", "interface" : "memory", "bitwidth" : 26, "direction" : "WRITEONLY"} , 
 	{ "Name" : "b_corner_1", "interface" : "memory", "bitwidth" : 32, "direction" : "READWRITE"} , 
 	{ "Name" : "c_corner_0", "interface" : "memory", "bitwidth" : 26, "direction" : "READWRITE"} , 
 	{ "Name" : "c_corner_1", "interface" : "memory", "bitwidth" : 32, "direction" : "READWRITE"} , 
 	{ "Name" : "d_corner_0", "interface" : "memory", "bitwidth" : 26, "direction" : "WRITEONLY"} , 
 	{ "Name" : "d_corner_1", "interface" : "memory", "bitwidth" : 32, "direction" : "READWRITE"} , 
 	{ "Name" : "squareAcceptance", "interface" : "memory", "bitwidth" : 1, "direction" : "READWRITE"} , 
 	{ "Name" : "flatTop", "interface" : "memory", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "flatBottom", "interface" : "memory", "bitwidth" : 1, "direction" : "READWRITE"} , 
 	{ "Name" : "triangleAcceptance", "interface" : "memory", "bitwidth" : 1, "direction" : "READWRITE"} , 
 	{ "Name" : "latest_patch_index_constprop", "interface" : "wire", "bitwidth" : 2, "direction" : "READWRITE", "extern" : 0} , 
 	{ "Name" : "num_patches_constprop", "interface" : "wire", "bitwidth" : 32, "direction" : "READWRITE", "extern" : 0} ]}
# RTL Port declarations: 
set portNum 139
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
	{ patch_buffer_address0 sc_out sc_lv 8 signal 3 } 
	{ patch_buffer_ce0 sc_out sc_logic 1 signal 3 } 
	{ patch_buffer_we0 sc_out sc_logic 1 signal 3 } 
	{ patch_buffer_d0 sc_out sc_lv 32 signal 3 } 
	{ patch_buffer_q0 sc_in sc_lv 32 signal 3 } 
	{ patch_buffer_address1 sc_out sc_lv 8 signal 3 } 
	{ patch_buffer_ce1 sc_out sc_logic 1 signal 3 } 
	{ patch_buffer_we1 sc_out sc_logic 1 signal 3 } 
	{ patch_buffer_d1 sc_out sc_lv 32 signal 3 } 
	{ patch_buffer_q1 sc_in sc_lv 32 signal 3 } 
	{ pSlope_address0 sc_out sc_lv 4 signal 4 } 
	{ pSlope_ce0 sc_out sc_logic 1 signal 4 } 
	{ pSlope_we0 sc_out sc_logic 1 signal 4 } 
	{ pSlope_d0 sc_out sc_lv 32 signal 4 } 
	{ shadow_bottomL_jR_address0 sc_out sc_lv 4 signal 5 } 
	{ shadow_bottomL_jR_ce0 sc_out sc_logic 1 signal 5 } 
	{ shadow_bottomL_jR_we0 sc_out sc_logic 1 signal 5 } 
	{ shadow_bottomL_jR_d0 sc_out sc_lv 32 signal 5 } 
	{ shadow_bottomL_jR_q0 sc_in sc_lv 32 signal 5 } 
	{ shadow_bottomL_jR_address1 sc_out sc_lv 4 signal 5 } 
	{ shadow_bottomL_jR_ce1 sc_out sc_logic 1 signal 5 } 
	{ shadow_bottomL_jR_q1 sc_in sc_lv 32 signal 5 } 
	{ shadow_bottomR_jR_address0 sc_out sc_lv 4 signal 6 } 
	{ shadow_bottomR_jR_ce0 sc_out sc_logic 1 signal 6 } 
	{ shadow_bottomR_jR_we0 sc_out sc_logic 1 signal 6 } 
	{ shadow_bottomR_jR_d0 sc_out sc_lv 32 signal 6 } 
	{ shadow_bottomR_jR_q0 sc_in sc_lv 32 signal 6 } 
	{ shadow_bottomR_jR_address1 sc_out sc_lv 4 signal 6 } 
	{ shadow_bottomR_jR_ce1 sc_out sc_logic 1 signal 6 } 
	{ shadow_bottomR_jR_q1 sc_in sc_lv 32 signal 6 } 
	{ shadow_bottomL_jL_address0 sc_out sc_lv 4 signal 7 } 
	{ shadow_bottomL_jL_ce0 sc_out sc_logic 1 signal 7 } 
	{ shadow_bottomL_jL_we0 sc_out sc_logic 1 signal 7 } 
	{ shadow_bottomL_jL_d0 sc_out sc_lv 32 signal 7 } 
	{ shadow_bottomL_jL_q0 sc_in sc_lv 32 signal 7 } 
	{ shadow_bottomL_jL_address1 sc_out sc_lv 4 signal 7 } 
	{ shadow_bottomL_jL_ce1 sc_out sc_logic 1 signal 7 } 
	{ shadow_bottomL_jL_q1 sc_in sc_lv 32 signal 7 } 
	{ shadow_bottomR_jL_address0 sc_out sc_lv 4 signal 8 } 
	{ shadow_bottomR_jL_ce0 sc_out sc_logic 1 signal 8 } 
	{ shadow_bottomR_jL_we0 sc_out sc_logic 1 signal 8 } 
	{ shadow_bottomR_jL_d0 sc_out sc_lv 32 signal 8 } 
	{ shadow_bottomR_jL_q0 sc_in sc_lv 32 signal 8 } 
	{ shadow_bottomR_jL_address1 sc_out sc_lv 4 signal 8 } 
	{ shadow_bottomR_jL_ce1 sc_out sc_logic 1 signal 8 } 
	{ shadow_bottomR_jL_q1 sc_in sc_lv 32 signal 8 } 
	{ z1_min_address0 sc_out sc_lv 4 signal 9 } 
	{ z1_min_ce0 sc_out sc_logic 1 signal 9 } 
	{ z1_min_we0 sc_out sc_logic 1 signal 9 } 
	{ z1_min_d0 sc_out sc_lv 26 signal 9 } 
	{ z1_min_q0 sc_in sc_lv 26 signal 9 } 
	{ z1_max_address0 sc_out sc_lv 4 signal 10 } 
	{ z1_max_ce0 sc_out sc_logic 1 signal 10 } 
	{ z1_max_we0 sc_out sc_logic 1 signal 10 } 
	{ z1_max_d0 sc_out sc_lv 26 signal 10 } 
	{ z1_max_q0 sc_in sc_lv 26 signal 10 } 
	{ a_corner_0_address0 sc_out sc_lv 2 signal 11 } 
	{ a_corner_0_ce0 sc_out sc_logic 1 signal 11 } 
	{ a_corner_0_we0 sc_out sc_logic 1 signal 11 } 
	{ a_corner_0_d0 sc_out sc_lv 26 signal 11 } 
	{ a_corner_1_address0 sc_out sc_lv 2 signal 12 } 
	{ a_corner_1_ce0 sc_out sc_logic 1 signal 12 } 
	{ a_corner_1_we0 sc_out sc_logic 1 signal 12 } 
	{ a_corner_1_d0 sc_out sc_lv 32 signal 12 } 
	{ a_corner_1_q0 sc_in sc_lv 32 signal 12 } 
	{ b_corner_0_address0 sc_out sc_lv 2 signal 13 } 
	{ b_corner_0_ce0 sc_out sc_logic 1 signal 13 } 
	{ b_corner_0_we0 sc_out sc_logic 1 signal 13 } 
	{ b_corner_0_d0 sc_out sc_lv 26 signal 13 } 
	{ b_corner_1_address0 sc_out sc_lv 2 signal 14 } 
	{ b_corner_1_ce0 sc_out sc_logic 1 signal 14 } 
	{ b_corner_1_we0 sc_out sc_logic 1 signal 14 } 
	{ b_corner_1_d0 sc_out sc_lv 32 signal 14 } 
	{ b_corner_1_q0 sc_in sc_lv 32 signal 14 } 
	{ c_corner_0_address0 sc_out sc_lv 2 signal 15 } 
	{ c_corner_0_ce0 sc_out sc_logic 1 signal 15 } 
	{ c_corner_0_we0 sc_out sc_logic 1 signal 15 } 
	{ c_corner_0_d0 sc_out sc_lv 26 signal 15 } 
	{ c_corner_0_q0 sc_in sc_lv 26 signal 15 } 
	{ c_corner_1_address0 sc_out sc_lv 2 signal 16 } 
	{ c_corner_1_ce0 sc_out sc_logic 1 signal 16 } 
	{ c_corner_1_we0 sc_out sc_logic 1 signal 16 } 
	{ c_corner_1_d0 sc_out sc_lv 32 signal 16 } 
	{ c_corner_1_q0 sc_in sc_lv 32 signal 16 } 
	{ d_corner_0_address0 sc_out sc_lv 2 signal 17 } 
	{ d_corner_0_ce0 sc_out sc_logic 1 signal 17 } 
	{ d_corner_0_we0 sc_out sc_logic 1 signal 17 } 
	{ d_corner_0_d0 sc_out sc_lv 26 signal 17 } 
	{ d_corner_1_address0 sc_out sc_lv 2 signal 18 } 
	{ d_corner_1_ce0 sc_out sc_logic 1 signal 18 } 
	{ d_corner_1_we0 sc_out sc_logic 1 signal 18 } 
	{ d_corner_1_d0 sc_out sc_lv 32 signal 18 } 
	{ d_corner_1_q0 sc_in sc_lv 32 signal 18 } 
	{ squareAcceptance_address0 sc_out sc_lv 2 signal 19 } 
	{ squareAcceptance_ce0 sc_out sc_logic 1 signal 19 } 
	{ squareAcceptance_we0 sc_out sc_logic 1 signal 19 } 
	{ squareAcceptance_d0 sc_out sc_lv 1 signal 19 } 
	{ squareAcceptance_q0 sc_in sc_lv 1 signal 19 } 
	{ flatTop_address0 sc_out sc_lv 2 signal 20 } 
	{ flatTop_ce0 sc_out sc_logic 1 signal 20 } 
	{ flatTop_we0 sc_out sc_logic 1 signal 20 } 
	{ flatTop_d0 sc_out sc_lv 1 signal 20 } 
	{ flatBottom_address0 sc_out sc_lv 2 signal 21 } 
	{ flatBottom_ce0 sc_out sc_logic 1 signal 21 } 
	{ flatBottom_we0 sc_out sc_logic 1 signal 21 } 
	{ flatBottom_d0 sc_out sc_lv 1 signal 21 } 
	{ flatBottom_q0 sc_in sc_lv 1 signal 21 } 
	{ triangleAcceptance_address0 sc_out sc_lv 2 signal 22 } 
	{ triangleAcceptance_ce0 sc_out sc_logic 1 signal 22 } 
	{ triangleAcceptance_we0 sc_out sc_logic 1 signal 22 } 
	{ triangleAcceptance_d0 sc_out sc_lv 1 signal 22 } 
	{ triangleAcceptance_q0 sc_in sc_lv 1 signal 22 } 
	{ latest_patch_index_constprop_i sc_in sc_lv 2 signal 23 } 
	{ latest_patch_index_constprop_o sc_out sc_lv 2 signal 23 } 
	{ latest_patch_index_constprop_o_ap_vld sc_out sc_logic 1 outvld 23 } 
	{ num_patches_constprop_i sc_in sc_lv 32 signal 24 } 
	{ num_patches_constprop_o sc_out sc_lv 32 signal 24 } 
	{ num_patches_constprop_o_ap_vld sc_out sc_logic 1 outvld 24 } 
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
 	{ "name": "patch_stream_V_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "patch_stream_V", "role": "write" }} , 
 	{ "name": "patch_buffer_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "patch_buffer", "role": "address0" }} , 
 	{ "name": "patch_buffer_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "patch_buffer", "role": "ce0" }} , 
 	{ "name": "patch_buffer_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "patch_buffer", "role": "we0" }} , 
 	{ "name": "patch_buffer_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "patch_buffer", "role": "d0" }} , 
 	{ "name": "patch_buffer_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "patch_buffer", "role": "q0" }} , 
 	{ "name": "patch_buffer_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "patch_buffer", "role": "address1" }} , 
 	{ "name": "patch_buffer_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "patch_buffer", "role": "ce1" }} , 
 	{ "name": "patch_buffer_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "patch_buffer", "role": "we1" }} , 
 	{ "name": "patch_buffer_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "patch_buffer", "role": "d1" }} , 
 	{ "name": "patch_buffer_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "patch_buffer", "role": "q1" }} , 
 	{ "name": "pSlope_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "pSlope", "role": "address0" }} , 
 	{ "name": "pSlope_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pSlope", "role": "ce0" }} , 
 	{ "name": "pSlope_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pSlope", "role": "we0" }} , 
 	{ "name": "pSlope_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "pSlope", "role": "d0" }} , 
 	{ "name": "shadow_bottomL_jR_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "shadow_bottomL_jR", "role": "address0" }} , 
 	{ "name": "shadow_bottomL_jR_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "shadow_bottomL_jR", "role": "ce0" }} , 
 	{ "name": "shadow_bottomL_jR_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "shadow_bottomL_jR", "role": "we0" }} , 
 	{ "name": "shadow_bottomL_jR_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "shadow_bottomL_jR", "role": "d0" }} , 
 	{ "name": "shadow_bottomL_jR_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "shadow_bottomL_jR", "role": "q0" }} , 
 	{ "name": "shadow_bottomL_jR_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "shadow_bottomL_jR", "role": "address1" }} , 
 	{ "name": "shadow_bottomL_jR_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "shadow_bottomL_jR", "role": "ce1" }} , 
 	{ "name": "shadow_bottomL_jR_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "shadow_bottomL_jR", "role": "q1" }} , 
 	{ "name": "shadow_bottomR_jR_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "shadow_bottomR_jR", "role": "address0" }} , 
 	{ "name": "shadow_bottomR_jR_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "shadow_bottomR_jR", "role": "ce0" }} , 
 	{ "name": "shadow_bottomR_jR_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "shadow_bottomR_jR", "role": "we0" }} , 
 	{ "name": "shadow_bottomR_jR_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "shadow_bottomR_jR", "role": "d0" }} , 
 	{ "name": "shadow_bottomR_jR_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "shadow_bottomR_jR", "role": "q0" }} , 
 	{ "name": "shadow_bottomR_jR_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "shadow_bottomR_jR", "role": "address1" }} , 
 	{ "name": "shadow_bottomR_jR_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "shadow_bottomR_jR", "role": "ce1" }} , 
 	{ "name": "shadow_bottomR_jR_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "shadow_bottomR_jR", "role": "q1" }} , 
 	{ "name": "shadow_bottomL_jL_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "shadow_bottomL_jL", "role": "address0" }} , 
 	{ "name": "shadow_bottomL_jL_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "shadow_bottomL_jL", "role": "ce0" }} , 
 	{ "name": "shadow_bottomL_jL_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "shadow_bottomL_jL", "role": "we0" }} , 
 	{ "name": "shadow_bottomL_jL_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "shadow_bottomL_jL", "role": "d0" }} , 
 	{ "name": "shadow_bottomL_jL_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "shadow_bottomL_jL", "role": "q0" }} , 
 	{ "name": "shadow_bottomL_jL_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "shadow_bottomL_jL", "role": "address1" }} , 
 	{ "name": "shadow_bottomL_jL_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "shadow_bottomL_jL", "role": "ce1" }} , 
 	{ "name": "shadow_bottomL_jL_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "shadow_bottomL_jL", "role": "q1" }} , 
 	{ "name": "shadow_bottomR_jL_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "shadow_bottomR_jL", "role": "address0" }} , 
 	{ "name": "shadow_bottomR_jL_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "shadow_bottomR_jL", "role": "ce0" }} , 
 	{ "name": "shadow_bottomR_jL_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "shadow_bottomR_jL", "role": "we0" }} , 
 	{ "name": "shadow_bottomR_jL_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "shadow_bottomR_jL", "role": "d0" }} , 
 	{ "name": "shadow_bottomR_jL_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "shadow_bottomR_jL", "role": "q0" }} , 
 	{ "name": "shadow_bottomR_jL_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "shadow_bottomR_jL", "role": "address1" }} , 
 	{ "name": "shadow_bottomR_jL_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "shadow_bottomR_jL", "role": "ce1" }} , 
 	{ "name": "shadow_bottomR_jL_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "shadow_bottomR_jL", "role": "q1" }} , 
 	{ "name": "z1_min_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "z1_min", "role": "address0" }} , 
 	{ "name": "z1_min_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "z1_min", "role": "ce0" }} , 
 	{ "name": "z1_min_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "z1_min", "role": "we0" }} , 
 	{ "name": "z1_min_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":26, "type": "signal", "bundle":{"name": "z1_min", "role": "d0" }} , 
 	{ "name": "z1_min_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":26, "type": "signal", "bundle":{"name": "z1_min", "role": "q0" }} , 
 	{ "name": "z1_max_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "z1_max", "role": "address0" }} , 
 	{ "name": "z1_max_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "z1_max", "role": "ce0" }} , 
 	{ "name": "z1_max_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "z1_max", "role": "we0" }} , 
 	{ "name": "z1_max_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":26, "type": "signal", "bundle":{"name": "z1_max", "role": "d0" }} , 
 	{ "name": "z1_max_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":26, "type": "signal", "bundle":{"name": "z1_max", "role": "q0" }} , 
 	{ "name": "a_corner_0_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "a_corner_0", "role": "address0" }} , 
 	{ "name": "a_corner_0_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "a_corner_0", "role": "ce0" }} , 
 	{ "name": "a_corner_0_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "a_corner_0", "role": "we0" }} , 
 	{ "name": "a_corner_0_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":26, "type": "signal", "bundle":{"name": "a_corner_0", "role": "d0" }} , 
 	{ "name": "a_corner_1_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "a_corner_1", "role": "address0" }} , 
 	{ "name": "a_corner_1_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "a_corner_1", "role": "ce0" }} , 
 	{ "name": "a_corner_1_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "a_corner_1", "role": "we0" }} , 
 	{ "name": "a_corner_1_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "a_corner_1", "role": "d0" }} , 
 	{ "name": "a_corner_1_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "a_corner_1", "role": "q0" }} , 
 	{ "name": "b_corner_0_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "b_corner_0", "role": "address0" }} , 
 	{ "name": "b_corner_0_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "b_corner_0", "role": "ce0" }} , 
 	{ "name": "b_corner_0_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "b_corner_0", "role": "we0" }} , 
 	{ "name": "b_corner_0_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":26, "type": "signal", "bundle":{"name": "b_corner_0", "role": "d0" }} , 
 	{ "name": "b_corner_1_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "b_corner_1", "role": "address0" }} , 
 	{ "name": "b_corner_1_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "b_corner_1", "role": "ce0" }} , 
 	{ "name": "b_corner_1_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "b_corner_1", "role": "we0" }} , 
 	{ "name": "b_corner_1_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "b_corner_1", "role": "d0" }} , 
 	{ "name": "b_corner_1_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "b_corner_1", "role": "q0" }} , 
 	{ "name": "c_corner_0_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "c_corner_0", "role": "address0" }} , 
 	{ "name": "c_corner_0_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "c_corner_0", "role": "ce0" }} , 
 	{ "name": "c_corner_0_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "c_corner_0", "role": "we0" }} , 
 	{ "name": "c_corner_0_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":26, "type": "signal", "bundle":{"name": "c_corner_0", "role": "d0" }} , 
 	{ "name": "c_corner_0_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":26, "type": "signal", "bundle":{"name": "c_corner_0", "role": "q0" }} , 
 	{ "name": "c_corner_1_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "c_corner_1", "role": "address0" }} , 
 	{ "name": "c_corner_1_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "c_corner_1", "role": "ce0" }} , 
 	{ "name": "c_corner_1_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "c_corner_1", "role": "we0" }} , 
 	{ "name": "c_corner_1_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "c_corner_1", "role": "d0" }} , 
 	{ "name": "c_corner_1_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "c_corner_1", "role": "q0" }} , 
 	{ "name": "d_corner_0_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "d_corner_0", "role": "address0" }} , 
 	{ "name": "d_corner_0_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "d_corner_0", "role": "ce0" }} , 
 	{ "name": "d_corner_0_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "d_corner_0", "role": "we0" }} , 
 	{ "name": "d_corner_0_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":26, "type": "signal", "bundle":{"name": "d_corner_0", "role": "d0" }} , 
 	{ "name": "d_corner_1_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "d_corner_1", "role": "address0" }} , 
 	{ "name": "d_corner_1_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "d_corner_1", "role": "ce0" }} , 
 	{ "name": "d_corner_1_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "d_corner_1", "role": "we0" }} , 
 	{ "name": "d_corner_1_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "d_corner_1", "role": "d0" }} , 
 	{ "name": "d_corner_1_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "d_corner_1", "role": "q0" }} , 
 	{ "name": "squareAcceptance_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "squareAcceptance", "role": "address0" }} , 
 	{ "name": "squareAcceptance_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "squareAcceptance", "role": "ce0" }} , 
 	{ "name": "squareAcceptance_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "squareAcceptance", "role": "we0" }} , 
 	{ "name": "squareAcceptance_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "squareAcceptance", "role": "d0" }} , 
 	{ "name": "squareAcceptance_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "squareAcceptance", "role": "q0" }} , 
 	{ "name": "flatTop_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "flatTop", "role": "address0" }} , 
 	{ "name": "flatTop_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "flatTop", "role": "ce0" }} , 
 	{ "name": "flatTop_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "flatTop", "role": "we0" }} , 
 	{ "name": "flatTop_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "flatTop", "role": "d0" }} , 
 	{ "name": "flatBottom_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "flatBottom", "role": "address0" }} , 
 	{ "name": "flatBottom_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "flatBottom", "role": "ce0" }} , 
 	{ "name": "flatBottom_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "flatBottom", "role": "we0" }} , 
 	{ "name": "flatBottom_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "flatBottom", "role": "d0" }} , 
 	{ "name": "flatBottom_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "flatBottom", "role": "q0" }} , 
 	{ "name": "triangleAcceptance_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "triangleAcceptance", "role": "address0" }} , 
 	{ "name": "triangleAcceptance_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "triangleAcceptance", "role": "ce0" }} , 
 	{ "name": "triangleAcceptance_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "triangleAcceptance", "role": "we0" }} , 
 	{ "name": "triangleAcceptance_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "triangleAcceptance", "role": "d0" }} , 
 	{ "name": "triangleAcceptance_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "triangleAcceptance", "role": "q0" }} , 
 	{ "name": "latest_patch_index_constprop_i", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "latest_patch_index_constprop", "role": "i" }} , 
 	{ "name": "latest_patch_index_constprop_o", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "latest_patch_index_constprop", "role": "o" }} , 
 	{ "name": "latest_patch_index_constprop_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "latest_patch_index_constprop", "role": "o_ap_vld" }} , 
 	{ "name": "num_patches_constprop_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "num_patches_constprop", "role": "i" }} , 
 	{ "name": "num_patches_constprop_o", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "num_patches_constprop", "role": "o" }} , 
 	{ "name": "num_patches_constprop_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "num_patches_constprop", "role": "o_ap_vld" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2", "3", "4", "5", "6", "7", "8", "26", "33", "37", "38", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52"],
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
					{"ID" : "33", "SubInstance" : "grp_get_index_from_z_fu_1317", "Port" : "points"},
					{"ID" : "8", "SubInstance" : "grp_alignedtoline_per_layer_loop3_fu_1250", "Port" : "points"}]},
			{"Name" : "num_points", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "33", "SubInstance" : "grp_get_index_from_z_fu_1317", "Port" : "num_points"},
					{"ID" : "8", "SubInstance" : "grp_alignedtoline_per_layer_loop3_fu_1250", "Port" : "num_points"}]},
			{"Name" : "patch_stream_V", "Type" : "Fifo", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "patch_stream_V_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "patch_buffer", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "26", "SubInstance" : "grp_getParallelograms_fu_1285", "Port" : "superpoints"},
					{"ID" : "37", "SubInstance" : "grp_patch_buffer_add_patch2_fu_1330", "Port" : "patch_buffer"}]},
			{"Name" : "pSlope", "Type" : "Memory", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "26", "SubInstance" : "grp_getParallelograms_fu_1285", "Port" : "pSlope"}]},
			{"Name" : "shadow_bottomL_jR", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "26", "SubInstance" : "grp_getParallelograms_fu_1285", "Port" : "shadow_bottomL_jR"},
					{"ID" : "38", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "shadow_bottomL_jR"}]},
			{"Name" : "shadow_bottomR_jR", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "26", "SubInstance" : "grp_getParallelograms_fu_1285", "Port" : "shadow_bottomR_jR"},
					{"ID" : "38", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "shadow_bottomR_jR"}]},
			{"Name" : "shadow_bottomL_jL", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "26", "SubInstance" : "grp_getParallelograms_fu_1285", "Port" : "shadow_bottomL_jL"},
					{"ID" : "38", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "shadow_bottomL_jL"}]},
			{"Name" : "shadow_bottomR_jL", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "26", "SubInstance" : "grp_getParallelograms_fu_1285", "Port" : "shadow_bottomR_jL"},
					{"ID" : "38", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "shadow_bottomR_jL"}]},
			{"Name" : "z1_min", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "26", "SubInstance" : "grp_getParallelograms_fu_1285", "Port" : "z1_min"},
					{"ID" : "38", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "z1_min"}]},
			{"Name" : "z1_max", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "26", "SubInstance" : "grp_getParallelograms_fu_1285", "Port" : "z1_max"},
					{"ID" : "38", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "z1_max"}]},
			{"Name" : "a_corner_0", "Type" : "Memory", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "38", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "a_corner_0"}]},
			{"Name" : "a_corner_1", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "38", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "a_corner_1"}]},
			{"Name" : "b_corner_0", "Type" : "Memory", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "38", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "b_corner_0"}]},
			{"Name" : "b_corner_1", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "38", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "b_corner_1"}]},
			{"Name" : "c_corner_0", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "38", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "c_corner_0"}]},
			{"Name" : "c_corner_1", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "38", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "c_corner_1"}]},
			{"Name" : "d_corner_0", "Type" : "Memory", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "38", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "d_corner_0"}]},
			{"Name" : "d_corner_1", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "38", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "d_corner_1"}]},
			{"Name" : "squareAcceptance", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "38", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "squareAcceptance"}]},
			{"Name" : "flatTop", "Type" : "Memory", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "38", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "flatTop"}]},
			{"Name" : "flatBottom", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "38", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "flatBottom"}]},
			{"Name" : "triangleAcceptance", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "38", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "triangleAcceptance"}]},
			{"Name" : "get_radiiradii", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "26", "SubInstance" : "grp_getParallelograms_fu_1285", "Port" : "get_radiiradii"},
					{"ID" : "8", "SubInstance" : "grp_alignedtoline_per_layer_loop3_fu_1250", "Port" : "get_radiiradii"}]},
			{"Name" : "lbVal_constprop", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "8", "SubInstance" : "grp_alignedtoline_per_layer_loop3_fu_1250", "Port" : "lbVal_constprop"}]},
			{"Name" : "rbVal_constprop", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "8", "SubInstance" : "grp_alignedtoline_per_layer_loop3_fu_1250", "Port" : "rbVal_constprop"}]},
			{"Name" : "get_trapezoid_edgestrapezoid_edges", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "8", "SubInstance" : "grp_alignedtoline_per_layer_loop3_fu_1250", "Port" : "get_trapezoid_edgestrapezoid_edges"}]},
			{"Name" : "latest_patch_index_constprop", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "37", "SubInstance" : "grp_patch_buffer_add_patch2_fu_1330", "Port" : "latest_patch_index_constprop"},
					{"ID" : "38", "SubInstance" : "grp_get_acceptanceCorners_fu_1341", "Port" : "latest_patch_index_constprop"}]},
			{"Name" : "num_patches_constprop", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "37", "SubInstance" : "grp_patch_buffer_add_patch2_fu_1330", "Port" : "num_patches_constprop"}]},
			{"Name" : "get_parallelogram_slopesparallelogram_slopes", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "26", "SubInstance" : "grp_getParallelograms_fu_1285", "Port" : "get_parallelogram_slopesparallelogram_slopes"}]}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.get_radiiradii_U", "Parent" : "0"},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.init_patch_V_U", "Parent" : "0"},
	{"ID" : "3", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.init_patch_V_1_U", "Parent" : "0"},
	{"ID" : "4", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.current_z_i_index_V_U", "Parent" : "0"},
	{"ID" : "5", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.new_z_i_index_V_U", "Parent" : "0"},
	{"ID" : "6", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.new_z_i_V_U", "Parent" : "0"},
	{"ID" : "7", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.new_z_i_atTop_V_U", "Parent" : "0"},
	{"ID" : "8", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.grp_alignedtoline_per_layer_loop3_fu_1250", "Parent" : "0", "Child" : ["9", "10", "23", "24", "25"],
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
					{"ID" : "10", "SubInstance" : "grp_p_find_boundaries_and_starting_index_and_value7_fu_922", "Port" : "points"}]},
			{"Name" : "num_points", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "10", "SubInstance" : "grp_p_find_boundaries_and_starting_index_and_value7_fu_922", "Port" : "num_points"}]},
			{"Name" : "p_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "z_top", "Type" : "None", "Direction" : "I"},
			{"Name" : "leftRight_offset", "Type" : "None", "Direction" : "I"},
			{"Name" : "init_patch", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "i_offset", "Type" : "None", "Direction" : "I"},
			{"Name" : "get_radiiradii", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "lbVal_constprop", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "10", "SubInstance" : "grp_p_find_boundaries_and_starting_index_and_value7_fu_922", "Port" : "lbVal_constprop"}]},
			{"Name" : "rbVal_constprop", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "10", "SubInstance" : "grp_p_find_boundaries_and_starting_index_and_value7_fu_922", "Port" : "rbVal_constprop"}]},
			{"Name" : "get_trapezoid_edgestrapezoid_edges", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "10", "SubInstance" : "grp_p_find_boundaries_and_starting_index_and_value7_fu_922", "Port" : "get_trapezoid_edgestrapezoid_edges"}]}]},
	{"ID" : "9", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_alignedtoline_per_layer_loop3_fu_1250.get_radiiradii_U", "Parent" : "8"},
	{"ID" : "10", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_alignedtoline_per_layer_loop3_fu_1250.grp_p_find_boundaries_and_starting_index_and_value7_fu_922", "Parent" : "8", "Child" : ["11", "12", "17", "20", "21", "22"],
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
			{"ID" : "11", "Name" : "p_find_boundaries_and_starting_index_and_value_entry25_U0"},
			{"ID" : "12", "Name" : "p_find_left_and_right_boundaries9_U0"},
			{"ID" : "17", "Name" : "p_find_starting_index_and_value8_U0"}],
		"OutputProcess" : [
			{"ID" : "12", "Name" : "p_find_left_and_right_boundaries9_U0"},
			{"ID" : "17", "Name" : "p_find_starting_index_and_value8_U0"}],
		"Port" : [
			{"Name" : "num_points", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "17", "SubInstance" : "p_find_starting_index_and_value8_U0", "Port" : "num_points"},
					{"ID" : "12", "SubInstance" : "p_find_left_and_right_boundaries9_U0", "Port" : "num_points"}]},
			{"Name" : "points", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "17", "SubInstance" : "p_find_starting_index_and_value8_U0", "Port" : "points"},
					{"ID" : "12", "SubInstance" : "p_find_left_and_right_boundaries9_U0", "Port" : "points"}]},
			{"Name" : "left_bound", "Type" : "Vld", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "12", "SubInstance" : "p_find_left_and_right_boundaries9_U0", "Port" : "left_bound"}]},
			{"Name" : "right_bound", "Type" : "Vld", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "12", "SubInstance" : "p_find_left_and_right_boundaries9_U0", "Port" : "right_bound"}]},
			{"Name" : "projectionToRow", "Type" : "None", "Direction" : "I"},
			{"Name" : "start_index", "Type" : "Vld", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "17", "SubInstance" : "p_find_starting_index_and_value8_U0", "Port" : "start_index"}]},
			{"Name" : "start_value", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "17", "SubInstance" : "p_find_starting_index_and_value8_U0", "Port" : "start_value"}]},
			{"Name" : "i", "Type" : "None", "Direction" : "I"},
			{"Name" : "get_trapezoid_edgestrapezoid_edges", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "12", "SubInstance" : "p_find_left_and_right_boundaries9_U0", "Port" : "get_trapezoid_edgestrapezoid_edges"}]},
			{"Name" : "lbVal_constprop", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "12", "SubInstance" : "p_find_left_and_right_boundaries9_U0", "Port" : "lbVal_constprop"}]},
			{"Name" : "rbVal_constprop", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "12", "SubInstance" : "p_find_left_and_right_boundaries9_U0", "Port" : "rbVal_constprop"}]}]},
	{"ID" : "11", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_alignedtoline_per_layer_loop3_fu_1250.grp_p_find_boundaries_and_starting_index_and_value7_fu_922.p_find_boundaries_and_starting_index_and_value_entry25_U0", "Parent" : "10",
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
			{"Name" : "projectionToRow_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "17", "DependentChan" : "20", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "projectionToRow_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "i_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "12", "DependentChan" : "21", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "i_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "i_out1", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "17", "DependentChan" : "22", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "i_out1_blk_n", "Type" : "RtlSignal"}]}]},
	{"ID" : "12", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_alignedtoline_per_layer_loop3_fu_1250.grp_p_find_boundaries_and_starting_index_and_value7_fu_922.p_find_left_and_right_boundaries9_U0", "Parent" : "10", "Child" : ["13", "14", "15", "16"],
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
			{"Name" : "i", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "11", "DependentChan" : "21", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "i_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "get_trapezoid_edgestrapezoid_edges", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "lbVal_constprop", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "rbVal_constprop", "Type" : "OVld", "Direction" : "IO"}]},
	{"ID" : "13", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_alignedtoline_per_layer_loop3_fu_1250.grp_p_find_boundaries_and_starting_index_and_value7_fu_922.p_find_left_and_right_boundaries9_U0.get_trapezoid_edgestrapezoid_edges_U", "Parent" : "12"},
	{"ID" : "14", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_alignedtoline_per_layer_loop3_fu_1250.grp_p_find_boundaries_and_starting_index_and_value7_fu_922.p_find_left_and_right_boundaries9_U0.faddfsub_32ns_32ns_32_3_full_dsp_1_U6", "Parent" : "12"},
	{"ID" : "15", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_alignedtoline_per_layer_loop3_fu_1250.grp_p_find_boundaries_and_starting_index_and_value7_fu_922.p_find_left_and_right_boundaries9_U0.fpext_32ns_64_2_no_dsp_1_U7", "Parent" : "12"},
	{"ID" : "16", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_alignedtoline_per_layer_loop3_fu_1250.grp_p_find_boundaries_and_starting_index_and_value7_fu_922.p_find_left_and_right_boundaries9_U0.fpext_32ns_64_2_no_dsp_1_U8", "Parent" : "12"},
	{"ID" : "17", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_alignedtoline_per_layer_loop3_fu_1250.grp_p_find_boundaries_and_starting_index_and_value7_fu_922.p_find_starting_index_and_value8_U0", "Parent" : "10", "Child" : ["18", "19"],
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
			{"Name" : "projectionToRow", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "11", "DependentChan" : "20", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "projectionToRow_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "start_index", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "start_value", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "i", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "11", "DependentChan" : "22", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "i_blk_n", "Type" : "RtlSignal"}]}]},
	{"ID" : "18", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_alignedtoline_per_layer_loop3_fu_1250.grp_p_find_boundaries_and_starting_index_and_value7_fu_922.p_find_starting_index_and_value8_U0.fsub_32ns_32ns_32_3_full_dsp_1_U19", "Parent" : "17"},
	{"ID" : "19", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_alignedtoline_per_layer_loop3_fu_1250.grp_p_find_boundaries_and_starting_index_and_value7_fu_922.p_find_starting_index_and_value8_U0.fcmp_32ns_32ns_1_2_no_dsp_1_U20", "Parent" : "17"},
	{"ID" : "20", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_alignedtoline_per_layer_loop3_fu_1250.grp_p_find_boundaries_and_starting_index_and_value7_fu_922.projectionToRow_c_U", "Parent" : "10"},
	{"ID" : "21", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_alignedtoline_per_layer_loop3_fu_1250.grp_p_find_boundaries_and_starting_index_and_value7_fu_922.i_c_U", "Parent" : "10"},
	{"ID" : "22", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_alignedtoline_per_layer_loop3_fu_1250.grp_p_find_boundaries_and_starting_index_and_value7_fu_922.i_c7_U", "Parent" : "10"},
	{"ID" : "23", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_alignedtoline_per_layer_loop3_fu_1250.dcmp_64ns_64ns_1_2_no_dsp_1_U42", "Parent" : "8"},
	{"ID" : "24", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_alignedtoline_per_layer_loop3_fu_1250.mul_33s_25ns_58_1_1_U43", "Parent" : "8"},
	{"ID" : "25", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_alignedtoline_per_layer_loop3_fu_1250.mul_78s_108ns_185_1_1_U44", "Parent" : "8"},
	{"ID" : "26", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.grp_getParallelograms_fu_1285", "Parent" : "0", "Child" : ["27", "28", "32"],
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
					{"ID" : "28", "SubInstance" : "grp_straightLineProjectorFromLayerIJtoK_fu_541", "Port" : "get_radiiradii"}]},
			{"Name" : "get_parallelogram_slopesparallelogram_slopes", "Type" : "Memory", "Direction" : "I"}]},
	{"ID" : "27", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_getParallelograms_fu_1285.get_parallelogram_slopesparallelogram_slopes_U", "Parent" : "26"},
	{"ID" : "28", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_getParallelograms_fu_1285.grp_straightLineProjectorFromLayerIJtoK_fu_541", "Parent" : "26", "Child" : ["29", "30", "31"],
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
	{"ID" : "29", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_getParallelograms_fu_1285.grp_straightLineProjectorFromLayerIJtoK_fu_541.get_radiiradii_U", "Parent" : "28"},
	{"ID" : "30", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_getParallelograms_fu_1285.grp_straightLineProjectorFromLayerIJtoK_fu_541.sdiv_46ns_26s_32_50_1_U60", "Parent" : "28"},
	{"ID" : "31", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_getParallelograms_fu_1285.grp_straightLineProjectorFromLayerIJtoK_fu_541.mul_33s_32s_52_1_1_U61", "Parent" : "28"},
	{"ID" : "32", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_getParallelograms_fu_1285.fpext_32ns_64_1_no_dsp_1_U67", "Parent" : "26"},
	{"ID" : "33", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.grp_get_index_from_z_fu_1317", "Parent" : "0", "Child" : ["34", "35", "36"],
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
	{"ID" : "34", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_get_index_from_z_fu_1317.fsub_32ns_32ns_32_3_full_dsp_1_U106", "Parent" : "33"},
	{"ID" : "35", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_get_index_from_z_fu_1317.fpext_32ns_64_1_no_dsp_1_U107", "Parent" : "33"},
	{"ID" : "36", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_get_index_from_z_fu_1317.fcmp_32ns_32ns_1_2_no_dsp_1_U108", "Parent" : "33"},
	{"ID" : "37", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.grp_patch_buffer_add_patch2_fu_1330", "Parent" : "0",
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
	{"ID" : "38", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.grp_get_acceptanceCorners_fu_1341", "Parent" : "0", "Child" : ["39", "40", "41", "42"],
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
	{"ID" : "39", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_get_acceptanceCorners_fu_1341.a_corner_list_V_U", "Parent" : "38"},
	{"ID" : "40", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_get_acceptanceCorners_fu_1341.b_corner_list_V_U", "Parent" : "38"},
	{"ID" : "41", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_get_acceptanceCorners_fu_1341.c_corner_list_V_U", "Parent" : "38"},
	{"ID" : "42", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_get_acceptanceCorners_fu_1341.d_corner_list_V_U", "Parent" : "38"},
	{"ID" : "43", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.fsub_32ns_32ns_32_3_full_dsp_1_U113", "Parent" : "0"},
	{"ID" : "44", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.uitofp_32ns_32_2_no_dsp_1_U114", "Parent" : "0"},
	{"ID" : "45", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.fpext_32ns_64_2_no_dsp_1_U115", "Parent" : "0"},
	{"ID" : "46", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.fcmp_32ns_32ns_1_2_no_dsp_1_U116", "Parent" : "0"},
	{"ID" : "47", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.dcmp_64ns_64ns_1_2_no_dsp_1_U117", "Parent" : "0"},
	{"ID" : "48", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_46s_55ns_100_1_1_U118", "Parent" : "0"},
	{"ID" : "49", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_33s_24s_52_1_1_U119", "Parent" : "0"},
	{"ID" : "50", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sdiv_46ns_26s_32_50_1_U120", "Parent" : "0"},
	{"ID" : "51", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_33s_32s_52_1_1_U121", "Parent" : "0"},
	{"ID" : "52", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_33s_32s_64_1_1_U122", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
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
	, {"Name" : "Interval", "Min" : "-1", "Max" : "-1"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
	{"Pipeline" : "1", "EnableSignal" : "ap_enable_pp1"}
	{"Pipeline" : "2", "EnableSignal" : "ap_enable_pp2"}
	{"Pipeline" : "3", "EnableSignal" : "ap_enable_pp3"}
	{"Pipeline" : "4", "EnableSignal" : "ap_enable_pp4"}
	{"Pipeline" : "5", "EnableSignal" : "ap_enable_pp5"}
	{"Pipeline" : "6", "EnableSignal" : "ap_enable_pp6"}
	{"Pipeline" : "7", "EnableSignal" : "ap_enable_pp7"}
	{"Pipeline" : "8", "EnableSignal" : "ap_enable_pp8"}
	{"Pipeline" : "9", "EnableSignal" : "ap_enable_pp9"}
	{"Pipeline" : "10", "EnableSignal" : "ap_enable_pp10"}
	{"Pipeline" : "11", "EnableSignal" : "ap_enable_pp11"}
]}

set Spec2ImplPortList { 
	points { ap_memory {  { points_address0 mem_address 1 12 }  { points_ce0 mem_ce 1 1 }  { points_q0 mem_dout 0 128 }  { points_address1 MemPortADDR2 1 12 }  { points_ce1 MemPortCE2 1 1 }  { points_q1 MemPortDOUT2 0 128 } } }
	num_points { ap_memory {  { num_points_address0 mem_address 1 3 }  { num_points_ce0 mem_ce 1 1 }  { num_points_q0 mem_dout 0 32 }  { num_points_address1 MemPortADDR2 1 3 }  { num_points_ce1 MemPortCE2 1 1 }  { num_points_q1 MemPortDOUT2 0 32 } } }
	patch_stream_V { ap_fifo {  { patch_stream_V_din fifo_data 1 96 }  { patch_stream_V_full_n fifo_status 0 1 }  { patch_stream_V_write fifo_update 1 1 } } }
	patch_buffer { ap_memory {  { patch_buffer_address0 mem_address 1 8 }  { patch_buffer_ce0 mem_ce 1 1 }  { patch_buffer_we0 mem_we 1 1 }  { patch_buffer_d0 mem_din 1 32 }  { patch_buffer_q0 mem_dout 0 32 }  { patch_buffer_address1 MemPortADDR2 1 8 }  { patch_buffer_ce1 MemPortCE2 1 1 }  { patch_buffer_we1 MemPortWE2 1 1 }  { patch_buffer_d1 MemPortDIN2 1 32 }  { patch_buffer_q1 MemPortDOUT2 0 32 } } }
	pSlope { ap_memory {  { pSlope_address0 mem_address 1 4 }  { pSlope_ce0 mem_ce 1 1 }  { pSlope_we0 mem_we 1 1 }  { pSlope_d0 mem_din 1 32 } } }
	shadow_bottomL_jR { ap_memory {  { shadow_bottomL_jR_address0 mem_address 1 4 }  { shadow_bottomL_jR_ce0 mem_ce 1 1 }  { shadow_bottomL_jR_we0 mem_we 1 1 }  { shadow_bottomL_jR_d0 mem_din 1 32 }  { shadow_bottomL_jR_q0 mem_dout 0 32 }  { shadow_bottomL_jR_address1 MemPortADDR2 1 4 }  { shadow_bottomL_jR_ce1 MemPortCE2 1 1 }  { shadow_bottomL_jR_q1 MemPortDOUT2 0 32 } } }
	shadow_bottomR_jR { ap_memory {  { shadow_bottomR_jR_address0 mem_address 1 4 }  { shadow_bottomR_jR_ce0 mem_ce 1 1 }  { shadow_bottomR_jR_we0 mem_we 1 1 }  { shadow_bottomR_jR_d0 mem_din 1 32 }  { shadow_bottomR_jR_q0 mem_dout 0 32 }  { shadow_bottomR_jR_address1 MemPortADDR2 1 4 }  { shadow_bottomR_jR_ce1 MemPortCE2 1 1 }  { shadow_bottomR_jR_q1 MemPortDOUT2 0 32 } } }
	shadow_bottomL_jL { ap_memory {  { shadow_bottomL_jL_address0 mem_address 1 4 }  { shadow_bottomL_jL_ce0 mem_ce 1 1 }  { shadow_bottomL_jL_we0 mem_we 1 1 }  { shadow_bottomL_jL_d0 mem_din 1 32 }  { shadow_bottomL_jL_q0 mem_dout 0 32 }  { shadow_bottomL_jL_address1 MemPortADDR2 1 4 }  { shadow_bottomL_jL_ce1 MemPortCE2 1 1 }  { shadow_bottomL_jL_q1 MemPortDOUT2 0 32 } } }
	shadow_bottomR_jL { ap_memory {  { shadow_bottomR_jL_address0 mem_address 1 4 }  { shadow_bottomR_jL_ce0 mem_ce 1 1 }  { shadow_bottomR_jL_we0 mem_we 1 1 }  { shadow_bottomR_jL_d0 mem_din 1 32 }  { shadow_bottomR_jL_q0 mem_dout 0 32 }  { shadow_bottomR_jL_address1 MemPortADDR2 1 4 }  { shadow_bottomR_jL_ce1 MemPortCE2 1 1 }  { shadow_bottomR_jL_q1 MemPortDOUT2 0 32 } } }
	z1_min { ap_memory {  { z1_min_address0 mem_address 1 4 }  { z1_min_ce0 mem_ce 1 1 }  { z1_min_we0 mem_we 1 1 }  { z1_min_d0 mem_din 1 26 }  { z1_min_q0 mem_dout 0 26 } } }
	z1_max { ap_memory {  { z1_max_address0 mem_address 1 4 }  { z1_max_ce0 mem_ce 1 1 }  { z1_max_we0 mem_we 1 1 }  { z1_max_d0 mem_din 1 26 }  { z1_max_q0 mem_dout 0 26 } } }
	a_corner_0 { ap_memory {  { a_corner_0_address0 mem_address 1 2 }  { a_corner_0_ce0 mem_ce 1 1 }  { a_corner_0_we0 mem_we 1 1 }  { a_corner_0_d0 mem_din 1 26 } } }
	a_corner_1 { ap_memory {  { a_corner_1_address0 mem_address 1 2 }  { a_corner_1_ce0 mem_ce 1 1 }  { a_corner_1_we0 mem_we 1 1 }  { a_corner_1_d0 mem_din 1 32 }  { a_corner_1_q0 mem_dout 0 32 } } }
	b_corner_0 { ap_memory {  { b_corner_0_address0 mem_address 1 2 }  { b_corner_0_ce0 mem_ce 1 1 }  { b_corner_0_we0 mem_we 1 1 }  { b_corner_0_d0 mem_din 1 26 } } }
	b_corner_1 { ap_memory {  { b_corner_1_address0 mem_address 1 2 }  { b_corner_1_ce0 mem_ce 1 1 }  { b_corner_1_we0 mem_we 1 1 }  { b_corner_1_d0 mem_din 1 32 }  { b_corner_1_q0 mem_dout 0 32 } } }
	c_corner_0 { ap_memory {  { c_corner_0_address0 mem_address 1 2 }  { c_corner_0_ce0 mem_ce 1 1 }  { c_corner_0_we0 mem_we 1 1 }  { c_corner_0_d0 mem_din 1 26 }  { c_corner_0_q0 mem_dout 0 26 } } }
	c_corner_1 { ap_memory {  { c_corner_1_address0 mem_address 1 2 }  { c_corner_1_ce0 mem_ce 1 1 }  { c_corner_1_we0 mem_we 1 1 }  { c_corner_1_d0 mem_din 1 32 }  { c_corner_1_q0 mem_dout 0 32 } } }
	d_corner_0 { ap_memory {  { d_corner_0_address0 mem_address 1 2 }  { d_corner_0_ce0 mem_ce 1 1 }  { d_corner_0_we0 mem_we 1 1 }  { d_corner_0_d0 mem_din 1 26 } } }
	d_corner_1 { ap_memory {  { d_corner_1_address0 mem_address 1 2 }  { d_corner_1_ce0 mem_ce 1 1 }  { d_corner_1_we0 mem_we 1 1 }  { d_corner_1_d0 mem_din 1 32 }  { d_corner_1_q0 mem_dout 0 32 } } }
	squareAcceptance { ap_memory {  { squareAcceptance_address0 mem_address 1 2 }  { squareAcceptance_ce0 mem_ce 1 1 }  { squareAcceptance_we0 mem_we 1 1 }  { squareAcceptance_d0 mem_din 1 1 }  { squareAcceptance_q0 mem_dout 0 1 } } }
	flatTop { ap_memory {  { flatTop_address0 mem_address 1 2 }  { flatTop_ce0 mem_ce 1 1 }  { flatTop_we0 mem_we 1 1 }  { flatTop_d0 mem_din 1 1 } } }
	flatBottom { ap_memory {  { flatBottom_address0 mem_address 1 2 }  { flatBottom_ce0 mem_ce 1 1 }  { flatBottom_we0 mem_we 1 1 }  { flatBottom_d0 mem_din 1 1 }  { flatBottom_q0 mem_dout 0 1 } } }
	triangleAcceptance { ap_memory {  { triangleAcceptance_address0 mem_address 1 2 }  { triangleAcceptance_ce0 mem_ce 1 1 }  { triangleAcceptance_we0 mem_we 1 1 }  { triangleAcceptance_d0 mem_din 1 1 }  { triangleAcceptance_q0 mem_dout 0 1 } } }
	latest_patch_index_constprop { ap_ovld {  { latest_patch_index_constprop_i in_data 0 2 }  { latest_patch_index_constprop_o out_data 1 2 }  { latest_patch_index_constprop_o_ap_vld out_vld 1 1 } } }
	num_patches_constprop { ap_ovld {  { num_patches_constprop_i in_data 0 32 }  { num_patches_constprop_o out_data 1 32 }  { num_patches_constprop_o_ap_vld out_vld 1 1 } } }
}
