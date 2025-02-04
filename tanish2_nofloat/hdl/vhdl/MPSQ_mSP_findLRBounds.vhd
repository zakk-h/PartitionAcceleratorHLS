-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
-- Version: 2020.2
-- Copyright (C) Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity MPSQ_mSP_findLRBounds is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    i : IN STD_LOGIC_VECTOR (2 downto 0);
    row_list_address0 : OUT STD_LOGIC_VECTOR (7 downto 0);
    row_list_ce0 : OUT STD_LOGIC;
    row_list_q0 : IN STD_LOGIC_VECTOR (31 downto 0);
    row_list_size : IN STD_LOGIC_VECTOR (31 downto 0);
    ap_return_0 : OUT STD_LOGIC_VECTOR (31 downto 0);
    ap_return_1 : OUT STD_LOGIC_VECTOR (31 downto 0) );
end;


architecture behav of MPSQ_mSP_findLRBounds is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (3 downto 0) := "0001";
    constant ap_ST_fsm_state2 : STD_LOGIC_VECTOR (3 downto 0) := "0010";
    constant ap_ST_fsm_pp0_stage0 : STD_LOGIC_VECTOR (3 downto 0) := "0100";
    constant ap_ST_fsm_state6 : STD_LOGIC_VECTOR (3 downto 0) := "1000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_lv32_2 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000010";
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv64_7FFFFFFFFFFFFFFF : STD_LOGIC_VECTOR (63 downto 0) := "0111111111111111111111111111111111111111111111111111111111111111";
    constant ap_const_lv33_0 : STD_LOGIC_VECTOR (32 downto 0) := "000000000000000000000000000000000";
    constant ap_const_lv32_20 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000100000";
    constant ap_const_lv32_3 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000011";

attribute shreg_extract : string;
    signal ap_CS_fsm : STD_LOGIC_VECTOR (3 downto 0) := "0001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal trapezoid_edges_V_address0 : STD_LOGIC_VECTOR (2 downto 0);
    signal trapezoid_edges_V_ce0 : STD_LOGIC;
    signal trapezoid_edges_V_q0 : STD_LOGIC_VECTOR (25 downto 0);
    signal j_reg_76 : STD_LOGIC_VECTOR (31 downto 0);
    signal j_reg_76_pp0_iter1_reg : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_CS_fsm_pp0_stage0 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage0 : signal is "none";
    signal ap_block_state3_pp0_stage0_iter0 : BOOLEAN;
    signal ap_block_state4_pp0_stage0_iter1 : BOOLEAN;
    signal ap_block_state5_pp0_stage0_iter2 : BOOLEAN;
    signal ap_block_pp0_stage0_11001 : BOOLEAN;
    signal left_bound_write_assign_reg_88 : STD_LOGIC_VECTOR (31 downto 0);
    signal right_bound_write_assign_reg_100 : STD_LOGIC_VECTOR (31 downto 0);
    signal rbVal_reg_112 : STD_LOGIC_VECTOR (63 downto 0);
    signal lbVal_reg_124 : STD_LOGIC_VECTOR (63 downto 0);
    signal ap_CS_fsm_state2 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state2 : signal is "none";
    signal rhs_fu_141_p1 : STD_LOGIC_VECTOR (32 downto 0);
    signal rhs_reg_292 : STD_LOGIC_VECTOR (32 downto 0);
    signal add_ln1622_fu_145_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal add_ln1622_reg_298 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_enable_reg_pp0_iter0 : STD_LOGIC := '0';
    signal icmp_ln1622_fu_151_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln1622_reg_303 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln1622_reg_303_pp0_iter1_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal lhs_reg_312 : STD_LOGIC_VECTOR (31 downto 0);
    signal select_ln1624_fu_201_p3 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_enable_reg_pp0_iter2 : STD_LOGIC := '0';
    signal lbVal_2_fu_209_p3 : STD_LOGIC_VECTOR (63 downto 0);
    signal select_ln1630_fu_254_p3 : STD_LOGIC_VECTOR (31 downto 0);
    signal rbVal_2_fu_262_p3 : STD_LOGIC_VECTOR (63 downto 0);
    signal ap_block_pp0_stage0_subdone : BOOLEAN;
    signal ap_condition_pp0_flush_enable : STD_LOGIC;
    signal ap_enable_reg_pp0_iter1 : STD_LOGIC := '0';
    signal ap_condition_pp0_exit_iter1_state4 : STD_LOGIC;
    signal ap_phi_mux_j_phi_fu_80_p4 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_block_pp0_stage0 : BOOLEAN;
    signal idxprom1_fu_136_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal trunc_ln1626_cast_fu_156_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal sext_ln215_fu_161_p1 : STD_LOGIC_VECTOR (32 downto 0);
    signal ret_fu_164_p2 : STD_LOGIC_VECTOR (32 downto 0);
    signal tmp_fu_175_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal sub_ln180_fu_169_p2 : STD_LOGIC_VECTOR (32 downto 0);
    signal lbVal_1_fu_183_p3 : STD_LOGIC_VECTOR (32 downto 0);
    signal sext_ln1618_fu_191_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal icmp_ln1624_fu_195_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal ret_25_fu_217_p2 : STD_LOGIC_VECTOR (32 downto 0);
    signal tmp_45_fu_228_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal sub_ln180_1_fu_222_p2 : STD_LOGIC_VECTOR (32 downto 0);
    signal rbVal_1_fu_236_p3 : STD_LOGIC_VECTOR (32 downto 0);
    signal sext_ln1630_fu_244_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal icmp_ln1630_fu_248_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_CS_fsm_state6 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state6 : signal is "none";
    signal ap_NS_fsm : STD_LOGIC_VECTOR (3 downto 0);
    signal ap_idle_pp0 : STD_LOGIC;
    signal ap_enable_pp0 : STD_LOGIC;
    signal ap_ce_reg : STD_LOGIC;

    component MPSQ_mSP_findLRBounds_trapezoid_edges_V IS
    generic (
        DataWidth : INTEGER;
        AddressRange : INTEGER;
        AddressWidth : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        address0 : IN STD_LOGIC_VECTOR (2 downto 0);
        ce0 : IN STD_LOGIC;
        q0 : OUT STD_LOGIC_VECTOR (25 downto 0) );
    end component;



