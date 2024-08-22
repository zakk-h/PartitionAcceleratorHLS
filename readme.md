
# Timing Details

These are results from the Tanish_v3 RTL (found in the root of the repository in the Vivado branch with that label, and the corresponding Vivado project with suffix Vivado). These results were recorded on 8/6/2024. Customized synthesis and implementation strategies were deployed to maximize performance - turning off things such as resource sharing. These decisions and their results are detailed below. 

Schematics and diagrams are available in this directory labeled accordingly.

## Device
The FPGA used for synthesis and implementation was the 

"xcvu19p-fsvb3824-1-e" in the Virtex UltraScale+ family. 

## Strategy: Performance_ExtraTimingOpt*
Includes alternate algorithms for timing-driven optimization.

### Design Initialization (init_design)
- tcl.pre: (Not Set)
- tcl.post: (Not Set)

### Opt Design (opt_design)
- is_enabled: Enabled
- tcl.pre: (Not Set)
- tcl.post: (Not Set)
- verbose: (Not Set)
- directive: ExploreWithRemap

### Place Design (place_design)
- tcl.pre: (Not Set)
- tcl.post: (Not Set)
- directive: ExtraTimingOpt

### Post-Place Power Opt Design (power_opt_design)
- is_enabled: Disabled
- tcl.pre: (Not Set)
- tcl.post: (Not Set)

### Post-Place Phys Opt Design (phys_opt_design)
- is_enabled: Enabled
- tcl.pre: (Not Set)
- tcl.post: (Not Set)
- directive: AddRetime (changing this to AggressiveFanoutOpt changed no aspect of timing)

### Route Design (route_design)
- tcl.pre: (Not Set)
- tcl.post: (Not Set)
- directive: AggressiveExplore

### Post-Route Phys Opt Design (phys_opt_design)
- is_enabled: Disabled
- tcl.pre: (Not Set)
- tcl.post: (Not Set)
- directive: AggressiveExplore


## Setup
- **Worst Negative Slack (WNS):** -0.180 ns
- **Total Negative Slack (TNS):** -5.792 ns
- **Number of Failing Endpoints:** 92
- **Total Number of Endpoints:** 54613

**Timing constraints are not met.**

## Hold
- **Worst Hold Slack (WHS):** 0.002 ns
- **Total Hold Slack (THS):** 0.000 ns
- **Number of Failing Endpoints:** 0
- **Total Number of Endpoints:** 54613

## Pulse Width
- **Worst Pulse Width Slack (WPWS):** 0.927 ns
- **Total Pulse Width Negative Slack (TPWS):** 0.000 ns
- **Number of Failing Endpoints:** 0
- **Total Number of Endpoints:** 23196

## Summary
- **Total On-Chip Power:** 6.786 W
- **Design Power Budget:** Not Specified
- **Power Budget Margin:** N/A
- **Junction Temperature:** 28.0°C
- **Thermal Margin:** 72.0°C (138.7 W)
- **Effective ϑJA:** 0.4°C/W
- **Power supplied to off-chip devices:** 0 W
- **Confidence level:** Low

## On-Chip Power
- **Dynamic:** 0.943 W (14%)
  - **Clocks:** 0.220 W (23%)
  - **Signals:** 0.220 W (23%)
  - **Logic:** 0.144 W (15%)
  - **BRAM:** 0.077 W (8%)
  - **DSP:** 0.085 W (9%)
  - **I/O:** 0.198 W (22%)
- **Device Static:** 5.842 W (86%)

## Implementation and Synthesis

| LUT   | FF    | BRAM | URAM | DSP | Run Strategy            |     |                                                      |
|-------|-------|------|------|-----|------------------|------------|-------------------------------------------------------------------|
| 19707 | 22184 | 19.0 | 0    | 83  | Flow_PerfOptimized_high (Vivado Synthesis 2020)                   |
| 19004 | 22091 | 19.0 | 0    | 83  |  Performance_ExtraTimingOpt* (Vivado Implementation 2020)          |

