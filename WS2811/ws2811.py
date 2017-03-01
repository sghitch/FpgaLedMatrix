import sys
import __builtin__
import math
from magma import *
from mantle import *
from boards.icestick import IceStick

#Necessary ROM Infrastructure (based off of UART.py from lecture)
def REGs(n):
    return [Register(8) for i in range(n)]

def MUXs(n):
    return [Mux(2,8) for i in range(n)]

def ROM(logn, init, A):
    n = 1 << logn
    assert len(A) == logn
    assert len(init) == n

    muxs = MUXs(n-1)
    for i in range(n/2):
        muxs[i](init[2*i], init[2*i+1], A[0])

    k = 0
    l = 1 << (logn-1)
    for i in range(logn-1):
        for j in range(l/2):
            muxs[k+l+j](muxs[k+2*j], muxs[k+2*j+1], A[i+1])
        k += l
        l /= 2

    return muxs[n-2]

def PAYLOAD_TIMER(n, baud):
    bitCount = Counter(3, ce=True, cout = True)
    bitCount(ce=baud)

    payloadIncrement = And2()(I0=baud, I1=bitCount.COUT)

    payloadCount = Counter(n, ce = True, cout = True)
    payloadCount(ce=payloadIncrement)

    return payloadCount

def WS2811_STREAM(data, mask, clock):
    HighVal = array(1,0,0,1)
    LowVal = array(0,0,1,0)
    Select = data
    BitSelect = Mux(2,4)
    BitSelect(I0=LowVal, I1=HighVal, S=Select)

    CompVar = UGT(4);
    CompVar(I0=BitSelect.O, I1=clock)

    signal = And2()(I0 = CompVar, I1=mask)
    return signal

def RUN(enable, baud):
    count = Counter(3, ce=True, r=True)
    done = Decode(7, 3)(count)

    run = DFF(ce=True)
    run_n = LUT3([0,0,1,0, 1,0,1,0])
    run_n(done, enable, run)
    run(run_n)
    wire(baud, run.CE)

    reset = LUT2(I0&~I1)(done, run)
    count(CE=baud, RESET=reset)

    return run


icestick = IceStick()
icestick.Clock.on()
for i in range(5):
    icestick.J3[i].output().on()
icestick.PMOD1[3].output().rename('I').on()

main = icestick.main()

# values = __builtin__.tuple((0,16,0,0,32,0,0,64,0,0,128,0,0,255,0,0))
# #values = __builtin__.tuple((0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0))
# init = [array(*int2seq(v, 8)) for v in values]

# printf = Counter(4, ce=True)
# rom = ROM(4, init, printf.O)

# data = array(rom.O[0], rom.O[1], rom.O[2], rom.O[3],
#              rom.O[4], rom.O[5], rom.O[6], rom.O[7])

clock = Counter(4, cout=True, incr=1)
baud = clock.COUT

# payloadCount = Counter(8, ce=True)
# payloadCount(ce=baud)
# payloadComp = UGT(8)(I0=array(1,1,1,1,1,1,1,0), I1=payloadCount)
# valid = payloadComp

# latchFull = UGT(8)
# latchFull(I0=array(0,0,0,0,0,0,0,1), I1=payloadCount)
# latchSingle = UGT(8)
# latchSingle(I0=array(0,0,0,0,0,0,0,0), I1=payloadCount)
# latchSingleInvert = Not()(latchSingle)
# latch = And2()(latchSingleInvert, latchFull)

# count = Counter(3, ce=True, r=True)
# done = Decode(7, 3)(count)

# run = DFF(ce=True)
# run_n = LUT3([0,0,1,0, 1,0,1,0])
# run_n(done, valid, run)
# run(run_n)
# wire(baud, run.CE)

# reset = LUT2(I0&~I1)(done, run)
# count(CE=baud, RESET=reset)

# shift = PISO(8, ce=True)
# load = LUT2(I0&~I1)(valid,run)
# shift(1,data,load)
# wire(baud, shift.CE)

# readyShift = LUT2(~I0 & I1)(run, baud)
# #ready = And2()(readyShift, latch)
# wire(readyShift, printf.CE)

# HighVal = array(1,0,0,1)
# LowVal = array(0,0,1,0)
# Select = shift
# BitSelect = Mux(2,4)
# BitSelect(I0=LowVal, I1=HighVal, S=Select)

# CompVar = UGT(4);
# CompVar(I0=BitSelect.O, I1=clock)

# signal = And2()
# signal(I0 = CompVar, I1=latch)

#-------------------------------------------------------------------#

num_led = 5
size = int(math.ceil(math.log((num_led * 3) + 8, 2)))

test_values = __builtin__.tuple((0,16,0,0,32,0,0,64,0,0,128,0,0,255,0,0))
#values = __builtin__.tuple((0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0))
test_init = [array(*int2seq(v, 8)) for v in test_values]

test_printf = Counter(4, ce=True)
test_rom = ROM(4, test_init, test_printf.O)

test_data = array(test_rom.O[0], test_rom.O[1], test_rom.O[2], test_rom.O[3],
             test_rom.O[4], test_rom.O[5], test_rom.O[6], test_rom.O[7])

test_payloadCounter = PAYLOAD_TIMER(size, baud)
test_payloadComp = UGT(size)(I0=array(*int2seq(num_led * 3, size)), I1=test_payloadCounter)
test_dataMask = DFF(ce=True)(I=test_payloadComp, ce=baud)

test_run = RUN(test_payloadComp, baud)
test_shift = PISO(8, ce=True)
test_load = LUT2(I0&~I1)(test_payloadComp,test_run)
test_shift(1,test_data,test_load)
wire(baud, test_shift.CE)

test_readyShift = LUT2(~I0 & I1)(test_run, baud)
wire(test_readyShift, test_printf.CE)

test_signal = WS2811_STREAM(test_shift, test_dataMask, clock)


wire(0,			            main.J3[0])
wire(baud,                  main.J3[1])
wire(test_dataMask,      main.J3[2])
wire(test_signal,                 main.J3[3])
wire(0,                main.J3[4])
wire(test_signal,                main.I)

compile(sys.argv[1], main)

