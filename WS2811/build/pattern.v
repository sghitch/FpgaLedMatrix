module Addcout4 (input [3:0] I0, input [3:0] I1, output [3:0] O, output  COUT);
wire  inst0_O;
wire  inst1_CO;
wire  inst2_O;
wire  inst3_CO;
wire  inst4_O;
wire  inst5_CO;
wire  inst6_O;
wire  inst7_CO;
SB_LUT4 #(.LUT_INIT(16'hC33C)) inst0 (.I0(1'b0), .I1(I0[0]), .I2(I1[0]), .I3(1'b0), .O(inst0_O));
SB_CARRY inst1 (.I0(I0[0]), .I1(I1[0]), .CI(1'b0), .CO(inst1_CO));
SB_LUT4 #(.LUT_INIT(16'hC33C)) inst2 (.I0(1'b0), .I1(I0[1]), .I2(I1[1]), .I3(inst1_CO), .O(inst2_O));
SB_CARRY inst3 (.I0(I0[1]), .I1(I1[1]), .CI(inst1_CO), .CO(inst3_CO));
SB_LUT4 #(.LUT_INIT(16'hC33C)) inst4 (.I0(1'b0), .I1(I0[2]), .I2(I1[2]), .I3(inst3_CO), .O(inst4_O));
SB_CARRY inst5 (.I0(I0[2]), .I1(I1[2]), .CI(inst3_CO), .CO(inst5_CO));
SB_LUT4 #(.LUT_INIT(16'hC33C)) inst6 (.I0(1'b0), .I1(I0[3]), .I2(I1[3]), .I3(inst5_CO), .O(inst6_O));
SB_CARRY inst7 (.I0(I0[3]), .I1(I1[3]), .CI(inst5_CO), .CO(inst7_CO));
assign O = {inst6_O,inst4_O,inst2_O,inst0_O};
assign COUT = inst7_CO;
endmodule

module Register4CE (input [3:0] I, output [3:0] O, input  CLK, input  CE);
wire  inst0_Q;
wire  inst1_Q;
wire  inst2_Q;
wire  inst3_Q;
SB_DFFE inst0 (.C(CLK), .E(CE), .D(I[0]), .Q(inst0_Q));
SB_DFFE inst1 (.C(CLK), .E(CE), .D(I[1]), .Q(inst1_Q));
SB_DFFE inst2 (.C(CLK), .E(CE), .D(I[2]), .Q(inst2_Q));
SB_DFFE inst3 (.C(CLK), .E(CE), .D(I[3]), .Q(inst3_Q));
assign O = {inst3_Q,inst2_Q,inst1_Q,inst0_Q};
endmodule

module Counter4CE (output [3:0] O, output  COUT, input  CLK, input  CE);
wire [3:0] inst0_O;
wire  inst0_COUT;
wire [3:0] inst1_O;
Addcout4 inst0 (.I0(inst1_O), .I1({1'b0,1'b0,1'b0,1'b1}), .O(inst0_O), .COUT(inst0_COUT));
Register4CE inst1 (.I(inst0_O), .O(inst1_O), .CLK(CLK), .CE(CE));
assign O = inst1_O;
assign COUT = inst0_COUT;
endmodule

module Mux2x8 (input [7:0] I0, input [7:0] I1, input  S, output [7:0] O);
wire  inst0_O;
wire  inst1_O;
wire  inst2_O;
wire  inst3_O;
wire  inst4_O;
wire  inst5_O;
wire  inst6_O;
wire  inst7_O;
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst0 (.I0(I0[0]), .I1(I1[0]), .I2(S), .I3(1'b0), .O(inst0_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst1 (.I0(I0[1]), .I1(I1[1]), .I2(S), .I3(1'b0), .O(inst1_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst2 (.I0(I0[2]), .I1(I1[2]), .I2(S), .I3(1'b0), .O(inst2_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst3 (.I0(I0[3]), .I1(I1[3]), .I2(S), .I3(1'b0), .O(inst3_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst4 (.I0(I0[4]), .I1(I1[4]), .I2(S), .I3(1'b0), .O(inst4_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst5 (.I0(I0[5]), .I1(I1[5]), .I2(S), .I3(1'b0), .O(inst5_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst6 (.I0(I0[6]), .I1(I1[6]), .I2(S), .I3(1'b0), .O(inst6_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst7 (.I0(I0[7]), .I1(I1[7]), .I2(S), .I3(1'b0), .O(inst7_O));
assign O = {inst7_O,inst6_O,inst5_O,inst4_O,inst3_O,inst2_O,inst1_O,inst0_O};
endmodule

module Register4 (input [3:0] I, output [3:0] O, input  CLK);
wire  inst0_Q;
wire  inst1_Q;
wire  inst2_Q;
wire  inst3_Q;
SB_DFF inst0 (.C(CLK), .D(I[0]), .Q(inst0_Q));
SB_DFF inst1 (.C(CLK), .D(I[1]), .Q(inst1_Q));
SB_DFF inst2 (.C(CLK), .D(I[2]), .Q(inst2_Q));
SB_DFF inst3 (.C(CLK), .D(I[3]), .Q(inst3_Q));
assign O = {inst3_Q,inst2_Q,inst1_Q,inst0_Q};
endmodule

module Counter4 (output [3:0] O, output  COUT, input  CLK);
wire [3:0] inst0_O;
wire  inst0_COUT;
wire [3:0] inst1_O;
Addcout4 inst0 (.I0(inst1_O), .I1({1'b0,1'b0,1'b0,1'b1}), .O(inst0_O), .COUT(inst0_COUT));
Register4 inst1 (.I(inst0_O), .O(inst1_O), .CLK(CLK));
assign O = inst1_O;
assign COUT = inst0_COUT;
endmodule

module Addcout6 (input [5:0] I0, input [5:0] I1, output [5:0] O, output  COUT);
wire  inst0_O;
wire  inst1_CO;
wire  inst2_O;
wire  inst3_CO;
wire  inst4_O;
wire  inst5_CO;
wire  inst6_O;
wire  inst7_CO;
wire  inst8_O;
wire  inst9_CO;
wire  inst10_O;
wire  inst11_CO;
SB_LUT4 #(.LUT_INIT(16'hC33C)) inst0 (.I0(1'b0), .I1(I0[0]), .I2(I1[0]), .I3(1'b0), .O(inst0_O));
SB_CARRY inst1 (.I0(I0[0]), .I1(I1[0]), .CI(1'b0), .CO(inst1_CO));
SB_LUT4 #(.LUT_INIT(16'hC33C)) inst2 (.I0(1'b0), .I1(I0[1]), .I2(I1[1]), .I3(inst1_CO), .O(inst2_O));
SB_CARRY inst3 (.I0(I0[1]), .I1(I1[1]), .CI(inst1_CO), .CO(inst3_CO));
SB_LUT4 #(.LUT_INIT(16'hC33C)) inst4 (.I0(1'b0), .I1(I0[2]), .I2(I1[2]), .I3(inst3_CO), .O(inst4_O));
SB_CARRY inst5 (.I0(I0[2]), .I1(I1[2]), .CI(inst3_CO), .CO(inst5_CO));
SB_LUT4 #(.LUT_INIT(16'hC33C)) inst6 (.I0(1'b0), .I1(I0[3]), .I2(I1[3]), .I3(inst5_CO), .O(inst6_O));
SB_CARRY inst7 (.I0(I0[3]), .I1(I1[3]), .CI(inst5_CO), .CO(inst7_CO));
SB_LUT4 #(.LUT_INIT(16'hC33C)) inst8 (.I0(1'b0), .I1(I0[4]), .I2(I1[4]), .I3(inst7_CO), .O(inst8_O));
SB_CARRY inst9 (.I0(I0[4]), .I1(I1[4]), .CI(inst7_CO), .CO(inst9_CO));
SB_LUT4 #(.LUT_INIT(16'hC33C)) inst10 (.I0(1'b0), .I1(I0[5]), .I2(I1[5]), .I3(inst9_CO), .O(inst10_O));
SB_CARRY inst11 (.I0(I0[5]), .I1(I1[5]), .CI(inst9_CO), .CO(inst11_CO));
assign O = {inst10_O,inst8_O,inst6_O,inst4_O,inst2_O,inst0_O};
assign COUT = inst11_CO;
endmodule

module Register6CE (input [5:0] I, output [5:0] O, input  CLK, input  CE);
wire  inst0_Q;
wire  inst1_Q;
wire  inst2_Q;
wire  inst3_Q;
wire  inst4_Q;
wire  inst5_Q;
SB_DFFE inst0 (.C(CLK), .E(CE), .D(I[0]), .Q(inst0_Q));
SB_DFFE inst1 (.C(CLK), .E(CE), .D(I[1]), .Q(inst1_Q));
SB_DFFE inst2 (.C(CLK), .E(CE), .D(I[2]), .Q(inst2_Q));
SB_DFFE inst3 (.C(CLK), .E(CE), .D(I[3]), .Q(inst3_Q));
SB_DFFE inst4 (.C(CLK), .E(CE), .D(I[4]), .Q(inst4_Q));
SB_DFFE inst5 (.C(CLK), .E(CE), .D(I[5]), .Q(inst5_Q));
assign O = {inst5_Q,inst4_Q,inst3_Q,inst2_Q,inst1_Q,inst0_Q};
endmodule

module Counter6CE (output [5:0] O, output  COUT, input  CLK, input  CE);
wire [5:0] inst0_O;
wire  inst0_COUT;
wire [5:0] inst1_O;
Addcout6 inst0 (.I0(inst1_O), .I1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b1}), .O(inst0_O), .COUT(inst0_COUT));
Register6CE inst1 (.I(inst0_O), .O(inst1_O), .CLK(CLK), .CE(CE));
assign O = inst1_O;
assign COUT = inst0_COUT;
endmodule

module Invert6 (input [5:0] I, output [5:0] O);
wire  inst0_O;
wire  inst1_O;
wire  inst2_O;
wire  inst3_O;
wire  inst4_O;
wire  inst5_O;
SB_LUT4 #(.LUT_INIT(16'h5555)) inst0 (.I0(I[0]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst0_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst1 (.I0(I[1]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst1_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst2 (.I0(I[2]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst2_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst3 (.I0(I[3]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst3_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst4 (.I0(I[4]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst4_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst5 (.I0(I[5]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst5_O));
assign O = {inst5_O,inst4_O,inst3_O,inst2_O,inst1_O,inst0_O};
endmodule

module Addcout3 (input [2:0] I0, input [2:0] I1, output [2:0] O, output  COUT);
wire  inst0_O;
wire  inst1_CO;
wire  inst2_O;
wire  inst3_CO;
wire  inst4_O;
wire  inst5_CO;
SB_LUT4 #(.LUT_INIT(16'hC33C)) inst0 (.I0(1'b0), .I1(I0[0]), .I2(I1[0]), .I3(1'b0), .O(inst0_O));
SB_CARRY inst1 (.I0(I0[0]), .I1(I1[0]), .CI(1'b0), .CO(inst1_CO));
SB_LUT4 #(.LUT_INIT(16'hC33C)) inst2 (.I0(1'b0), .I1(I0[1]), .I2(I1[1]), .I3(inst1_CO), .O(inst2_O));
SB_CARRY inst3 (.I0(I0[1]), .I1(I1[1]), .CI(inst1_CO), .CO(inst3_CO));
SB_LUT4 #(.LUT_INIT(16'hC33C)) inst4 (.I0(1'b0), .I1(I0[2]), .I2(I1[2]), .I3(inst3_CO), .O(inst4_O));
SB_CARRY inst5 (.I0(I0[2]), .I1(I1[2]), .CI(inst3_CO), .CO(inst5_CO));
assign O = {inst4_O,inst2_O,inst0_O};
assign COUT = inst5_CO;
endmodule

module Register3CER (input [2:0] I, output [2:0] O, input  CLK, input  CE, input  RESET);
wire  inst0_Q;
wire  inst1_Q;
wire  inst2_Q;
SB_DFFESR inst0 (.C(CLK), .R(RESET), .E(CE), .D(I[0]), .Q(inst0_Q));
SB_DFFESR inst1 (.C(CLK), .R(RESET), .E(CE), .D(I[1]), .Q(inst1_Q));
SB_DFFESR inst2 (.C(CLK), .R(RESET), .E(CE), .D(I[2]), .Q(inst2_Q));
assign O = {inst2_Q,inst1_Q,inst0_Q};
endmodule

module Counter3CER (output [2:0] O, output  COUT, input  CLK, input  CE, input  RESET);
wire [2:0] inst0_O;
wire  inst0_COUT;
wire [2:0] inst1_O;
Addcout3 inst0 (.I0(inst1_O), .I1({1'b0,1'b0,1'b1}), .O(inst0_O), .COUT(inst0_COUT));
Register3CER inst1 (.I(inst0_O), .O(inst1_O), .CLK(CLK), .CE(CE), .RESET(RESET));
assign O = inst1_O;
assign COUT = inst0_COUT;
endmodule

module Register8CE (input [7:0] I, output [7:0] O, input  CLK, input  CE);
wire  inst0_Q;
wire  inst1_Q;
wire  inst2_Q;
wire  inst3_Q;
wire  inst4_Q;
wire  inst5_Q;
wire  inst6_Q;
wire  inst7_Q;
SB_DFFE inst0 (.C(CLK), .E(CE), .D(I[0]), .Q(inst0_Q));
SB_DFFE inst1 (.C(CLK), .E(CE), .D(I[1]), .Q(inst1_Q));
SB_DFFE inst2 (.C(CLK), .E(CE), .D(I[2]), .Q(inst2_Q));
SB_DFFE inst3 (.C(CLK), .E(CE), .D(I[3]), .Q(inst3_Q));
SB_DFFE inst4 (.C(CLK), .E(CE), .D(I[4]), .Q(inst4_Q));
SB_DFFE inst5 (.C(CLK), .E(CE), .D(I[5]), .Q(inst5_Q));
SB_DFFE inst6 (.C(CLK), .E(CE), .D(I[6]), .Q(inst6_Q));
SB_DFFE inst7 (.C(CLK), .E(CE), .D(I[7]), .Q(inst7_Q));
assign O = {inst7_Q,inst6_Q,inst5_Q,inst4_Q,inst3_Q,inst2_Q,inst1_Q,inst0_Q};
endmodule

module PISO8CE (input  SI, input [7:0] PI, input  LOAD, output  O, input  CLK, input  CE);
wire  inst0_O;
wire  inst1_O;
wire  inst2_O;
wire  inst3_O;
wire  inst4_O;
wire  inst5_O;
wire  inst6_O;
wire  inst7_O;
wire [7:0] inst8_O;
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst0 (.I0(SI), .I1(PI[0]), .I2(LOAD), .I3(1'b0), .O(inst0_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst1 (.I0(inst8_O[0]), .I1(PI[1]), .I2(LOAD), .I3(1'b0), .O(inst1_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst2 (.I0(inst8_O[1]), .I1(PI[2]), .I2(LOAD), .I3(1'b0), .O(inst2_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst3 (.I0(inst8_O[2]), .I1(PI[3]), .I2(LOAD), .I3(1'b0), .O(inst3_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst4 (.I0(inst8_O[3]), .I1(PI[4]), .I2(LOAD), .I3(1'b0), .O(inst4_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst5 (.I0(inst8_O[4]), .I1(PI[5]), .I2(LOAD), .I3(1'b0), .O(inst5_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst6 (.I0(inst8_O[5]), .I1(PI[6]), .I2(LOAD), .I3(1'b0), .O(inst6_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst7 (.I0(inst8_O[6]), .I1(PI[7]), .I2(LOAD), .I3(1'b0), .O(inst7_O));
Register8CE inst8 (.I({inst7_O,inst6_O,inst5_O,inst4_O,inst3_O,inst2_O,inst1_O,inst0_O}), .O(inst8_O), .CLK(CLK), .CE(CE));
assign O = inst8_O[7];
endmodule

module Mux2x4 (input [3:0] I0, input [3:0] I1, input  S, output [3:0] O);
wire  inst0_O;
wire  inst1_O;
wire  inst2_O;
wire  inst3_O;
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst0 (.I0(I0[0]), .I1(I1[0]), .I2(S), .I3(1'b0), .O(inst0_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst1 (.I0(I0[1]), .I1(I1[1]), .I2(S), .I3(1'b0), .O(inst1_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst2 (.I0(I0[2]), .I1(I1[2]), .I2(S), .I3(1'b0), .O(inst2_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst3 (.I0(I0[3]), .I1(I1[3]), .I2(S), .I3(1'b0), .O(inst3_O));
assign O = {inst3_O,inst2_O,inst1_O,inst0_O};
endmodule

module Invert4 (input [3:0] I, output [3:0] O);
wire  inst0_O;
wire  inst1_O;
wire  inst2_O;
wire  inst3_O;
SB_LUT4 #(.LUT_INIT(16'h5555)) inst0 (.I0(I[0]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst0_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst1 (.I0(I[1]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst1_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst2 (.I0(I[2]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst2_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst3 (.I0(I[3]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst3_O));
assign O = {inst3_O,inst2_O,inst1_O,inst0_O};
endmodule

module main (output [4:0] J3, input  CLKIN);
wire [3:0] inst0_O;
wire  inst0_COUT;
wire [7:0] inst1_O;
wire [7:0] inst2_O;
wire [7:0] inst3_O;
wire [7:0] inst4_O;
wire [7:0] inst5_O;
wire [7:0] inst6_O;
wire [7:0] inst7_O;
wire [7:0] inst8_O;
wire [7:0] inst9_O;
wire [7:0] inst10_O;
wire [7:0] inst11_O;
wire [7:0] inst12_O;
wire [7:0] inst13_O;
wire [7:0] inst14_O;
wire [7:0] inst15_O;
wire [3:0] inst16_O;
wire  inst16_COUT;
wire [5:0] inst17_O;
wire  inst17_COUT;
wire  inst18_O;
wire [5:0] inst19_O;
wire [5:0] inst20_O;
wire  inst20_COUT;
wire  inst21_O;
wire [5:0] inst22_O;
wire [5:0] inst23_O;
wire  inst23_COUT;
wire [2:0] inst24_O;
wire  inst24_COUT;
wire  inst25_O;
wire  inst26_Q;
wire  inst27_O;
wire  inst28_O;
wire  inst29_O;
wire  inst30_O;
wire  inst31_O;
wire  inst32_O;
wire [3:0] inst33_O;
wire  inst34_O;
wire [3:0] inst35_O;
wire [3:0] inst36_O;
wire  inst36_COUT;
Counter4CE inst0 (.O(inst0_O), .COUT(inst0_COUT), .CLK(CLKIN), .CE(inst32_O));
Mux2x8 inst1 (.I0({1'b0,1'b1,1'b1,1'b0,1'b1,1'b0,1'b0,1'b0}), .I1({1'b0,1'b1,1'b1,1'b0,1'b0,1'b1,1'b0,1'b1}), .S(inst0_O[0]), .O(inst1_O));
Mux2x8 inst2 (.I0({1'b0,1'b1,1'b1,1'b0,1'b1,1'b1,1'b0,1'b0}), .I1({1'b0,1'b1,1'b1,1'b0,1'b1,1'b1,1'b0,1'b0}), .S(inst0_O[0]), .O(inst2_O));
Mux2x8 inst3 (.I0({1'b0,1'b1,1'b1,1'b0,1'b1,1'b1,1'b1,1'b1}), .I1({1'b0,1'b0,1'b1,1'b0,1'b1,1'b1,1'b0,1'b0}), .S(inst0_O[0]), .O(inst3_O));
Mux2x8 inst4 (.I0({1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0}), .I1({1'b0,1'b1,1'b1,1'b1,1'b0,1'b1,1'b1,1'b1}), .S(inst0_O[0]), .O(inst4_O));
Mux2x8 inst5 (.I0({1'b0,1'b1,1'b1,1'b0,1'b1,1'b1,1'b1,1'b1}), .I1({1'b0,1'b1,1'b1,1'b1,1'b0,1'b0,1'b1,1'b0}), .S(inst0_O[0]), .O(inst5_O));
Mux2x8 inst6 (.I0({1'b0,1'b1,1'b1,1'b0,1'b1,1'b1,1'b0,1'b0}), .I1({1'b0,1'b1,1'b1,1'b0,1'b0,1'b1,1'b0,1'b0}), .S(inst0_O[0]), .O(inst6_O));
Mux2x8 inst7 (.I0({1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0}), .I1({1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0}), .S(inst0_O[0]), .O(inst7_O));
Mux2x8 inst8 (.I0({1'b0,1'b0,1'b0,1'b0,1'b1,1'b1,1'b0,1'b1}), .I1({1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b1,1'b0}), .S(inst0_O[0]), .O(inst8_O));
Mux2x8 inst9 (.I0(inst1_O), .I1(inst2_O), .S(inst0_O[1]), .O(inst9_O));
Mux2x8 inst10 (.I0(inst3_O), .I1(inst4_O), .S(inst0_O[1]), .O(inst10_O));
Mux2x8 inst11 (.I0(inst5_O), .I1(inst6_O), .S(inst0_O[1]), .O(inst11_O));
Mux2x8 inst12 (.I0(inst7_O), .I1(inst8_O), .S(inst0_O[1]), .O(inst12_O));
Mux2x8 inst13 (.I0(inst9_O), .I1(inst10_O), .S(inst0_O[2]), .O(inst13_O));
Mux2x8 inst14 (.I0(inst11_O), .I1(inst12_O), .S(inst0_O[2]), .O(inst14_O));
Mux2x8 inst15 (.I0(inst13_O), .I1(inst14_O), .S(inst0_O[3]), .O(inst15_O));
Counter4 inst16 (.O(inst16_O), .COUT(inst16_COUT), .CLK(CLKIN));
Counter6CE inst17 (.O(inst17_O), .COUT(inst17_COUT), .CLK(CLKIN), .CE(inst16_COUT));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst18 (.I0(inst20_COUT), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst18_O));
Invert6 inst19 (.I({1'b0,1'b1,1'b0,1'b1,1'b1,1'b1}), .O(inst19_O));
Addcout6 inst20 (.I0(inst17_O), .I1(inst19_O), .O(inst20_O), .COUT(inst20_COUT));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst21 (.I0(inst23_COUT), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst21_O));
Invert6 inst22 (.I({1'b0,1'b1,1'b1,1'b0,1'b0,1'b0}), .O(inst22_O));
Addcout6 inst23 (.I0(inst17_O), .I1(inst22_O), .O(inst23_O), .COUT(inst23_COUT));
Counter3CER inst24 (.O(inst24_O), .COUT(inst24_COUT), .CLK(CLKIN), .CE(inst16_COUT), .RESET(inst28_O));
SB_LUT4 #(.LUT_INIT(16'h0080)) inst25 (.I0(inst24_O[0]), .I1(inst24_O[1]), .I2(inst24_O[2]), .I3(1'b0), .O(inst25_O));
SB_DFFE inst26 (.C(CLKIN), .E(inst16_COUT), .D(inst27_O), .Q(inst26_Q));
SB_LUT4 #(.LUT_INIT(16'h5454)) inst27 (.I0(inst25_O), .I1(inst18_O), .I2(inst26_Q), .I3(1'b0), .O(inst27_O));
SB_LUT4 #(.LUT_INIT(16'h2222)) inst28 (.I0(inst25_O), .I1(inst26_Q), .I2(1'b0), .I3(1'b0), .O(inst28_O));
PISO8CE inst29 (.SI(1'b1), .PI({inst15_O[0],inst15_O[1],inst15_O[2],inst15_O[3],inst15_O[4],inst15_O[5],inst15_O[6],inst15_O[7]}), .LOAD(inst30_O), .O(inst29_O), .CLK(CLKIN), .CE(inst16_COUT));
SB_LUT4 #(.LUT_INIT(16'h2222)) inst30 (.I0(inst18_O), .I1(inst26_Q), .I2(1'b0), .I3(1'b0), .O(inst30_O));
SB_LUT4 #(.LUT_INIT(16'h8888)) inst31 (.I0(inst29_O), .I1(inst21_O), .I2(1'b0), .I3(1'b0), .O(inst31_O));
SB_LUT4 #(.LUT_INIT(16'h4444)) inst32 (.I0(inst26_Q), .I1(inst16_COUT), .I2(1'b0), .I3(1'b0), .O(inst32_O));
Mux2x4 inst33 (.I0({1'b0,1'b1,1'b0,1'b0}), .I1({1'b1,1'b0,1'b0,1'b1}), .S(inst29_O), .O(inst33_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst34 (.I0(inst36_COUT), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst34_O));
Invert4 inst35 (.I(inst33_O), .O(inst35_O));
Addcout4 inst36 (.I0(inst16_O), .I1(inst35_O), .O(inst36_O), .COUT(inst36_COUT));
assign J3 = {inst31_O,inst21_O,inst29_O,inst16_COUT,1'b0};
endmodule

