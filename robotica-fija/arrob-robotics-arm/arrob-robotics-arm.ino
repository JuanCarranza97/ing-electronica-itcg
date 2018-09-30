#include "ARROB_CONFIG.h"

void setup() {
  uart_init();
  pinMode(13,OUTPUT);
}

void loop() {
 if(UART_PORT.available()){
      char caracter;
      int Numbers[20];
      int bufferSize=0;

      if(uart_get(&caracter,&bufferSize,Numbers)){
        UART_PORT.println("Finalizo bien");
        UART_PORT.println("Char = "+String(caracter)+" \nMsg Size = "+String(bufferSize));
      }
      else{
        UART_PORT.println("Termino mal :c");
      }
 }
}
