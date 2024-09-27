`include "tester.v"
`include "dui.v"

module testbench

     wire clk, rst; 
     wire s_llegada_vehiculo, s_ingreso_vehiculo;
     wire [15:0] clave_ingresada;
     wire signal_compuerta, signal_alarma_pin, signal_alarma_bloqueo;

     initial begin
          $dumpfile("resusultados.vcd")
          $dumpvars(-1,DUT);
          $monitor("s_llegada_vehiculo = %b, s_ingreso_vehiculo = %b ,signal_compuerta = %b, signal_alarma_bloqueo = %b, signal_alarma_pin = %b"
                    s_llegada_vehiculo,s_ingreso_vehiculo,signal_compuerta,signal_alarma_bloqueo,signal_alarma_pin)

     end


     access DUT(
          .clock(clk), 
          .reset(rst), 
          .sensor_ingreso_vehiculo(s_ingreso_vehiculo),
          .sensor_llegada_vehiculo(s_llegada_vehiculo),
          .clave_ingresada(clave), 
          .senal_compuerta(signal_compuerta),
          .senal_alarma_pin(signal_alarma_pin),
          .senal_alarma_bloqueo(signal_alarma_bloqueo)
     );

     tester SIMULACION(
          .clock(clk), 
          .reset(rst), 
          .sensor_ingreso_vehiculo(s_ingreso_vehiculo),
          .sensor_llegada_vehiculo(s_llegada_vehiculo),
          .clave_ingresada(clave), 
          .senal_compuerta(signal_compuerta),
          .senal_alarma_pin(signal_alarma_pin),
          .senal_alarma_bloqueo(signal_alarma_bloqueo)
     ):