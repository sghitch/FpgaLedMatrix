from magma.port import Port, INPUT, OUTPUT, INOUT
from magma.t import Type, Kind, IntegerTypes, In, Out

__all__  = ['BitType', 'BitKind', 'Bit', 'BitIn', 'BitOut', 'BitInOut']

__all__ += ['VCC', 'GND', 'HIGH', 'LOW']

#
# Create a Bit
#
#   Bit(name=, direction=) - Define a Bit
#
# Each bit is associated with a Port. The Port keeps track of
# how bits are wired together.
#
class BitType(Type):
    def __init__(self, *largs, **kwargs):
        
        Type.__init__(self, **kwargs)

        self.port = Port(self)

    def __eq__(self, rhs):
        return self is rhs

    def __call__(self, output):
        return self.wire(output)

    def wire(i, o):

        #print('Bit.wire(', str(i), ', ', str(o), ')')

        # promote integer types to LOW/HIGH
        if isinstance(o, IntegerTypes):
            o = HIGH if o else LOW

        if not isinstance(o, BitType):
            print('Wiring error: wiring', o, 'to', i, '(not a Bit)')
            return

        #if o.isoutput() and i.isoutput():
        #    print("Error: can't wire an output to an output")
        #    return
        #if i.isinput() and o.isinput():
        #    print("Error: can't wire an input to an input")
        #    return

        if o.isinput() and not i.isinput():
            i, o = o, i

        i.port.wire(o.port)

    def driven(self):
        return self.port.driven()

    def wired(self):
        return self.port.wired()

    # return the input or output Bit connected to this Bit
    def trace(self):
        t = self.port.trace()
        if t: t = t.bit
        return t

    # return the output Bit connected to this input Bit
    def value(self):
        t = self.port.value()
        if t: t = t.bit
        return t

    def getinst(self):
        t = self.trace()
        return t.name.inst if t else None

    def getgpio(self):
        return self.getinst()



class BitKind(Kind):

    def __init__(cls, name, bases, dct):
        Kind.__init__( cls, name, bases, dct)

        if not hasattr(cls, 'direction'):
            cls.direction = None


    def __eq__(cls, rhs):
        if not isinstance(rhs, BitKind):
            return False

        #if cls.direction is None or rhs.direction is None:
        #    return True

        return cls.direction == rhs.direction

    def __str__(cls):
        if cls._isinput():  return 'In(Bit)'
        if cls._isoutput(): return 'Out(Bit)'
        if cls._isinout():  return 'InOut(Bit)'
        return 'Bit'

    def _isoriented(cls, direction):
        return cls.direction == direction

    def qualify(cls, direction): 
        if   direction is None:   return Bit
        elif direction == INPUT:  return BitIn
        elif direction == OUTPUT: return BitOut
        return cls

    def flip(cls):
        if   cls._isoriented(INPUT):  return BitOut
        elif cls._isoriented(OUTPUT): return BitIn
        return cls



def _Bit(**kwargs):
    return BitKind('Bit', (BitType,), kwargs)

Bit = _Bit()

# should these be subclasses of Bit?
BitIn = _Bit(direction=INPUT)
BitOut = _Bit(direction=OUTPUT)
BitInOut = _Bit(direction=INOUT)

VCC = BitOut(name="VCC")
GND = BitOut(name="GND")

HIGH = VCC
LOW = GND
    
if __name__ == '__main__':
    assert Bit == Bit
    assert not (Bit != Bit)

    assert str(Bit) == 'Bit'

    assert VCC == VCC
    assert GND == GND
    assert VCC != GND

    assert str(VCC) == 'VCC'
    assert str(GND) == 'GND'

