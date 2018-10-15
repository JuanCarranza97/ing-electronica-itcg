#include "TERMINAL.h"

extern dof axis[6]; 
const String axis_names[6] = {"WAIST","SHOULDER_1","SHOULDER_2","ELBOW","DOLL","GRIPPER"};
const String setting_names[DATA_SIZE] = {"SERVO_PIN","MAX_SIGNAL","MIN_SIGNAL","MAX_DEGREE","MIN_DEGREE","HOME_DEGREE"};


terminal_actions actions[]={
  {terminalAction_a,'a',1},
  {terminalAction_s,'s',3},
  {terminalAction_e,'e',1},
  {terminalAction_r,'r',2},
  {terminalAction_d,'d',2},
  {terminalAction_p,'p',3},
  {terminalAction_t,'t',2},
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
                    UART_PORT.println("e"+String(actions[i].Callback(Numbers)));
                  }
                  else{
                    UART_PORT.println("e"+String(2));                
                  }
                }
              }
        }
        else{
          UART_PORT.println("e"+String(2));
        }
  }  
}


int terminalAction_a(int var[]){
  if(var[0] == 0 ||  var[0] == 1){
     if(var[0] == 0)        digitalWrite(13,LOW);
     else if(var[0] == 1)   digitalWrite(13,HIGH);
  }
  else  return 3;
  return 0;  
}

int terminalAction_s(int var[]){
  if(var[0] >= 0 && var[0] <= 5){  //If DOF exists
    if(var[1] >= 0 && var[1] < DATA_SIZE){  //if configuration exists
       axis[var[0]].set(var[1],var[2]);
    }
    else  return 3;
  }
  else    return 4;
  return 0;
}

int terminalAction_e(int var[]){
  if(var[0] == 1){  //Writing  EEPROM
    eeprom_write();
  }
  else if(var[0] == 0){  //Reading EEPROM
    eeprom_read();
  }
  else{
    return 3;
  }
  return 0;
}

int terminalAction_r(int var[]){
   if(var[0] >= 0 && var[0] <= 5){
      if(var[1] >= 0 && var[1] < DATA_SIZE){
        UART_PORT.println("v"+String(var[0])+","+String(var[1])+","+String(axis[var[0]].get_value(var[1])));
        delay(50);
      }
      else return 3;
    }
    else{
      return 4;
    }
    return 0;
 }

int terminalAction_d(int var[]){
  if(var[0] >= 0 && var[0] < 6){
    if(var[1] == 0)      axis[var[0]].detach_servo();
    else if(var[1] == 0) axis[var[0]].attach_servo();
    else                 return 3;
  }
  else{
    return 4;
  }
  return 0; 
}

int terminalAction_p(int var[]){
  //0 without map,1 with map
  if(var[0] >= 0 && var[0] < 6) {
    if(var[1] == 0 || var[1] == 1) axis[0].set_position(var[1],var[2]);
    else{  //No available config
      return 3;
    }
  }
  else {  //No specifics  DOF
    return 4;
  }
  return 0;
}

int terminalAction_t(int var[]){
  if(var[0] >= 0 && var[0] <6){
    axis[var[0]].test_servo(var[1]);
  }
  else{
    return 3;
  }
  return 0;
}

