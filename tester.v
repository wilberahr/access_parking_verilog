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

     
     initial begin
     //Incializacion en bajo del clock y en alto del reset
     // al inicio de los tiempos
     clock = 0;
     reset = 1;
     //inicializacion en bajo de los sensores al inicio de la simulacion
     sensor_llegada_vehiculo = 0, 
     sensor_ingreso_vehiculo = 0,
     
     //Activación en bajo del reset
     #5 reset = 0;
     //Desactivación en alto del reset
     #15 reset = 1;
     
     //////////////////////////////////////////
     //Prueba 1: funcionamiento normal básico
     //
     // Llegada de un vehículo
     #20 sensor_llegada_vehiculo = 1;
     // Ingreso del pin correcto y apertura de puerta
     #20 clave_ingresada = 4'h3257;
     // Sensor de fin de entrada y cierre de compuerta.
     #20 sensor_ingreso_vehiculo = 0;
     


     //Prueba 2: ingreso de pin incorrecto menos de 3 veces
     //
     // Llegada de un vehículo
     #20 sensor_llegada_vehiculo = 1;
     // Ingreso de pin incorrecto (una o dos veces), puerta permanece cerrada. 
     #20 clave_ingresada = 4'h7523;
     #20 clave_ingresada = 4'h4368;
     // Ingreso de pin correcto, funcionamiento normal básico. 
     #20 clave_ingresada = 4'h3257;
     // Revisión de contador de intentos incorrectos.


     //////////////////////////////////////////
     //Prueba 3: Ingreso de pin incorrecto 3 o más veces
     #20 clave_ingresada = 4'h7523;
     #20 clave_ingresada = 4'h4368;
     #20 clave_ingresada = 4'h2656;
     // Revisión de alarma de pin incorrecto.
     
     // Revisión de contador de intentos incorrectos. 
     
     // Ingreso de pin correcto, funcionamiento normal básico. 
     #20 clave_ingresada = 4'h3257;
     // Revisión de limpieza de contadores y alarmas.

     //////////////////////////////////////////
     //Prueba 4: alarma de bloqueo
     //
     // Ambos sensores encienden al mismo tiempo, 
     #20 sensor_llegada_vehiculo = 1;
     #0 sensor_ingreso_vehiculo = 1;
     // Encendido de alarma de bloqueo, 
     
     // Ingreso de clave incorrecta, bloqueo permanece. 
     #20 clave_ingresada = 4'h5479;
     // Ingreso de clave correcta, desbloqueo. 
     #20 clave_ingresada = 4'h3257;
     // Funcionamiento normal básico.

     #200 $finish;
     end

     always begin
     #5 clock = !clock;
     end


     

endmodule