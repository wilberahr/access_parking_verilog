# Directorio de archivos de verilog 
SRC_DIR= ./src
# Directorio de archivos liberty .lib .v
LIB_DIR= ./lib
# Dierctorio de archivos generados en vpp .vcd
BUILD_DIR = ./build 
# Directorio para guardar formas de onda de .vcd
SIM_DIR = ./sim
# TODO: Directorio de archivos de prueba para cada modulo
TESTS_DIR = ./tests
# Directorio de archivos de compilacion .out
BIN_DIR = ./bin
# Directorio de archivos de yosis
SCRIPTS_DIR = ./scripts

DIR = $(SRC_DIR) $(LIB_DIR) $(BUILD_DIR) $(SIM_DIR) $(TESTS_DIR) $(SCRIPTS_DIR)
# Compilador 
COMPILER = iverilog
# Banderas del compilador
FLAGS = -o
# Nombre del dispositivo bajo prueba
DUT = dut
# Nombre del archivo del DUT
DUT_FILE= $(DUT).v
# Nombre del archivo del DUT sintetizado
SYNYH_FILE = $(SRC_DIR)/$(DUT)_synth.v
# Biblioteca de archivos liberty
CMOS_LIB= $(LIB_DIR)/cmos_cells.lib 
# Archivo .ys de receta para yosis
YS = $(SCRIPTS_DIR)/$(DUT).ys
#TODO: Ver si se cambian o eliminan variablaes
TARGET = resultados_$(DUT)
OUTPUT = $(DUT).out

TESTBENCH= testbench.v
TESTER= tester.v

tarea: $(TESTBENCH)
	$(COMPILER) $(FLAGS) $(OUTPUT) $(TESTBENCH)
	vpp $(OUTPUT)
	GTKWAVE $(TARGET) 