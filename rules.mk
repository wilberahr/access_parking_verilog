all: yosis gtkwave iverilog simulation

yosis: $(SYNYH_FILE)
	
gtkwave: $(TARGET)
	gtkwave $(TARGET) 

iverilog: $(OUTPUT)

simulation: $(TARGET)



$(TARGET): $(OUTPUT) 
	vpp $(OUTPUT)
	gtkwave $(TARGET)

$(OUTPUT): $(TESTBENCH)
	iverilog -o $(OUTPUT) $(TESTBENCH)


$(SYNYH_FILE): $(YS)
	yosis -s $(YS)
	iverilog -o $(OUTPUT)_synth $(TESTBENCH)
	vpp $(OUTPUT)_synth
	gtkwave $(TARGET)_synth.vcd

$(YS): $(DUT_FILE) $(CMOS_LIB) $(DUT_FILE)
	read_verilog $(DUT_FILE).v
	hierarchy -check -top $(DUT)
	proc
	opt
	fsm
	opt
	memory
	opt
	techmap
	opt
	dfflibmap -liberty ./$(CMOS_LIB)
	abc -liberty ./cmos_cells.lib
	show
	clean
	write_verilog $(SYNYH_FILE) 