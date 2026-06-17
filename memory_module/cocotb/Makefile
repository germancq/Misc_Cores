# Makefile
# 1. Configuración del Simulador
# Por defecto usamos Icarus, pero se puede sobreescribir desde la terminal
# Ejemplo: make SIM=verilator
SIM ?= icarus
# 2. Lenguaje del Top-Level
TOPLEVEL_LANG ?= verilog
# 3. Fuentes HDL (Ruta absoluta o relativa)
# $(PWD) es la variable interna de Make con el directorio actual
VERILOG_SOURCES += ../hdl/memory_module.sv

$(info "hello world with SIM=$(SIM)")
ifeq ($(SIM), icarus)
COMPILE_ARGS += -Pmemory_module.DATA_WIDTH=8
COMPILE_ARGS += -Pmemory_module.ADDR=4
COMPILE_ARGS += -Pmemory_module.FILE_MEM=\"../../memory_module/hdl/init.mem\"

endif
ifeq ($(SIM), verilator)
COMPILE_ARGS += -GDATA_WIDTH=8
COMPILE_ARGS += -GADDR=4
endif
# 4. Configuración del Módulo (Python)
# El nombre del archivo .py SIN la extensión
COCOTB_TEST_MODULES = test_memory_module
# 5. Configuración del Top-Level (SystemVerilog)
# El nombre exacto del módulo dentro del archivo .sv
COCOTB_TOPLEVEL = memory_module
# 6. Inclusión de la "Magia" de CocoTB
# Esto importa las reglas de compilación y ejecución estándar
include $(shell cocotb-config --makefiles)/Makefile.sim

clean_all:
	rm *.pyc
	rm *.xml
