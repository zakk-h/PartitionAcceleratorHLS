-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity MPSQ_straightLineProjectorFromLayerIJtoK_radiiDivisionList_rom is 
    generic(
             DWIDTH     : integer := 35; 
             AWIDTH     : integer := 6; 
             MEM_SIZE    : integer := 36
    ); 
    port (
          addr0      : in std_logic_vector(AWIDTH-1 downto 0); 
          ce0       : in std_logic; 
          q0         : out std_logic_vector(DWIDTH-1 downto 0);
          clk       : in std_logic
    ); 
end entity; 


architecture rtl of MPSQ_straightLineProjectorFromLayerIJtoK_radiiDivisionList_rom is 

signal addr0_tmp : std_logic_vector(AWIDTH-1 downto 0); 
type mem_array is array (0 to MEM_SIZE-1) of std_logic_vector (DWIDTH-1 downto 0); 
signal mem : mem_array := (
    0 to 6=> "00000000000000000000000000000000000", 
    7 => "00100000000000000000000000000000000", 
    8 => "00010000000000000000000000000000000", 
    9 => "00001010101010101010101010101010101", 
    10 => "00001000000000000000000000000000000", 
    11 => "00000110011001100110011001100110011", 
    12 => "00000000000000000000000000000000000", 
    13 => "01000000000000000000000000000000000", 
    14 => "00100000000000000000000000000000000", 
    15 => "00010101010101010101010101010101010", 
    16 => "00010000000000000000000000000000000", 
    17 => "00001100110011001100110011001100110", 
    18 => "00000000000000000000000000000000000", 
    19 => "01100000000000000000000000000000000", 
    20 => "00110000000000000000000000000000000", 
    21 => "00100000000000000000000000000000000", 
    22 => "00011000000000000000000000000000000", 
    23 => "00010011001100110011001100110011001", 
    24 => "00000000000000000000000000000000000", 
    25 => "10000000000000000000000000000000000", 
    26 => "01000000000000000000000000000000000", 
    27 => "00101010101010101010101010101010101", 
    28 => "00100000000000000000000000000000000", 
    29 => "00011001100110011001100110011001100", 
    30 => "00000000000000000000000000000000000", 
    31 => "10100000000000000000000000000000000", 
    32 => "01010000000000000000000000000000000", 
    33 => "00110101010101010101010101010101010", 
    34 => "00101000000000000000000000000000000", 
    35 => "00100000000000000000000000000000000" );


begin 


memory_access_guard_0: process (addr0) 
begin
      addr0_tmp <= addr0;
--synthesis translate_off
      if (CONV_INTEGER(addr0) > mem_size-1) then
           addr0_tmp <= (others => '0');
      else 
           addr0_tmp <= addr0;
      end if;
--synthesis translate_on
end process;

p_rom_access: process (clk)  
begin 
    if (clk'event and clk = '1') then
        if (ce0 = '1') then 
            q0 <= mem(CONV_INTEGER(addr0_tmp)); 
        end if;
    end if;
end process;

end rtl;

Library IEEE;
use IEEE.std_logic_1164.all;

entity MPSQ_straightLineProjectorFromLayerIJtoK_radiiDivisionList is
    generic (
        DataWidth : INTEGER := 35;
        AddressRange : INTEGER := 36;
        AddressWidth : INTEGER := 6);
    port (
        reset : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        address0 : IN STD_LOGIC_VECTOR(AddressWidth - 1 DOWNTO 0);
        ce0 : IN STD_LOGIC;
        q0 : OUT STD_LOGIC_VECTOR(DataWidth - 1 DOWNTO 0));
end entity;

architecture arch of MPSQ_straightLineProjectorFromLayerIJtoK_radiiDivisionList is
    component MPSQ_straightLineProjectorFromLayerIJtoK_radiiDivisionList_rom is
        port (
            clk : IN STD_LOGIC;
            addr0 : IN STD_LOGIC_VECTOR;
            ce0 : IN STD_LOGIC;
            q0 : OUT STD_LOGIC_VECTOR);
    end component;



begin
    MPSQ_straightLineProjectorFromLayerIJtoK_radiiDivisionList_rom_U :  component MPSQ_straightLineProjectorFromLayerIJtoK_radiiDivisionList_rom
    port map (
        clk => clk,
        addr0 => address0,
        ce0 => ce0,
        q0 => q0);

end architecture;


