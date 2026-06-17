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

async def run_adder_test(dut, index=0):
    random.seed(index)
    N = dut.N.value

    a_rand = random.getrandbits(N)
    b_rand = random.getrandbits(N)


    expected_sum = (a_rand + b_rand) & ((2**int(N))-1)
    expected_carry = (a_rand + b_rand) >> int(N)

    dut.a.value = a_rand
    dut.b.value = b_rand
    dut.cin.value = 0

    await Timer(10,'ns')

    dut._log.info(f"dut iniciado con datos: a={hex(dut.a.value)}, b={hex(dut.b.value)}")
    dut._log.info(f"dut resultados con datos: sum={hex(dut.sum.value)}, cout={dut.cout.value}")

    assert (dut.sum.value == expected_sum),f"ERROR input values a={hex(a_rand)}, b={hex(b_rand)}. expected_sum={hex(expected_sum)}, calculated_sum={hex(dut.sum.value)}"
    assert (dut.cout.value == expected_carry),f"ERROR input values a={hex(a_rand)}, b={hex(b_rand)}. expected_carry={hex(expected_carry)}, calculated_carry={hex(dut.cout.value)}"

n=20
factory = TestFactory(run_adder_test)
factory.add_option("index", range(0,n))
factory.generate_tests()