begin
    trapezoid_edges_V_U : component MPSQ_mSP_findLRBounds_trapezoid_edges_V
    generic map (
        DataWidth => 26,
        AddressRange => 5,
        AddressWidth => 3)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        address0 => trapezoid_edges_V_address0,
        ce0 => trapezoid_edges_V_ce0,
        q0 => trapezoid_edges_V_q0);





    ap_CS_fsm_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_CS_fsm <= ap_ST_fsm_state1;
            else
                ap_CS_fsm <= ap_NS_fsm;
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter0_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter0 <= ap_const_logic_0;
            else
                if ((ap_const_logic_1 = ap_condition_pp0_flush_enable)) then 
                    ap_enable_reg_pp0_iter0 <= ap_const_logic_0;
                elsif ((ap_const_logic_1 = ap_CS_fsm_state2)) then 
                    ap_enable_reg_pp0_iter0 <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter1_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter1 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
                elsif (((ap_const_logic_1 = ap_CS_fsm_state2) or ((ap_enable_reg_pp0_iter0 = ap_const_logic_0) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_const_logic_1 = ap_condition_pp0_exit_iter1_state4)))) then 
                    ap_enable_reg_pp0_iter1 <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter2_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter2 <= ap_const_logic_0;
            else
                if (((ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_const_logic_1 = ap_condition_pp0_exit_iter1_state4))) then 
                    ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter0;
                elsif ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
                elsif ((ap_const_logic_1 = ap_CS_fsm_state2)) then 
                    ap_enable_reg_pp0_iter2 <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;


    j_reg_76_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((icmp_ln1622_reg_303 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1))) then 
                j_reg_76 <= add_ln1622_reg_298;
            elsif ((ap_const_logic_1 = ap_CS_fsm_state2)) then 
                j_reg_76 <= ap_const_lv32_0;
            end if; 
        end if;
    end process;

    lbVal_reg_124_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (icmp_ln1622_reg_303_pp0_iter1_reg = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then 
                lbVal_reg_124 <= lbVal_2_fu_209_p3;
            elsif ((ap_const_logic_1 = ap_CS_fsm_state2)) then 
                lbVal_reg_124 <= ap_const_lv64_7FFFFFFFFFFFFFFF;
            end if; 
        end if;
    end process;

    left_bound_write_assign_reg_88_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (icmp_ln1622_reg_303_pp0_iter1_reg = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then 
                left_bound_write_assign_reg_88 <= select_ln1624_fu_201_p3;
            elsif ((ap_const_logic_1 = ap_CS_fsm_state2)) then 
                left_bound_write_assign_reg_88 <= ap_const_lv32_0;
            end if; 
        end if;
    end process;

    rbVal_reg_112_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (icmp_ln1622_reg_303_pp0_iter1_reg = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then 
                rbVal_reg_112 <= rbVal_2_fu_262_p3;
            elsif ((ap_const_logic_1 = ap_CS_fsm_state2)) then 
                rbVal_reg_112 <= ap_const_lv64_7FFFFFFFFFFFFFFF;
            end if; 
        end if;
    end process;

    right_bound_write_assign_reg_100_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (icmp_ln1622_reg_303_pp0_iter1_reg = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then 
                right_bound_write_assign_reg_100 <= select_ln1630_fu_254_p3;
            elsif ((ap_const_logic_1 = ap_CS_fsm_state2)) then 
                right_bound_write_assign_reg_100 <= ap_const_lv32_0;
            end if; 
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                add_ln1622_reg_298 <= add_ln1622_fu_145_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                icmp_ln1622_reg_303 <= icmp_ln1622_fu_151_p2;
                icmp_ln1622_reg_303_pp0_iter1_reg <= icmp_ln1622_reg_303;
                j_reg_76_pp0_iter1_reg <= j_reg_76;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((icmp_ln1622_reg_303 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                lhs_reg_312 <= row_list_q0;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state2)) then
                    rhs_reg_292(25 downto 0) <= rhs_fu_141_p1(25 downto 0);
            end if;
        end if;
    end process;
    rhs_reg_292(32 downto 26) <= "0000000";

    ap_NS_fsm_assign_proc : process (ap_start, ap_CS_fsm, ap_CS_fsm_state1, ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, ap_block_pp0_stage0_subdone, ap_enable_reg_pp0_iter1)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                if (((ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state1))) then
                    ap_NS_fsm <= ap_ST_fsm_state2;
                else
                    ap_NS_fsm <= ap_ST_fsm_state1;
                end if;
            when ap_ST_fsm_state2 => 
                ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
            when ap_ST_fsm_pp0_stage0 => 
                if (not(((ap_enable_reg_pp0_iter0 = ap_const_logic_0) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1)))) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                elsif (((ap_enable_reg_pp0_iter0 = ap_const_logic_0) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1))) then
                    ap_NS_fsm <= ap_ST_fsm_state6;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                end if;
            when ap_ST_fsm_state6 => 
                ap_NS_fsm <= ap_ST_fsm_state1;
            when others =>  
                ap_NS_fsm <= "XXXX";
        end case;
    end process;
    add_ln1622_fu_145_p2 <= std_logic_vector(unsigned(ap_phi_mux_j_phi_fu_80_p4) + unsigned(ap_const_lv32_1));
    ap_CS_fsm_pp0_stage0 <= ap_CS_fsm(2);
    ap_CS_fsm_state1 <= ap_CS_fsm(0);
    ap_CS_fsm_state2 <= ap_CS_fsm(1);
    ap_CS_fsm_state6 <= ap_CS_fsm(3);
        ap_block_pp0_stage0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage0_11001 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage0_subdone <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state3_pp0_stage0_iter0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state4_pp0_stage0_iter1 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state5_pp0_stage0_iter2 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_condition_pp0_exit_iter1_state4_assign_proc : process(ap_enable_reg_pp0_iter0, ap_enable_reg_pp0_iter1)
    begin
        if (((ap_enable_reg_pp0_iter0 = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1))) then 
            ap_condition_pp0_exit_iter1_state4 <= ap_const_logic_1;
        else 
            ap_condition_pp0_exit_iter1_state4 <= ap_const_logic_0;
        end if; 
    end process;


    ap_condition_pp0_flush_enable_assign_proc : process(ap_CS_fsm_pp0_stage0, icmp_ln1622_fu_151_p2, ap_block_pp0_stage0_subdone)
    begin
        if (((icmp_ln1622_fu_151_p2 = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            ap_condition_pp0_flush_enable <= ap_const_logic_1;
        else 
            ap_condition_pp0_flush_enable <= ap_const_logic_0;
        end if; 
    end process;


    ap_done_assign_proc : process(ap_start, ap_CS_fsm_state1, ap_CS_fsm_state6)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state6) or ((ap_start = ap_const_logic_0) and (ap_const_logic_1 = ap_CS_fsm_state1)))) then 
            ap_done <= ap_const_logic_1;
        else 
            ap_done <= ap_const_logic_0;
        end if; 
    end process;

    ap_enable_pp0 <= (ap_idle_pp0 xor ap_const_logic_1);

    ap_idle_assign_proc : process(ap_start, ap_CS_fsm_state1)
    begin
        if (((ap_start = ap_const_logic_0) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_pp0_assign_proc : process(ap_enable_reg_pp0_iter0, ap_enable_reg_pp0_iter2, ap_enable_reg_pp0_iter1)
    begin
        if (((ap_enable_reg_pp0_iter2 = ap_const_logic_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_0))) then 
            ap_idle_pp0 <= ap_const_logic_1;
        else 
            ap_idle_pp0 <= ap_const_logic_0;
        end if; 
    end process;


    ap_phi_mux_j_phi_fu_80_p4_assign_proc : process(j_reg_76, ap_CS_fsm_pp0_stage0, add_ln1622_reg_298, icmp_ln1622_reg_303, ap_enable_reg_pp0_iter1, ap_block_pp0_stage0)
    begin
        if (((icmp_ln1622_reg_303 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1))) then 
            ap_phi_mux_j_phi_fu_80_p4 <= add_ln1622_reg_298;
        else 
            ap_phi_mux_j_phi_fu_80_p4 <= j_reg_76;
        end if; 
    end process;


    ap_ready_assign_proc : process(ap_CS_fsm_state6)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state6)) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;

    ap_return_0 <= left_bound_write_assign_reg_88;
    ap_return_1 <= right_bound_write_assign_reg_100;
    icmp_ln1622_fu_151_p2 <= "1" when (ap_phi_mux_j_phi_fu_80_p4 = row_list_size) else "0";
    icmp_ln1624_fu_195_p2 <= "1" when (signed(sext_ln1618_fu_191_p1) < signed(lbVal_reg_124)) else "0";
    icmp_ln1630_fu_248_p2 <= "1" when (signed(sext_ln1630_fu_244_p1) < signed(rbVal_reg_112)) else "0";
    idxprom1_fu_136_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(i),64));
    lbVal_1_fu_183_p3 <= 
        sub_ln180_fu_169_p2 when (tmp_fu_175_p3(0) = '1') else 
        ret_fu_164_p2;
    lbVal_2_fu_209_p3 <= 
        sext_ln1618_fu_191_p1 when (icmp_ln1624_fu_195_p2(0) = '1') else 
        lbVal_reg_124;
    rbVal_1_fu_236_p3 <= 
        sub_ln180_1_fu_222_p2 when (tmp_45_fu_228_p3(0) = '1') else 
        ret_25_fu_217_p2;
    rbVal_2_fu_262_p3 <= 
        sext_ln1630_fu_244_p1 when (icmp_ln1630_fu_248_p2(0) = '1') else 
        rbVal_reg_112;
    ret_25_fu_217_p2 <= std_logic_vector(signed(sext_ln215_fu_161_p1) - signed(rhs_reg_292));
    ret_fu_164_p2 <= std_logic_vector(signed(sext_ln215_fu_161_p1) + signed(rhs_reg_292));
    rhs_fu_141_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(trapezoid_edges_V_q0),33));
    row_list_address0 <= trunc_ln1626_cast_fu_156_p1(8 - 1 downto 0);

    row_list_ce0_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0_11001, ap_enable_reg_pp0_iter0)
    begin
        if (((ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            row_list_ce0 <= ap_const_logic_1;
        else 
            row_list_ce0 <= ap_const_logic_0;
        end if; 
    end process;

    select_ln1624_fu_201_p3 <= 
        j_reg_76_pp0_iter1_reg when (icmp_ln1624_fu_195_p2(0) = '1') else 
        left_bound_write_assign_reg_88;
    select_ln1630_fu_254_p3 <= 
        j_reg_76_pp0_iter1_reg when (icmp_ln1630_fu_248_p2(0) = '1') else 
        right_bound_write_assign_reg_100;
        sext_ln1618_fu_191_p1 <= std_logic_vector(IEEE.numeric_std.resize(signed(lbVal_1_fu_183_p3),64));

        sext_ln1630_fu_244_p1 <= std_logic_vector(IEEE.numeric_std.resize(signed(rbVal_1_fu_236_p3),64));

        sext_ln215_fu_161_p1 <= std_logic_vector(IEEE.numeric_std.resize(signed(lhs_reg_312),33));

    sub_ln180_1_fu_222_p2 <= std_logic_vector(unsigned(ap_const_lv33_0) - unsigned(ret_25_fu_217_p2));
    sub_ln180_fu_169_p2 <= std_logic_vector(unsigned(ap_const_lv33_0) - unsigned(ret_fu_164_p2));
    tmp_45_fu_228_p3 <= ret_25_fu_217_p2(32 downto 32);
    tmp_fu_175_p3 <= ret_fu_164_p2(32 downto 32);
    trapezoid_edges_V_address0 <= idxprom1_fu_136_p1(3 - 1 downto 0);

    trapezoid_edges_V_ce0_assign_proc : process(ap_start, ap_CS_fsm_state1)
    begin
        if (((ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            trapezoid_edges_V_ce0 <= ap_const_logic_1;
        else 
            trapezoid_edges_V_ce0 <= ap_const_logic_0;
        end if; 
    end process;

    trunc_ln1626_cast_fu_156_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(ap_phi_mux_j_phi_fu_80_p4),64));
end behav;
