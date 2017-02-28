from collections import Sequence
from magma import *
from parts.lattice.ice40.primitives.PLB import SB_LUT4, A0, A1, A2

__all__  = ['LUT1', 'LUT2', 'LUT3', 'LUT4']
__all__ += ['LUT5', 'LUT6', 'LUT7', 'LUT8']
__all__ += ['LUTN', 'LUT']
__all__ += ['Logic1', 'Logic2', 'Logic3', 'Logic4']
__all__ += ['Logic5', 'Logic6', 'Logic7', 'Logic8']

def LUT1(rom, **kwargs):
    lut = SB_LUT4(LUT_INIT=lutinit(rom,1<<4),**kwargs)
    wire(0, lut.I1)
    wire(0, lut.I2)
    wire(0, lut.I3)
    return AnonymousCircuit("I0", lut.I0, "O", lut.O) 

def LUT2(rom, **kwargs):
    lut = SB_LUT4(LUT_INIT=lutinit(rom,1<<4), **kwargs)
    wire(0, lut.I2)
    wire(0, lut.I3)
    return AnonymousCircuit("I0", lut.I0, "I1", lut.I1, "O", lut.O) 

def LUT3(rom, **kwargs):
    lut = SB_LUT4(LUT_INIT=lutinit(rom,1<<4), **kwargs)
    wire(0, lut.I3)
    return AnonymousCircuit("I0", lut.I0, "I1", lut.I1, "I2", lut.I2, "O", lut.O) 

def LUT4(rom, **kwargs):
    return SB_LUT4(LUT_INIT=lutinit(rom,1<<4), **kwargs)

def LUT5(rom, **kwargs):
    if isinstance(rom, IntegerTypes):
        rom = int2seq(rom, 32)
    I0, I1, I2, I3, I4 = In(Bit)(), In(Bit)(), In(Bit)(), In(Bit)(), In(Bit)()
    lut = fork( LUT4(rom[ 0:16]), LUT4(rom[16:32]) )
    lut(I0, I1, I2, I3)
    mux = Mux2()
    mux(lut.O[0], lut.O[1], I4)
    return AnonymousCircuit("I0", I0,
                            "I1", I1,
                            "I2", I2,
                            "I3", I3,
                            "I4", I4,
                            "O", mux.O)


def LUT6(rom, **kwargs):
    if isinstance(rom, IntegerTypes):
        rom = int2seq(rom, 64)
    I0, I1, I2, I3, I4, I5 = In(Bit)(), In(Bit)(), In(Bit)(), In(Bit)(), In(Bit)(), In(Bit)()
    lut = fork( LUT5(rom[ 0:32]), LUT5(rom[32:64]))
    mux = Mux2()
    lut(I0, I1, I2, I3, I4)
    mux(lut.O[0], lut.O[1], I5)
    return AnonymousCircuit("I0", I0,
                            "I1", I1,
                            "I2", I2,
                            "I3", I3,
                            "I4", I4,
                            "I5", I5,
                            "O", mux.O)

def LUT7(rom, **kwargs):
    if isinstance(rom, IntegerTypes):
        rom = int2seq(rom, 128)
    I0, I1, I2, I3, I4, I5, I6 = In(Bit)(), In(Bit)(), In(Bit)(), In(Bit)(), In(Bit)(), In(Bit)(), In(Bit)()
    lut = fork( LUT6(rom[ 0:64]), LUT6(rom[64:128]))
    mux = Mux2()
    lut(I0, I1, I2, I3, I4, I5)
    mux(lut.O[0], lut.O[1], I6)
    return AnonymousCircuit("I0", I0,
                            "I1", I1,
                            "I2", I2,
                            "I3", I3,
                            "I4", I4,
                            "I5", I5,
                            "I6", I6,
                            "O", mux.O)

def LUT8(rom, **kwargs):
    if isinstance(rom, IntegerTypes):
        rom = int2seq(rom, 256)
    I0, I1, I2, I3, I4, I5, I6, I7 = In(Bit)(), In(Bit)(), In(Bit)(), In(Bit)(), In(Bit)(), In(Bit)(), In(Bit)(), In(Bit)()
    lut = fork( LUT7(rom[ 0:128]), LUT7(rom[128:256]))
    mux = Mux2()
    lut(I0, I1, I2, I3, I4, I5, I6)
    mux(lut.O[0], lut.O[1], I7)
    return AnonymousCircuit("I0", I0,
                            "I1", I1,
                            "I2", I2,
                            "I3", I3,
                            "I4", I4,
                            "I5", I5,
                            "I6", I6,
                            "I7", I7,
                            "O", mux.O)

def LUTN(rom, n=None, **kwargs):
    """
    n-bit LUT

    I[n] -> n
    """

    # rom must be a sequence
    if isinstance(rom, Sequence):
        assert n is None
        n = len(rom)
    else:
        n = 1 << n

    if n == 2:
        return LUT1(rom, **kwargs)
    if n == 4:
        return LUT2(rom, **kwargs)
    if n == 8:
        return LUT3(rom, **kwargs)
    if n == 16:
        return LUT4(rom, **kwargs)
    if n == 32:
        return LUT5(rom, **kwargs)
    if n == 64:
        return LUT6(rom, **kwargs)
    if n == 128:
        return LUT7(rom, **kwargs)
    if n == 256:
        return LUT8(rom, **kwargs)

    return None

def LUT(rom, **kwargs):
    """
    n-bit LUT

    I[n] -> n
    """
    return LUTN(rom, **kwargs)


Logic1 = LUT1
Logic2 = LUT2
Logic3 = LUT3
Logic4 = LUT4
Logic5 = LUT5
Logic6 = LUT6
Logic7 = LUT7
Logic8 = LUT8

#
# C ? B : A
#
MUX2DATA = (~A2&A0)|(A2&A1)
    
def Mux2(**kwargs):
    """Construct a Mux with 2 1-bit inputs."""
    lut = LUT3(MUX2DATA, **kwargs)
    return AnonymousCircuit("I0", lut.I0,
                            "I1", lut.I1,
                            "S", lut.I2,
                            "O", lut.O)
