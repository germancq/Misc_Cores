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
import UART_TX
import numpy as np
from cocotb.clock import Clock
from cocotb.regression import TestFactory
from cocotb.triggers import FallingEdge, RisingEdge, Timer

'''
def setup(dut, data_test):
    clk_period = int((1*(10**9)) / int(dut.CLK_HZ.value))
    cocotb.start_soon(Clock(dut.clk,clk_period,unit="ns").start())
    dut.start.value = 0
    dut.din.value = data_test
    dut.rst.value = 0


async def rst_test(dut):
    dut.rst.value = 1
    await n_cycles_clk(dut, 2)
    assert (
        int(dut.current_state.value) == int(dut.IDLE.value)
    ), f"ERROR IN RST, STATE IS {dut.current_state.value}, EXPECTED {dut.IDLE.value}"
    assert (
        dut.busy.value == 0
    ), f"ERROR IN RST BUSY value {
        dut.busy.value}"
    assert (
        dut.bits_counter_dout.value == 0
    ), f"ERROR IN RST BITS_COUNTER value {dut.bits_counter_dout.value}"
    assert (
        dut.sampling_counter_dout.value == 0
    ), f"ERROR IN RST SAMPLING_COUNTER value {dut.sampling_counter_dout.value}"

    await n_cycles_clk(dut, 10)
    assert (
        int(dut.current_state.value) == int(dut.IDLE.value)
    ), f"ERROR IN RST, STATE IS {dut.current_state.value}, EXPECTED {dut.IDLE.value}"

    dut.rst.value = 0


async def rx_test(dut, test_byte):
    dut.start.value = 1
    await n_cycles_clk(dut, 1)


    assert (
        int(dut.current_state.value) == int(dut.START_BIT.value)
    ), f"ERROR IN TX, STATE IS {dut.current_state.value}, EXPECTED {dut.START_BIT.value}"

    assert (dut.tx_dout.value == test_byte),f"ERROR writing test_byte={hex(test_byte)} into shift_register = {hex(dut.tx_dout.value)}"

    assert (
        dut.busy.value == 1
    ), f"ERROR IN RST BUSY value {
        dut.busy.value}"

    dut._log.info(int(dut.CLK_HZ.value))
    dut._log.info(int(dut.BAUDIOS.value))
    dut._log.info(int(dut.CICLOS_PERIODO.value))

    while int(dut.sampling_counter_dout.value) != int(dut.CICLOS_PERIODO.value) - 2:
        assert (
            int(dut.current_state.value) == int(dut.START_BIT.value)
        ), f"ERROR IN TX, STATE IS {dut.current_state.value}, EXPECTED {dut.START_BIT.value}"
        await n_cycles_clk(dut, 1)

    assert(dut.sampling_rst.value == 1),f"ERROR SAMPLING RST"
    assert(dut.tx_shift_r.value == 1),f"ERROR SHIFTING RST"

    await n_cycles_clk(dut, 1)

    assert (
        dut.sampling_counter_dout.value == 0
    ), f"ERROR IN RST SAMPLING_COUNTER value {dut.sampling_counter_dout.value}"

    assert (
        int(dut.current_state.value) == int(dut.DATA_BITS.value)
    ), f"ERROR IN TX, STATE IS {dut.current_state.value}, EXPECTED {dut.DATA_BITS.value}"

    assert (
        dut.busy.value == 1
    ), f"ERROR IN RST BUSY value {
        dut.busy.value}"

    dut._log.info(hex(test_byte))
    for i in range(0, 8):
        bit_value = (test_byte >> i) & 0x1

        assert (
            dut.bits_counter_dout.value == i
        ), f"ERROR IN TX, EXPECTED BITS_COUNTER = {hex(dut.bits_counter_dout.value)} CALCULATED = {hex(i)}"
        while int(dut.sampling_counter_dout.value) != int(dut.CICLOS_PERIODO.value) - 2:
            assert (
                int(dut.current_state.value) == int(dut.DATA_BITS.value)
            ), f"ERROR IN TX, STATE IS {dut.current_state.value}, EXPECTED {dut.DATA_BITS.value}"
            await n_cycles_clk(dut, 1)
        dut._log.info(hex(dut.tx_dout.value))
        assert (
            dut.tx.value == bit_value
        ), f"ERROR IN TX bit{i}, tx value is {
            dut.tx.value}"
        await n_cycles_clk(dut, 1)

    assert (
        int(dut.current_state.value) == int(dut.STOP_BIT.value)
    ), f"ERROR IN TX, STATE IS {dut.current_state.value}, EXPECTED {dut.STOP_BIT.value}"

    while int(dut.sampling_counter_dout.value) != int(dut.CICLOS_PERIODO.value) - 2:
        assert (
            int(dut.current_state.value) == int(dut.STOP_BIT.value)
        ), f"ERROR IN TX, STATE IS {dut.current_state.value}, EXPECTED {dut.STOP_BIT.value}"
        await n_cycles_clk(dut, 1)

    await n_cycles_clk(dut,1)

    assert (
        int(dut.current_state.value) == int(dut.DONE.value)
    ), f"ERROR IN TX, STATE IS {dut.current_state.value}, EXPECTED {dut.DONE.value}"

    assert (
        dut.busy.value == 0
    ), f"ERROR IN TX ACTIVE value {
        dut.busy.value}"

    assert (
        dut.done.value == 1
    ), f"ERROR IN TX DONE value {
        dut.done.value}"


async def n_cycles_clk(dut, n):
    for i in range(0, n):
        await RisingEdge(dut.clk)
        await FallingEdge(dut.clk)
'''

@cocotb.test()
@cocotb.parametrize(index=range(0,5))
async def test(dut, index=0):
    random.seed(index)

    data_test = random.getrandbits(8)

    uart_tx_dut = UART_TX.UART_TX(dut)
    await uart_tx_dut.rst(dut.rst,dut)
    await uart_tx_dut.operation(dut.start,dut.din,dut,data_test)

    #setup(dut, data_test)

    #await rst_test(dut)
    #await rx_test(dut, data_test)



