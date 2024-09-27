module access(clock, 
reset, 
sensor_ingreso_vehiculo,
sensor_llegada_vehiculo,
clave_ingresada, 
senal_compuerta,
senal_alarma_pin,
senal_alarma_bloqueo)

     input wire clock, reset; 
     input wire sensor_llegada_vehiculo, sensor_ingreso_vehiculo;
     input wire [7:0] clave_ingresada;
     output reg senal_compuerta, senal_alarma_pin, senal_alarma_bloqueo;


endmodule