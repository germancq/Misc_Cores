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

test_vectors =  [0x40,
                 0x79,
                 0x24,
                 0x30,
                 0x19,
                 0x12,
                 0x02,
                 0x78,
                 0x00,
                 0x10,
                 0x08,
                 0x03,
                 0x46,
                 0x21,
                 0x06,
                 0x0e]
                 
                 


async def run_hex_to_7seg_test(dut, index=0):

    dut.data_in.value = index
    expected_result = test_vectors[index]


    await Timer(10,'ns')
    
    dut._log.info(f"result = {hex(dut.data_out.value)}")


    assert (dut.data_out.value == expected_result), f"ERROR en dout, expected={hex(expected_result)}, calculated={hex(dut.data_out.value)}"



n=len(test_vectors)
factory = TestFactory(run_hex_to_7seg_test)
factory.add_option("index", range(0,n))
factory.generate_tests()
