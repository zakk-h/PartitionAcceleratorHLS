// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================

`timescale 1 ns / 1 ps

module makePatches_ShadowQuilt_fromEdges_mul_64s_64s_64_1_1_Multiplier_3(a, b, p);
input[64 - 1 : 0] a; 
input[64 - 1 : 0] b; 
output[64 - 1 : 0] p;

assign p = $signed(a) * $signed(b);
endmodule
`timescale 1 ns / 1 ps
module makePatches_ShadowQuilt_fromEdges_mul_64s_64s_64_1_1(
    din0,
    din1,
    dout);

parameter ID = 32'd1;
parameter NUM_STAGE = 32'd1;
parameter din0_WIDTH = 32'd1;
parameter din1_WIDTH = 32'd1;
parameter dout_WIDTH = 32'd1;
input[din0_WIDTH - 1:0] din0;
input[din1_WIDTH - 1:0] din1;
output[dout_WIDTH - 1:0] dout;



makePatches_ShadowQuilt_fromEdges_mul_64s_64s_64_1_1_Multiplier_3 makePatches_ShadowQuilt_fromEdges_mul_64s_64s_64_1_1_Multiplier_3_U(
    .a( din0 ),
    .b( din1 ),
    .p( dout ));

endmodule

