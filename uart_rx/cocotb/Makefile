# Makefile
# 1. Configuración del Simulador
# Por defecto usamos Icarus, pero se puede sobreescribir desde la terminal
# Ejemplo: make SIM=verilator
SIM ?= icarus
# 2. Lenguaje del Top-Level
TOPLEVEL_LANG ?= verilog
# 3. Fuentes HDL (Ruta absoluta o relativa)
# $(PWD) es la variable interna de Make con el directorio actual
VERILOG_SOURCES += ../hdl/uart_rx.sv\
		   ../../counter/hdl/counter.sv\
		   ../../shift_register/hdl/shift_register.sv

ifeq ($(SIM), icarus)
	COMPILE_ARGS += -Puart_rx.BAUDIOS=9600
	COMPILE_ARGS += -Puart_rx.CLK_HZ=100000000
endif
ifeq ($(SIM), verilator)
	COMPILE_ARGS += -GBAUDIOS=9600
	COMPILE_ARGS += -GCLK_HZ=100000000
endif
# 4. Configuración del Módulo (Python)
# El nombre del archivo .py SIN la extensión
COCOTB_TEST_MODULES = test_uart_rx
# 5. Configuración del Top-Level (SystemVerilog)
# El nombre exacto del módulo dentro del archivo .sv
COCOTB_TOPLEVEL = uart_rx
# 6. Inclusión de la "Magia" de CocoTB
# Esto importa las reglas de compilación y ejecución estándar
include $(shell cocotb-config --makefiles)/Makefile.sim
