#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# File              : test_mux.py
# Author            : German C.Quiveu <germancq@dte.us.es>
# Date              : 13.03.2026
# Last Modified Date: 13.03.2026
# Last Modified By  : German C.Quiveu <germancq@dte.us.es>

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer, FallingEdge, RisingEdge
from cocotb.regression import TestFactory
import random

CLK_PERIOD = 20

def setup_dut(dut, din):
    cocotb.start_soon(Clock(dut.clk,CLK_PERIOD,unit="ns").start())
    dut.din.value = din
    dut.w.value = 0
    dut.cl.value = 0

async def rst_function(dut):
    dut.cl.value = 1
    dut.w.value = 1
    await n_cycles_clock(dut,1)
    assert(dut.dout.value==0),f"ERROR in CLEAR SIGNAL"

async def write_function(dut):
    dut.cl.value = 0
    dut.w.value = 1
    await n_cycles_clock(dut,1)
    assert(dut.dout.value == dut.din.value),f"ERROR in WRITE"

async def retain_value_function(dut):
    dut.cl.value=0
    dut.w.value=0
    expected = dut.dout.value
    await n_cycles_clock(dut,5)
    assert (dut.dout.value == expected),f"ERROR retained value"

async def n_cycles_clock(dut,n):
    for _ in range(0,n):
        await RisingEdge(dut.clk)
        await FallingEdge(dut.clk)

@cocotb.test()
@cocotb.parametrize(index=range(0,10))
async def run_register_test(dut, index=0):
    """
    Verifica un vector aleatorio.
    Args:
        index: Se usa como semilla para garantizar reproducibilidad.
    """

    #1. Configuración
    #Fije la semilla random usando 'index'
    random.seed(index)
    #Lea el parámetro de ancho desde el "dut"
    DATA_WIDTH = dut.DATA_WIDTH.value

    #2. Generación de Estimulos
    #Genere valores aleatorios para las entradas (a,b y sel)

    din_rand = random.getrandbits(DATA_WIDTH) #N random bits

    #3. Asignacion valores
    #Asigne los valores a los puertos del DUT
    setup_dut(dut,din_rand)

    #4 testar funcionalidad
    await rst_function(dut)
    await retain_value_function(dut)
    await write_function(dut)
    await retain_value_function(dut)