## Path Details
| Name  | Slack | Levels | High Fanout | From | To | Total Delay | Logic Delay | Net Delay | Requirement | Source Clock | Destination Clock | Exception | Clock Uncertainty |
|-------|-------|--------|-------------|------|----|-------------|-------------|-----------|-------------|--------------|-------------------|-----------|-------------------|
| Path 1 | -0.18 | 5      | 12          | grp_solveNextColumn_fu_336/grp_solveNextPatchPair_fu_190/grp_solveComplmentaryPatch_fu_508/grp_makePatch_alignedToLine_fu_649/NPpatches_parameters_V_U/MPSQ_makePatch_alignedToLine_NPpatches_parameters_V_ram_U/ram_reg_bram_0/CLKBWRCLK | grp_solveNextColumn_fu_336/grp_solveNextPatchPair_fu_190/grp_solveComplmentaryPatch_fu_508/grp_makePatch_alignedToLine_fu_649/NPpatches_parameters_V_U/MPSQ_makePatch_alignedToLine_NPpatches_parameters_V_ram_U/ram_reg_bram_0/WEA[2] | 2.57        | 1.56        | 1.02     | 3.00        | ap_clk       | ap_clk            |           | 0.04             |
| Path 2 | -0.18 | 5      | 12          | grp_solveNextColumn_fu_336/grp_solveNextPatchPair_fu_190/grp_solveComplmentaryPatch_fu_508/grp_makePatch_alignedToLine_fu_649/NPpatches_parameters_V_U/MPSQ_makePatch_alignedToLine_NPpatches_parameters_V_ram_U/ram_reg_bram_0/CLKBWRCLK | grp_solveNextColumn_fu_336/grp_solveNextPatchPair_fu_190/grp_solveComplmentaryPatch_fu_508/grp_makePatch_alignedToLine_fu_649/NPpatches_parameters_V_U/MPSQ_makePatch_alignedToLine_NPpatches_parameters_V_ram_U/ram_reg_bram_0/WEA[1] | 2.57        | 1.56        | 1.02     | 3.00        | ap_clk       | ap_clk            |           | 0.04             |
| Path 3 | -0.17 | 5      | 12          | grp_solveNextColumn_fu_336/grp_solveNextPatchPair_fu_190/grp_solveComplmentaryPatch_fu_508/grp_makePatch_alignedToLine_fu_649/NPpatches_parameters_V_U/MPSQ_makePatch_alignedToLine_NPpatches_parameters_V_ram_U/ram_reg_bram_0/CLKBWRCLK | grp_solveNextColumn_fu_336/grp_solveNextPatchPair_fu_190/grp_solveComplmentaryPatch_fu_508/grp_makePatch_alignedToLine_fu_649/NPpatches_parameters_V_U/MPSQ_makePatch_alignedToLine_NPpatches_parameters_V_ram_U/ram_reg_bram_0/WEA[3] | 2.57        | 1.56        | 1.01     | 3.00        | ap_clk       | ap_clk            |           | 0.04             |
| Path 4 | -0.17 | 5      | 12          | grp_solveNextColumn_fu_336/grp_solveNextPatchPair_fu_190/grp_solveComplmentaryPatch_fu_508/grp_makePatch_alignedToLine_fu_649/NPpatches_parameters_V_U/MPSQ_makePatch_alignedToLine_NPpatches_parameters_V_ram_U/ram_reg_bram_0/CLKBWRCLK | grp_solveNextColumn_fu_336/grp_solveNextPatchPair_fu_190/grp_solveComplmentaryPatch_fu_508/grp_makePatch_alignedToLine_fu_649/NPpatches_parameters_V_U/MPSQ_makePatch_alignedToLine_NPpatches_parameters_V_ram_U/ram_reg_bram_0/WEA[0] | 2.57        | 1.56        | 1.01     | 3.00        | ap_clk       | ap_clk            |           | 0.04             |
| Path 5 | -0.17 | 9      | 6           | grp_solveNextColumn_fu_336/grp_solveNextPatchPair_fu_190/grp_straightLineProjectorFromLayerIJtoK_fu_1464/trunc_ln1_reg_311_reg[0]/C | grp_solveNextColumn_fu_336/grp_solveNextPatchPair_fu_190/grp_makeThirdPatch_fu_481/ap_CS_fsm_reg[81]/D | 2.92        | 1.16        | 1.76     | 3.00        | ap_clk       | ap_clk            |           | 0.04             |
| Path 6 | -0.12 | 5      | 14          | grp_solveNextColumn_fu_336/grp_solveNextPatchPair_fu_190/grp_solveComplmentaryPatch_fu_508/grp_makePatch_alignedToLine_fu_649/NPpatches_parameters_V_U/MPSQ_makePatch_alignedToLine_NPpatches_parameters_V_ram_U/ram_reg_bram_0/CLKARDCLK | grp_solveNextColumn_fu_336/grp_solveNextPatchPair_fu_190/grp_solveComplmentaryPatch_fu_508/grp_makePatch_alignedToLine_fu_649/NPpatches_parameters_V_U/MPSQ_makePatch_alignedToLine_NPpatches_parameters_V_ram_U/ram_reg_bram_0/WEBWE[1] | 2.52        | 1.54        | 0.98     | 3.00        | ap_clk       | ap_clk            |           | 0.04             |
| Path 7 | -0.12 | 8      | 203         | grp_solveNextColumn_fu_336/grp_solveNextPatchPair_fu_190/ap_CS_fsm_reg[24]/C | grp_solveNextColumn_fu_336/grp_solveNextPatchPair_fu_190/grp_makePatch_alignedToLine_fu_541/grp_makeSuperPoint_alignedToLine11_fu_414/temp_start_reg_903_reg[6]/D | 3.16        | 1.05        | 2.11     | 3.00        | ap_clk       | ap_clk            |           | 0.04             |
| Path 8 | -0.12 | 5      | 14          | grp_solveNextColumn_fu_336/grp_solveNextPatchPair_fu_190/grp_solveComplmentaryPatch_fu_508/grp_makePatch_alignedToLine_fu_649/NPpatches_parameters_V_U/MPSQ_makePatch_alignedToLine_NPpatches_parameters_V_ram_U/ram_reg_bram_0/CLKARDCLK | grp_solveNextColumn_fu_336/grp_solveNextPatchPair_fu_190/grp_solveComplmentaryPatch_fu_508/grp_makePatch_alignedToLine_fu_649/NPpatches_parameters_V_U/MPSQ_makePatch_alignedToLine_NPpatches_parameters_V_ram_U/ram_reg_bram_0/WEBWE[0] | 2.51 | 1.54 | 0.97 | 3.00 | ap_clk | ap_clk | | 0.04 |
| Path 9 | -0.11 | 5      | 14          | grp_solveNextColumn_fu_336/grp_solveNextPatchPair_fu_190/grp_solveComplmentaryPatch_fu_508/grp_makePatch_alignedToLine_fu_649/NPpatches_parameters_V_U/MPSQ_makePatch_alignedToLine_NPpatches_parameters_V_ram_U/ram_reg_bram_0/CLKARDCLK | grp_solveNextColumn_fu_336/grp_solveNextPatchPair_fu_190/grp_solveComplmentaryPatch_fu_508/grp_makePatch_alignedToLine_fu_649/NPpatches_parameters_V_U/MPSQ_makePatch_alignedToLine_NPpatches_parameters_V_ram_U/ram_reg_bram_0/WEBWE[3] | 2.51 | 1.54 | 0.96 | 3.00 | ap_clk | ap_clk | | 0.04 |
| Path 10 | -0.11 | 5     | 14          | grp_solveNextColumn_fu_336/grp_solveNextPatchPair_fu_190/grp_solveComplmentaryPatch_fu_508/grp_makePatch_alignedToLine_fu_649/NPpatches_parameters_V_U/MPSQ_makePatch_alignedToLine_NPpatches_parameters_V_ram_U/ram_reg_bram_0/CLKARDCLK | grp_solveNextColumn_fu_336/grp_solveNextPatchPair_fu_190/grp_solveComplmentaryPatch_fu_508/grp_makePatch_alignedToLine_fu_649/NPpatches_parameters_V_U/MPSQ_makePatch_alignedToLine_NPpatches_parameters_V_ram_U/ram_reg_bram_0/WEBWE[2] | 2.50 | 1.54 | 0.96 | 3.00 | ap_clk | ap_clk | | 0.04 |


