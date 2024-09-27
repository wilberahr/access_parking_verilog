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
     localparam primera_clave_incorrecta    = 6'b000100;
     localparam segunda_clave_incorrecta    = 6'b001000;
     localparam bloqueo_de_puerta           = 6'b010000;
     localparam ingresando_vehiculo         = 6'b100000;

     localparam cuenta_intentos = 2'b00;

     reg [7:0] estado_actual = 6'b000000;
     reg [7:0] proximo_estado = 6'b000000;

     always @(posedge clock) begin
          if (reset) begin
               estado  <= espera_llegada_vehiculo;
               cuenta_intentos <= 2'b00;  
          end else begin
               estado  <= proximo_estado;
               cuenta_intentos <= proxima_cuenta;
          end
     end
endmodule