from magma import *
from mantle.lattice.mantle40.decode import Decode

__all__  = ['Decoder']

def DefineDecoder(n, invert=False):
    """
    n-bit to 2^n decoder.
    """

    class _Decoder(Circuit):
        name = 'Decoder'+str(n)+("Invert" if invert else "")
        IO = ['I', In(Array(n, Bit)), 'O', Out(Array(1<<n, Bit))]
        @classmethod
        def definition(Dec):
            def decode(y):
                return Decode(y, n, invert, loc=(0,y/8, y%8))
            dec = fork(col(decode, 1<<n))
            wire(Dec.I, dec.I)
            wire(dec.O, Dec.O)
    return _Decoder

def Decoder(n, invert=False, **kwargs):
    return DefineDecoder(n, invert)(**kwargs)
