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

module Register9CE (input [8:0] I, output [8:0] O, input  CLK, input  CE);
wire  inst0_Q;
wire  inst1_Q;
wire  inst2_Q;
wire  inst3_Q;
wire  inst4_Q;
wire  inst5_Q;
wire  inst6_Q;
wire  inst7_Q;
wire  inst8_Q;
SB_DFFE inst0 (.C(CLK), .E(CE), .D(I[0]), .Q(inst0_Q));
SB_DFFE inst1 (.C(CLK), .E(CE), .D(I[1]), .Q(inst1_Q));
SB_DFFE inst2 (.C(CLK), .E(CE), .D(I[2]), .Q(inst2_Q));
SB_DFFE inst3 (.C(CLK), .E(CE), .D(I[3]), .Q(inst3_Q));
SB_DFFE inst4 (.C(CLK), .E(CE), .D(I[4]), .Q(inst4_Q));
SB_DFFE inst5 (.C(CLK), .E(CE), .D(I[5]), .Q(inst5_Q));
SB_DFFE inst6 (.C(CLK), .E(CE), .D(I[6]), .Q(inst6_Q));
SB_DFFE inst7 (.C(CLK), .E(CE), .D(I[7]), .Q(inst7_Q));
SB_DFFE inst8 (.C(CLK), .E(CE), .D(I[8]), .Q(inst8_Q));
assign O = {inst8_Q,inst7_Q,inst6_Q,inst5_Q,inst4_Q,inst3_Q,inst2_Q,inst1_Q,inst0_Q};
endmodule

module Counter9CE (output [8:0] O, output  COUT, input  CLK, input  CE);
wire [8:0] inst0_O;
wire  inst0_COUT;
wire [8:0] inst1_O;
Addcout9 inst0 (.I0(inst1_O), .I1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1}), .O(inst0_O), .COUT(inst0_COUT));
Register9CE inst1 (.I(inst0_O), .O(inst1_O), .CLK(CLK), .CE(CE));
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

module Register4CER (input [3:0] I, output [3:0] O, input  CLK, input  CE, input  RESET);
wire  inst0_Q;
wire  inst1_Q;
wire  inst2_Q;
wire  inst3_Q;
SB_DFFESR inst0 (.C(CLK), .R(RESET), .E(CE), .D(I[0]), .Q(inst0_Q));
SB_DFFESR inst1 (.C(CLK), .R(RESET), .E(CE), .D(I[1]), .Q(inst1_Q));
SB_DFFESR inst2 (.C(CLK), .R(RESET), .E(CE), .D(I[2]), .Q(inst2_Q));
SB_DFFESR inst3 (.C(CLK), .R(RESET), .E(CE), .D(I[3]), .Q(inst3_Q));
assign O = {inst3_Q,inst2_Q,inst1_Q,inst0_Q};
endmodule

module Counter4CER (output [3:0] O, output  COUT, input  CLK, input  CE, input  RESET);
wire [3:0] inst0_O;
wire  inst0_COUT;
wire [3:0] inst1_O;
Addcout4 inst0 (.I0(inst1_O), .I1({1'b0,1'b0,1'b0,1'b1}), .O(inst0_O), .COUT(inst0_COUT));
Register4CER inst1 (.I(inst0_O), .O(inst1_O), .CLK(CLK), .CE(CE), .RESET(RESET));
assign O = inst1_O;
assign COUT = inst0_COUT;
endmodule

