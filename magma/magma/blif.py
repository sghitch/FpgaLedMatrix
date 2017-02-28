import types
from collections import OrderedDict, Sequence
from magma.bits import seq2int, fun2seq
from magma.bit import VCC, GND, BitType
from magma.array import ArrayType
from magma.port import INPUT, OUTPUT, INOUT
from magma.wire import wiredefaultclock
from magma.circuit import *

__all__ = ['compile']

def fullname(prefix, name):
    return prefix + '_' + name if prefix else name

def fullqualifiedname(prefix, v):
     return fullname(prefix, str(v))

def fullinputname(prefix, v):
    if   v == VCC:
        return '$true'
    elif v == GND:
        return '$false'
    else:
        return fullqualifiedname(prefix, v)

def compileinput(prefix, from_, to):
    assert isinstance(from_, BitType)
    to = fullqualifiedname(prefix, to)
    from_ = fullinputname(prefix, from_)
    return '.names %s %s\n1 1\n' % (from_, to)

def compileinputs(instance, prefix):
    s = ''
    for k, v in instance.interface.ports.items():
        if v.isinput():
            if isinstance(v, ArrayType):
                for i in range(len(v)):
                    w = v[i].value()
                    if w:
                        s += compileinput(prefix, w, v[i])
            else:
                w = v.value()
                if w:
                    s += compileinput(prefix, w, v)
    return s


def compileprimitive(prim, prefix, location):

    assert not isdefinition(prim)

    def arg(k,v): # helper function to format arg
        if not isinstance(v, str): v = str(v)
        return '%s=%s' % (k, v)

    # collect args
    args = []
    for k, v in prim.interface.ports.items():
        if v.direction == INPUT or v.direction == INOUT:
            # connect input to an output by tracing the net
            w = v.value()
            if w:
                w = fullinputname(prefix, w)
                args.append( arg(k,w) )
        elif v.direction == OUTPUT or v.direction == INOUT:
            # connect output to a wire with a fully qualified name
            w = fullqualifiedname(prefix, v)
            args.append( arg(k,w) )

    s  = '.gate ' + str(prim.__class__.__name__) + ' ' + ' '.join(args) + '\n'

    # parameters
    for k, v in prim.kwargs.items():
        if k == 'LUT_INIT':
            if isinstance(v, tuple):
                v = v[0]
            #v = int('0x'+v[4:], 0) # convert from verilog hex
            v = bin(v)[2:]         # convert to binary, skipping 0b
            s += '.param %s %s\n' % (k, v)

    # attributes - only location for now
    if location:
        s += '.attr loc "%d,%d/%d"\n' % location

    return s


def compiledefinition(defn, prefix, location=None):
    s = ''
    for instance in defn.instances:
        wiredefaultclock(defn, instance)
        if location and instance.loc:
            x = location[0] + instance.loc[0]
            y = location[1] + instance.loc[1]
            z = location[2] + instance.loc[2]
            instlocation = (x,y,z)
        else:
            instlocation = None
        s += compileinstance(instance, prefix, instlocation)
    s += '# wire instance outputs\n'
    return s + compileinputs(defn, prefix)

def compileinstance(instance, prefix, location):
    defn = type(instance)
    if isdefinition(defn):
        instname = fullname(prefix, instance.name)
        s  = '# ' + str(defn) + ' ' + instname + ' instances\n'
        s += compiledefinition(defn, instname, location)
        s += '# wire instance inputs\n'
        s += compileinputs(instance, prefix)
        s += '# ' + str(defn) + ' ' + instname + '\n'
    else:
        s  = compileprimitive(instance, prefix, location)
    return s

def compile(main, origin=None):

    s = '.model %s\n' % main.__name__

    inputs = []
    outputs = []
    for k, v in main.interface.ports.items():
        if v.direction == INPUT or v.direction == INOUT:
            inputs.append(k)
        if v.direction == OUTPUT or v.direction == INOUT:
            outputs.append(k)
    s += '.inputs '  + " ".join(outputs) + '\n' # flip inputs
    s += '.outputs ' + " ".join(inputs) + '\n'  # flip outputs
         
    s += '.names $false\n'
    s += '.names $true\n'
    s += '1\n'

    if origin and len(origin) == 2:
        origin = (origin[0], origin[1], 0)
    s += compiledefinition(main, '', origin)

    return s

