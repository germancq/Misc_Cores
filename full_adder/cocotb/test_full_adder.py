#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# File              : test_full_adder.py
# Author            : German C.Quiveu <germancq@dte.us.es>
# Date              : 03.04.2026
# Last Modified Date: 03.04.2026
# Last Modified By  : German C.Quiveu <germancq@dte.us.es>

import cocotb
from cocotb.triggers import Timer
from cocotb.regression import TestFactory
import random

#test vectors a,b,cin,sum,cout
test_vectors =  [{'a': 0,'b':0,'cin':0,'sum':0,'cout':0},
                 {'a': 0,'b':0,'cin':1,'sum':1,'cout':0},
                 {'a': 0,'b':1,'cin':0,'sum':1,'cout':0},
                 {'a': 0,'b':1,'cin':1,'sum':0,'cout':1},
                 {'a': 1,'b':0,'cin':0,'sum':1,'cout':0},
                 {'a': 1,'b':0,'cin':1,'sum':0,'cout':1},
                 {'a': 1,'b':1,'cin':0,'sum':0,'cout':1},
                 {'a': 1,'b':1,'cin':1,'sum':1,'cout':1}]


async def run_full_adder_test(dut, index=0):

    dut.a.value = test_vectors[index]['a']
    dut.b.value = test_vectors[index]['b']
    dut.cin.value = test_vectors[index]['cin']


    await Timer(10,'ns')

    #colocarlo despues del Timer, sino los datos no estaran todavia en el dut
    dut._log.info(f"dut iniciado con datos: a={dut.a.value},b={dut.b.value},cin={dut.cin.value}")

    assert (dut.sum.value == test_vectors[index]['sum']), f"ERROR en sum, a={dut.a.value} b={dut.b.value} cin={dut.cin.value}"

    assert (dut.cout.value == test_vectors[index]['cout']), f"ERROR en cout, a={dut.a.value} b={dut.b.value} cin={dut.cin.value}"


n=len(test_vectors)
factory = TestFactory(run_full_adder_test)
factory.add_option("index", range(0,n))
factory.generate_tests()
