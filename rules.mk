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