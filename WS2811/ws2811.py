import sys
import __builtin__
import math
import colorsys
from magma import *
from mantle import *
from parts.lattice.ice40.primitives.RAMB import RAMB
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

    CompVar = UGT(4)
    CompVar(I0=BitSelect.O, I1=clock)

    signal = And2()(I0 = CompVar, I1=mask)
    return signal

def EDGE_DETECT(signal):
    edgeFlipFlop = DFF(init=0, ce=False, r=False, s=False)
    edgeFlipFlop(I=signal)

    edgeNot = Not()(edgeFlipFlop.O)
    edgeAnd = And2()(I0=edgeNot, I1=signal)

    return edgeAnd

def RAM_ADVANCE(n, enable, run, baud):
    nextByte = Not()(run)
    addrIncrement = And3()(I0=nextByte, I1=baud, I2=enable)

    addrCount = Counter(9, cout = True, ce =True, r=True)
    done = UGT(9)
    done(I0=addrCount, I1=array(*int2seq(n, 9)))
 
    addrCount(CE=addrIncrement, RESET=done)
    return addrCount

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
icestick.J3[1].rename('D0').output().on()
icestick.J3[2].rename('D1').output().on()
icestick.J3[3].rename('D2').output().on()
icestick.J3[4].rename('D3').output().on()
icestick.J1[1].rename('D4').output().on()
icestick.J1[2].rename('D5').output().on()
icestick.J1[3].rename('D6').output().on()
icestick.J1[4].rename('D7').output().on()
icestick.PMOD1[3].output().rename('I').on()

main = icestick.main()

clock = Counter(4, cout=True, incr=1)
baud = clock.COUT

num_led = 2
num_bytes = num_led * 3 - 1
size = int(math.ceil(math.log(num_bytes + 8, 2))) 

# colorList = []
# for i in range(num_led):
#     color = colorsys.hls_to_rgb(i * (1.0/50), 0.25, 1)
#     for j in range(3):
#         colorList.append(int(color[j] * 255))

# for i in range(num_bytes - (num_led * 3) + 1):
#     colorList.append(0)

N = 8
M = 4096/N
rom = range(M)
rom[0] = 255
rom[1] = 255
rom[2] = 255
rom[3] = 255

ramb = RAMB( rom )
data = array(ramb.RDATA[0], ramb.RDATA[1], ramb.RDATA[2], ramb.RDATA[3],
             ramb.RDATA[4], ramb.RDATA[5], ramb.RDATA[6], ramb.RDATA[7])

payloadCounter = PAYLOAD_TIMER(size, baud)
payloadComp = UGT(size)(I0=array(*int2seq(num_bytes, size)), I1=payloadCounter)
dataMask = DFF(ce=True)(I=payloadComp, ce=baud)

run = RUN(payloadComp, baud)
shift = PISO(8, ce=True)
load = LUT2(I0&~I1)(payloadComp,run)
shift(1,data,load)
wire(baud, shift.CE)
readyShift = LUT2(~I0 & I1)(run, baud)

RADDR = RAM_ADVANCE(num_bytes, payloadComp, run, baud)
wire( 1, ramb.RE    )
wire( 1, ramb.RCLKE )
wire(RADDR, ramb.RADDR )

signal = WS2811_STREAM(shift, dataMask, clock)

wire(baud,			main.D0)
wire(RADDR.O[0],             main.D1)
wire(RADDR.O[1],             main.D2)
wire(RADDR.O[2],             main.D3)
wire(payloadComp,        main.D4)
wire(run,             main.D5)
wire(shift,             main.D6)
wire(signal,             main.D7)
wire(signal,        main.I)

compile(sys.argv[1], main)

