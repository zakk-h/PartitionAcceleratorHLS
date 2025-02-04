-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
-- Version: 2020.2
-- Copyright (C) Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity MPSQ_getSolveNextPatchPairWhileCondition is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    GDn_points_address0 : OUT STD_LOGIC_VECTOR (2 downto 0);
    GDn_points_ce0 : OUT STD_LOGIC;
    GDn_points_q0 : IN STD_LOGIC_VECTOR (31 downto 0);
    lastPatchIndex : IN STD_LOGIC_VECTOR (4 downto 0);
    repeat_original : IN STD_LOGIC_VECTOR (0 downto 0);
    white_space_height : IN STD_LOGIC_VECTOR (63 downto 0);
    previous_white_space_height : IN STD_LOGIC_VECTOR (63 downto 0);
    current_z_top_index : IN STD_LOGIC_VECTOR (31 downto 0);
    patches_parameters_address0 : OUT STD_LOGIC_VECTOR (11 downto 0);
    patches_parameters_ce0 : OUT STD_LOGIC;
    patches_parameters_q0 : IN STD_LOGIC_VECTOR (31 downto 0);
    ap_return : OUT STD_LOGIC_VECTOR (0 downto 0) );
end;


architecture behav of MPSQ_getSolveNextPatchPairWhileCondition is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (3 downto 0) := "0001";
    constant ap_ST_fsm_state2 : STD_LOGIC_VECTOR (3 downto 0) := "0010";
    constant ap_ST_fsm_state3 : STD_LOGIC_VECTOR (3 downto 0) := "0100";
    constant ap_ST_fsm_state4 : STD_LOGIC_VECTOR (3 downto 0) := "1000";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv32_2 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000010";
    constant ap_const_lv64_4 : STD_LOGIC_VECTOR (63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000100";
    constant ap_const_lv32_3 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000011";
    constant ap_const_lv7_0 : STD_LOGIC_VECTOR (6 downto 0) := "0000000";
    constant ap_const_lv3_0 : STD_LOGIC_VECTOR (2 downto 0) := "000";
    constant ap_const_lv12_3D : STD_LOGIC_VECTOR (11 downto 0) := "000000111101";
    constant ap_const_lv64_0 : STD_LOGIC_VECTOR (63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";
    constant ap_const_lv32_3F : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000111111";
    constant ap_const_lv64_5 : STD_LOGIC_VECTOR (63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000101";
    constant ap_const_lv32_FD050F1C : STD_LOGIC_VECTOR (31 downto 0) := "11111101000001010000111100011100";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_boolean_1 : BOOLEAN := true;

attribute shreg_extract : string;
    signal ap_CS_fsm : STD_LOGIC_VECTOR (3 downto 0) := "0001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal add_ln886_fu_139_p2 : STD_LOGIC_VECTOR (11 downto 0);
    signal add_ln886_reg_245 : STD_LOGIC_VECTOR (11 downto 0);
    signal ap_CS_fsm_state2 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state2 : signal is "none";
    signal ap_CS_fsm_state3 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state3 : signal is "none";
    signal sub_ln180_fu_149_p2 : STD_LOGIC_VECTOR (63 downto 0);
    signal sub_ln180_reg_263 : STD_LOGIC_VECTOR (63 downto 0);
    signal patches_parameters_load_reg_268 : STD_LOGIC_VECTOR (31 downto 0);
    signal zext_ln886_2_fu_145_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal ap_CS_fsm_state4 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state4 : signal is "none";
    signal tmp_s_fu_121_p3 : STD_LOGIC_VECTOR (7 downto 0);
    signal tmp_fu_113_p3 : STD_LOGIC_VECTOR (11 downto 0);
    signal zext_ln886_fu_129_p1 : STD_LOGIC_VECTOR (11 downto 0);
    signal sub_ln886_fu_133_p2 : STD_LOGIC_VECTOR (11 downto 0);
    signal tmp_25_fu_155_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal select_ln180_fu_162_p3 : STD_LOGIC_VECTOR (63 downto 0);
    signal icmp_ln886_fu_174_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln911_fu_179_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_26_fu_207_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln909_1_fu_202_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln909_fu_215_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln909_fu_168_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln912_fu_190_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal xor_ln913_fu_196_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal and_ln910_1_fu_227_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln910_fu_184_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal and_ln910_2_fu_233_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal and_ln910_fu_221_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal and_ln910_3_fu_239_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_return_preg : STD_LOGIC_VECTOR (0 downto 0) := "0";
    signal ap_NS_fsm : STD_LOGIC_VECTOR (3 downto 0);
    signal ap_ce_reg : STD_LOGIC;


begin




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


    ap_return_preg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_return_preg <= ap_const_lv1_0;
            else
                if ((ap_const_logic_1 = ap_CS_fsm_state4)) then 
                    ap_return_preg <= and_ln910_3_fu_239_p2;
                end if; 
            end if;
        end if;
    end process;

    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state1)) then
                    add_ln886_reg_245(11 downto 3) <= add_ln886_fu_139_p2(11 downto 3);
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state3)) then
                patches_parameters_load_reg_268 <= patches_parameters_q0;
                sub_ln180_reg_263 <= sub_ln180_fu_149_p2;
            end if;
        end if;
    end process;
    add_ln886_reg_245(2 downto 0) <= "101";

    ap_NS_fsm_assign_proc : process (ap_start, ap_CS_fsm, ap_CS_fsm_state1)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                if (((ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state1))) then
                    ap_NS_fsm <= ap_ST_fsm_state2;
                else
                    ap_NS_fsm <= ap_ST_fsm_state1;
                end if;
            when ap_ST_fsm_state2 => 
                ap_NS_fsm <= ap_ST_fsm_state3;
            when ap_ST_fsm_state3 => 
                ap_NS_fsm <= ap_ST_fsm_state4;
            when ap_ST_fsm_state4 => 
                ap_NS_fsm <= ap_ST_fsm_state1;
            when others =>  
                ap_NS_fsm <= "XXXX";
        end case;
    end process;
    GDn_points_address0 <= ap_const_lv64_4(3 - 1 downto 0);

    GDn_points_ce0_assign_proc : process(ap_CS_fsm_state3)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state3)) then 
            GDn_points_ce0 <= ap_const_logic_1;
        else 
            GDn_points_ce0 <= ap_const_logic_0;
        end if; 
    end process;

    add_ln886_fu_139_p2 <= std_logic_vector(unsigned(sub_ln886_fu_133_p2) + unsigned(ap_const_lv12_3D));
    and_ln910_1_fu_227_p2 <= (xor_ln913_fu_196_p2 and icmp_ln912_fu_190_p2);
    and_ln910_2_fu_233_p2 <= (or_ln910_fu_184_p2 and and_ln910_1_fu_227_p2);
    and_ln910_3_fu_239_p2 <= (and_ln910_fu_221_p2 and and_ln910_2_fu_233_p2);
    and_ln910_fu_221_p2 <= (or_ln909_fu_215_p2 and icmp_ln909_fu_168_p2);
    ap_CS_fsm_state1 <= ap_CS_fsm(0);
    ap_CS_fsm_state2 <= ap_CS_fsm(1);
    ap_CS_fsm_state3 <= ap_CS_fsm(2);
    ap_CS_fsm_state4 <= ap_CS_fsm(3);

    ap_done_assign_proc : process(ap_start, ap_CS_fsm_state1, ap_CS_fsm_state4)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state4) or ((ap_start = ap_const_logic_0) and (ap_const_logic_1 = ap_CS_fsm_state1)))) then 
            ap_done <= ap_const_logic_1;
        else 
            ap_done <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_assign_proc : process(ap_start, ap_CS_fsm_state1)
    begin
        if (((ap_start = ap_const_logic_0) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;


    ap_ready_assign_proc : process(ap_CS_fsm_state4)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state4)) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;


    ap_return_assign_proc : process(ap_CS_fsm_state4, and_ln910_3_fu_239_p2, ap_return_preg)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state4)) then 
            ap_return <= and_ln910_3_fu_239_p2;
        else 
            ap_return <= ap_return_preg;
        end if; 
    end process;

    icmp_ln886_fu_174_p2 <= "1" when (signed(patches_parameters_load_reg_268) > signed(ap_const_lv32_FD050F1C)) else "0";
    icmp_ln909_1_fu_202_p2 <= "1" when (signed(white_space_height) > signed(ap_const_lv64_0)) else "0";
    icmp_ln909_fu_168_p2 <= "1" when (signed(select_ln180_fu_162_p3) > signed(ap_const_lv64_5)) else "0";
    icmp_ln911_fu_179_p2 <= "1" when (signed(white_space_height) > signed(ap_const_lv64_5)) else "0";
    icmp_ln912_fu_190_p2 <= "1" when (signed(GDn_points_q0) > signed(current_z_top_index)) else "0";
    or_ln909_fu_215_p2 <= (tmp_26_fu_207_p3 or icmp_ln909_1_fu_202_p2);
    or_ln910_fu_184_p2 <= (icmp_ln911_fu_179_p2 or icmp_ln886_fu_174_p2);
    patches_parameters_address0 <= zext_ln886_2_fu_145_p1(12 - 1 downto 0);

    patches_parameters_ce0_assign_proc : process(ap_CS_fsm_state2)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state2)) then 
            patches_parameters_ce0 <= ap_const_logic_1;
        else 
            patches_parameters_ce0 <= ap_const_logic_0;
        end if; 
    end process;

    select_ln180_fu_162_p3 <= 
        sub_ln180_reg_263 when (tmp_25_fu_155_p3(0) = '1') else 
        white_space_height;
    sub_ln180_fu_149_p2 <= std_logic_vector(unsigned(ap_const_lv64_0) - unsigned(white_space_height));
    sub_ln886_fu_133_p2 <= std_logic_vector(unsigned(tmp_fu_113_p3) - unsigned(zext_ln886_fu_129_p1));
    tmp_25_fu_155_p3 <= white_space_height(63 downto 63);
    tmp_26_fu_207_p3 <= previous_white_space_height(63 downto 63);
    tmp_fu_113_p3 <= (lastPatchIndex & ap_const_lv7_0);
    tmp_s_fu_121_p3 <= (lastPatchIndex & ap_const_lv3_0);
    xor_ln913_fu_196_p2 <= (repeat_original xor ap_const_lv1_1);
    zext_ln886_2_fu_145_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(add_ln886_reg_245),64));
    zext_ln886_fu_129_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(tmp_s_fu_121_p3),12));
end behav;
