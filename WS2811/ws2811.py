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
    edgeFlipFlop = DFF()
    edgeFlipFlop(I=signal)

    edgeNot = Not()(edgeFlipFlop.O)
    edgeAnd = And2()(I0=edgeNot, I1=signal)

    return edgeAnd

def FALLING_EDGE_DETECT(signal):
    edgeFlipFlop = DFF()
    edgeFlipFlop(I=signal)

    edgeNot = Not()(signal)
    edgeAnd = And2()(I0=edgeFlipFlop.O, I1=edgeNot)

    return edgeAnd

def RAM_ADVANCE(n, enable, run, baud):
    nextByte = Not()(run)
    addrIncrement = And3()(I0=nextByte, I1=baud, I2=enable)

    addrCount = Counter(9, cout = True, ce =True, r=True)
    done = UGT(9)
    done(I0=addrCount, I1=array(*int2seq(n, 9)))
 
    addrCount(CE=addrIncrement, RESET=done)
    addOne = Add(9)
    addOne(I0=addrCount, I1=array(*int2seq(1, 9)))
    return addOne

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

def ResetModMCounter(m, n, RESET, CE):
    s = False
    counter = Counter(n, cin=False, cout=True, incr=1, next=False,
                   ce=True, r=True, s=False)
    reset = Decode(m - 1, n)(counter)

    reset = Or2()(reset, RESET)
    reset = And2()(reset, CE)
    wire(reset, counter.RESET) 

    wire(CE, counter.CE)
    
    return counter

def BAUD_COUNTER(baud, signal, CE):
    RESET = FALLING_EDGE_DETECT(signal)

    counter = ResetModMCounter(baud, 8, RESET, CE)
    output1 = Decode(baud/2, 8)(counter)

    return output1

def UART_MEMORY(signal, raddr, num_bytes):
	baud = BAUD_COUNTER(103, signal, 1)
	notSignal = Not()(signal)
	startIndicator = FALLING_EDGE_DETECT(signal)

	countCompare = UGT(4)
	nextByte = And2()(I0=Not()(countCompare), I1=startIndicator)
	countEnable = Or2()(I0= And2()(I0=countCompare, I1=baud), I1=nextByte)
	byteCounter = ResetModMCounter(11, 4, 0, countEnable)
	countCompare(I0=array(*int2seq(9, 4)), I1=byteCounter.O)

	shiftReg = SIPO(10, ce=True)
	wire(countEnable, shiftReg.CE)
	shiftReg(signal)
	
	rom = range(512)
	for i in range(512):
		rom[i] = 0

	ramb = RAMB( rom )
	rdata = array(ramb.RDATA[7], ramb.RDATA[6], ramb.RDATA[5], ramb.RDATA[4],
		ramb.RDATA[3], ramb.RDATA[2], ramb.RDATA[1], ramb.RDATA[0])
	WDATA= array(shiftReg.O[1],shiftReg.O[2],shiftReg.O[3],shiftReg.O[4],
		shiftReg.O[5],shiftReg.O[6],shiftReg.O[7],shiftReg.O[8])

	addressCounter = Counter(9, ce=True)(CE=nextByte)
	uncorrectedAddr = addressCounter
	correctedAddr = Add(9)(I0=uncorrectedAddr, I1=array(*int2seq(0, 9)))

	RADDR = raddr
	WADDR = correctedAddr
	WE = nextByte
	ramb(RE=1, RCLKE=1, RADDR=RADDR, WE=WE, WCLKE=1, WADDR=WADDR, WDATA=WDATA)
    
	return rdata

def LOCAL_ADDRESS(addr):
	isZeroRange = And2()(I0=UGT(11)(I0=addr, I1=array(*int2seq(0, 11))), I1=UGT(11)(I1=addr, I0=array(*int2seq(511, 11))))
	isOneRange = And2()(I0=UGT(11)(I0=addr, I1=array(*int2seq(512, 11))), I1=UGT(11)(I1=addr, I0=array(*int2seq(1023, 11))))
	isTwoRange = And2()(I0=UGT(11)(I0=addr, I1=array(*int2seq(1024, 11))), I1=UGT(11)(I1=addr, I0=array(*int2seq(1535, 11))))
	
	firstRangeVal = Mux(2,11)(I0=array(*int2seq(0, 11)), I1=array(*int2seq(512, 11)), S=isOneRange)
	secondRangeVal = Mux(2,11)(I0=array(*int2seq(0, 11)), I1=array(*int2seq(1024, 11)), S=isTwoRange)

	firstRangeAddr = Sub(11)(I1=addr, I0=firstRangeVal)
	secondRangeAddr = Sub(11)(I1=firstRangeAddr, I0=firstRangeVal)
	localAddr = array(secondRangeAddr[0], secondRangeAddr[1], secondRangeAddr[2], secondRangeAddr[3],
		secondRangeAddr[4], secondRangeAddr[5], secondRangeAddr[6], secondRangeAddr[7], 
		secondRangeAddr[8], isZeroRange, isOneRange, isTwoRange)

	return localAddr


