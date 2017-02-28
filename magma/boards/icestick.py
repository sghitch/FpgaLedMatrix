from magma import *
from mantle import *

from parts.lattice.ice40.ice40 import ICE40HX1K

from parts.generic.crystal import Crystal
from parts.generic.led import LED

from peripherals.timer import Timer

class IceStick(Board):

    def __init__(self):

        super(IceStick, self).__init__("IceStick")

        # Need to define the interface ...

        self.fpga = fpga = ICE40HX1K(board=self, package='tq144')

        self.CLKIN = fpga.PIO3_00
        self.CLKIN.rename('CLKIN')

        self.Crystal = Crystal(12000000, board=self)
        wire(self.Crystal.O, self.CLKIN.I)

        self.Clock = fpga.clock
        wire(self.CLKIN.O, self.Clock.I)

        self.Timer = Timer(fpga, name='systimer')

        leds = ["PIO1_14", "PIO1_13", "PIO1_12", "PIO1_11", "PIO1_10"]
        for i,k in enumerate(leds):
             name = "D%d" % (i+1)
             pin = getattr(fpga, k)
             pin.rename(name).output()
             led = LED(name=name, board=self)
             wire(pin, led.I)
             setattr(self, name, led)

        # Pmod connector
        self.PMOD0 = [fpga.PIO1_02, fpga.PIO1_03, fpga.PIO1_04, fpga.PIO1_05]
        for i in range(len(self.PMOD0)):
             self.PMOD0[i].rename( "PMOD0[%d]" % i )

        self.PMOD1 = [fpga.PIO1_06, fpga.PIO1_07, fpga.PIO1_08, fpga.PIO1_09]
        for i in range(len(self.PMOD1)):
             self.PMOD1[i].rename( "PMOD1[%d]" % i )

        self.J1 = [fpga.PIO0_02, fpga.PIO0_03, fpga.PIO0_04, fpga.PIO0_05,
                   fpga.PIO0_06, fpga.PIO0_07, fpga.PIO0_08, fpga.PIO0_09]
        for i in range(len(self.J1)):
             self.J1[i].rename( "J1[%d]" % i )

        self.J3 = [fpga.PIO2_17, fpga.PIO2_16, fpga.PIO2_15, fpga.PIO2_14,
                   fpga.PIO2_13, fpga.PIO2_12, fpga.PIO2_11, fpga.PIO2_10]
        for i in range(len(self.J3)):
             self.J3[i].rename( "J3[%d]" % i )


        # USART
        # self.DCD = fpga.PIO3_02
        # self.DSR = fpga.PIO3_03
        # self.DTR = fpga.PIO3_04
        # self.CTS = fpga.PIO3_05
        # self.RTS = fpga.PIO3_06
        self.TX = fpga.PIO3_07
        self.TX.rename('TX').output()
        self.RX = fpga.PIO3_08
        self.RX.rename('RX').input()

    def main(self):
        return self.fpga.main()


if __name__ == '__main__':
    icestick = IceStick()
