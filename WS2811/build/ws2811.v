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

module Register3CE (input [2:0] I, output [2:0] O, input  CLK, input  CE);
wire  inst0_Q;
wire  inst1_Q;
wire  inst2_Q;
SB_DFFE inst0 (.C(CLK), .E(CE), .D(I[0]), .Q(inst0_Q));
SB_DFFE inst1 (.C(CLK), .E(CE), .D(I[1]), .Q(inst1_Q));
SB_DFFE inst2 (.C(CLK), .E(CE), .D(I[2]), .Q(inst2_Q));
assign O = {inst2_Q,inst1_Q,inst0_Q};
endmodule

module Counter3CE (output [2:0] O, output  COUT, input  CLK, input  CE);
wire [2:0] inst0_O;
wire  inst0_COUT;
wire [2:0] inst1_O;
Addcout3 inst0 (.I0(inst1_O), .I1({1'b0,1'b0,1'b1}), .O(inst0_O), .COUT(inst0_COUT));
Register3CE inst1 (.I(inst0_O), .O(inst1_O), .CLK(CLK), .CE(CE));
assign O = inst1_O;
assign COUT = inst0_COUT;
endmodule

module Addcout8 (input [7:0] I0, input [7:0] I1, output [7:0] O, output  COUT);
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
wire  inst12_O;
wire  inst13_CO;
wire  inst14_O;
wire  inst15_CO;
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
SB_LUT4 #(.LUT_INIT(16'hC33C)) inst12 (.I0(1'b0), .I1(I0[6]), .I2(I1[6]), .I3(inst11_CO), .O(inst12_O));
SB_CARRY inst13 (.I0(I0[6]), .I1(I1[6]), .CI(inst11_CO), .CO(inst13_CO));
SB_LUT4 #(.LUT_INIT(16'hC33C)) inst14 (.I0(1'b0), .I1(I0[7]), .I2(I1[7]), .I3(inst13_CO), .O(inst14_O));
SB_CARRY inst15 (.I0(I0[7]), .I1(I1[7]), .CI(inst13_CO), .CO(inst15_CO));
assign O = {inst14_O,inst12_O,inst10_O,inst8_O,inst6_O,inst4_O,inst2_O,inst0_O};
assign COUT = inst15_CO;
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

module Counter8CE (output [7:0] O, output  COUT, input  CLK, input  CE);
wire [7:0] inst0_O;
wire  inst0_COUT;
wire [7:0] inst1_O;
Addcout8 inst0 (.I0(inst1_O), .I1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1}), .O(inst0_O), .COUT(inst0_COUT));
Register8CE inst1 (.I(inst0_O), .O(inst1_O), .CLK(CLK), .CE(CE));
assign O = inst1_O;
assign COUT = inst0_COUT;
endmodule

module Invert8 (input [7:0] I, output [7:0] O);
wire  inst0_O;
wire  inst1_O;
wire  inst2_O;
wire  inst3_O;
wire  inst4_O;
wire  inst5_O;
wire  inst6_O;
wire  inst7_O;
SB_LUT4 #(.LUT_INIT(16'h5555)) inst0 (.I0(I[0]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst0_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst1 (.I0(I[1]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst1_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst2 (.I0(I[2]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst2_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst3 (.I0(I[3]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst3_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst4 (.I0(I[4]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst4_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst5 (.I0(I[5]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst5_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst6 (.I0(I[6]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst6_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst7 (.I0(I[7]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst7_O));
assign O = {inst7_O,inst6_O,inst5_O,inst4_O,inst3_O,inst2_O,inst1_O,inst0_O};
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

module Addcout9 (input [8:0] I0, input [8:0] I1, output [8:0] O, output  COUT);
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
wire  inst12_O;
wire  inst13_CO;
wire  inst14_O;
wire  inst15_CO;
wire  inst16_O;
wire  inst17_CO;
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
SB_LUT4 #(.LUT_INIT(16'hC33C)) inst12 (.I0(1'b0), .I1(I0[6]), .I2(I1[6]), .I3(inst11_CO), .O(inst12_O));
SB_CARRY inst13 (.I0(I0[6]), .I1(I1[6]), .CI(inst11_CO), .CO(inst13_CO));
SB_LUT4 #(.LUT_INIT(16'hC33C)) inst14 (.I0(1'b0), .I1(I0[7]), .I2(I1[7]), .I3(inst13_CO), .O(inst14_O));
SB_CARRY inst15 (.I0(I0[7]), .I1(I1[7]), .CI(inst13_CO), .CO(inst15_CO));
SB_LUT4 #(.LUT_INIT(16'hC33C)) inst16 (.I0(1'b0), .I1(I0[8]), .I2(I1[8]), .I3(inst15_CO), .O(inst16_O));
SB_CARRY inst17 (.I0(I0[8]), .I1(I1[8]), .CI(inst15_CO), .CO(inst17_CO));
assign O = {inst16_O,inst14_O,inst12_O,inst10_O,inst8_O,inst6_O,inst4_O,inst2_O,inst0_O};
assign COUT = inst17_CO;
endmodule

module Register9CER (input [8:0] I, output [8:0] O, input  CLK, input  CE, input  RESET);
wire  inst0_Q;
wire  inst1_Q;
wire  inst2_Q;
wire  inst3_Q;
wire  inst4_Q;
wire  inst5_Q;
wire  inst6_Q;
wire  inst7_Q;
wire  inst8_Q;
SB_DFFESR inst0 (.C(CLK), .R(RESET), .E(CE), .D(I[0]), .Q(inst0_Q));
SB_DFFESR inst1 (.C(CLK), .R(RESET), .E(CE), .D(I[1]), .Q(inst1_Q));
SB_DFFESR inst2 (.C(CLK), .R(RESET), .E(CE), .D(I[2]), .Q(inst2_Q));
SB_DFFESR inst3 (.C(CLK), .R(RESET), .E(CE), .D(I[3]), .Q(inst3_Q));
SB_DFFESR inst4 (.C(CLK), .R(RESET), .E(CE), .D(I[4]), .Q(inst4_Q));
SB_DFFESR inst5 (.C(CLK), .R(RESET), .E(CE), .D(I[5]), .Q(inst5_Q));
SB_DFFESR inst6 (.C(CLK), .R(RESET), .E(CE), .D(I[6]), .Q(inst6_Q));
SB_DFFESR inst7 (.C(CLK), .R(RESET), .E(CE), .D(I[7]), .Q(inst7_Q));
SB_DFFESR inst8 (.C(CLK), .R(RESET), .E(CE), .D(I[8]), .Q(inst8_Q));
assign O = {inst8_Q,inst7_Q,inst6_Q,inst5_Q,inst4_Q,inst3_Q,inst2_Q,inst1_Q,inst0_Q};
endmodule

module Counter9CER (output [8:0] O, output  COUT, input  CLK, input  CE, input  RESET);
wire [8:0] inst0_O;
wire  inst0_COUT;
wire [8:0] inst1_O;
Addcout9 inst0 (.I0(inst1_O), .I1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1}), .O(inst0_O), .COUT(inst0_COUT));
Register9CER inst1 (.I(inst0_O), .O(inst1_O), .CLK(CLK), .CE(CE), .RESET(RESET));
assign O = inst1_O;
assign COUT = inst0_COUT;
endmodule

