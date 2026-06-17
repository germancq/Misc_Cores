# Makefile
# 1. Configuración del Simulador
# Por defecto usamos Icarus, pero se puede sobreescribir desde la terminal
# Ejemplo: make SIM=verilator
SIM ?= icarus
# 2. Lenguaje del Top-Level
TOPLEVEL_LANG ?= verilog
# 3. Fuentes HDL (Ruta absoluta o relativa)
# $(PWD) es la variable interna de Make con el directorio actual
VERILOG_SOURCES += ../hdl/display.sv\
		   ../../counter/hdl/counter.sv\
		   ../../hex_to_7seg/hdl/hex_to_7seg.sv

ifeq ($(SIM), icarus)
	COMPILE_ARGS += -Pdisplay.CLK_HZ=1000
	COMPILE_ARGS += -Pdisplay.FREC_DISPLAY=500
	COMPILE_ARGS += -Pdisplay.N=16
endif
ifeq ($(SIM), verilator)
	COMPILE_ARGS += -GCLK_HZ=1000
	COMPILE_ARGS += -GFREC_DISPLAY=500
	COMPILE_ARGS += -GN=16
endif
# 4. Configuración del Módulo (Python)
# El nombre del archivo .py SIN la extensión
COCOTB_TEST_MODULES = test_display
# 5. Configuración del Top-Level (SystemVerilog)
# El nombre exacto del módulo dentro del archivo .sv
COCOTB_TOPLEVEL = display
# 6. Inclusión de la "Magia" de CocoTB
# Esto importa las reglas de compilación y ejecución estándar
include $(shell cocotb-config --makefiles)/Makefile.sim
