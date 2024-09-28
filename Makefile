all: testbench.v
	iverilog -o salida testbench.v
	echo "------Running simulation------" >> simulation_log
	date >>  simulationlog_log
	vvp salida >> simulation_log
	echo "------------------------------" >> simulation_log
	gtkwave resultados.vcd

sim: testbench.v
	iverilog -o salida testbench.v
	echo "------Running simulation------" >> simulation_log
	date >> simulation_log
	vvp salida >> simulation_log
	echo "------------------------------" >> simulation_log
	gtkwave resultados.vcd

yosis: testbench.v mdio.ys
	yosis -s mdio.ys 
	iverilog -o salidaYosis testbench.vcd
	echo "------Running simulation------" >> simulation_log
	date >>  simulationlogYosis_log
	vvp salidaYosis >> simulationlogYosis_log
	echo "------------------------------" >> simulation_log
	gtkwave resultados.vcd

clean:
	rm salida
	rm salidaYosis

clear:
	rm salida
	rm salidaYosis
	rm resultados.vcd
