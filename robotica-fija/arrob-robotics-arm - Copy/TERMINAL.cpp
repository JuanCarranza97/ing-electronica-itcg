#include "TERMINAL.h"

extern dof axis[6]; 
String axis_names[6] = {"WAIST","SHOULDER_1","SHOULDER_2","ELBOW","DOLL","GRIPPER"};
String setting_names[DATA_SIZE] = {"SERVO_PIN","MAX_SIGNAL","MIN_SIGNAL","MAX_DEGREE","MIN_DEGREE","HOME_DEGREE"};

terminal_actions actions[]={
  {terminalAction_a,'a',1,"Modify LED13 Output STATUS(0-LOW,1-HIGH) {aSTATUS}","Led 13 Toggle"},
  {terminalAction_s,'s',3,"Set VALUE to specific DOF SETUP {sDOF,SETUP,VALUE}","Setting servo values"},
  {terminalAction_e,'e',1,"Save or Read EEPROM memory values ACTION(0-Read,1-Write) {eACTION}","EEPROM Memory Access"},
  {terminalAction_r,'r',2,"Read SETUP of DOF {rDOF,SETUP} SETUP=a, returns all","Reading specific value"},
};


#define TERMINAL_ACTIONS_SIZE (sizeof(actions)/sizeof(terminal_actions))

void terminal_lab(void){
  if(UART_PORT.available()){
      char caracter;
      int Numbers[20];
      int bufferSize=0;

        if(uart_get(&caracter,&bufferSize,Numbers)){
           bool found = false;
      
              for(int i = 0;i<TERMINAL_ACTIONS_SIZE;i++){
                if(caracter == actions[i].caracter){
                  found = true;
                  if(actions[i].tam == bufferSize){
                    actions[i].Callback(Numbers);
                  }                
                }
              }
        }
  }  
}


void terminalAction_a(int var[]){
     if(var[0] == 0) {
      digitalWrite(13,LOW);
      #ifdef TERMINAL_LOG
        UART_PORT.println("  -LED13 OFF");
      #endif
     }
     else if(var[0] == 1)           {
      digitalWrite(13,HIGH);
      #ifdef TERMINAL_LOG
        UART_PORT.println("  -LED13 ON");
      #endif
     }
     else{
      #ifdef TERMINAL_LOG
        UART_PORT.println("  -Led status didn't change");
      #endif
     }
}

void terminalAction_s(int var[]){
  if(var[0] >= 0 && var[0] <= 5){
    if(var[1] >= 0 && var[1] <= 6){
       #ifdef TERMINAL_LOG
       switch(var[0]){
         case WAIST:
          UART_PORT.print(" -Setting WAIST ...");
          break;

         case SHOULDER_1:
          UART_PORT.print(" -Setting SHOULDER 1 ...");
          break;

         case SHOULDER_2:
          UART_PORT.print(" -Setting SHOULDER 2 ...");
          break;

         case ELBOW:
          UART_PORT.print(" -Setting ELBOW ...");
          break;

         case DOLL:
          UART_PORT.print(" -Setting DOLL ...");
          break;

         case GRIPPER:
          UART_PORT.print(" -Setting GRIPPER ...");
          break;
       }
       #endif
       axis[var[0]].set(var[1],var[2]);
    }
    else{
      #ifndef TERMINAL_LOG
        UART_PORT.println(" ERROR: I'm sorry, Actually I don't have that setting");
      #endif
    }
  }
  else{
    #ifdef TERMINAL_LOG
      UART_PORT.println(" ERROR: I'm sorry, I don't have this DOF");
    #endif
  }
}

void terminalAction_e(int var[]){
  if(var[0] == 1){
    #ifdef TERMINAL_LOG
      UART_PORT.print(" -Writing EEPROM ... ");
    #endif
    eeprom_write();
    #ifdef TERMINAL_LOG
      UART_PORT.println(" Done");
     #endif
  }
  else if(var[0] == 0){
    #ifdef TERMINAL_LOG
      UART_PORT.print(" -Reading EEPROM ... ");
    #endif
    eeprom_read();
    #ifdef  TERMINAL_LOG 
      UART_PORT.println(" Done");
     #endif
  }
  else{
    #ifdef TERMINAL_LOG
      UART_PORT.println("ERROR: Not memory access function defined");
    #endif
  }
}

void terminalAction_r(int var[]){
   if(var[0] >= 0 && var[0] < 6){
        UART_PORT.println(" -"+axis_names[var[0]]+" "+setting_names[var[1]]+" = "+String(axis[var[0]].get_value(var[1])));
    }
 }
