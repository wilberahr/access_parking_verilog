module tester(
     clock, 
     reset, 
     sensor_ingreso_vehiculo,
     sensor_llegada_vehiculo,
     clave, 
     senal_compuerta,
     senal_alarma_pin,
     senal_alarma_bloqueo)

     output reg clock, reset; 
     output reg sensor_llegada_vehiculo, sensor_ingreso_vehiculo;
     output reg [15:0] clave_ingresada;
     input wire senal_compuerta, senal_alarma_pin, senal_alarma_bloqueo;

     

endmodule