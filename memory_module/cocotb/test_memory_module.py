#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# File              : test_mux.py
# Author            : German C.Quiveu <germancq@dte.us.es>
# Date              : 13.03.2026
# Last Modified Date: 13.03.2026
# Last Modified By  : German C.Quiveu <germancq@dte.us.es>

import os
import sys

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer, FallingEdge, RisingEdge
from cocotb.regression import TestFactory
import random

CLK_PERIOD = 20

def setup_dut(dut):
    cocotb.start_soon(Clock(dut.clk,CLK_PERIOD,unit="ns").start())
    dut.din.value = 0 
    dut.addr.value = 0
    dut.we.value = 0

async def check_initial_contents(dut):
    dut.we.value = 0
    ADDR = int(dut.ADDR.value)
    dut.addr.value=0
    FILE_MEM = dut.FILE_MEM.value
    DATA_WIDTH = int(dut.DATA_WIDTH.value)
    await n_cycles_clock(dut,1)
    with(open(FILE_MEM, "rb+")) as init_mem:
        for i in range(0,2**ADDR):
            dut.addr.value=i
            hex_str = init_mem.read(int(DATA_WIDTH/8)*2)#2 caracteres por dato en la memoria 00 0F 0A A8
            expected_value = int(hex_str,16)
            await n_cycles_clock(dut,1)
            assert(dut.dout.value == expected_value),f"ERROR INIT en ADDR = {i}, expected = {hex(expected_value)}, calculated = {hex(dut.dout.value)}"

async def test_writing(dut):
    ADDR = int(dut.ADDR.value)
    dut.addr.value=0
    DATA_WIDTH = int(dut.DATA_WIDTH.value)
    await n_cycles_clock(dut,1)
    for i in range(0,2**ADDR):
        dut.addr.value=i
        dut.we.value = 1
        dut.din.value = i
        await n_cycles_clock(dut,1)
        dut.we.value = 0
        await n_cycles_clock(dut,1)
        assert(dut.dout.value == i),f"ERROR INIT en ADDR = {i}, expected = {hex(i)}, calculated = {hex(dut.dout.value)}"


async def n_cycles_clock(dut,n):
    for _ in range(0,n):
        await RisingEdge(dut.clk)
        await FallingEdge(dut.clk)

@cocotb.test()
@cocotb.parametrize(index=range(0,1))
async def run_memory_test(dut, index=0):
    """
    Verifica un vector aleatorio.
    Args:
        index: Se usa como semilla para garantizar reproducibilidad.
    """

    #Fije la semilla random usando 'index'
    random.seed(index)

    #Asigne los valores a los puertos del DUT
    setup_dut(dut)
    print(dut.FILE_MEM.value)

    #testar funcionalidad
    await check_initial_contents(dut)
    await test_writing(dut)