module Invert9 (input [8:0] I, output [8:0] O);
wire  inst0_O;
wire  inst1_O;
wire  inst2_O;
wire  inst3_O;
wire  inst4_O;
wire  inst5_O;
wire  inst6_O;
wire  inst7_O;
wire  inst8_O;
SB_LUT4 #(.LUT_INIT(16'h5555)) inst0 (.I0(I[0]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst0_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst1 (.I0(I[1]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst1_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst2 (.I0(I[2]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst2_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst3 (.I0(I[3]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst3_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst4 (.I0(I[4]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst4_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst5 (.I0(I[5]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst5_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst6 (.I0(I[6]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst6_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst7 (.I0(I[7]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst7_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst8 (.I0(I[8]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst8_O));
assign O = {inst8_O,inst7_O,inst6_O,inst5_O,inst4_O,inst3_O,inst2_O,inst1_O,inst0_O};
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

module Register8CER (input [7:0] I, output [7:0] O, input  CLK, input  CE, input  RESET);
wire  inst0_Q;
wire  inst1_Q;
wire  inst2_Q;
wire  inst3_Q;
wire  inst4_Q;
wire  inst5_Q;
wire  inst6_Q;
wire  inst7_Q;
SB_DFFESR inst0 (.C(CLK), .R(RESET), .E(CE), .D(I[0]), .Q(inst0_Q));
SB_DFFESR inst1 (.C(CLK), .R(RESET), .E(CE), .D(I[1]), .Q(inst1_Q));
SB_DFFESR inst2 (.C(CLK), .R(RESET), .E(CE), .D(I[2]), .Q(inst2_Q));
SB_DFFESR inst3 (.C(CLK), .R(RESET), .E(CE), .D(I[3]), .Q(inst3_Q));
SB_DFFESR inst4 (.C(CLK), .R(RESET), .E(CE), .D(I[4]), .Q(inst4_Q));
SB_DFFESR inst5 (.C(CLK), .R(RESET), .E(CE), .D(I[5]), .Q(inst5_Q));
SB_DFFESR inst6 (.C(CLK), .R(RESET), .E(CE), .D(I[6]), .Q(inst6_Q));
SB_DFFESR inst7 (.C(CLK), .R(RESET), .E(CE), .D(I[7]), .Q(inst7_Q));
assign O = {inst7_Q,inst6_Q,inst5_Q,inst4_Q,inst3_Q,inst2_Q,inst1_Q,inst0_Q};
endmodule

