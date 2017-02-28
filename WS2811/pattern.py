import sys
import __builtin__
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

icestick = IceStick()
icestick.Clock.on()
for i in range(5):
    icestick.J3[i].output().on()

main = icestick.main()

init = [array(*int2seq(ord(c), 8)) for c in 'hello, world  \r\n']

printf = Counter(4, ce=True)
rom = ROM(4, init, printf.O)

data = array(rom.O[7], rom.O[6], rom.O[5], rom.O[4],
             rom.O[3], rom.O[2], rom.O[1], rom.O[0])

clock = Counter(4, cout=True, incr=1)
baud = clock.COUT

payloadCount = Counter(6, ce=True)
payloadCount(ce=baud)
payloadComp = UGT(6)
payloadComp(I0=array(1,1,1,0,1,0), I1=payloadCount)
valid = payloadComp

latch = UGT(6)
latch(I0=array(0,0,0,1,1,0), I1=payloadCount)

count = Counter(3, ce=True, r=True)
done = Decode(7, 3)(count)

run = DFF(ce=True)
run_n = LUT3([0,0,1,0, 1,0,1,0])
run_n(done, valid, run)
run(run_n)
wire(baud, run.CE)

reset = LUT2(I0&~I1)(done, run)
count(CE=baud, RESET=reset)

shift = PISO(8, ce=True)
load = LUT2(I0&~I1)(valid,run)
shift(1,data,load)
wire(baud, shift.CE)

signal = And2()
signal(I0 = shift, I1=latch)

ready = LUT2(~I0 & I1)(run, baud)
wire(ready, printf.CE)

HighVal = array(1,0,0,1)
LowVal = array(0,0,1,0)
Select = shift
BitSelect = Mux(2,4)
BitSelect(I0=LowVal, I1=HighVal, S=Select)

CompVar = UGT(4);
CompVar(I0=BitSelect.O, I1=clock)

# wire(main.CLKIN, main.J3[0])
# wire(baud,       main.J3[1])
# wire(run,        main.J3[2])
# wire(done,       main.J3[3])
wire(0,			 main.J3[0])
wire(baud,       	 main.J3[1])
wire(shift,       	 main.J3[2])
wire(latch,      	 main.J3[3])
wire(signal,      main.J3[4])
#wire(ready,      main.J3[5])
#wire(valid,      main.J3[6])
#wire(count,      main.J3[4:8])

compile(sys.argv[1], main)

