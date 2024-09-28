module tester(
     clock, 
     reset, 
     sensor_ingreso_vehiculo,
     sensor_llegada_vehiculo,
     clave_ingresada, 
     senal_compuerta,
     senal_alarma_pin,
     senal_alarma_bloqueo);

     output reg clock, reset; 
     output reg sensor_llegada_vehiculo, sensor_ingreso_vehiculo;
     output reg [15:0] clave_ingresada;
     input wire senal_compuerta, senal_alarma_pin, senal_alarma_bloqueo;

     
     initial begin
     //Incializacion en bajo del clock y en alto del reset
     // al inicio de los tiempos
     $display("====INICIANDO SIMULACION====");
     $display("Incializacion del clock y reset");
     clock = 0;
     reset = 1;
     //inicializacion en bajo de los sensores al inicio de la simulacion
     $display("Incializacion sensores");
     sensor_llegada_vehiculo = 0; 
     sensor_ingreso_vehiculo = 0;
     
     //Activación en bajo del reset
     $display("Reset activado en bajo");
     #5 reset = 0;
     //Desactivación en alto del reset
     $display("Reset activado en bajo");
     #15 reset = 1;
     
     //////////////////////////////////////////
     //Prueba 1: funcionamiento normal básico
     $display("====Prueba 1: funcionamiento normal básico====");
     $display("====Iniciando prueba 1====");
     // Llegada de un vehículo
     #20 sensor_llegada_vehiculo = 1;
     // Ingreso del pin correcto y apertura de puerta
     #20 clave_ingresada = 16'h3257;
     $display("Apertura de puerta= %b",senal_compuerta);
     // Sensor de fin de entrada y cierre de compuerta.
     #20 sensor_ingreso_vehiculo = 0;
     $display("====Finalizando prueba 1====");
     $display(" ");

     //////////////////////////////////////////
     //Prueba 2: ingreso de pin incorrecto menos de 3 veces
     $display("Prueba 2: ingreso de pin incorrecto menos de 3 veces.");
     $display("====Iniciando prueba 2====");
     // Llegada de un vehículo
     #20 sensor_llegada_vehiculo = 1;
     // Ingreso de pin incorrecto (una o dos veces), puerta permanece cerrada. 
     #20 clave_ingresada = 16'h7523;
     $display("Apertura de puerta= %b",senal_compuerta);
     //$display("Intentos incorrectos= %d",cuenta_intentos);
     #20 clave_ingresada = 16'h4368;
     //$display("Intentos incorrectos= %d",cuenta_intentos);
     $display("Apertura de puerta= %b",senal_compuerta);
     //$display("Intentos incorrectos= %d",cuenta_intentos);
     // Ingreso de pin correcto, funcionamiento normal básico. 
     #20 clave_ingresada = 16'h3257;
     $display("Apertura de puerta= %b",senal_compuerta);
     // Revisión de contador de intentos incorrectos.
     //$display("Intentos incorrectos= %d",cuenta_intentos);
     $display("====Finalizando prueba 2====");
     $display(" ");

     //////////////////////////////////////////
     //Prueba 3: Ingreso de pin incorrecto 3 o más veces
     $display("Prueba 3: Ingreso de pin incorrecto 3 o más veces");
     $display("====Iniciando prueba====");
     #20 clave_ingresada = 16'h7523;
     #20 clave_ingresada = 16'h4368;
     #20 clave_ingresada = 16'h2656;
     // Revisión de alarma de pin incorrecto.
     $display("Alarma de pin= %b",senal_alarma_pin);
     // Revisión de contador de intentos incorrectos. 
     //$display("Intentos incorrectos= %d",cuenta_intentos);
     // Ingreso de pin correcto, funcionamiento normal básico. 
     #20 clave_ingresada = 16'h3257;
     // Revisión de limpieza de contadores y alarmas.
     //$display("Intentos incorrectos= %d",cuenta_intentos);
     $display("Alarma de bloqueo= %b",senal_alarma_bloqueo);
     $display("Alarma de pin= %b",senal_alarma_pin);
     $display("====Finalizando prueba 3====");
     $display(" ");

     //////////////////////////////////////////
     //Prueba 4: alarma de bloqueo
     $display("Prueba 4: alarma de bloqueo");
     $display("====Iniciando prueba 4====");
     // Ambos sensores encienden al mismo tiempo, 
     #20 sensor_llegada_vehiculo = 1;
     #0 sensor_ingreso_vehiculo = 1;
     // Encendido de alarma de bloqueo, 
     $display("Alarma de bloqueo= %b",senal_alarma_bloqueo);
     // Ingreso de clave incorrecta, bloqueo permanece. 
     #20 clave_ingresada = 16'h5479;
     $display("Apertura de puerta= %b",senal_compuerta);
     $display("Alarma de bloqueo= %b",senal_alarma_bloqueo);
     // Ingreso de clave correcta, desbloqueo. 
     #20 clave_ingresada = 16'h3257;
     // Funcionamiento normal básico.
     $display("Apertura de puerta= %b",senal_compuerta);
     $display("Alarma de bloqueo= %b",senal_alarma_bloqueo);
     $display("Alarma de pin= %b",senal_alarma_pin);
     $display("====Finalizando prueba 4====");
     $display(" ");
     $display("====FINALIZANDO SIMULACION====");
     #200 $finish;
     end

     always begin
     #5 clock = !clock;
     end

   
     

endmodule