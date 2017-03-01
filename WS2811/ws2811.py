import sys
import __builtin__
import math
import colorsys
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

clock = Counter(4, cout=True, incr=1)
baud = clock.COUT

num_led = 42
num_bytes = int(math.pow(2, math.ceil(math.log((num_led * 3), 2)))) - 1
size = int(math.ceil(math.log(num_bytes + 8, 2))) 

colorList = []
for i in range(num_led):
    color = colorsys.hls_to_rgb(i * (1.0/50), 0.25, 1)
    for j in range(3):
        colorList.append(int(color[j] * 255))

for i in range(num_bytes - (num_led * 3) + 1):
    colorList.append(0)

#Make sure values contains num_bytes + 1 entries
values = __builtin__.tuple(colorList)
#values = __builtin__.tuple((255,0,0,255,128,64,0,0,255,255,0,0,255,128,64,0,0,255,255,0,0,255,128,64,0,0,255,255,0,0,255,128,64,0,0,255,255,0,0,255,128,64,0,0,255,255,0,0,255,128,64,0,0,255,255,0,0,255,128,64,0,0,255,255,0,0,255,128,64,0,0,255,255,0,0,255,128,64,0,0,255,255,0,0,255,128,64,0,0,255,255,0,0,255,128,64,0,0,255,255,0,0,255,128,64,0,0,255,255,0,0,255,128,64,0,0,255,255,0,0,255,128,64,0,0,255,255,0))
init = [array(*int2seq(v, 8)) for v in values]
print (len(init))

printf = Counter(size-1, ce=True)
rom = ROM(size-1, init, printf.O)

data = array(rom.O[0], rom.O[1], rom.O[2], rom.O[3],
             rom.O[4], rom.O[5], rom.O[6], rom.O[7])

payloadCounter = PAYLOAD_TIMER(size, baud)
payloadComp = UGT(size)(I0=array(*int2seq(num_bytes, size)), I1=payloadCounter)
dataMask = DFF(ce=True)(I=payloadComp, ce=baud)

run = RUN(payloadComp, baud)
shift = PISO(8, ce=True)
load = LUT2(I0&~I1)(payloadComp,run)
shift(1,data,load)
wire(baud, shift.CE)

readyShift = LUT2(~I0 & I1)(run, baud)
wire(readyShift, printf.CE)

signal = WS2811_STREAM(shift, dataMask, clock)


wire(0,			            main.J3[0])
wire(baud,                  main.J3[1])
wire(dataMask,      main.J3[2])
wire(run,                 main.J3[3])
wire(signal,                main.J3[4])
wire(signal,                main.I)

compile(sys.argv[1], main)