module Counter8CER (output [7:0] O, output  COUT, input  CLK, input  CE, input  RESET);
wire [7:0] inst0_O;
wire  inst0_COUT;
wire [7:0] inst1_O;
Addcout8 inst0 (.I0(inst1_O), .I1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1}), .O(inst0_O), .COUT(inst0_COUT));
Register8CER inst1 (.I(inst0_O), .O(inst1_O), .CLK(CLK), .CE(CE), .RESET(RESET));
assign O = inst1_O;
assign COUT = inst0_COUT;
endmodule

module main (output  D4, output  D5, output  D6, output  D7, input  O, output  I, output  D3, output  D2, output  D1, output  D0, input  CLKIN);
wire [3:0] inst0_O;
wire  inst0_COUT;
wire [15:0] inst1_RDATA;
wire [2:0] inst2_O;
wire  inst2_COUT;
wire  inst3_O;
wire [7:0] inst4_O;
wire  inst4_COUT;
wire  inst5_O;
wire [7:0] inst6_O;
wire [7:0] inst7_O;
wire  inst7_COUT;
wire  inst8_Q;
wire [2:0] inst9_O;
wire  inst9_COUT;
wire  inst10_O;
wire  inst11_Q;
wire  inst12_O;
wire  inst13_O;
wire  inst14_O;
wire  inst15_O;
wire  inst16_O;
wire  inst17_O;
wire  inst18_O;
wire [8:0] inst19_O;
wire  inst19_COUT;
wire  inst20_O;
wire [8:0] inst21_O;
wire [8:0] inst22_O;
wire  inst22_COUT;
wire [8:0] inst23_O;
wire  inst23_COUT;
wire [3:0] inst24_O;
wire  inst25_O;
wire [3:0] inst26_O;
wire [3:0] inst27_O;
wire  inst27_COUT;
wire  inst28_O;
wire  inst29_Q;
wire  inst30_O;
wire  inst31_O;
wire [7:0] inst32_O;
wire  inst32_COUT;
wire  inst33_O;
wire  inst34_O;
wire  inst35_O;
wire  inst36_O;
wire  inst37_O;
wire  inst38_O;
wire  inst39_O;
wire  inst40_O;
wire  inst41_O;
wire  inst42_O;
wire  inst43_O;
wire  inst44_O;
wire  inst45_O;
wire  inst46_O;
wire  inst47_O;
wire  inst48_O;
wire  inst49_O;
wire  inst50_O;
wire  inst51_O;
wire  inst52_O;
wire  inst53_O;
wire  inst54_O;
wire  inst55_O;
wire  inst56_O;
wire  inst57_O;
wire  inst58_O;
wire  inst59_O;
wire  inst60_O;
wire  inst61_O;
wire  inst62_O;
wire  inst63_O;
wire  inst64_O;
wire  inst65_O;
wire  inst66_O;
wire  inst67_O;
wire  inst68_O;
wire  inst69_O;
wire  inst70_O;
wire  inst71_O;
wire  inst72_O;
wire  inst73_O;
wire  inst74_O;
wire  inst75_O;
wire  inst76_O;
wire  inst77_O;
wire  inst78_O;
wire  inst79_O;
wire  inst80_O;
wire  inst81_O;
wire  inst82_O;
wire  inst83_O;
wire  inst84_O;
wire  inst85_O;
wire  inst86_O;
wire  inst87_O;
wire  inst88_O;
wire  inst89_O;
wire  inst90_O;
wire  inst91_O;
wire  inst92_O;
wire  inst93_O;
wire  inst94_O;
wire  inst95_O;
wire  inst96_O;
Counter4 inst0 (.O(inst0_O), .COUT(inst0_COUT), .CLK(CLKIN));
SB_RAM40_4K #(.INIT_1(256'h03BA02A803E303B5028A03C803C30280033B036902220324034B020802570341),
.INIT_0(256'h00AA00F801E300A000CB01C900820094016B002800270161000A000801430000),
.INIT_3(256'h0AEE0BE90AA20AB50BCB0A880A920BC10A2A0A290B630A200A0A0B490A060A00),
.INIT_2(256'h09EB08B908A209E108CA088809C308C5082A096908760820094B090908020941),
.INIT_5(256'h22BF22A823E322E4228A23C922D32280236B232822222361230F220823432314),
.INIT_4(256'h20AA21E921E320A0219E21C920822185216B202821222161200A205921432000),
.INIT_7(256'h2BEB2BE92AA22BB52BCB2A882B922BC12A2A2B292B632A202A5E2B492A022A45),
.INIT_6(256'h29EB28A828E229E1288A289929C32880282E296928232820294B281828022941),
.INIT_9(256'hC3FFC3FCC3F3C3F0C3CFC3CCC3C3C3C0C33F822D82228361821E820883438241),
.INIT_8(256'h80AA81E980F280A081CB80DD808281C1812E802881638131800A814981428000),
.INIT_A(256'hCCFFCCFCCCF3CCF0CCCFCCCCCCC3CCC0CC3FCC3CCC33CC30CC0FCC0CCC03CC00),
.INIT_C(256'hF0FFF0FCF0F3F0F0F0CFF0CCF0C3F0C0F03FF03CF033F030F00FF00CF003F000),
.READ_MODE(1),
.INIT_E(256'hFCFFFCFCFCF3FCF0FCCFFCCCFCC3FCC0FC3FFC3CFC33FC30FC0FFC0CFC03FC00),
.INIT_D(256'hF3FFF3FCF3F3F3F0F3CFF3CCF3C3F3C0F33FF33CF333F330F30FF30CF303F300),
.INIT_F(256'hFFFFFFFCFFF3FFF0FFCFFFCCFFC3FFC0FF3FFF3CFF33FF30FF0FFF0CFF03FF00),
.WRITE_MODE(1),
.INIT_B(256'hCFFFCFFCCFF3CFF0CFCFCFCCCFC3CFC0CF3FCF3CCF33CF30CF0FCF0CCF03CF00)) inst1 (.RDATA(inst1_RDATA), .RADDR({1'b0,1'b0,inst23_O[8],inst23_O[7],inst23_O[6],inst23_O[5],inst23_O[4],inst23_O[3],inst23_O[2],inst23_O[1],inst23_O[0]}), .RCLK(CLKIN), .RCLKE(1'b1), .RE(1'b1), .WCLK(CLKIN), .WCLKE(1'b1), .WE(1'b1), .MASK({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
Counter3CE inst2 (.O(inst2_O), .COUT(inst2_COUT), .CLK(CLKIN), .CE(inst0_COUT));
SB_LUT4 #(.LUT_INIT(16'h8888)) inst3 (.I0(inst0_COUT), .I1(inst2_COUT), .I2(1'b0), .I3(1'b0), .O(inst3_O));
Counter8CE inst4 (.O(inst4_O), .COUT(inst4_COUT), .CLK(CLKIN), .CE(inst3_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst5 (.I0(inst7_COUT), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst5_O));
Invert8 inst6 (.I({1'b1,1'b0,1'b0,1'b1,1'b0,1'b1,1'b0,1'b1}), .O(inst6_O));
Addcout8 inst7 (.I0(inst4_O), .I1(inst6_O), .O(inst7_O), .COUT(inst7_COUT));
SB_DFFE inst8 (.C(CLKIN), .E(inst0_COUT), .D(inst5_O), .Q(inst8_Q));
Counter3CER inst9 (.O(inst9_O), .COUT(inst9_COUT), .CLK(CLKIN), .CE(inst0_COUT), .RESET(inst13_O));
SB_LUT4 #(.LUT_INIT(16'h0080)) inst10 (.I0(inst9_O[0]), .I1(inst9_O[1]), .I2(inst9_O[2]), .I3(1'b0), .O(inst10_O));
SB_DFFE inst11 (.C(CLKIN), .E(inst0_COUT), .D(inst12_O), .Q(inst11_Q));
SB_LUT4 #(.LUT_INIT(16'h5454)) inst12 (.I0(inst10_O), .I1(inst5_O), .I2(inst11_Q), .I3(1'b0), .O(inst12_O));
SB_LUT4 #(.LUT_INIT(16'h2222)) inst13 (.I0(inst10_O), .I1(inst11_Q), .I2(1'b0), .I3(1'b0), .O(inst13_O));
PISO8CE inst14 (.SI(1'b1), .PI({inst1_RDATA[14],inst1_RDATA[12],inst1_RDATA[10],inst1_RDATA[8],inst1_RDATA[6],inst1_RDATA[4],inst1_RDATA[2],inst1_RDATA[0]}), .LOAD(inst15_O), .O(inst14_O), .CLK(CLKIN), .CE(inst0_COUT));
SB_LUT4 #(.LUT_INIT(16'h2222)) inst15 (.I0(inst5_O), .I1(inst11_Q), .I2(1'b0), .I3(1'b0), .O(inst15_O));
SB_LUT4 #(.LUT_INIT(16'h4444)) inst16 (.I0(inst11_Q), .I1(inst0_COUT), .I2(1'b0), .I3(1'b0), .O(inst16_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst17 (.I0(inst11_Q), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst17_O));
SB_LUT4 #(.LUT_INIT(16'h8080)) inst18 (.I0(inst17_O), .I1(inst0_COUT), .I2(inst5_O), .I3(1'b0), .O(inst18_O));
Counter9CER inst19 (.O(inst19_O), .COUT(inst19_COUT), .CLK(CLKIN), .CE(inst18_O), .RESET(inst20_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst20 (.I0(inst22_COUT), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst20_O));
Invert9 inst21 (.I(inst19_O), .O(inst21_O));
Addcout9 inst22 (.I0({1'b0,1'b1,1'b0,1'b0,1'b1,1'b0,1'b1,1'b0,1'b1}), .I1(inst21_O), .O(inst22_O), .COUT(inst22_COUT));
Addcout9 inst23 (.I0(inst19_O), .I1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1}), .O(inst23_O), .COUT(inst23_COUT));
Mux2x4 inst24 (.I0({1'b0,1'b1,1'b0,1'b0}), .I1({1'b1,1'b0,1'b0,1'b1}), .S(inst14_O), .O(inst24_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst25 (.I0(inst27_COUT), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst25_O));
Invert4 inst26 (.I(inst24_O), .O(inst26_O));
Addcout4 inst27 (.I0(inst0_O), .I1(inst26_O), .O(inst27_O), .COUT(inst27_COUT));
SB_LUT4 #(.LUT_INIT(16'h8888)) inst28 (.I0(inst25_O), .I1(inst8_Q), .I2(1'b0), .I3(1'b0), .O(inst28_O));
SB_DFF inst29 (.C(CLKIN), .D(O), .Q(inst29_Q));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst30 (.I0(O), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst30_O));
SB_LUT4 #(.LUT_INIT(16'h8888)) inst31 (.I0(inst29_Q), .I1(inst30_O), .I2(1'b0), .I3(1'b0), .O(inst31_O));
Counter8CER inst32 (.O(inst32_O), .COUT(inst32_COUT), .CLK(CLKIN), .CE(1'b1), .RESET(inst65_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst33 (.I0(inst32_O[0]), .I1(inst32_O[1]), .I2(inst32_O[2]), .I3(inst32_O[3]), .O(inst33_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst34 (.I0(inst32_O[0]), .I1(inst32_O[1]), .I2(inst32_O[2]), .I3(inst32_O[3]), .O(inst34_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst35 (.I0(inst33_O), .I1(inst34_O), .I2(inst32_O[4]), .I3(1'b0), .O(inst35_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst36 (.I0(inst32_O[0]), .I1(inst32_O[1]), .I2(inst32_O[2]), .I3(inst32_O[3]), .O(inst36_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst37 (.I0(inst32_O[0]), .I1(inst32_O[1]), .I2(inst32_O[2]), .I3(inst32_O[3]), .O(inst37_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst38 (.I0(inst36_O), .I1(inst37_O), .I2(inst32_O[4]), .I3(1'b0), .O(inst38_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst39 (.I0(inst35_O), .I1(inst38_O), .I2(inst32_O[5]), .I3(1'b0), .O(inst39_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst40 (.I0(inst32_O[0]), .I1(inst32_O[1]), .I2(inst32_O[2]), .I3(inst32_O[3]), .O(inst40_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst41 (.I0(inst32_O[0]), .I1(inst32_O[1]), .I2(inst32_O[2]), .I3(inst32_O[3]), .O(inst41_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst42 (.I0(inst40_O), .I1(inst41_O), .I2(inst32_O[4]), .I3(1'b0), .O(inst42_O));
SB_LUT4 #(.LUT_INIT(16'h0040)) inst43 (.I0(inst32_O[0]), .I1(inst32_O[1]), .I2(inst32_O[2]), .I3(inst32_O[3]), .O(inst43_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst44 (.I0(inst32_O[0]), .I1(inst32_O[1]), .I2(inst32_O[2]), .I3(inst32_O[3]), .O(inst44_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst45 (.I0(inst43_O), .I1(inst44_O), .I2(inst32_O[4]), .I3(1'b0), .O(inst45_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst46 (.I0(inst42_O), .I1(inst45_O), .I2(inst32_O[5]), .I3(1'b0), .O(inst46_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst47 (.I0(inst39_O), .I1(inst46_O), .I2(inst32_O[6]), .I3(1'b0), .O(inst47_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst48 (.I0(inst32_O[0]), .I1(inst32_O[1]), .I2(inst32_O[2]), .I3(inst32_O[3]), .O(inst48_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst49 (.I0(inst32_O[0]), .I1(inst32_O[1]), .I2(inst32_O[2]), .I3(inst32_O[3]), .O(inst49_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst50 (.I0(inst48_O), .I1(inst49_O), .I2(inst32_O[4]), .I3(1'b0), .O(inst50_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst51 (.I0(inst32_O[0]), .I1(inst32_O[1]), .I2(inst32_O[2]), .I3(inst32_O[3]), .O(inst51_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst52 (.I0(inst32_O[0]), .I1(inst32_O[1]), .I2(inst32_O[2]), .I3(inst32_O[3]), .O(inst52_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst53 (.I0(inst51_O), .I1(inst52_O), .I2(inst32_O[4]), .I3(1'b0), .O(inst53_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst54 (.I0(inst50_O), .I1(inst53_O), .I2(inst32_O[5]), .I3(1'b0), .O(inst54_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst55 (.I0(inst32_O[0]), .I1(inst32_O[1]), .I2(inst32_O[2]), .I3(inst32_O[3]), .O(inst55_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst56 (.I0(inst32_O[0]), .I1(inst32_O[1]), .I2(inst32_O[2]), .I3(inst32_O[3]), .O(inst56_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst57 (.I0(inst55_O), .I1(inst56_O), .I2(inst32_O[4]), .I3(1'b0), .O(inst57_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst58 (.I0(inst32_O[0]), .I1(inst32_O[1]), .I2(inst32_O[2]), .I3(inst32_O[3]), .O(inst58_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst59 (.I0(inst32_O[0]), .I1(inst32_O[1]), .I2(inst32_O[2]), .I3(inst32_O[3]), .O(inst59_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst60 (.I0(inst58_O), .I1(inst59_O), .I2(inst32_O[4]), .I3(1'b0), .O(inst60_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst61 (.I0(inst57_O), .I1(inst60_O), .I2(inst32_O[5]), .I3(1'b0), .O(inst61_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst62 (.I0(inst54_O), .I1(inst61_O), .I2(inst32_O[6]), .I3(1'b0), .O(inst62_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst63 (.I0(inst47_O), .I1(inst62_O), .I2(inst32_O[7]), .I3(1'b0), .O(inst63_O));
SB_LUT4 #(.LUT_INIT(16'hEEEE)) inst64 (.I0(inst63_O), .I1(inst31_O), .I2(1'b0), .I3(1'b0), .O(inst64_O));
SB_LUT4 #(.LUT_INIT(16'h8888)) inst65 (.I0(inst64_O), .I1(1'b1), .I2(1'b0), .I3(1'b0), .O(inst65_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst66 (.I0(inst32_O[0]), .I1(inst32_O[1]), .I2(inst32_O[2]), .I3(inst32_O[3]), .O(inst66_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst67 (.I0(inst32_O[0]), .I1(inst32_O[1]), .I2(inst32_O[2]), .I3(inst32_O[3]), .O(inst67_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst68 (.I0(inst66_O), .I1(inst67_O), .I2(inst32_O[4]), .I3(1'b0), .O(inst68_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst69 (.I0(inst32_O[0]), .I1(inst32_O[1]), .I2(inst32_O[2]), .I3(inst32_O[3]), .O(inst69_O));
SB_LUT4 #(.LUT_INIT(16'h0008)) inst70 (.I0(inst32_O[0]), .I1(inst32_O[1]), .I2(inst32_O[2]), .I3(inst32_O[3]), .O(inst70_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst71 (.I0(inst69_O), .I1(inst70_O), .I2(inst32_O[4]), .I3(1'b0), .O(inst71_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst72 (.I0(inst68_O), .I1(inst71_O), .I2(inst32_O[5]), .I3(1'b0), .O(inst72_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst73 (.I0(inst32_O[0]), .I1(inst32_O[1]), .I2(inst32_O[2]), .I3(inst32_O[3]), .O(inst73_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst74 (.I0(inst32_O[0]), .I1(inst32_O[1]), .I2(inst32_O[2]), .I3(inst32_O[3]), .O(inst74_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst75 (.I0(inst73_O), .I1(inst74_O), .I2(inst32_O[4]), .I3(1'b0), .O(inst75_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst76 (.I0(inst32_O[0]), .I1(inst32_O[1]), .I2(inst32_O[2]), .I3(inst32_O[3]), .O(inst76_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst77 (.I0(inst32_O[0]), .I1(inst32_O[1]), .I2(inst32_O[2]), .I3(inst32_O[3]), .O(inst77_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst78 (.I0(inst76_O), .I1(inst77_O), .I2(inst32_O[4]), .I3(1'b0), .O(inst78_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst79 (.I0(inst75_O), .I1(inst78_O), .I2(inst32_O[5]), .I3(1'b0), .O(inst79_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst80 (.I0(inst72_O), .I1(inst79_O), .I2(inst32_O[6]), .I3(1'b0), .O(inst80_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst81 (.I0(inst32_O[0]), .I1(inst32_O[1]), .I2(inst32_O[2]), .I3(inst32_O[3]), .O(inst81_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst82 (.I0(inst32_O[0]), .I1(inst32_O[1]), .I2(inst32_O[2]), .I3(inst32_O[3]), .O(inst82_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst83 (.I0(inst81_O), .I1(inst82_O), .I2(inst32_O[4]), .I3(1'b0), .O(inst83_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst84 (.I0(inst32_O[0]), .I1(inst32_O[1]), .I2(inst32_O[2]), .I3(inst32_O[3]), .O(inst84_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst85 (.I0(inst32_O[0]), .I1(inst32_O[1]), .I2(inst32_O[2]), .I3(inst32_O[3]), .O(inst85_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst86 (.I0(inst84_O), .I1(inst85_O), .I2(inst32_O[4]), .I3(1'b0), .O(inst86_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst87 (.I0(inst83_O), .I1(inst86_O), .I2(inst32_O[5]), .I3(1'b0), .O(inst87_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst88 (.I0(inst32_O[0]), .I1(inst32_O[1]), .I2(inst32_O[2]), .I3(inst32_O[3]), .O(inst88_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst89 (.I0(inst32_O[0]), .I1(inst32_O[1]), .I2(inst32_O[2]), .I3(inst32_O[3]), .O(inst89_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst90 (.I0(inst88_O), .I1(inst89_O), .I2(inst32_O[4]), .I3(1'b0), .O(inst90_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst91 (.I0(inst32_O[0]), .I1(inst32_O[1]), .I2(inst32_O[2]), .I3(inst32_O[3]), .O(inst91_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst92 (.I0(inst32_O[0]), .I1(inst32_O[1]), .I2(inst32_O[2]), .I3(inst32_O[3]), .O(inst92_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst93 (.I0(inst91_O), .I1(inst92_O), .I2(inst32_O[4]), .I3(1'b0), .O(inst93_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst94 (.I0(inst90_O), .I1(inst93_O), .I2(inst32_O[5]), .I3(1'b0), .O(inst94_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst95 (.I0(inst87_O), .I1(inst94_O), .I2(inst32_O[6]), .I3(1'b0), .O(inst95_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst96 (.I0(inst80_O), .I1(inst95_O), .I2(inst32_O[7]), .I3(1'b0), .O(inst96_O));
assign D4 = 1'b0;
assign D5 = 1'b0;
assign D6 = 1'b0;
assign D7 = O;
assign I = inst28_O;
assign D3 = 1'b0;
assign D2 = 1'b0;
assign D1 = 1'b0;
assign D0 = inst96_O;
endmodule

