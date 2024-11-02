
all: yosis gtkwave iverilog simulation dir

dir: $(SRC_DIR) $(LIB_DIR) $(BUILD_DIR) $(SIM_DIR) $(TESTS_DIR) $(SCRIPT_DIR)


$(SRC_DIR):
	mkdir -p $(SRC_DIR)
	
$(LIB_DIR):
	mkdir -p $(LIB_DIR)
	
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)
	
$(SIM_DIR):
	mkdir -p $(SIM_DIR)

$(TESTS_DIR):
	mkdir -p $(TESTS_DIR)

$(SCRIPT_DIR):
	mkdir -p $(SCRIPT_DIR)

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

#TODO agregar los .PHONY yosis gtkwave iverilog simulation dir

yosis: $(SYNYH_FILE)
	$(SYNYH_FILE)
	
gtkwave: $(TARGET)
	gtkwave $(TARGET) 

iverilog: $(OUTPUT)

yosis_simulation: yosis
	iverilog -o $(OUTPUT)_synth $(TESTBENCH)
	vpp $(OUTPUT)_synth
	gtkwave $(TARGET)_synth.vcd


$(TARGET): $(OUTPUT) 
	vpp $(BIN_DIR)/$(OUTPUT)
	gtkwave $(TARGET).vcd

$(OUTPUT): $(TESTBENCH)
	iverilog -o $(OUTPUT) $(TESTBENCH)


$(SYNYH_FILE): $(YS)
	yosis -s $(YS)

$(YS): $(DUT).ys


#$(YS): $(DUT_FILE) $(CMOS_LIB) $(DUT).ys
#	echo "read_verilog $(DUT_FILE)" >>  $(DUT).ys
#	echo "hierarchy -check -top $(DUT)" >> $(DUT).ys
#	echo "proc; opt; fsm; opt; memory; opt" >> $(DUT).ys
#	echo "techmap; opt" >> $(DUT).ys
#	echo "dfflibmap -liberty ./$(CMOS_LIB)" >> $(DUT).ys
#	echo "abc -liberty ./cmos_cells.lib" >> $(DUT).ys
#	echo "show" >> $(DUT).ys
#	echo "clean" >> $(DUT).ys
#	echo "write_verilog $(SYNYH_FILE)" $(DUT).ys 

#Expresiones regulares

$(BIN_DIR)/%.out: $(SRC_DIR)/%.v
	iverilog -o $@ $<

%.vcd: $(BIN_DIR)/%.out
	vpp $<
	gtkwave $@

%.ys: %_DUT.v $(CMOS_LIB)
	touch -p $@
	echo "read_verilog $<" >>  $@
	echo "hierarchy -check -top $(%)" >> $@
	echo "proc; opt; fsm; opt; memory; opt" >> $@
	echo "techmap; opt" >> $@
	echo "dfflibmap -liberty $(CMOS_LIB)" >> $@
	echo "abc -liberty $(CMOS_LIB)" >> $@
	echo "show" >> $@
	echo "clean" >> $@
	echo "write_verilog synth_$<" >> $@ 

#TODO: regla clean y clear
#TODO agregar los .PHONY

clean:
	rm salida
	rm salidaYosis

clear:
	rm salida
	rm salidaYosis
	rm resultados.vcd