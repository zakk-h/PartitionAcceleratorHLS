// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Version: 2020.2
// Copyright (C) Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module MPSQ_get_acceptanceCorners (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        wp_parameters_address0,
        wp_parameters_ce0,
        wp_parameters_we0,
        wp_parameters_d0,
        wp_parameters_q0,
        wp_parameters_address1,
        wp_parameters_ce1,
        wp_parameters_we1,
        wp_parameters_d1,
        wp_parameters_q1
);

parameter    ap_ST_fsm_state1 = 20'd1;
parameter    ap_ST_fsm_state2 = 20'd2;
parameter    ap_ST_fsm_state3 = 20'd4;
parameter    ap_ST_fsm_pp0_stage0 = 20'd8;
parameter    ap_ST_fsm_pp0_stage1 = 20'd16;
parameter    ap_ST_fsm_state7 = 20'd32;
parameter    ap_ST_fsm_state8 = 20'd64;
parameter    ap_ST_fsm_state9 = 20'd128;
parameter    ap_ST_fsm_state10 = 20'd256;
parameter    ap_ST_fsm_state11 = 20'd512;
parameter    ap_ST_fsm_state12 = 20'd1024;
parameter    ap_ST_fsm_state13 = 20'd2048;
parameter    ap_ST_fsm_state14 = 20'd4096;
parameter    ap_ST_fsm_state15 = 20'd8192;
parameter    ap_ST_fsm_state16 = 20'd16384;
parameter    ap_ST_fsm_state17 = 20'd32768;
parameter    ap_ST_fsm_state18 = 20'd65536;
parameter    ap_ST_fsm_state19 = 20'd131072;
parameter    ap_ST_fsm_state20 = 20'd262144;
parameter    ap_ST_fsm_state21 = 20'd524288;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
output  [6:0] wp_parameters_address0;
output   wp_parameters_ce0;
output   wp_parameters_we0;
output  [31:0] wp_parameters_d0;
input  [31:0] wp_parameters_q0;
output  [6:0] wp_parameters_address1;
output   wp_parameters_ce1;
output   wp_parameters_we1;
output  [31:0] wp_parameters_d1;
input  [31:0] wp_parameters_q1;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg[6:0] wp_parameters_address0;
reg wp_parameters_ce0;
reg wp_parameters_we0;
reg[31:0] wp_parameters_d0;
reg[6:0] wp_parameters_address1;
reg wp_parameters_ce1;
reg wp_parameters_we1;
reg[31:0] wp_parameters_d1;

