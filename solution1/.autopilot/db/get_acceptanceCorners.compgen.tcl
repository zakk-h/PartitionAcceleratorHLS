# This script segment is generated automatically by AutoPilot

# Memory (RAM/ROM)  definition:
set ID 86
set hasByteEnable 0
set MemName system_top_get_acceptanceCorners_a_corner_list_V
set CoreName ap_simcore_mem
set PortList { 2 0 }
set DataWd 32
set AddrRange 4
set AddrWd 2
set impl_style auto
set TrueReset 0
set HasInitializer 0
set IsROM 0
set ROMData {}
set NumOfStage 2
set MaxLatency -1
set DelayBudget 0.73
set ClkPeriod 10
set RegisteredInput 0
if {${::AESL::PGuard_simmodel_gen}} {
if {[info proc ap_gen_simcore_mem] == "ap_gen_simcore_mem"} {
    eval "ap_gen_simcore_mem { \
    id ${ID} \
    name ${MemName} \
    corename ${CoreName}  \
    op mem \
    hasByteEnable ${hasByteEnable} \
    reset_level 1 \
    sync_rst true \
    stage_num ${NumOfStage}  \
    registered_input ${RegisteredInput} \
    port_num 2 \
    port_list \{${PortList}\} \
    data_wd ${DataWd} \
    addr_wd ${AddrWd} \
    addr_range ${AddrRange} \
    style ${impl_style} \
    true_reset ${TrueReset} \
    delay_budget ${DelayBudget} \
    clk_period ${ClkPeriod} \
    HasInitializer ${HasInitializer} \
    rom_data \{${ROMData}\} \
 } "
} else {
    puts "@W \[IMPL-102\] Cannot find ap_gen_simcore_mem, check your platform lib"
}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
  ::AP::rtl_comp_handler $MemName
}