module SIPO10CE (input  I, output [9:0] O, input  CLK, input  CE);
wire  inst0_Q;
wire  inst1_Q;
wire  inst2_Q;
wire  inst3_Q;
wire  inst4_Q;
wire  inst5_Q;
wire  inst6_Q;
wire  inst7_Q;
wire  inst8_Q;
wire  inst9_Q;
SB_DFFE inst0 (.C(CLK), .E(CE), .D(I), .Q(inst0_Q));
SB_DFFE inst1 (.C(CLK), .E(CE), .D(inst0_Q), .Q(inst1_Q));
SB_DFFE inst2 (.C(CLK), .E(CE), .D(inst1_Q), .Q(inst2_Q));
SB_DFFE inst3 (.C(CLK), .E(CE), .D(inst2_Q), .Q(inst3_Q));
SB_DFFE inst4 (.C(CLK), .E(CE), .D(inst3_Q), .Q(inst4_Q));
SB_DFFE inst5 (.C(CLK), .E(CE), .D(inst4_Q), .Q(inst5_Q));
SB_DFFE inst6 (.C(CLK), .E(CE), .D(inst5_Q), .Q(inst6_Q));
SB_DFFE inst7 (.C(CLK), .E(CE), .D(inst6_Q), .Q(inst7_Q));
SB_DFFE inst8 (.C(CLK), .E(CE), .D(inst7_Q), .Q(inst8_Q));
SB_DFFE inst9 (.C(CLK), .E(CE), .D(inst8_Q), .Q(inst9_Q));
assign O = {inst9_Q,inst8_Q,inst7_Q,inst6_Q,inst5_Q,inst4_Q,inst3_Q,inst2_Q,inst1_Q,inst0_Q};
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