(* fsm_encoding = "none" *) reg   [19:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg   [31:0] i_reg_272;
reg   [31:0] d_corner_max_V_reg_283;
reg   [31:0] c_corner_max_V_reg_296;
reg   [31:0] b_corner_min_V_reg_309;
reg   [31:0] a_corner_min_V_reg_323;
reg   [31:0] reg_350;
wire    ap_CS_fsm_state2;
wire    ap_CS_fsm_state8;
reg   [31:0] reg_356;
wire    ap_CS_fsm_pp0_stage1;
reg    ap_enable_reg_pp0_iter0;
wire    ap_block_state5_pp0_stage1_iter0;
wire    ap_block_pp0_stage1_11001;
reg   [0:0] icmp_ln248_reg_633;
wire   [6:0] wp_parameters_addr_reg_534;
wire   [6:0] wp_parameters_addr_7_reg_545;
wire    ap_CS_fsm_state3;
wire   [6:0] wp_parameters_addr_8_reg_551;
wire   [31:0] add_ln248_fu_362_p2;
reg   [31:0] add_ln248_reg_628;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_block_state4_pp0_stage0_iter0;
wire    ap_block_state6_pp0_stage0_iter1;
wire    ap_block_pp0_stage0_11001;
wire   [0:0] icmp_ln248_fu_368_p2;
wire   [6:0] sub_ln878_fu_398_p2;
reg   [6:0] sub_ln878_reg_637;
wire   [0:0] icmp_ln878_fu_440_p2;
reg   [0:0] icmp_ln878_reg_663;
reg   [31:0] b_corner_min_V_1_reg_668;
wire   [0:0] icmp_ln878_9_fu_446_p2;
reg   [0:0] icmp_ln878_9_reg_673;
wire   [31:0] a_corner_min_V_1_fu_452_p3;
reg    ap_enable_reg_pp0_iter1;
wire   [31:0] b_corner_min_V_2_fu_459_p3;
wire   [31:0] c_corner_max_V_1_fu_471_p3;
wire   [31:0] d_corner_max_V_2_fu_485_p3;
wire   [0:0] icmp_ln874_fu_493_p2;
reg   [0:0] icmp_ln874_reg_698;
wire    ap_CS_fsm_state9;
wire   [0:0] icmp_ln886_8_fu_517_p2;
reg   [0:0] icmp_ln886_8_reg_711;
wire    ap_CS_fsm_state18;
wire   [0:0] icmp_ln878_10_fu_523_p2;
reg   [0:0] icmp_ln878_10_reg_715;
wire    ap_CS_fsm_state20;
wire    ap_block_pp0_stage0_subdone;
reg    ap_condition_pp0_exit_iter0_state4;
wire    ap_block_pp0_stage1_subdone;
reg   [31:0] ap_phi_mux_i_phi_fu_276_p4;
wire    ap_block_pp0_stage0;
reg   [31:0] arrayidx1796519_load_0_reg_336;
wire   [63:0] zext_ln878_fu_404_p1;
wire   [63:0] zext_ln878_1_fu_415_p1;
wire   [63:0] zext_ln886_fu_425_p1;
wire    ap_block_pp0_stage1;
wire   [63:0] zext_ln886_1_fu_435_p1;
wire    ap_CS_fsm_state7;
wire    ap_CS_fsm_state10;
wire    ap_CS_fsm_state11;
wire    ap_CS_fsm_state12;
wire    ap_CS_fsm_state13;
wire    ap_CS_fsm_state14;
wire   [0:0] icmp_ln874_1_fu_499_p2;
wire    ap_CS_fsm_state15;
wire    ap_CS_fsm_state16;
wire   [0:0] icmp_ln874_2_fu_505_p2;
wire    ap_CS_fsm_state17;
wire   [0:0] icmp_ln874_3_fu_511_p2;
wire    ap_CS_fsm_state19;
wire    ap_CS_fsm_state21;
wire   [3:0] trunc_ln878_fu_374_p1;
wire   [5:0] trunc_ln878_1_fu_386_p1;
wire   [6:0] tmp_cast_fu_378_p3;
wire   [6:0] tmp_49_cast_fu_390_p3;
wire   [6:0] or_ln878_fu_409_p2;
wire   [6:0] add_ln886_fu_420_p2;
wire   [6:0] add_ln886_2_fu_430_p2;
wire   [0:0] icmp_ln886_fu_465_p2;
wire   [0:0] icmp_ln886_7_fu_479_p2;
reg   [19:0] ap_NS_fsm;
reg    ap_idle_pp0;
wire    ap_enable_pp0;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_fsm = 20'd1;
#0 ap_enable_reg_pp0_iter0 = 1'b0;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter0 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_condition_pp0_exit_iter0_state4) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_enable_reg_pp0_iter0 <= 1'b0;
        end else if ((1'b1 == ap_CS_fsm_state3)) begin
            ap_enable_reg_pp0_iter0 <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if ((((1'b0 == ap_block_pp0_stage1_subdone) & (1'b1 == ap_CS_fsm_pp0_stage1)) | ((1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b0) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
            ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
        end else if ((1'b1 == ap_CS_fsm_state3)) begin
            ap_enable_reg_pp0_iter1 <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln248_reg_633 == 1'd0) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1))) begin
        a_corner_min_V_reg_323 <= a_corner_min_V_1_fu_452_p3;
    end else if ((1'b1 == ap_CS_fsm_state3)) begin
        a_corner_min_V_reg_323 <= 32'd4294967295;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_state18) & (icmp_ln886_8_fu_517_p2 == 1'd0))) begin
        arrayidx1796519_load_0_reg_336 <= c_corner_max_V_reg_296;
    end else if (((1'b1 == ap_CS_fsm_state20) & (icmp_ln886_8_reg_711 == 1'd1))) begin
        arrayidx1796519_load_0_reg_336 <= b_corner_min_V_reg_309;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln248_reg_633 == 1'd0) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1))) begin
        b_corner_min_V_reg_309 <= b_corner_min_V_2_fu_459_p3;
    end else if ((1'b1 == ap_CS_fsm_state3)) begin
        b_corner_min_V_reg_309 <= 32'd4294967295;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln248_reg_633 == 1'd0) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1))) begin
        c_corner_max_V_reg_296 <= c_corner_max_V_1_fu_471_p3;
    end else if ((1'b1 == ap_CS_fsm_state3)) begin
        c_corner_max_V_reg_296 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln248_reg_633 == 1'd0) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1))) begin
        d_corner_max_V_reg_283 <= d_corner_max_V_2_fu_485_p3;
    end else if ((1'b1 == ap_CS_fsm_state3)) begin
        d_corner_max_V_reg_283 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln248_reg_633 == 1'd0) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1))) begin
        i_reg_272 <= add_ln248_reg_628;
    end else if ((1'b1 == ap_CS_fsm_state3)) begin
        i_reg_272 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state8)) begin
        reg_356 <= wp_parameters_q1;
    end else if (((icmp_ln248_reg_633 == 1'd0) & (1'b0 == ap_block_pp0_stage1_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
        reg_356 <= wp_parameters_q0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        add_ln248_reg_628 <= add_ln248_fu_362_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln248_reg_633 == 1'd0) & (1'b0 == ap_block_pp0_stage1_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
        b_corner_min_V_1_reg_668 <= wp_parameters_q1;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        icmp_ln248_reg_633 <= icmp_ln248_fu_368_p2;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state9)) begin
        icmp_ln874_reg_698 <= icmp_ln874_fu_493_p2;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state20)) begin
        icmp_ln878_10_reg_715 <= icmp_ln878_10_fu_523_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln248_reg_633 == 1'd0) & (1'b0 == ap_block_pp0_stage1_11001) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
        icmp_ln878_9_reg_673 <= icmp_ln878_9_fu_446_p2;
        icmp_ln878_reg_663 <= icmp_ln878_fu_440_p2;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state18)) begin
        icmp_ln886_8_reg_711 <= icmp_ln886_8_fu_517_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_state8) | (1'b1 == ap_CS_fsm_state2))) begin
        reg_350 <= wp_parameters_q0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln248_fu_368_p2 == 1'd0))) begin
        sub_ln878_reg_637[6 : 1] <= sub_ln878_fu_398_p2[6 : 1];
    end
end

always @ (*) begin
    if ((icmp_ln248_fu_368_p2 == 1'd1)) begin
        ap_condition_pp0_exit_iter0_state4 = 1'b1;
    end else begin
        ap_condition_pp0_exit_iter0_state4 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state21) | ((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1)))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter0 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln248_reg_633 == 1'd0) & (1'b0 == ap_block_pp0_stage0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1))) begin
        ap_phi_mux_i_phi_fu_276_p4 = add_ln248_reg_628;
    end else begin
        ap_phi_mux_i_phi_fu_276_p4 = i_reg_272;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state21)) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state20)) begin
        wp_parameters_address0 = 64'd49;
    end else if ((1'b1 == ap_CS_fsm_state19)) begin
        wp_parameters_address0 = 64'd90;
    end else if ((1'b1 == ap_CS_fsm_state17)) begin
        wp_parameters_address0 = 64'd21;
    end else if ((1'b1 == ap_CS_fsm_state16)) begin
        wp_parameters_address0 = wp_parameters_addr_7_reg_545;
    end else if (((1'b1 == ap_CS_fsm_state14) | (1'b1 == ap_CS_fsm_state18))) begin
        wp_parameters_address0 = 64'd84;
    end else if ((1'b1 == ap_CS_fsm_state13)) begin
        wp_parameters_address0 = 64'd19;
    end else if ((1'b1 == ap_CS_fsm_state12)) begin
        wp_parameters_address0 = 64'd66;
    end else if ((1'b1 == ap_CS_fsm_state11)) begin
        wp_parameters_address0 = 64'd54;
    end else if ((1'b1 == ap_CS_fsm_state10)) begin
        wp_parameters_address0 = 64'd48;
    end else if (((1'b1 == ap_CS_fsm_state21) | (1'b1 == ap_CS_fsm_state9))) begin
        wp_parameters_address0 = 64'd55;
    end else if ((1'b1 == ap_CS_fsm_state8)) begin
        wp_parameters_address0 = 64'd18;
    end else if ((1'b1 == ap_CS_fsm_state7)) begin
        wp_parameters_address0 = 64'd4;
    end else if (((1'b0 == ap_block_pp0_stage1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
        wp_parameters_address0 = zext_ln886_fu_425_p1;
    end else if (((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        wp_parameters_address0 = zext_ln878_fu_404_p1;
    end else if ((1'b1 == ap_CS_fsm_state3)) begin
        wp_parameters_address0 = 64'd72;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        wp_parameters_address0 = 64'd78;
    end else if ((1'b1 == ap_CS_fsm_state1)) begin
        wp_parameters_address0 = 64'd108;
    end else begin
        wp_parameters_address0 = 'bx;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state20)) begin
        wp_parameters_address1 = wp_parameters_addr_8_reg_551;
    end else if ((1'b1 == ap_CS_fsm_state18)) begin
        wp_parameters_address1 = 64'd72;
    end else if ((1'b1 == ap_CS_fsm_state15)) begin
        wp_parameters_address1 = 64'd20;
    end else if (((1'b1 == ap_CS_fsm_state14) | (1'b1 == ap_CS_fsm_state13))) begin
        wp_parameters_address1 = 64'd78;
    end else if (((1'b1 == ap_CS_fsm_state16) | (1'b1 == ap_CS_fsm_state12))) begin
        wp_parameters_address1 = wp_parameters_addr_reg_534;
    end else if ((1'b1 == ap_CS_fsm_state11)) begin
        wp_parameters_address1 = 64'd60;
    end else if (((1'b1 == ap_CS_fsm_state21) | (1'b1 == ap_CS_fsm_state10))) begin
        wp_parameters_address1 = 64'd67;
    end else if (((1'b1 == ap_CS_fsm_state19) | (1'b1 == ap_CS_fsm_state9))) begin
        wp_parameters_address1 = 64'd61;
    end else if ((1'b1 == ap_CS_fsm_state8)) begin
        wp_parameters_address1 = 64'd49;
    end else if ((1'b1 == ap_CS_fsm_state7)) begin
        wp_parameters_address1 = 64'd5;
    end else if (((1'b0 == ap_block_pp0_stage1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
        wp_parameters_address1 = zext_ln886_1_fu_435_p1;
    end else if (((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        wp_parameters_address1 = zext_ln878_1_fu_415_p1;
    end else if ((1'b1 == ap_CS_fsm_state3)) begin
        wp_parameters_address1 = 64'd90;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        wp_parameters_address1 = 64'd84;
    end else begin
        wp_parameters_address1 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state8) | (1'b1 == ap_CS_fsm_state2) | (1'b1 == ap_CS_fsm_state21) | (1'b1 == ap_CS_fsm_state19) | (1'b1 == ap_CS_fsm_state17) | (1'b1 == ap_CS_fsm_state16) | (1'b1 == ap_CS_fsm_state14) | (1'b1 == ap_CS_fsm_state13) | (1'b1 == ap_CS_fsm_state12) | (1'b1 == ap_CS_fsm_state11) | (1'b1 == ap_CS_fsm_state10) | (1'b1 == ap_CS_fsm_state7) | (1'b1 == ap_CS_fsm_state20) | (1'b1 == ap_CS_fsm_state18) | (1'b1 == ap_CS_fsm_state9) | (1'b1 == ap_CS_fsm_state3) | ((1'b0 == ap_block_pp0_stage1_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1)) | ((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)) | ((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        wp_parameters_ce0 = 1'b1;
    end else begin
        wp_parameters_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state8) | (1'b1 == ap_CS_fsm_state2) | (1'b1 == ap_CS_fsm_state21) | (1'b1 == ap_CS_fsm_state19) | (1'b1 == ap_CS_fsm_state16) | (1'b1 == ap_CS_fsm_state15) | (1'b1 == ap_CS_fsm_state14) | (1'b1 == ap_CS_fsm_state13) | (1'b1 == ap_CS_fsm_state12) | (1'b1 == ap_CS_fsm_state11) | (1'b1 == ap_CS_fsm_state10) | (1'b1 == ap_CS_fsm_state7) | (1'b1 == ap_CS_fsm_state20) | (1'b1 == ap_CS_fsm_state18) | (1'b1 == ap_CS_fsm_state9) | (1'b1 == ap_CS_fsm_state3) | ((1'b0 == ap_block_pp0_stage1_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1)) | ((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        wp_parameters_ce1 = 1'b1;
    end else begin
        wp_parameters_ce1 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state21)) begin
        wp_parameters_d0 = arrayidx1796519_load_0_reg_336;
    end else if (((1'b1 == ap_CS_fsm_state16) | (1'b1 == ap_CS_fsm_state14) | (1'b1 == ap_CS_fsm_state18))) begin
        wp_parameters_d0 = 32'd0;
    end else if (((1'b1 == ap_CS_fsm_state12) | (1'b1 == ap_CS_fsm_state11))) begin
        wp_parameters_d0 = reg_356;
    end else if ((1'b1 == ap_CS_fsm_state10)) begin
        wp_parameters_d0 = reg_350;
    end else if (((1'b1 == ap_CS_fsm_state20) | (1'b1 == ap_CS_fsm_state9))) begin
        wp_parameters_d0 = b_corner_min_V_reg_309;
    end else if (((1'b1 == ap_CS_fsm_state2) | (1'b1 == ap_CS_fsm_state19) | (1'b1 == ap_CS_fsm_state3))) begin
        wp_parameters_d0 = 32'd1;
    end else begin
        wp_parameters_d0 = 'bx;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state21)) begin
        wp_parameters_d1 = arrayidx1796519_load_0_reg_336;
    end else if ((1'b1 == ap_CS_fsm_state19)) begin
        wp_parameters_d1 = b_corner_min_V_reg_309;
    end else if ((1'b1 == ap_CS_fsm_state11)) begin
        wp_parameters_d1 = reg_350;
    end else if ((1'b1 == ap_CS_fsm_state10)) begin
        wp_parameters_d1 = d_corner_max_V_reg_283;
    end else if ((1'b1 == ap_CS_fsm_state9)) begin
        wp_parameters_d1 = c_corner_max_V_reg_296;
    end else if ((1'b1 == ap_CS_fsm_state8)) begin
        wp_parameters_d1 = a_corner_min_V_reg_323;
    end else if (((1'b1 == ap_CS_fsm_state16) | (1'b1 == ap_CS_fsm_state14) | (1'b1 == ap_CS_fsm_state13) | (1'b1 == ap_CS_fsm_state12) | (1'b1 == ap_CS_fsm_state18) | (1'b1 == ap_CS_fsm_state3))) begin
        wp_parameters_d1 = 32'd0;
    end else if (((1'b1 == ap_CS_fsm_state2) | (1'b1 == ap_CS_fsm_state20))) begin
        wp_parameters_d1 = 32'd1;
    end else begin
        wp_parameters_d1 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state2) | (1'b1 == ap_CS_fsm_state19) | (1'b1 == ap_CS_fsm_state12) | (1'b1 == ap_CS_fsm_state11) | (1'b1 == ap_CS_fsm_state10) | (1'b1 == ap_CS_fsm_state9) | (1'b1 == ap_CS_fsm_state3) | ((icmp_ln878_10_reg_715 == 1'd1) & (1'b1 == ap_CS_fsm_state21)) | ((icmp_ln874_3_fu_511_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state18)) | ((icmp_ln874_2_fu_505_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state16)) | ((icmp_ln874_1_fu_499_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state14)) | ((1'b1 == ap_CS_fsm_state20) & (icmp_ln886_8_reg_711 == 1'd1)))) begin
        wp_parameters_we0 = 1'b1;
    end else begin
        wp_parameters_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state8) | (1'b1 == ap_CS_fsm_state2) | (1'b1 == ap_CS_fsm_state19) | (1'b1 == ap_CS_fsm_state11) | (1'b1 == ap_CS_fsm_state10) | (1'b1 == ap_CS_fsm_state9) | (1'b1 == ap_CS_fsm_state3) | ((icmp_ln878_10_reg_715 == 1'd1) & (1'b1 == ap_CS_fsm_state21)) | ((icmp_ln874_3_fu_511_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state18)) | ((icmp_ln874_2_fu_505_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state16)) | ((icmp_ln874_1_fu_499_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state14)) | ((1'b1 == ap_CS_fsm_state13) & (icmp_ln874_reg_698 == 1'd0)) | ((1'b1 == ap_CS_fsm_state12) & (icmp_ln874_reg_698 == 1'd0)) | ((1'b1 == ap_CS_fsm_state20) & (icmp_ln878_10_fu_523_p2 == 1'd1)))) begin
        wp_parameters_we1 = 1'b1;
    end else begin
        wp_parameters_we1 = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        ap_ST_fsm_state3 : begin
            ap_NS_fsm = ap_ST_fsm_pp0_stage0;
        end
        ap_ST_fsm_pp0_stage0 : begin
            if ((~((1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (icmp_ln248_fu_368_p2 == 1'd1)) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage1;
            end else if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (icmp_ln248_fu_368_p2 == 1'd1))) begin
                ap_NS_fsm = ap_ST_fsm_state7;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end
        end
        ap_ST_fsm_pp0_stage1 : begin
            if ((1'b0 == ap_block_pp0_stage1_subdone)) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage1;
            end
        end
        ap_ST_fsm_state7 : begin
            ap_NS_fsm = ap_ST_fsm_state8;
        end
        ap_ST_fsm_state8 : begin
            ap_NS_fsm = ap_ST_fsm_state9;
        end
        ap_ST_fsm_state9 : begin
            ap_NS_fsm = ap_ST_fsm_state10;
        end
        ap_ST_fsm_state10 : begin
            ap_NS_fsm = ap_ST_fsm_state11;
        end
        ap_ST_fsm_state11 : begin
            ap_NS_fsm = ap_ST_fsm_state12;
        end
        ap_ST_fsm_state12 : begin
            ap_NS_fsm = ap_ST_fsm_state13;
        end
        ap_ST_fsm_state13 : begin
            ap_NS_fsm = ap_ST_fsm_state14;
        end
        ap_ST_fsm_state14 : begin
            ap_NS_fsm = ap_ST_fsm_state15;
        end
        ap_ST_fsm_state15 : begin
            ap_NS_fsm = ap_ST_fsm_state16;
        end
        ap_ST_fsm_state16 : begin
            ap_NS_fsm = ap_ST_fsm_state17;
        end
        ap_ST_fsm_state17 : begin
            ap_NS_fsm = ap_ST_fsm_state18;
        end
        ap_ST_fsm_state18 : begin
            if (((1'b1 == ap_CS_fsm_state18) & (icmp_ln886_8_fu_517_p2 == 1'd0))) begin
                ap_NS_fsm = ap_ST_fsm_state20;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state19;
            end
        end
        ap_ST_fsm_state19 : begin
            ap_NS_fsm = ap_ST_fsm_state20;
        end
        ap_ST_fsm_state20 : begin
            ap_NS_fsm = ap_ST_fsm_state21;
        end
        ap_ST_fsm_state21 : begin
            ap_NS_fsm = ap_ST_fsm_state1;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign a_corner_min_V_1_fu_452_p3 = ((icmp_ln878_reg_663[0:0] == 1'b1) ? reg_356 : a_corner_min_V_reg_323);

assign add_ln248_fu_362_p2 = (ap_phi_mux_i_phi_fu_276_p4 + 32'd1);

assign add_ln886_2_fu_430_p2 = (sub_ln878_reg_637 + 7'd3);

assign add_ln886_fu_420_p2 = (sub_ln878_reg_637 + 7'd2);

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd3];

assign ap_CS_fsm_pp0_stage1 = ap_CS_fsm[32'd4];

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state10 = ap_CS_fsm[32'd8];

assign ap_CS_fsm_state11 = ap_CS_fsm[32'd9];

assign ap_CS_fsm_state12 = ap_CS_fsm[32'd10];

assign ap_CS_fsm_state13 = ap_CS_fsm[32'd11];

assign ap_CS_fsm_state14 = ap_CS_fsm[32'd12];

assign ap_CS_fsm_state15 = ap_CS_fsm[32'd13];

assign ap_CS_fsm_state16 = ap_CS_fsm[32'd14];

assign ap_CS_fsm_state17 = ap_CS_fsm[32'd15];

assign ap_CS_fsm_state18 = ap_CS_fsm[32'd16];

assign ap_CS_fsm_state19 = ap_CS_fsm[32'd17];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state20 = ap_CS_fsm[32'd18];

assign ap_CS_fsm_state21 = ap_CS_fsm[32'd19];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state7 = ap_CS_fsm[32'd5];

assign ap_CS_fsm_state8 = ap_CS_fsm[32'd6];

assign ap_CS_fsm_state9 = ap_CS_fsm[32'd7];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_11001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_subdone = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage1 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage1_11001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage1_subdone = ~(1'b1 == 1'b1);

assign ap_block_state4_pp0_stage0_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state5_pp0_stage1_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state6_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign b_corner_min_V_2_fu_459_p3 = ((icmp_ln878_9_reg_673[0:0] == 1'b1) ? b_corner_min_V_1_reg_668 : b_corner_min_V_reg_309);

assign c_corner_max_V_1_fu_471_p3 = ((icmp_ln886_fu_465_p2[0:0] == 1'b1) ? wp_parameters_q0 : c_corner_max_V_reg_296);

assign d_corner_max_V_2_fu_485_p3 = ((icmp_ln886_7_fu_479_p2[0:0] == 1'b1) ? wp_parameters_q1 : d_corner_max_V_reg_283);

assign icmp_ln248_fu_368_p2 = ((ap_phi_mux_i_phi_fu_276_p4 == reg_350) ? 1'b1 : 1'b0);

assign icmp_ln874_1_fu_499_p2 = ((b_corner_min_V_reg_309 == wp_parameters_q0) ? 1'b1 : 1'b0);

assign icmp_ln874_2_fu_505_p2 = ((c_corner_max_V_reg_296 == wp_parameters_q1) ? 1'b1 : 1'b0);

assign icmp_ln874_3_fu_511_p2 = ((d_corner_max_V_reg_283 == wp_parameters_q0) ? 1'b1 : 1'b0);

assign icmp_ln874_fu_493_p2 = ((a_corner_min_V_reg_323 == wp_parameters_q0) ? 1'b1 : 1'b0);

assign icmp_ln878_10_fu_523_p2 = (($signed(b_corner_min_V_reg_309) < $signed(d_corner_max_V_reg_283)) ? 1'b1 : 1'b0);

assign icmp_ln878_9_fu_446_p2 = (($signed(wp_parameters_q1) < $signed(b_corner_min_V_reg_309)) ? 1'b1 : 1'b0);

assign icmp_ln878_fu_440_p2 = (($signed(wp_parameters_q0) < $signed(a_corner_min_V_reg_323)) ? 1'b1 : 1'b0);

assign icmp_ln886_7_fu_479_p2 = (($signed(wp_parameters_q1) > $signed(d_corner_max_V_reg_283)) ? 1'b1 : 1'b0);

assign icmp_ln886_8_fu_517_p2 = (($signed(c_corner_max_V_reg_296) > $signed(a_corner_min_V_reg_323)) ? 1'b1 : 1'b0);

assign icmp_ln886_fu_465_p2 = (($signed(wp_parameters_q0) > $signed(c_corner_max_V_reg_296)) ? 1'b1 : 1'b0);

assign or_ln878_fu_409_p2 = (sub_ln878_fu_398_p2 | 7'd1);

assign sub_ln878_fu_398_p2 = (tmp_cast_fu_378_p3 - tmp_49_cast_fu_390_p3);

assign tmp_49_cast_fu_390_p3 = {{trunc_ln878_1_fu_386_p1}, {1'd0}};

assign tmp_cast_fu_378_p3 = {{trunc_ln878_fu_374_p1}, {3'd0}};

assign trunc_ln878_1_fu_386_p1 = ap_phi_mux_i_phi_fu_276_p4[5:0];

assign trunc_ln878_fu_374_p1 = ap_phi_mux_i_phi_fu_276_p4[3:0];

assign wp_parameters_addr_7_reg_545 = 64'd72;

assign wp_parameters_addr_8_reg_551 = 64'd90;

assign wp_parameters_addr_reg_534 = 64'd84;

assign zext_ln878_1_fu_415_p1 = or_ln878_fu_409_p2;

assign zext_ln878_fu_404_p1 = sub_ln878_fu_398_p2;

assign zext_ln886_1_fu_435_p1 = add_ln886_2_fu_430_p2;

assign zext_ln886_fu_425_p1 = add_ln886_fu_420_p2;

always @ (posedge ap_clk) begin
    sub_ln878_reg_637[0] <= 1'b0;
end

endmodule //MPSQ_get_acceptanceCorners
