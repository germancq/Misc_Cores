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
import math


def setup_dut(dut, din):
    cocotb.start_soon(Clock(dut.clk,int(dut.CLK_HZ.value),unit="ns").start())
    dut.din.value = din
    dut.rst.value = 0

async def rst_function(dut):
    dut.rst.value = 1
    await n_cycles_clock(dut,5)
    assert(dut.counter_dout.value==0),f"ERROR in RST SIGNAL, counter_dout={hex(dut.counter_dout.value)}"
    assert(dut.an_counter.value==0),f"ERROR in RST SIGNAL, an_counter={hex(dut.an_conuter.value)}"

def check_din_i(dut,din):
    N = int(dut.N.value)
    expected_din_i = [0] * int(N/4)
    for i in range(0,int(N/4)):
        expected_din_i[i]= (din>>(4*i)) & 0xF
        assert(dut.din_i[i].value == expected_din_i[i]),f"ERROR check din i in position i={i} with din={hex(din)} calculated={hex(dut.din_i[i].value)} expected={hex(expected_din_i[i])}"


async def an_function(dut):
    dut.rst.value = 0
    CLK_HZ = int(dut.CLK_HZ.value)
    FREC_DISPLAY = int(dut.FREC_DISPLAY.value)
    expected_div = int(math.log2(CLK_HZ/FREC_DISPLAY))
    #dut._log.info(expected_div)
    assert(dut.DIV.value == expected_div),f"ERROR EXPECTED DIV, expected={hex(expected_div)}, calculated={hex(dut.DIV.value)}"
    N = int(dut.N.value)
    for i in range(0,int(N/4)):
        #dut._log.info(dut.an_counter.value)
        expected_value = ~(1<<i) & (2**(int(N/4))-1)
        assert(dut.an.value == expected_value),f"error en ciclo {i} con an = {dut.an.value} expected={expected_value}"
        await an_cycle(dut)


async def an_cycle(dut):
    loop_cond=1
    j=1
    while(loop_cond):
        prev_value = dut.an_counter.value
        await n_cycles_clock(dut,1)
        current_value = dut.an_counter.value
        if(prev_value != current_value):
            loop_cond = 0
    #dut._log.info(f"ciclos necesarios para an = {j}")

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
    N = dut.N.value

    #2. Generación de Estimulos
    #Genere valores aleatorios para las entradas (a,b y sel)

    din_rand = random.getrandbits(N) #N random bits

    #3. Asignacion valores
    #Asigne los valores a los puertos del DUT
    setup_dut(dut,din_rand)

    #4 testar funcionalidad
    await rst_function(dut)
    check_din_i(dut,din_rand)
    await an_function(dut)



