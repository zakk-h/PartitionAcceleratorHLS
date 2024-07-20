# This script segment is generated automatically by AutoPilot

set id 70
set name laplacianCalculator_mux_164_32_1_1
set corename simcore_mux
set op mux
set stage_num 1
set max_latency -1
set registered_input 1
set din0_width 32
set din0_signed 0
set din1_width 32
set din1_signed 0
set din2_width 32
set din2_signed 0
set din3_width 32
set din3_signed 0
set din4_width 32
set din4_signed 0
set din5_width 32
set din5_signed 0
set din6_width 32
set din6_signed 0
set din7_width 32
set din7_signed 0
set din8_width 32
set din8_signed 0
set din9_width 32
set din9_signed 0
set din10_width 32
set din10_signed 0
set din11_width 32
set din11_signed 0
set din12_width 32
set din12_signed 0
set din13_width 32
set din13_signed 0
set din14_width 32
set din14_signed 0
set din15_width 32
set din15_signed 0
set din16_width 4
set din16_signed 0
set dout_width 32
if {${::AESL::PGuard_simmodel_gen}} {
if {[info proc ap_gen_simcore_mux] == "ap_gen_simcore_mux"} {
eval "ap_gen_simcore_mux { \
    id ${id} \
    name ${name} \
    corename ${corename} \
    op ${op} \
    reset_level 1 \
    sync_rst true \
    stage_num ${stage_num} \
    max_latency ${max_latency} \
    registered_input ${registered_input} \
    din0_width ${din0_width} \
    din0_signed ${din0_signed} \
    din1_width ${din1_width} \
    din1_signed ${din1_signed} \
    din2_width ${din2_width} \
    din2_signed ${din2_signed} \
    din3_width ${din3_width} \
    din3_signed ${din3_signed} \
    din4_width ${din4_width} \
    din4_signed ${din4_signed} \
    din5_width ${din5_width} \
    din5_signed ${din5_signed} \
    din6_width ${din6_width} \
    din6_signed ${din6_signed} \
    din7_width ${din7_width} \
    din7_signed ${din7_signed} \
    din8_width ${din8_width} \
    din8_signed ${din8_signed} \
    din9_width ${din9_width} \
    din9_signed ${din9_signed} \
    din10_width ${din10_width} \
    din10_signed ${din10_signed} \
    din11_width ${din11_width} \
    din11_signed ${din11_signed} \
    din12_width ${din12_width} \
    din12_signed ${din12_signed} \
    din13_width ${din13_width} \
    din13_signed ${din13_signed} \
    din14_width ${din14_width} \
    din14_signed ${din14_signed} \
    din15_width ${din15_width} \
    din15_signed ${din15_signed} \
    din16_width ${din16_width} \
    din16_signed ${din16_signed} \
    dout_width ${dout_width} \
}"
} else {
puts "@W \[IMPL-100\] Cannot find ap_gen_simcore_mux, check your AutoPilot builtin lib"
}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler ${name}
}


set op mux
set corename Multiplexer
if {${::AESL::PGuard_autocg_gen} && ${::AESL::PGuard_autocg_ipmgen}} {
if {[info proc ::AESL_LIB_VIRTEX::xil_gen_pipemux] == "::AESL_LIB_VIRTEX::xil_gen_pipemux"} {
eval "::AESL_LIB_VIRTEX::xil_gen_pipemux { \
    id ${id} \
    name ${name} \
    corename ${corename} \
    op ${op} \
    reset_level 1 \
    sync_rst true \
    stage_num ${stage_num} \
    max_latency ${max_latency} \
    registered_input ${registered_input} \
    din0_width ${din0_width} \
    din0_signed ${din0_signed} \
    din1_width ${din1_width} \
    din1_signed ${din1_signed} \
    din2_width ${din2_width} \
    din2_signed ${din2_signed} \
    din3_width ${din3_width} \
    din3_signed ${din3_signed} \
    din4_width ${din4_width} \
    din4_signed ${din4_signed} \
    din5_width ${din5_width} \
    din5_signed ${din5_signed} \
    din6_width ${din6_width} \
    din6_signed ${din6_signed} \
    din7_width ${din7_width} \
    din7_signed ${din7_signed} \
    din8_width ${din8_width} \
    din8_signed ${din8_signed} \
    din9_width ${din9_width} \
    din9_signed ${din9_signed} \
    din10_width ${din10_width} \
    din10_signed ${din10_signed} \
    din11_width ${din11_width} \
    din11_signed ${din11_signed} \
    din12_width ${din12_width} \
    din12_signed ${din12_signed} \
    din13_width ${din13_width} \
    din13_signed ${din13_signed} \
    din14_width ${din14_width} \
    din14_signed ${din14_signed} \
    din15_width ${din15_width} \
    din15_signed ${din15_signed} \
    din16_width ${din16_width} \
    din16_signed ${din16_signed} \
    dout_width ${dout_width} \
}"
} else {
puts "@W \[IMPL-101\] Cannot find ::AESL_LIB_VIRTEX::xil_gen_pipemux, check your platform lib"
}
}


# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 73 \
    name nodeTriplets \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename nodeTriplets \
    op interface \
    ports { nodeTriplets_address0 { O 14 vector } nodeTriplets_ce0 { O 1 bit } nodeTriplets_we0 { O 1 bit } nodeTriplets_d0 { O 16 vector } nodeTriplets_address1 { O 14 vector } nodeTriplets_ce1 { O 1 bit } nodeTriplets_we1 { O 1 bit } nodeTriplets_d1 { O 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'nodeTriplets'"
}
}


# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 74 \
    name aboveNodeList_0_0_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_aboveNodeList_0_0_read \
    op interface \
    ports { aboveNodeList_0_0_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 75 \
    name aboveNodeList_0_1_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_aboveNodeList_0_1_read \
    op interface \
    ports { aboveNodeList_0_1_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 76 \
    name aboveNodeList_1_0_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_aboveNodeList_1_0_read \
    op interface \
    ports { aboveNodeList_1_0_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 77 \
    name aboveNodeList_1_1_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_aboveNodeList_1_1_read \
    op interface \
    ports { aboveNodeList_1_1_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 78 \
    name aboveNodeList_2_0_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_aboveNodeList_2_0_read \
    op interface \
    ports { aboveNodeList_2_0_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 79 \
    name aboveNodeList_2_1_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_aboveNodeList_2_1_read \
    op interface \
    ports { aboveNodeList_2_1_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 80 \
    name aboveNodeList_3_0_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_aboveNodeList_3_0_read \
    op interface \
    ports { aboveNodeList_3_0_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 81 \
    name aboveNodeList_3_1_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_aboveNodeList_3_1_read \
    op interface \
    ports { aboveNodeList_3_1_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 82 \
    name aboveNodeList_4_0_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_aboveNodeList_4_0_read \
    op interface \
    ports { aboveNodeList_4_0_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 83 \
    name aboveNodeList_4_1_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_aboveNodeList_4_1_read \
    op interface \
    ports { aboveNodeList_4_1_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 84 \
    name aboveNodeList_5_0_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_aboveNodeList_5_0_read \
    op interface \
    ports { aboveNodeList_5_0_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 85 \
    name aboveNodeList_5_1_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_aboveNodeList_5_1_read \
    op interface \
    ports { aboveNodeList_5_1_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 86 \
    name aboveNodeList_6_0_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_aboveNodeList_6_0_read \
    op interface \
    ports { aboveNodeList_6_0_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 87 \
    name aboveNodeList_6_1_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_aboveNodeList_6_1_read \
    op interface \
    ports { aboveNodeList_6_1_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 88 \
    name aboveNodeList_7_0_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_aboveNodeList_7_0_read \
    op interface \
    ports { aboveNodeList_7_0_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 89 \
    name aboveNodeList_7_1_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_aboveNodeList_7_1_read \
    op interface \
    ports { aboveNodeList_7_1_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 90 \
    name aboveNodeList_8_0_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_aboveNodeList_8_0_read \
    op interface \
    ports { aboveNodeList_8_0_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 91 \
    name aboveNodeList_8_1_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_aboveNodeList_8_1_read \
    op interface \
    ports { aboveNodeList_8_1_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 92 \
    name aboveNodeList_9_0_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_aboveNodeList_9_0_read \
    op interface \
    ports { aboveNodeList_9_0_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 93 \
    name aboveNodeList_9_1_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_aboveNodeList_9_1_read \
    op interface \
    ports { aboveNodeList_9_1_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 94 \
    name aboveNodeList_10_0_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_aboveNodeList_10_0_read \
    op interface \
    ports { aboveNodeList_10_0_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 95 \
    name aboveNodeList_10_1_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_aboveNodeList_10_1_read \
    op interface \
    ports { aboveNodeList_10_1_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 96 \
    name aboveNodeList_11_0_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_aboveNodeList_11_0_read \
    op interface \
    ports { aboveNodeList_11_0_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 97 \
    name aboveNodeList_11_1_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_aboveNodeList_11_1_read \
    op interface \
    ports { aboveNodeList_11_1_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 98 \
    name aboveNodeList_12_0_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_aboveNodeList_12_0_read \
    op interface \
    ports { aboveNodeList_12_0_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 99 \
    name aboveNodeList_12_1_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_aboveNodeList_12_1_read \
    op interface \
    ports { aboveNodeList_12_1_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 100 \
    name aboveNodeList_13_0_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_aboveNodeList_13_0_read \
    op interface \
    ports { aboveNodeList_13_0_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 101 \
    name aboveNodeList_13_1_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_aboveNodeList_13_1_read \
    op interface \
    ports { aboveNodeList_13_1_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 102 \
    name aboveNodeList_14_0_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_aboveNodeList_14_0_read \
    op interface \
    ports { aboveNodeList_14_0_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 103 \
    name aboveNodeList_14_1_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_aboveNodeList_14_1_read \
    op interface \
    ports { aboveNodeList_14_1_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 104 \
    name aboveNodeList_15_0_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_aboveNodeList_15_0_read \
    op interface \
    ports { aboveNodeList_15_0_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 105 \
    name aboveNodeList_15_1_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_aboveNodeList_15_1_read \
    op interface \
    ports { aboveNodeList_15_1_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 106 \
    name belowNodeList_0_0_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_belowNodeList_0_0_read \
    op interface \
    ports { belowNodeList_0_0_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 107 \
    name belowNodeList_0_1_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_belowNodeList_0_1_read \
    op interface \
    ports { belowNodeList_0_1_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 108 \
    name belowNodeList_1_0_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_belowNodeList_1_0_read \
    op interface \
    ports { belowNodeList_1_0_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 109 \
    name belowNodeList_1_1_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_belowNodeList_1_1_read \
    op interface \
    ports { belowNodeList_1_1_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 110 \
    name belowNodeList_2_0_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_belowNodeList_2_0_read \
    op interface \
    ports { belowNodeList_2_0_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 111 \
    name belowNodeList_2_1_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_belowNodeList_2_1_read \
    op interface \
    ports { belowNodeList_2_1_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 112 \
    name belowNodeList_3_0_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_belowNodeList_3_0_read \
    op interface \
    ports { belowNodeList_3_0_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 113 \
    name belowNodeList_3_1_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_belowNodeList_3_1_read \
    op interface \
    ports { belowNodeList_3_1_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 114 \
    name belowNodeList_4_0_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_belowNodeList_4_0_read \
    op interface \
    ports { belowNodeList_4_0_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 115 \
    name belowNodeList_4_1_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_belowNodeList_4_1_read \
    op interface \
    ports { belowNodeList_4_1_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 116 \
    name belowNodeList_5_0_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_belowNodeList_5_0_read \
    op interface \
    ports { belowNodeList_5_0_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 117 \
    name belowNodeList_5_1_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_belowNodeList_5_1_read \
    op interface \
    ports { belowNodeList_5_1_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 118 \
    name belowNodeList_6_0_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_belowNodeList_6_0_read \
    op interface \
    ports { belowNodeList_6_0_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 119 \
    name belowNodeList_6_1_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_belowNodeList_6_1_read \
    op interface \
    ports { belowNodeList_6_1_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 120 \
    name belowNodeList_7_0_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_belowNodeList_7_0_read \
    op interface \
    ports { belowNodeList_7_0_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 121 \
    name belowNodeList_7_1_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_belowNodeList_7_1_read \
    op interface \
    ports { belowNodeList_7_1_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 122 \
    name belowNodeList_8_0_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_belowNodeList_8_0_read \
    op interface \
    ports { belowNodeList_8_0_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 123 \
    name belowNodeList_8_1_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_belowNodeList_8_1_read \
    op interface \
    ports { belowNodeList_8_1_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 124 \
    name belowNodeList_9_0_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_belowNodeList_9_0_read \
    op interface \
    ports { belowNodeList_9_0_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 125 \
    name belowNodeList_9_1_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_belowNodeList_9_1_read \
    op interface \
    ports { belowNodeList_9_1_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 126 \
    name belowNodeList_10_0_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_belowNodeList_10_0_read \
    op interface \
    ports { belowNodeList_10_0_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 127 \
    name belowNodeList_10_1_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_belowNodeList_10_1_read \
    op interface \
    ports { belowNodeList_10_1_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 128 \
    name belowNodeList_11_0_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_belowNodeList_11_0_read \
    op interface \
    ports { belowNodeList_11_0_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 129 \
    name belowNodeList_11_1_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_belowNodeList_11_1_read \
    op interface \
    ports { belowNodeList_11_1_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 130 \
    name belowNodeList_12_0_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_belowNodeList_12_0_read \
    op interface \
    ports { belowNodeList_12_0_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 131 \
    name belowNodeList_12_1_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_belowNodeList_12_1_read \
    op interface \
    ports { belowNodeList_12_1_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 132 \
    name belowNodeList_13_0_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_belowNodeList_13_0_read \
    op interface \
    ports { belowNodeList_13_0_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 133 \
    name belowNodeList_13_1_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_belowNodeList_13_1_read \
    op interface \
    ports { belowNodeList_13_1_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 134 \
    name belowNodeList_14_0_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_belowNodeList_14_0_read \
    op interface \
    ports { belowNodeList_14_0_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 135 \
    name belowNodeList_14_1_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_belowNodeList_14_1_read \
    op interface \
    ports { belowNodeList_14_1_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 136 \
    name belowNodeList_15_0_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_belowNodeList_15_0_read \
    op interface \
    ports { belowNodeList_15_0_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 137 \
    name belowNodeList_15_1_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_belowNodeList_15_1_read \
    op interface \
    ports { belowNodeList_15_1_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 138 \
    name inputNode_0_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_inputNode_0_read \
    op interface \
    ports { inputNode_0_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 139 \
    name inputNode_1_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_inputNode_1_read \
    op interface \
    ports { inputNode_1_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 140 \
    name nodeTriplets_offset \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_nodeTriplets_offset \
    op interface \
    ports { nodeTriplets_offset { I 2 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 141 \
    name nodeTriplets1_offset \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_nodeTriplets1_offset \
    op interface \
    ports { nodeTriplets1_offset { I 4 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id -1 \
    name ap_ctrl \
    type ap_ctrl \
    reset_level 1 \
    sync_rst true \
    corename ap_ctrl \
    op interface \
    ports { ap_start { I 1 bit } ap_ready { O 1 bit } ap_done { O 1 bit } ap_idle { O 1 bit } } \
} "
}


# Adapter definition:
set PortName ap_clk
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_clock] == "cg_default_interface_gen_clock"} {
eval "cg_default_interface_gen_clock { \
    id -2 \
    name ${PortName} \
    reset_level 1 \
    sync_rst true \
    corename apif_ap_clk \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-113\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}


# Adapter definition:
set PortName ap_rst
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_reset] == "cg_default_interface_gen_reset"} {
eval "cg_default_interface_gen_reset { \
    id -3 \
    name ${PortName} \
    reset_level 1 \
    sync_rst true \
    corename apif_ap_rst \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-114\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}



# merge
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_end
    cg_default_interface_gen_bundle_end
    AESL_LIB_XILADAPTER::native_axis_end
}


