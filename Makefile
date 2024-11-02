SRC_DIR= ./src
LIB_DIR= ./lib
BUILD_DIR = ./build 
SIM_DIR = ./sim
TESTS_DIR = ./tests

YOSIS_DIR = $(SRC_DIR)/yosis

TARGET = resultados.vcd
OUTPUT = salida
COMPILER = iverilog
FLAGS = -o
TESTBENCH= testbench.v
TESTER= tester.v
DUT = dut
DUT_FILE= $(DUT).v
SYNYH_FILE = $(DUT)_synth.v
CMOS_LIB= cmos_cells.lib 
YS = $(DUT).ys