def MEGA_MEMORY(RADDR, WADDR, WE, WDATA):
	localRAddrTrans = LOCAL_ADDRESS(RADDR)
	localRADDR = array(localRAddrTrans[0], localRAddrTrans[1], localRAddrTrans[2], localRAddrTrans[3],
		localRAddrTrans[4], localRAddrTrans[5], localRAddrTrans[6], localRAddrTrans[7], localRAddrTrans[8])
	ram0RE = localRAddrTrans[9]
	ram1RE = localRAddrTrans[10]
	ram2RE = localRAddrTrans[11]

	localWAddrTrans = LOCAL_ADDRESS(WADDR)
	localWADDR = array(localWAddrTrans[0], localWAddrTrans[1], localWAddrTrans[2], localWAddrTrans[3],
		localWAddrTrans[4], localWAddrTrans[5], localWAddrTrans[6], localWAddrTrans[7], localWAddrTrans[8])
	ram0WE = And2(I0=localWAddrTrans[9], I1=WE) 
	ram1WE = And2(I0=localWAddrTrans[10], I1=WE) 
	ram2WE = And2(I0=localWAddrTrans[11], I1=WE) 

	rom = range(512)
	for i in range(512):
		rom[i] = 0

	ram0 = RAMB(rom)
	ram0(RE=ram0RE, RCLKE=1, RADDR=localRADDR, WE=ram0WE, WCLKE=1, WADDR=localWADDR, WDATA=WDATA)
	ram1 = RAMB(rom)
	ram1(RE=ram1RE, RCLKE=1, RADDR=localRADDR, WE=ram1WE, WCLKE=1, WADDR=localWADDR, WDATA=WDATA)
	ram2 = RAMB(rom)
	ram2(RE=ram2RE, RCLKE=1, RADDR=localRADDR, WE=ram2WE, WCLKE=1, WADDR=localWADDR, WDATA=WDATA)

	output = array(0,0,0,0,0,0,0,0)
	return output

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
icestick.PMOD1[0].input().rename('O').on()
icestick.RX.input().on()

main = icestick.main()

filter1 = DFF()(I=main.O)
filter2 = DFF()(I=filter1)
uart = DFF()(I=filter2)

clock = Counter(4, cout=True, incr=1)
baud = clock.COUT

#Don't have zero LEDS, unexpected things will happen
num_led = 100
num_bytes = num_led * 3 - 1
size = int(math.ceil(math.log(num_bytes + 8, 2))) 

rom = range(512)
for i in range(512):
	rom[i] = 0

ramb = RAMB(rom)

payloadCounter = PAYLOAD_TIMER(size, baud)
payloadComp = UGT(size)(I0=array(*int2seq(num_bytes, size)), I1=payloadCounter)
dataMask = DFF(ce=True)(I=payloadComp, ce=baud)

run = RUN(payloadComp, baud)
shift = PISO(8, ce=True)
load = LUT2(I0&~I1)(payloadComp,run)
wire(baud, shift.CE)
readyShift = LUT2(~I0 & I1)(run, baud)

RADDR = RAM_ADVANCE(num_bytes, payloadComp, run, baud)
memory = UART_MEMORY(uart, RADDR, num_bytes + 1)
shift(1,memory,load)

ramb(RE=1, RCLKE=1, RADDR=RADDR, WE=1, WCLKE=1)

signal = WS2811_STREAM(shift, dataMask, clock)

wire(uart,	main.D0)
wire(signal,   main.D1)
wire(0,   main.D2)
wire(0,   main.D3)
wire(0,   main.D4)
wire(0,   main.D5)
wire(0,   main.D6)
wire(0,   main.D7)
wire(signal,    main.I)

compile(sys.argv[1], main)

