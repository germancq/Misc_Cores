#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# File              : test_half_adder.py
# Author            : German C.Quiveu <germancq@dte.us.es>
# Date              : 03.04.2026
# Last Modified Date: 03.04.2026
# Last Modified By  : German C.Quiveu <germancq@dte.us.es>

import cocotb
from cocotb.triggers import Timer
from cocotb.regression import TestFactory
import random

async def run_half_adder_test(dut, index=0):
    """
    en este caso verificaremos todos los casos
    CASO 0: A=0, B=0, sum=0, c=0 
    """
    dut.a.value = 0
    dut.b.value = 0

    await Timer(10,'ns')

    assert (dut.sum.value == 0), f"Error en sum value en CASO 0"
    assert (dut.c.value == 0), f"Error en sum value en CASO 0"

    """
    CASO 1: A=0, B=1, sum=1, c=0 
    """
    dut.a.value = 0
    dut.b.value = 1

    await Timer(10,'ns')

    assert (dut.sum.value == 1), f"Error en sum value en CASO 0"
    assert (dut.c.value == 0), f"Error en sum value en CASO 0"
    """
    en este caso verificaremos todos los casos
    CASO 2: A=1, B=0, sum=1, c=0 
    """
    dut.a.value = 1
    dut.b.value = 0

    await Timer(10,'ns')

    assert (dut.sum.value == 1), f"Error en sum value en CASO 0"
    assert (dut.c.value == 0), f"Error en sum value en CASO 0"
    """
    en este caso verificaremos todos los casos
    CASO 3: A=1, B=1, sum=0, c=1 
    """
    dut.a.value = 1
    dut.b.value = 1

    await Timer(10,'ns')

    assert (dut.sum.value == 0), f"Error en sum value en CASO 0"
    assert (dut.c.value == 1), f"Error en sum value en CASO 0"

n=1
factory = TestFactory(run_half_adder_test)
factory.add_option("index", range(0,n))
factory.generate_tests()
