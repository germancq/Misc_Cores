#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# File              : test_mux.py
# Author            : German C.Quiveu <germancq@dte.us.es>
# Date              : 13.03.2026
# Last Modified Date: 13.03.2026
# Last Modified By  : German C.Quiveu <germancq@dte.us.es>
import os
import random
import sys

import cocotb
import UART
import numpy as np
from cocotb.clock import Clock
from cocotb.regression import TestFactory
from cocotb.triggers import FallingEdge, RisingEdge, Timer


@cocotb.test()
@cocotb.parametrize(index=range(0,5))
async def test(dut, index=0):
    random.seed(index)

    data_test = random.getrandbits(8)

    uart_dut = UART.UART(dut)

    await uart_dut.rst(dut.rst,dut)
    await uart_dut.read(dut.rx,dut,data_test)
    await uart_dut.rst(dut.rst,dut)
    await uart_dut.write(dut.tx_start,dut.tx_byte,dut,data_test)

    #setup(dut)

    #await rst_test(dut)
    #await tx_test(dut, data_test)



