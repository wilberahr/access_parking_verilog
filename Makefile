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
YOSIS_DIR = $(SRC_DIR)/yosis

# Compilador 
COMPILER = iverilog
# Banderas del compilador
FLAGS = -o
# Nombre del dispositivo bajo prueba
DUT = dut
# Nombre del archivo del DUT
DUT_FILE= $(DUT).v
# Nombre del archivo del DUT sintetizado
SYNYH_FILE = $(DUT)_synth.v
# Biblioteca de archivos liberty
CMOS_LIB= $(LIB_DIR)/cmos_cells.lib 
# Archivo .ys de receta para yosis
YS = $(DUT).ys
#TODO: Ver si se cambian o eliminan variablaes
TARGET = resultados_$(DUT)
OUTPUT = $(DUT)

TESTBENCH= testbench.v
TESTER= tester.v