set CoreName RAM
if {${::AESL::PGuard_autocg_gen} && ${::AESL::PGuard_autocg_ipmgen}} {
if {[info proc ::AESL_LIB_VIRTEX::xil_gen_RAM] == "::AESL_LIB_VIRTEX::xil_gen_RAM"} {
    eval "::AESL_LIB_VIRTEX::xil_gen_RAM { \
    id ${ID} \
    name ${MemName} \
    corename ${CoreName}  \
    op mem \
    hasByteEnable ${hasByteEnable} \
    reset_level 1 \
    sync_rst true \
    stage_num ${NumOfStage}  \
    registered_input ${RegisteredInput} \
    port_num 2 \
    port_list \{${PortList}\} \
    data_wd ${DataWd} \
    addr_wd ${AddrWd} \
    addr_range ${AddrRange} \
    style ${impl_style} \
    true_reset ${TrueReset} \
    delay_budget ${DelayBudget} \
    clk_period ${ClkPeriod} \
    HasInitializer ${HasInitializer} \
    rom_data \{${ROMData}\} \
 } "
  } else {
    puts "@W \[IMPL-104\] Cannot find ::AESL_LIB_VIRTEX::xil_gen_RAM, check your platform lib"
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
    id 87 \
    name shadow_bottomL_jR \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename shadow_bottomL_jR \
    op interface \
    ports { shadow_bottomL_jR_address0 { O 4 vector } shadow_bottomL_jR_ce0 { O 1 bit } shadow_bottomL_jR_q0 { I 32 vector } shadow_bottomL_jR_address1 { O 4 vector } shadow_bottomL_jR_ce1 { O 1 bit } shadow_bottomL_jR_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'shadow_bottomL_jR'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 88 \
    name shadow_bottomR_jR \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename shadow_bottomR_jR \
    op interface \
    ports { shadow_bottomR_jR_address0 { O 4 vector } shadow_bottomR_jR_ce0 { O 1 bit } shadow_bottomR_jR_q0 { I 32 vector } shadow_bottomR_jR_address1 { O 4 vector } shadow_bottomR_jR_ce1 { O 1 bit } shadow_bottomR_jR_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'shadow_bottomR_jR'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 89 \
    name shadow_bottomL_jL \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename shadow_bottomL_jL \
    op interface \
    ports { shadow_bottomL_jL_address0 { O 4 vector } shadow_bottomL_jL_ce0 { O 1 bit } shadow_bottomL_jL_q0 { I 32 vector } shadow_bottomL_jL_address1 { O 4 vector } shadow_bottomL_jL_ce1 { O 1 bit } shadow_bottomL_jL_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'shadow_bottomL_jL'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 90 \
    name shadow_bottomR_jL \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename shadow_bottomR_jL \
    op interface \
    ports { shadow_bottomR_jL_address0 { O 4 vector } shadow_bottomR_jL_ce0 { O 1 bit } shadow_bottomR_jL_q0 { I 32 vector } shadow_bottomR_jL_address1 { O 4 vector } shadow_bottomR_jL_ce1 { O 1 bit } shadow_bottomR_jL_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'shadow_bottomR_jL'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 91 \
    name z1_min \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename z1_min \
    op interface \
    ports { z1_min_address0 { O 4 vector } z1_min_ce0 { O 1 bit } z1_min_q0 { I 26 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'z1_min'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 92 \
    name z1_max \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename z1_max \
    op interface \
    ports { z1_max_address0 { O 4 vector } z1_max_ce0 { O 1 bit } z1_max_q0 { I 26 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'z1_max'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 93 \
    name a_corner_0 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename a_corner_0 \
    op interface \
    ports { a_corner_0_address0 { O 2 vector } a_corner_0_ce0 { O 1 bit } a_corner_0_we0 { O 1 bit } a_corner_0_d0 { O 26 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'a_corner_0'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 94 \
    name a_corner_1 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename a_corner_1 \
    op interface \
    ports { a_corner_1_address0 { O 2 vector } a_corner_1_ce0 { O 1 bit } a_corner_1_we0 { O 1 bit } a_corner_1_d0 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'a_corner_1'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 95 \
    name b_corner_0 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename b_corner_0 \
    op interface \
    ports { b_corner_0_address0 { O 2 vector } b_corner_0_ce0 { O 1 bit } b_corner_0_we0 { O 1 bit } b_corner_0_d0 { O 26 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'b_corner_0'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 96 \
    name b_corner_1 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename b_corner_1 \
    op interface \
    ports { b_corner_1_address0 { O 2 vector } b_corner_1_ce0 { O 1 bit } b_corner_1_we0 { O 1 bit } b_corner_1_d0 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'b_corner_1'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 97 \
    name c_corner_0 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename c_corner_0 \
    op interface \
    ports { c_corner_0_address0 { O 2 vector } c_corner_0_ce0 { O 1 bit } c_corner_0_we0 { O 1 bit } c_corner_0_d0 { O 26 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'c_corner_0'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 98 \
    name c_corner_1 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename c_corner_1 \
    op interface \
    ports { c_corner_1_address0 { O 2 vector } c_corner_1_ce0 { O 1 bit } c_corner_1_we0 { O 1 bit } c_corner_1_d0 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'c_corner_1'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 99 \
    name d_corner_0 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename d_corner_0 \
    op interface \
    ports { d_corner_0_address0 { O 2 vector } d_corner_0_ce0 { O 1 bit } d_corner_0_we0 { O 1 bit } d_corner_0_d0 { O 26 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'd_corner_0'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 100 \
    name d_corner_1 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename d_corner_1 \
    op interface \
    ports { d_corner_1_address0 { O 2 vector } d_corner_1_ce0 { O 1 bit } d_corner_1_we0 { O 1 bit } d_corner_1_d0 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'd_corner_1'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 101 \
    name squareAcceptance \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename squareAcceptance \
    op interface \
    ports { squareAcceptance_address0 { O 2 vector } squareAcceptance_ce0 { O 1 bit } squareAcceptance_we0 { O 1 bit } squareAcceptance_d0 { O 1 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'squareAcceptance'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 102 \
    name flatTop \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename flatTop \
    op interface \
    ports { flatTop_address0 { O 2 vector } flatTop_ce0 { O 1 bit } flatTop_we0 { O 1 bit } flatTop_d0 { O 1 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'flatTop'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 103 \
    name flatBottom \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename flatBottom \
    op interface \
    ports { flatBottom_address0 { O 2 vector } flatBottom_ce0 { O 1 bit } flatBottom_we0 { O 1 bit } flatBottom_d0 { O 1 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'flatBottom'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 104 \
    name triangleAcceptance \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename triangleAcceptance \
    op interface \
    ports { triangleAcceptance_address0 { O 2 vector } triangleAcceptance_ce0 { O 1 bit } triangleAcceptance_we0 { O 1 bit } triangleAcceptance_d0 { O 1 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'triangleAcceptance'"
}
}


# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 105 \
    name latest_patch_index_constprop \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_latest_patch_index_constprop \
    op interface \
    ports { latest_patch_index_constprop { I 2 vector } } \
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


