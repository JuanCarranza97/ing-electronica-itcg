#include "TERMINAL.h"

/*extern Servo articulacion[8];
extern int servosPinOut[8];

terminal_actions actions[]={
  {terminalAction_A,'A',8,"Recibe los pines se los servomotores conectados al robot cuadrupedo (Ej: A2,3,4,5,6,7,8,9)","Modificando pines de Servos"},
  {terminalAction_a,'a',1,"Pide los pines de los sermotores guardados en el cuadrupedo (Ej: a0)","Enviando pines de Servos"},
  {terminalAction_B,'B',1,"Prueba servomotor conectado en ese pin (Ej: B0)","Probando Servo"},
  {terminalAction_b,'b',1,"Obtener el voltaje de la bateria (Ej: B0)","Obtener voltaje"},
};


#define TERMINAL_ACTIONS_SIZE (sizeof(actions)/sizeof(terminal_actions))
*/
void terminal_lab(void){
  
  if(UART_PORT.available()){
      char caracter;
      int Numbers[20];
      int bufferSize=0;

      if(uart_get(&caracter,&bufferSize,Numbers)){
          UART_PORT.println("El caracter fue "+String(caracter)+" y Se detectaron "+String(bufferSize)+" caracteres");  
      }
      else{
        UART_PORT.println("TErmino mal");
      }
      /*bool found = false;
      
        for(int i = 0;i<TERMINAL_ACTIONS_SIZE;i++){
          if(caracter == actions[i].caracter){
            found = true;
            #ifdef TERMINAL_MESSAGES
              Serial.println(actions[i].actionString);
            #endif
            if(actions[i].tam == bufferSize){
              actions[i].Callback(Numbers,bufferSize);
            }
            else{
              #ifdef TERMINAL_MESSAGES
                UART_PORT.println("NO COINCIDE");
              #endif
            }
          }
        }

      /* #ifdef TERMINAL_MESSAGES
       if(found == false){
        UART_PORT.println("COMANDO NO RECONOCIDO, INTRODUZCA UNO VALIDO");
          for(int i = 0;i<TERMINAL_ACTIONS_SIZE;i++){
            UART_PORT.println(" -CHAR: "+String(actions[i].caracter)+"-"+actions[i].helpString);
          }
       }
       #endif*/
  }
  
}

/*
void terminalAction_A(int var[],int tam){
      for(int i = 0;i<8;i++){
        servosPinOut[i]=var[i];   
     }
     saveEEPROM();
}

void terminalAction_a(int var[],int tam){
    UART_PORT.print("a");
    for(int i = 0;i<7;i++){
      UART_PORT.print(String(servosPinOut[i])+",");
    }
     UART_PORT.println(servosPinOut[7]);
}

void terminalAction_B(int var[],int tam){
  articulacion[var[0]].attach(servosPinOut[var[0]]);
  for(int i = 70;i<140;i++){
    articulacion[var[0]].write(i);
    delay(20);
  }
  for(int i = 140;i>70;i--){
    articulacion[var[0]].write(i);
    delay(20);
  }
  articulacion[var[0]].detach();
}

void terminalAction_b(int var[],int tam){
  delay(10);
  UART_PORT.println("b"+String(100*getVoltage()));
}*/

