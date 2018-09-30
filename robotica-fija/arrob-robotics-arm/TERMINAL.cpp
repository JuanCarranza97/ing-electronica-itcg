#include "TERMINAL.h"

/*extern Servo articulacion[8];
extern int servosPinOut[8];*/

terminal_actions actions[]={
  {terminalAction_A,'a',1,"Recibe los pines se los servomotores conectados al robot cuadrupedo (Ej: A2,3,4,5,6,7,8,9)","Modificando pines de Servos"},
};


#define TERMINAL_ACTIONS_SIZE (sizeof(actions)/sizeof(terminal_actions))

void terminal_lab(void){
  if(UART_PORT.available()){
      char caracter;
      int Numbers[20];
      int bufferSize=0;

        if(uart_get(&caracter,&bufferSize,Numbers)){
          UART_PORT.println("Finalizo bien");
          UART_PORT.println("Char = "+String(caracter)+" \nMsg Size = "+String(bufferSize));

           bool found = false;
      
              for(int i = 0;i<TERMINAL_ACTIONS_SIZE;i++){
                if(caracter == actions[i].caracter){
                  found = true;
                  #ifdef TERMINAL_LOG
                    Serial.println(actions[i].actionString);
                  #endif
                  if(actions[i].tam == bufferSize){
                    actions[i].Callback(Numbers);
                  }
                  else{
                    #ifdef TERMINAL_LOG
                      UART_PORT.println("Number Size doesn't match");
                    #endif
                  }
                }
              }

               #ifdef TERMINAL_LOG
                if(found == false){
                  UART_PORT.println("ERROR: command it's not recognized, Here are the valid ones");
                    for(int i = 0;i<TERMINAL_ACTIONS_SIZE;i++){
                      UART_PORT.println(" -Char: "+String(actions[i].caracter)+", "+actions[i].helpString);
                    }
                }
               #endif
        }
        else{
          UART_PORT.println("Termino mal :c");
        }
  }  
}


void terminalAction_A(int var[]){
     UART_PORT.println("TE medio a la primer fucnion");
     if(var[0] == 0) digitalWrite(13,LOW);
     else            digitalWrite(13,HIGH);
}

/*
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