module main (output  D4, output  D5, output  D6, output  D7, input  O, output  I, output  D3, output  D2, output  D1, output  D0, input  CLKIN, input  RX);
wire  inst0_Q;
wire  inst1_Q;
wire  inst2_Q;
wire [3:0] inst3_O;
wire  inst3_COUT;
wire [15:0] inst4_RDATA;
wire [2:0] inst5_O;
wire  inst5_COUT;
wire  inst6_O;
wire [8:0] inst7_O;
wire  inst7_COUT;
wire  inst8_O;
wire [8:0] inst9_O;
wire [8:0] inst10_O;
wire  inst10_COUT;
wire  inst11_Q;
wire [2:0] inst12_O;
wire  inst12_COUT;
wire  inst13_O;
wire  inst14_Q;
wire  inst15_O;
wire  inst16_O;
wire  inst17_O;
wire  inst18_O;
wire  inst19_O;
wire  inst20_O;
wire  inst21_O;
wire [8:0] inst22_O;
wire  inst22_COUT;
wire  inst23_O;
wire [8:0] inst24_O;
wire [8:0] inst25_O;
wire  inst25_COUT;
wire [8:0] inst26_O;
wire  inst26_COUT;
wire  inst27_Q;
wire  inst28_O;
wire  inst29_O;
wire [7:0] inst30_O;
wire  inst30_COUT;
wire  inst31_O;
wire  inst32_O;
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
wire  inst96_Q;
wire  inst97_O;
wire  inst98_O;
wire  inst99_O;
wire [3:0] inst100_O;
wire [3:0] inst101_O;
wire  inst101_COUT;
wire  inst102_O;
wire  inst103_O;
wire  inst104_O;
wire  inst105_O;
wire [3:0] inst106_O;
wire  inst106_COUT;
wire  inst107_O;
wire  inst108_O;
wire  inst109_O;
wire [9:0] inst110_O;
wire [15:0] inst111_RDATA;
wire [8:0] inst112_O;
wire  inst112_COUT;
wire [8:0] inst113_O;
wire  inst113_COUT;
wire [3:0] inst114_O;
wire  inst115_O;
wire [3:0] inst116_O;
wire [3:0] inst117_O;
wire  inst117_COUT;
wire  inst118_O;
SB_DFF inst0 (.C(CLKIN), .D(O), .Q(inst0_Q));
SB_DFF inst1 (.C(CLKIN), .D(inst0_Q), .Q(inst1_Q));
SB_DFF inst2 (.C(CLKIN), .D(inst1_Q), .Q(inst2_Q));
Counter4 inst3 (.O(inst3_O), .COUT(inst3_COUT), .CLK(CLKIN));
SB_RAM40_4K #(.INIT_1(256'h0000000000000000000000000000000000000000000000000000000000000000),
.INIT_0(256'h0000000000000000000000000000000000000000000000000000000000000000),
.INIT_3(256'h0000000000000000000000000000000000000000000000000000000000000000),
.INIT_2(256'h0000000000000000000000000000000000000000000000000000000000000000),
.INIT_5(256'h0000000000000000000000000000000000000000000000000000000000000000),
.INIT_4(256'h0000000000000000000000000000000000000000000000000000000000000000),
.INIT_7(256'h0000000000000000000000000000000000000000000000000000000000000000),
.INIT_6(256'h0000000000000000000000000000000000000000000000000000000000000000),
.INIT_9(256'h0000000000000000000000000000000000000000000000000000000000000000),
.INIT_8(256'h0000000000000000000000000000000000000000000000000000000000000000),
.INIT_A(256'h0000000000000000000000000000000000000000000000000000000000000000),
.INIT_C(256'h0000000000000000000000000000000000000000000000000000000000000000),
.READ_MODE(1),
.INIT_E(256'h0000000000000000000000000000000000000000000000000000000000000000),
.INIT_D(256'h0000000000000000000000000000000000000000000000000000000000000000),
.INIT_F(256'h0000000000000000000000000000000000000000000000000000000000000000),
.WRITE_MODE(1),
.INIT_B(256'h0000000000000000000000000000000000000000000000000000000000000000)) inst4 (.RDATA(inst4_RDATA), .RADDR({1'b0,1'b0,inst26_O[8],inst26_O[7],inst26_O[6],inst26_O[5],inst26_O[4],inst26_O[3],inst26_O[2],inst26_O[1],inst26_O[0]}), .RCLK(CLKIN), .RCLKE(1'b1), .RE(1'b1), .WCLK(CLKIN), .WCLKE(1'b1), .WE(1'b1), .MASK({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
Counter3CE inst5 (.O(inst5_O), .COUT(inst5_COUT), .CLK(CLKIN), .CE(inst3_COUT));
SB_LUT4 #(.LUT_INIT(16'h8888)) inst6 (.I0(inst3_COUT), .I1(inst5_COUT), .I2(1'b0), .I3(1'b0), .O(inst6_O));
Counter9CE inst7 (.O(inst7_O), .COUT(inst7_COUT), .CLK(CLKIN), .CE(inst6_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst8 (.I0(inst10_COUT), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst8_O));
Invert9 inst9 (.I({1'b1,1'b0,1'b0,1'b1,1'b0,1'b1,1'b0,1'b1,1'b1}), .O(inst9_O));
Addcout9 inst10 (.I0(inst7_O), .I1(inst9_O), .O(inst10_O), .COUT(inst10_COUT));
SB_DFFE inst11 (.C(CLKIN), .E(inst3_COUT), .D(inst8_O), .Q(inst11_Q));
Counter3CER inst12 (.O(inst12_O), .COUT(inst12_COUT), .CLK(CLKIN), .CE(inst3_COUT), .RESET(inst16_O));
SB_LUT4 #(.LUT_INIT(16'h0080)) inst13 (.I0(inst12_O[0]), .I1(inst12_O[1]), .I2(inst12_O[2]), .I3(1'b0), .O(inst13_O));
SB_DFFE inst14 (.C(CLKIN), .E(inst3_COUT), .D(inst15_O), .Q(inst14_Q));
SB_LUT4 #(.LUT_INIT(16'h5454)) inst15 (.I0(inst13_O), .I1(inst8_O), .I2(inst14_Q), .I3(1'b0), .O(inst15_O));
SB_LUT4 #(.LUT_INIT(16'h2222)) inst16 (.I0(inst13_O), .I1(inst14_Q), .I2(1'b0), .I3(1'b0), .O(inst16_O));
PISO8CE inst17 (.SI(1'b1), .PI({inst111_RDATA[0],inst111_RDATA[2],inst111_RDATA[4],inst111_RDATA[6],inst111_RDATA[8],inst111_RDATA[10],inst111_RDATA[12],inst111_RDATA[14]}), .LOAD(inst18_O), .O(inst17_O), .CLK(CLKIN), .CE(inst3_COUT));
SB_LUT4 #(.LUT_INIT(16'h2222)) inst18 (.I0(inst8_O), .I1(inst14_Q), .I2(1'b0), .I3(1'b0), .O(inst18_O));
SB_LUT4 #(.LUT_INIT(16'h4444)) inst19 (.I0(inst14_Q), .I1(inst3_COUT), .I2(1'b0), .I3(1'b0), .O(inst19_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst20 (.I0(inst14_Q), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst20_O));
SB_LUT4 #(.LUT_INIT(16'h8080)) inst21 (.I0(inst20_O), .I1(inst3_COUT), .I2(inst8_O), .I3(1'b0), .O(inst21_O));
Counter9CER inst22 (.O(inst22_O), .COUT(inst22_COUT), .CLK(CLKIN), .CE(inst21_O), .RESET(inst23_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst23 (.I0(inst25_COUT), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst23_O));
Invert9 inst24 (.I(inst22_O), .O(inst24_O));
Addcout9 inst25 (.I0({1'b1,1'b0,1'b0,1'b1,1'b0,1'b1,1'b0,1'b1,1'b1}), .I1(inst24_O), .O(inst25_O), .COUT(inst25_COUT));
Addcout9 inst26 (.I0(inst22_O), .I1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1}), .O(inst26_O), .COUT(inst26_COUT));
SB_DFF inst27 (.C(CLKIN), .D(inst2_Q), .Q(inst27_Q));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst28 (.I0(inst2_Q), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst28_O));
SB_LUT4 #(.LUT_INIT(16'h8888)) inst29 (.I0(inst27_Q), .I1(inst28_O), .I2(1'b0), .I3(1'b0), .O(inst29_O));
Counter8CER inst30 (.O(inst30_O), .COUT(inst30_COUT), .CLK(CLKIN), .CE(1'b1), .RESET(inst63_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst31 (.I0(inst30_O[0]), .I1(inst30_O[1]), .I2(inst30_O[2]), .I3(inst30_O[3]), .O(inst31_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst32 (.I0(inst30_O[0]), .I1(inst30_O[1]), .I2(inst30_O[2]), .I3(inst30_O[3]), .O(inst32_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst33 (.I0(inst31_O), .I1(inst32_O), .I2(inst30_O[4]), .I3(1'b0), .O(inst33_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst34 (.I0(inst30_O[0]), .I1(inst30_O[1]), .I2(inst30_O[2]), .I3(inst30_O[3]), .O(inst34_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst35 (.I0(inst30_O[0]), .I1(inst30_O[1]), .I2(inst30_O[2]), .I3(inst30_O[3]), .O(inst35_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst36 (.I0(inst34_O), .I1(inst35_O), .I2(inst30_O[4]), .I3(1'b0), .O(inst36_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst37 (.I0(inst33_O), .I1(inst36_O), .I2(inst30_O[5]), .I3(1'b0), .O(inst37_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst38 (.I0(inst30_O[0]), .I1(inst30_O[1]), .I2(inst30_O[2]), .I3(inst30_O[3]), .O(inst38_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst39 (.I0(inst30_O[0]), .I1(inst30_O[1]), .I2(inst30_O[2]), .I3(inst30_O[3]), .O(inst39_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst40 (.I0(inst38_O), .I1(inst39_O), .I2(inst30_O[4]), .I3(1'b0), .O(inst40_O));
SB_LUT4 #(.LUT_INIT(16'h0040)) inst41 (.I0(inst30_O[0]), .I1(inst30_O[1]), .I2(inst30_O[2]), .I3(inst30_O[3]), .O(inst41_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst42 (.I0(inst30_O[0]), .I1(inst30_O[1]), .I2(inst30_O[2]), .I3(inst30_O[3]), .O(inst42_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst43 (.I0(inst41_O), .I1(inst42_O), .I2(inst30_O[4]), .I3(1'b0), .O(inst43_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst44 (.I0(inst40_O), .I1(inst43_O), .I2(inst30_O[5]), .I3(1'b0), .O(inst44_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst45 (.I0(inst37_O), .I1(inst44_O), .I2(inst30_O[6]), .I3(1'b0), .O(inst45_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst46 (.I0(inst30_O[0]), .I1(inst30_O[1]), .I2(inst30_O[2]), .I3(inst30_O[3]), .O(inst46_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst47 (.I0(inst30_O[0]), .I1(inst30_O[1]), .I2(inst30_O[2]), .I3(inst30_O[3]), .O(inst47_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst48 (.I0(inst46_O), .I1(inst47_O), .I2(inst30_O[4]), .I3(1'b0), .O(inst48_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst49 (.I0(inst30_O[0]), .I1(inst30_O[1]), .I2(inst30_O[2]), .I3(inst30_O[3]), .O(inst49_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst50 (.I0(inst30_O[0]), .I1(inst30_O[1]), .I2(inst30_O[2]), .I3(inst30_O[3]), .O(inst50_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst51 (.I0(inst49_O), .I1(inst50_O), .I2(inst30_O[4]), .I3(1'b0), .O(inst51_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst52 (.I0(inst48_O), .I1(inst51_O), .I2(inst30_O[5]), .I3(1'b0), .O(inst52_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst53 (.I0(inst30_O[0]), .I1(inst30_O[1]), .I2(inst30_O[2]), .I3(inst30_O[3]), .O(inst53_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst54 (.I0(inst30_O[0]), .I1(inst30_O[1]), .I2(inst30_O[2]), .I3(inst30_O[3]), .O(inst54_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst55 (.I0(inst53_O), .I1(inst54_O), .I2(inst30_O[4]), .I3(1'b0), .O(inst55_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst56 (.I0(inst30_O[0]), .I1(inst30_O[1]), .I2(inst30_O[2]), .I3(inst30_O[3]), .O(inst56_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst57 (.I0(inst30_O[0]), .I1(inst30_O[1]), .I2(inst30_O[2]), .I3(inst30_O[3]), .O(inst57_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst58 (.I0(inst56_O), .I1(inst57_O), .I2(inst30_O[4]), .I3(1'b0), .O(inst58_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst59 (.I0(inst55_O), .I1(inst58_O), .I2(inst30_O[5]), .I3(1'b0), .O(inst59_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst60 (.I0(inst52_O), .I1(inst59_O), .I2(inst30_O[6]), .I3(1'b0), .O(inst60_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst61 (.I0(inst45_O), .I1(inst60_O), .I2(inst30_O[7]), .I3(1'b0), .O(inst61_O));
SB_LUT4 #(.LUT_INIT(16'hEEEE)) inst62 (.I0(inst61_O), .I1(inst29_O), .I2(1'b0), .I3(1'b0), .O(inst62_O));
SB_LUT4 #(.LUT_INIT(16'h8888)) inst63 (.I0(inst62_O), .I1(1'b1), .I2(1'b0), .I3(1'b0), .O(inst63_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst64 (.I0(inst30_O[0]), .I1(inst30_O[1]), .I2(inst30_O[2]), .I3(inst30_O[3]), .O(inst64_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst65 (.I0(inst30_O[0]), .I1(inst30_O[1]), .I2(inst30_O[2]), .I3(inst30_O[3]), .O(inst65_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst66 (.I0(inst64_O), .I1(inst65_O), .I2(inst30_O[4]), .I3(1'b0), .O(inst66_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst67 (.I0(inst30_O[0]), .I1(inst30_O[1]), .I2(inst30_O[2]), .I3(inst30_O[3]), .O(inst67_O));
SB_LUT4 #(.LUT_INIT(16'h0008)) inst68 (.I0(inst30_O[0]), .I1(inst30_O[1]), .I2(inst30_O[2]), .I3(inst30_O[3]), .O(inst68_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst69 (.I0(inst67_O), .I1(inst68_O), .I2(inst30_O[4]), .I3(1'b0), .O(inst69_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst70 (.I0(inst66_O), .I1(inst69_O), .I2(inst30_O[5]), .I3(1'b0), .O(inst70_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst71 (.I0(inst30_O[0]), .I1(inst30_O[1]), .I2(inst30_O[2]), .I3(inst30_O[3]), .O(inst71_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst72 (.I0(inst30_O[0]), .I1(inst30_O[1]), .I2(inst30_O[2]), .I3(inst30_O[3]), .O(inst72_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst73 (.I0(inst71_O), .I1(inst72_O), .I2(inst30_O[4]), .I3(1'b0), .O(inst73_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst74 (.I0(inst30_O[0]), .I1(inst30_O[1]), .I2(inst30_O[2]), .I3(inst30_O[3]), .O(inst74_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst75 (.I0(inst30_O[0]), .I1(inst30_O[1]), .I2(inst30_O[2]), .I3(inst30_O[3]), .O(inst75_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst76 (.I0(inst74_O), .I1(inst75_O), .I2(inst30_O[4]), .I3(1'b0), .O(inst76_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst77 (.I0(inst73_O), .I1(inst76_O), .I2(inst30_O[5]), .I3(1'b0), .O(inst77_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst78 (.I0(inst70_O), .I1(inst77_O), .I2(inst30_O[6]), .I3(1'b0), .O(inst78_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst79 (.I0(inst30_O[0]), .I1(inst30_O[1]), .I2(inst30_O[2]), .I3(inst30_O[3]), .O(inst79_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst80 (.I0(inst30_O[0]), .I1(inst30_O[1]), .I2(inst30_O[2]), .I3(inst30_O[3]), .O(inst80_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst81 (.I0(inst79_O), .I1(inst80_O), .I2(inst30_O[4]), .I3(1'b0), .O(inst81_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst82 (.I0(inst30_O[0]), .I1(inst30_O[1]), .I2(inst30_O[2]), .I3(inst30_O[3]), .O(inst82_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst83 (.I0(inst30_O[0]), .I1(inst30_O[1]), .I2(inst30_O[2]), .I3(inst30_O[3]), .O(inst83_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst84 (.I0(inst82_O), .I1(inst83_O), .I2(inst30_O[4]), .I3(1'b0), .O(inst84_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst85 (.I0(inst81_O), .I1(inst84_O), .I2(inst30_O[5]), .I3(1'b0), .O(inst85_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst86 (.I0(inst30_O[0]), .I1(inst30_O[1]), .I2(inst30_O[2]), .I3(inst30_O[3]), .O(inst86_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst87 (.I0(inst30_O[0]), .I1(inst30_O[1]), .I2(inst30_O[2]), .I3(inst30_O[3]), .O(inst87_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst88 (.I0(inst86_O), .I1(inst87_O), .I2(inst30_O[4]), .I3(1'b0), .O(inst88_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst89 (.I0(inst30_O[0]), .I1(inst30_O[1]), .I2(inst30_O[2]), .I3(inst30_O[3]), .O(inst89_O));
SB_LUT4 #(.LUT_INIT(16'h0000)) inst90 (.I0(inst30_O[0]), .I1(inst30_O[1]), .I2(inst30_O[2]), .I3(inst30_O[3]), .O(inst90_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst91 (.I0(inst89_O), .I1(inst90_O), .I2(inst30_O[4]), .I3(1'b0), .O(inst91_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst92 (.I0(inst88_O), .I1(inst91_O), .I2(inst30_O[5]), .I3(1'b0), .O(inst92_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst93 (.I0(inst85_O), .I1(inst92_O), .I2(inst30_O[6]), .I3(1'b0), .O(inst93_O));
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst94 (.I0(inst78_O), .I1(inst93_O), .I2(inst30_O[7]), .I3(1'b0), .O(inst94_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst95 (.I0(inst2_Q), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst95_O));
SB_DFF inst96 (.C(CLKIN), .D(inst2_Q), .Q(inst96_Q));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst97 (.I0(inst2_Q), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst97_O));
SB_LUT4 #(.LUT_INIT(16'h8888)) inst98 (.I0(inst96_Q), .I1(inst97_O), .I2(1'b0), .I3(1'b0), .O(inst98_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst99 (.I0(inst101_COUT), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst99_O));
Invert4 inst100 (.I({1'b1,1'b0,1'b0,1'b1}), .O(inst100_O));
Addcout4 inst101 (.I0(inst106_O), .I1(inst100_O), .O(inst101_O), .COUT(inst101_COUT));
SB_LUT4 #(.LUT_INIT(16'h8888)) inst102 (.I0(inst103_O), .I1(inst98_O), .I2(1'b0), .I3(1'b0), .O(inst102_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst103 (.I0(inst99_O), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst103_O));
SB_LUT4 #(.LUT_INIT(16'hEEEE)) inst104 (.I0(inst105_O), .I1(inst102_O), .I2(1'b0), .I3(1'b0), .O(inst104_O));
SB_LUT4 #(.LUT_INIT(16'h8888)) inst105 (.I0(inst99_O), .I1(inst94_O), .I2(1'b0), .I3(1'b0), .O(inst105_O));
Counter4CER inst106 (.O(inst106_O), .COUT(inst106_COUT), .CLK(CLKIN), .CE(inst104_O), .RESET(inst109_O));
SB_LUT4 #(.LUT_INIT(16'h0400)) inst107 (.I0(inst106_O[0]), .I1(inst106_O[1]), .I2(inst106_O[2]), .I3(inst106_O[3]), .O(inst107_O));
SB_LUT4 #(.LUT_INIT(16'hEEEE)) inst108 (.I0(inst107_O), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst108_O));
SB_LUT4 #(.LUT_INIT(16'h8888)) inst109 (.I0(inst108_O), .I1(inst104_O), .I2(1'b0), .I3(1'b0), .O(inst109_O));
SIPO10CE inst110 (.I(inst2_Q), .O(inst110_O), .CLK(CLKIN), .CE(inst104_O));
SB_RAM40_4K #(.INIT_1(256'h0000000000000000000000000000000000000000000000000000000000000000),
.INIT_0(256'h0000000000000000000000000000000000000000000000000000000000000000),
.INIT_3(256'h0000000000000000000000000000000000000000000000000000000000000000),
.INIT_2(256'h0000000000000000000000000000000000000000000000000000000000000000),
.INIT_5(256'h0000000000000000000000000000000000000000000000000000000000000000),
.INIT_4(256'h0000000000000000000000000000000000000000000000000000000000000000),
.INIT_7(256'h0000000000000000000000000000000000000000000000000000000000000000),
.INIT_6(256'h0000000000000000000000000000000000000000000000000000000000000000),
.INIT_9(256'h0000000000000000000000000000000000000000000000000000000000000000),
.INIT_8(256'h0000000000000000000000000000000000000000000000000000000000000000),
.INIT_A(256'h0000000000000000000000000000000000000000000000000000000000000000),
.INIT_C(256'h0000000000000000000000000000000000000000000000000000000000000000),
.READ_MODE(1),
.INIT_E(256'h0000000000000000000000000000000000000000000000000000000000000000),
.INIT_D(256'h0000000000000000000000000000000000000000000000000000000000000000),
.INIT_F(256'h0000000000000000000000000000000000000000000000000000000000000000),
.WRITE_MODE(1),
.INIT_B(256'h0000000000000000000000000000000000000000000000000000000000000000)) inst111 (.RDATA(inst111_RDATA), .RADDR({1'b0,1'b0,inst26_O[8],inst26_O[7],inst26_O[6],inst26_O[5],inst26_O[4],inst26_O[3],inst26_O[2],inst26_O[1],inst26_O[0]}), .RCLK(CLKIN), .RCLKE(1'b1), .RE(1'b1), .WCLK(CLKIN), .WCLKE(1'b1), .WE(inst102_O), .WADDR({1'b0,1'b0,inst113_O[8],inst113_O[7],inst113_O[6],inst113_O[5],inst113_O[4],inst113_O[3],inst113_O[2],inst113_O[1],inst113_O[0]}), .MASK({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}), .WDATA({1'b0,inst110_O[8],1'b0,inst110_O[7],1'b0,inst110_O[6],1'b0,inst110_O[5],1'b0,inst110_O[4],1'b0,inst110_O[3],1'b0,inst110_O[2],1'b0,inst110_O[1]}));
Counter9CE inst112 (.O(inst112_O), .COUT(inst112_COUT), .CLK(CLKIN), .CE(inst102_O));
Addcout9 inst113 (.I0(inst112_O), .I1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}), .O(inst113_O), .COUT(inst113_COUT));
Mux2x4 inst114 (.I0({1'b0,1'b1,1'b0,1'b0}), .I1({1'b1,1'b0,1'b0,1'b1}), .S(inst17_O), .O(inst114_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst115 (.I0(inst117_COUT), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst115_O));
Invert4 inst116 (.I(inst114_O), .O(inst116_O));
Addcout4 inst117 (.I0(inst3_O), .I1(inst116_O), .O(inst117_O), .COUT(inst117_COUT));
SB_LUT4 #(.LUT_INIT(16'h8888)) inst118 (.I0(inst115_O), .I1(inst11_Q), .I2(1'b0), .I3(1'b0), .O(inst118_O));
assign D4 = 1'b0;
assign D5 = 1'b0;
assign D6 = 1'b0;
assign D7 = 1'b0;
assign I = inst118_O;
assign D3 = 1'b0;
assign D2 = 1'b0;
assign D1 = inst118_O;
assign D0 = inst2_Q;
endmodule

