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



     localparam espera_llegada_vehiculo     = 6'b000001;
     localparam vehiculo_ha_llegado         = 6'b000010;
     localparam clave_incorrecta            = 6'b000100;
     localparam bloqueo_de_puerta           = 6'b001000;
     localparam ingresando_vehiculo         = 6'b010000;

     reg [1:0] cuenta_intentos = 2'b00;
     reg [1:0] proxima_cuenta_intentos = 2'b00;

     reg [7:0] estado_actual = 6'b000000;
     reg [7:0] proximo_estado = 6'b000000;

     always @(posedge clock) begin
          if (reset) begin
               estado  <= espera_llegada_vehiculo;
               cuenta_intentos <= 2'b00;  
          end else begin
               estado  <= proximo_estado;
               cuenta_intentos <= proxima_cuenta_intentos;
          end
     end

     always @(*) begin

          proximo_estado = estado; 
          proxima_cuenta_intentos = cuenta_intentos;

          case(estado)
               // Se espera la llegada de un vehículo (estado inicial)
               espera_llegada_vehiculo:
                    begin
                         if (sensor_ingreso_vehiculo && sensor_llegada_vehiculo) 
                         begin
                              senal_alarma_bloqueo = activado;
                              proximo_estado = bloqueo_de_puerta;
                         end
                    else
                         begin  
                              if (sensor_llegada_vehiculo && ~sensor_ingreso_vehiculo) proximo_estado = vehiculo_ha_llegado; 
                              else proximo_estado = espera_llegada_vehiculo;
                         end
                    end
               // Ha llegado un vehículo
               vehiculo_ha_llegado: 
                    begin
                         if (sensor_ingreso_vehiculo && sensor_llegada_vehiculo) 
                         begin
                              senal_alarma_bloqueo = activado;
                              proximo_estado = bloqueo_de_puerta;
                         end
                         else
                              begin  
                                   if (clave == clave_correcta) proximo_estado = ingresando_vehiculo; 
                                   else proximo_estado = clave_incorrecta;
                         end
                    end

               // Se ha intruducido clave incorrecta
               clave_incorrecta:                              
                    begin
                         if (sensor_ingreso_vehiculo && sensor_llegada_vehiculo) 
                         begin
                              senal_alarma_bloqueo = acivado;
                              proximo_estado = bloqueo_de_puerta;
                         end
                         else
                         begin  

                              if(cuenta_intentos < 3)
                              begin
                                   if (clave = clave_correcta) 
                                   begin
                                        senal_compuerta = activado;
                                        senal_alarma_pin = ~activado;
                                        proxima_cuenta_intentos  = 0;
                                        proximo_estado = ingresando_vehiculo; 
                                   end
                                   else
                                   begin
                                        proximo_estado = clave_incorrecta;
                                        proxima_cuenta_intentos ++;


                                   end

                              end
                              else
                              begin
                                   proximo_estado = bloqueo_de_puerta;
                                   senal_alarma_pin = activado;
                                   proxima_cuenta = 0;

                              end
                         end
                    end
               
               
               // Se ha bloqueado la compuerta
               bloqueo_de_puerta: 
                    begin
                    if (sensor_ingreso_vehiculo && sensor_llegada_vehiculo)
                         begin
                              senal_alarma_bloqueo = activado;
                              proximo_estado = bloqueo_de_puerta;
                         end
                    else
                         begin
                              if(clave = clave_correcta) 
                              begin
                                   senal_alarma_bloqueo = ~activado;
                                   proximo_estado = espera_llegada_vehiculo;
                              end
                              else proximo_estado = bloqueo_de_puerta;
                         end
                    end
               
               
               
               // Un vehículo está ingresando
               ingresando_vehiculo: 
                    begin
                    if (sensor_ingreso_vehiculo && sensor_llegada_vehiculo)
                         begin
                              senal_alarma_bloqueo = activado;
                              proximo_estado = bloqueo_de_puerta;
                         end
                    else 
                    begin 
                         if (sensor_ingreso_vehiculo && ~sensor_llegada_vehiculo)
                         begin
                              senal_alarma_bloqueo = ~activado;
                              senal_compuerta = ~activado;
                              proximo_estado = espera_llegada_vehiculo;
                         end
                         else
                         begin
                              if (~sensor_ingreso_vehiculo && ~sensor_llegada_vehiculo)
                              begin
                              senal_compuerta = activado;
                              proximo_estado = ingresando_vehiculo;
                              end
                              else 
                              begin
                                   senal_compuerta = activado;
                                   proximo_estado = ingresando_vehiculo;
                              end         
                         end
                    end  

                    default:   proximo_estado = espera_llegada_vehiculo; 
          endcase

     end
endmodule