# Previous Synthesis and Implementation

These results use the default synthesis and implementation settings in Vivado. Notably, resource sharing is on auto, among other default settings.

## Setup
- **Worst Negative Slack (WNS):** -0.216 ns
- **Total Negative Slack (TNS):** -18.513 ns
- **Number of Failing Endpoints:** 326
- **Total Number of Endpoints:** 47911
- **Timing constraints are not met.**

## Hold
- **Worst Hold Slack (WHS):** 0.010 ns
- **Total Hold Slack (THS):** 0.000 ns
- **Number of Failing Endpoints:** 0
- **Total Number of Endpoints:** 47911

## Pulse Width
- **Worst Pulse Width Slack (WPWS):** 0.927 ns
- **Total Pulse Width Negative Slack (TPWS):** 0.000 ns
- **Number of Failing Endpoints:** 0
- **Total Number of Endpoints:** 19491


## Power Summary
- **Dynamic:** 0.733 W (11%)
  - **Clocks:** 0.184 W (25%)
  - **Signals:** 0.146 W (20%)
  - **Logic:** 0.093 W (13%)
  - **BRAM:** 0.075 W (10%)
  - **DSP:** 0.049 W (7%)
  - **I/O:** 0.186 W (25%)
- **Static:** 5.836 W (89%)
  - **PL Static:** 5.836 W (100%)

## On-Chip
- **Dynamic:** 0.733 W (11%)
- **Static:** 5.836 W (89%)

# Research Questions or Notes

LUT and FF counts in Vivado, at least with the implementation strategies run, are approximately two times smaller than in Vitis (20k each vs 40k each, roughly).

We estimate that synthesizing and implementing the large circuit in Vivado could take up to 300 times longer than the small circuit RTL. The small circuit RTL takes approximately 2.5 hours to implement, depending on the implementation strategy. Therefore, it is infeasible to synthesize the large circuit on our personal hardware. We considered utilizing the Duke Computing Cluster (DCC) for this purpose, using X11 forwarding to get a graphical user interface (GUI), but have tabled this discussion.

There is significant benefit to using the test bench (simulation) workflow in Vivado. However, the test bench must be written in Verilog, which I and others do not currently know. We have postponed simulation steps in Vivado because of this. However, this approach will give us access to validation even after implementation, using the actual placement, routing, and other details. Simulation can also be done before, at the RTL level or with a gate-level netlist. From my research, it is uncommon to validate at the transistor level. At any level, we could generate a waveform timing diagram, which could be compared with Vitis quite directly (since the hierarchy in the circuit is mostly preserved). However, depending on the level at which the simulation is performed, some aspects, like routing delays, may not be exact. Not using resource sharing will likely preserve the hierarchy better Additionally, resource sharing makes it difficult to backtrack and contribute a behavior or an issue to a specific method because of the shared nature. The logic and operations are intertwined. 