TARGET = resultados.vcd
OUTPUT = salida
COMPILER = iverilog
FLAGS = -o
TESTBENCH= testbench.v
TESTER= tester.v
DUT_file= dut
SYNYH_file = $(DUT_file)_synth.v
CMOS_LIB= cmos_cells.lib 
YS = acceso.ys

#all: $(TESTBENCH) $(YS)
#	yosis -s $(YS)
#	iverilog -o $(OUTPUT) $(TESTBENCH)
#	vpp $(OUTPUT)
#	gtkwave $(TARGET).vcd 

all: yosis gtkwave iverilog simulation

yosis: $(DUT_file)_synth.v
	yosis -s $(YS)
gtkwave: $(TARGET)
	gtkwave $(TARGET) 


$(TARGET): $(OUTPUT) 
	vpp $(OUTPUT)
	gtkwave $(TARGET)

$(OUTPUT): $(TESTBENCH)
	iverilog -o $(OUTPUT) $(TESTBENCH)

$(DUT_file)_synth.v: $(YS)
	yosis -s $(YS)

$(YS): $(DUT_file) $(SRC_files) $(CMOS_LIB) $(DUT_file)
	read_verilog $(DUT_file).v
	hierarchy -check -top $(DUT_file)
	proc
	opt
	fsm
	opt
	memory
	opt
	techmap
	opt
	dfflibmap -liberty ./$(CMOS_LIB)
	show
	write_verilog $(DUT_file)_synth.v  



sinthesis : $(SRC_files) $(CMOS_LIB) $(DUT_file)
	read_verilog $(DUT_file).v
	hierarchy -check -top $(DUT_file)
	proc
	opt
	fsm
	opt
	techmap
	dfflibmap -liberty ./$(CMOS_LIB)
	show
	write_verilog $(DUT_file)_synth.v  



iverilog: $(TESTBENCH)
	$(COMPILER) -o $(OUTPUT) $(TESTBENCH)
	
	
simulation: $(OUTPUT)	
	vpp $(OUTPUT)
	@echo "------Running simulation------" >> simulation_log
	@date >>  simulationlog_log
	vvp salida >> simulation_log
	@echo "------------------------------" >> simulation_log
	gtkwave $(TARGET).vcd

testing: iverilog


	

sim_yosis:  

gtkwave: 




all: testbench.v
	iverilog -o salida testbench.v
	@echo "------Running simulation------" >> simulation_log
	@date >>  simulationlog_log
	vvp salida >> simulation_log
	@echo "------------------------------" >> simulation_log
	gtkwave resultados.vcd

sim: testbench.v
	iverilog -o salida testbench.v
	@echo "------Running simulation------" >> simulation_log
	@date >> simulation_log
	vvp salida >> simulation_log
	@echo "------------------------------" >> simulation_log
	gtkwave resultados.vcd

yosis: testbench.v mdio.ys
	yosis -s mdio.ys 
	iverilog -o salidaYosis testbench.vcd
	@echo "------Running simulation------" >> simulation_log
	@date >>  simulationlogYosis_log
	vvp salidaYosis >> simulationlogYosis_log
	@echo "------------------------------" >> simulation_log
	gtkwave resultados.vcd

clean:
	rm salida
	rm salidaYosis

clear:
	rm salida
	rm salidaYosis
	rm resultados.vcd
