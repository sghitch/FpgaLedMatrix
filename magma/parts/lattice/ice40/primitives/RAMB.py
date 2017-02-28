from collections import OrderedDict
from magma import *

__all__  = ['SB_RAM40_4K']
__all__ += ['RAMB', 'ROMB']

# posedge read clock, posedge write clock
SB_RAM40_4K = DeclareCircuit("SB_RAM40_4K",
    "output RDATA", Out(Array(16, Bit)),
    "input RADDR", In(Array(11, Bit)),
    "input RCLK",  In(Bit),
    "input RCLKE", In(Bit),
    "input RE",    In(Bit),
    "input WCLK",  In(Bit),
    "input WCLKE", In(Bit),
    "input WE",    In(Bit),
    "input WADDR", In(Array(11, Bit)),
    "input MASK",  In(Array(16, Bit)),
    "input WDATA", In(Array(16, Bit)) )

# posedge read clock, negedge write clock
# negedge read clock, posedge write clock
# negedge read clock, negedge write clock
# - can get these effects by inverting the RCLK and/or the WCLK
# NEGCLK_R(0|1)
# NEGCLK_W(0|1)


# MASK=0, write-enabled, MASK=1, write-disabled

def wireaddr(addr, n):
    for i in range(n):
        wire(0, addr[10-i])
    return addr[0:11-n]

def RAMB(rom, readonly=False):
    ram40 = None
    n = len(rom)
    if   n ==  256: # 256x16
        params = init(rom,16,mode=0)
        ram40 = SB_RAM40_4K(**params)
        ram40.RADDR = wireaddr(ram40.RADDR, 3)
        if not readonly:
            ram40.WADDR = wireaddr(ram40.WADDR, 3)
    elif n ==  512: # 512x8
        params = init(rom,8,mode=1)
        ram40 = SB_RAM40_4K(**params)
        ram40.RADDR = wireaddr(ram40.RADDR, 2)
        RDATA = ram40.RDATA
        ram40.RDATA = array(RDATA[0], RDATA[2], RDATA[4], RDATA[6],
                            RDATA[8], RDATA[10], RDATA[12], RDATA[14])
        if not readonly:
            WDATA = ram40.WDATA
            wire(0,WDATA[1])
            wire(0,WDATA[3])
            wire(0,WDATA[5])
            wire(0,WDATA[7])
            wire(0,WDATA[9])
            wire(0,WDATA[11])
            wire(0,WDATA[13])
            wire(0,WDATA[15])
            ram40.WDATA = array(WDATA[0], WDATA[2], WDATA[4], WDATA[6],
                                WDATA[8], WDATA[10], WDATA[12], WDATA[14])
            ram40.WADDR = wireaddr(ram40.WADDR, 2)
    elif n == 1024: # 1024x4
        params = init(rom,4,mode=2)
        ram40 =  SB_RAM40_4K(**params)
        ram40.RADDR = wireaddr(ram40.RADDR, 1)
        RDATA = ram40.RDATA
        ram40.RDATA = array(RDATA[1], RDATA[5], RDATA[9], RDATA[13])
        if not readonly:
            WDATA = ram40.WDATA
            wire(0,WDATA[0])
            wire(0,WDATA[2])
            wire(0,WDATA[3])
            wire(0,WDATA[4])
            wire(0,WDATA[6])
            wire(0,WDATA[7])
            wire(0,WDATA[8])
            wire(0,WDATA[10])
            wire(0,WDATA[11])
            wire(0,WDATA[12])
            wire(0,WDATA[14])
            wire(0,WDATA[15])
            ram40.WDATA = array(WDATA[1], WDATA[5], WDATA[9], WDATA[13])
            ram40.WADDR = wireaddr(ram40.WADDR, 1)
    elif n == 2048: # 2048x2
        params = init(rom,2,mode=3)
        ram40 = SB_RAM40_4K(**params)
        RDATA = ram40.RDATA
        ram40.RDATA = array(RDATA[3], RDATA[11])
        if not readonly:
            WDATA = ram40.WDATA
            wire(0,WDATA[0])
            wire(0,WDATA[1])
            wire(0,WDATA[2])
            wire(0,WDATA[4])
            wire(0,WDATA[5])
            wire(0,WDATA[6])
            wire(0,WDATA[7])
            wire(0,WDATA[8])
            wire(0,WDATA[9])
            wire(0,WDATA[10])
            wire(0,WDATA[12])
            wire(0,WDATA[13])
            wire(0,WDATA[14])
            wire(0,WDATA[15])
            ram40.WDATA = array(WDATA[3], WDATA[11])
    if readonly:
        wire( 0, ram40.WE    )
        wire( 0, ram40.WCLKE )
        wire( array(*(11*[0])), ram40.WADDR )
        wire( array(*(16*[0])), ram40.WDATA )
        del ram40.WDATA
        del ram40.WADDR
    wire(array(*(16*[0])), ram40.MASK)
    return ram40

def ROMB(rom):
    return RAMB(rom, readonly=True)
#
# N is the number of bits of output
#
def init(rom,N,mode=0):
    # INIT_%x 256 bits = 32 bytes = 64 nibbles
    params = OrderedDict({})
    params['WRITE_MODE'] = str(mode)
    params['READ_MODE'] = str(mode)

    # M is the number of high (>8) address values
    #  e.g. if N == 8, then there are 2 high address values 
    M = 16/N
    for i in range(16):
        v = 0
        for b in range(256):
            col = (b/M)%N
            # NB. the high address values ocuppy the lowest bit positions
            row = 256*(b%M) + 16*i + b/16
            bit = (rom[row] >> col)&1
            #print('i=%x'%i, 'b=%d'%b, row, col)
            v |= bit << b
        key = 'INIT_%X' % i
        #params[key] = "256'h%064x" % v
        params[key] = (v, 256)
    return params

if __name__ == '__main__':
    rom = range(512)
    for i in range(512):
        rom[i] = i & 0xff

    ramb = RAMB(rom)
    print(ramb.interface)
