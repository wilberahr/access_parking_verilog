SRC_DIR= ./src
LIB_DIR= ./lib
BUILD_DIR = ./build 
SIM_DIR = ./sim
TESTS_DIR = ./tests
BIN_DIR = ./bin

YOSIS_DIR = $(SRC_DIR)/yosis


COMPILER = iverilog
FLAGS = -o

DUT = dut
DUT_FILE= $(DUT).v
SYNYH_FILE = $(DUT)_synth.v
CMOS_LIB= $(LIB_DIR)/cmos_cells.lib 
YS = $(DUT).ys

TARGET = resultados_$(DUT)
OUTPUT = $(DUT)

TESTBENCH= testbench.v
TESTER= tester.v
