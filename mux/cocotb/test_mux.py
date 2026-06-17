#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# File              : test_mux.py
# Author            : German C.Quiveu <germancq@dte.us.es>
# Date              : 13.03.2026
# Last Modified Date: 13.03.2026
# Last Modified By  : German C.Quiveu <germancq@dte.us.es>

import cocotb
from cocotb.triggers import Timer
from cocotb.regression import TestFactory
import random

#dut (device under test) en este caso el MUX
#Mux tiene 3 entradas (a,b y sel) y una salida (dout) y un parametro N para indicar el tamaño de los datos.
async def run_mux_test(dut, index=0):
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
    a_rand = random.getrandbits(N) #N random bits
    b_rand = random.getrandbits(N)
    sel_rand = random.getrandbits(1)

    #3. Ejecución
    #Asigne los valores a los puertos del DUT
    dut.a.value = a_rand
    dut.b.value = b_rand
    dut.sel.value = sel_rand
    #Espere un tiempo delta para que la lógica se propague
    await Timer(10,'ns')

    #4. Monitorización y checkeo
    #Calcule el valor esperado en Python
    expected_dout = b_rand
    if(sel_rand == 0):
        expected_dout = a_rand
    #Compare con dut.dout.value usando 'assert'
    assert (dut.dout.value == expected_dout), f"Error en el resultado, iteracion {index}, valor esperado = {hex(expected_dout)}, valor calculado = {hex(dut.dout.value)}"

# --- Configuración de la Factoría ---

n = 10
factory = TestFactory(run_mux_test)
factory.add_option("index", range(0, n))
factory.generate_tests()

