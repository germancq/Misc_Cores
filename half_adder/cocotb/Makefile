# Makefile
# 1. Configuración del Simulador
# Por defecto usamos Icarus, pero se puede sobreescribir desde la terminal
# Ejemplo: make SIM=verilator
SIM ?= icarus 
# 2. Lenguaje del Top-Level
TOPLEVEL_LANG ?= verilog
# 3. Fuentes HDL (Ruta absoluta o relativa)
# $(PWD) es la variable interna de Make con el directorio actual
VERILOG_SOURCES += ../hdl/half_adder.sv

# 4. Configuración del Módulo (Python)
# El nombre del archivo .py SIN la extensión
COCOTB_TEST_MODULES = test_half_adder
# 5. Configuración del Top-Level (SystemVerilog)
# El nombre exacto del módulo dentro del archivo .sv
COCOTB_TOPLEVEL = half_adder
# 6. Inclusión de CocoTB
# Esto importa las reglas de compilación y ejecución estándar
include $(shell cocotb-config --makefiles)/Makefile.sim
