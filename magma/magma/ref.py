__all__ = ['AnonRef', 'InstRef', 'DefnRef', 'ArrayRef', 'TupleRef']

class Ref:
    def __str__(self):
        return self.qualifiedname()

class AnonRef(Ref):
    def __init__(self, name=None):
        self.name = name

    def qualifiedname(self, sep='.'):
        return str(self.name) if self.name else ""

    def anon(self):
        return False if self.name else True

class InstRef(Ref):
    def __init__(self, inst, name):
        assert inst
        self.inst = inst # Inst
        self.name = name

    def qualifiedname(self, sep='.'):
        name = self.name
        if isinstance(self.name, (int, long)):
            # Hack, Hack, Hack
            if sep == '.':
                return str(self.inst) + '[%d]' % self.name
        return str(self.inst) + sep + str(name)

    def anon(self):
        return False

class DefnRef(Ref):
    def __init__(self, defn, name):
        assert defn
        self.defn = str(defn) # Definition
        self.name = name

    def qualifiedname(self, sep='.'):
        if sep == '.':
            return self.defn + sep + self.name
        else:
            return self.name

    def anon(self):
        return False

class ArrayRef(Ref):
   def __init__(self, array, index):
       self.array = array # Array
       self.index = index

   def qualifiedname(self, sep='.'):
       return self.array.name.qualifiedname(sep=sep) + \
                '[%d]' % self.index

   def anon(self):
       return self.array.name.anon()

class TupleRef(Ref):
   def __init__(self, tuple, index):
       self.tuple = tuple # Tuple
       self.index = index

   def qualifiedname(self, sep='.'):
       return self.tuple.name.qualifiedname(sep=sep) + sep + str(self.index)

   def anon(self):
       return self.tuple.name.anon()



if __name__ == '__main__':
   a = AnonRef()
   print(str(a))
   a = AnonRef('x')
   print(str(a))

   print(isinstance(a,Ref))

