#include "DOF.h"

dof::dof(){
  
}

void dof::set(int _setup,int _val){
  #ifdef TERMINAL_LOG
  switch(_setup){
    case SERVO_PIN:     
      UART_PORT.println(" SERVO_PIN configured to "+String(_val));
      break;
      
    case MAX_SIGNAL:
      UART_PORT.println(" MAX_SIGNAL configured to "+String(_val));
      break;

    case MIN_SIGNAL:
      UART_PORT.println(" MIN_SIGNAL configured to "+String(_val));
      break;

    case MAX_DEGREE:
      UART_PORT.println(" MAX_DEGREE configured to "+String(_val));
      break;

    case MIN_DEGREE:
      UART_PORT.println(" MIN_DEGREE configured to "+String(_val));
      break;

    case HOME_DEGREE:
      UART_PORT.println(" HOME_DEGREE configured to "+String(_val));
      break;

    default:
      UART_PORT.println(" DOF setup input it's not configured");
      break;
  }
  #endif
  data[_setup] = _val;
}

void dof::init_eeprom_at(int _addr){
  eeprom_addr = _addr;  
}

void dof::eeprom_read(void){
  for(int i = 0;i<DATA_SIZE;i++)
    data[i] = EEPROM.read(eeprom_addr+i);  
}

void dof::eeprom_write(void){
  for(int i = 0;i<DATA_SIZE;i++)
    EEPROM.write(eeprom_addr+i,data[i]);
}
