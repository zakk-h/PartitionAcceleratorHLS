// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================

`timescale 1 ns / 1 ps

module system_top_mul_78s_108ns_185_3_1_Multiplier_1(clk, ce, a, b, p);
input clk;
input ce;
input[78 - 1 : 0] a; 
input[108 - 1 : 0] b; 
output[185 - 1 : 0] p;

reg signed [78 - 1 : 0] a_reg0;
reg [108 - 1 : 0] b_reg0;
wire signed [185 - 1 : 0] tmp_product;
reg signed [185 - 1 : 0] buff0;

assign p = buff0;
assign tmp_product = a_reg0 * $signed({1'b0, b_reg0});
always @ (posedge clk) begin
    if (ce) begin
        a_reg0 <= a;
        b_reg0 <= b;
        buff0 <= tmp_product;
    end
end
endmodule
`timescale 1 ns / 1 ps
module system_top_mul_78s_108ns_185_3_1(
    clk,
    reset,
    ce,
    din0,
    din1,
    dout);

parameter ID = 32'd1;
parameter NUM_STAGE = 32'd1;
parameter din0_WIDTH = 32'd1;
parameter din1_WIDTH = 32'd1;
parameter dout_WIDTH = 32'd1;
input clk;
input reset;
input ce;
input[din0_WIDTH - 1:0] din0;
input[din1_WIDTH - 1:0] din1;
output[dout_WIDTH - 1:0] dout;



system_top_mul_78s_108ns_185_3_1_Multiplier_1 system_top_mul_78s_108ns_185_3_1_Multiplier_1_U(
    .clk( clk ),
    .ce( ce ),
    .a( din0 ),
    .b( din1 ),
    .p( dout ));

endmodule

