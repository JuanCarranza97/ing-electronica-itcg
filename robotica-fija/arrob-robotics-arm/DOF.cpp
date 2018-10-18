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

int dof::get_value(int _setup){
  if(_setup >= 0 && _setup < DATA_SIZE)
    return data[_setup];
}
void dof::init_eeprom_at(int _addr){
  eeprom_addr = _addr;  
}

void dof::eeprom_read(void){
  for(int i = 0;i<DATA_SIZE;i++)
    data[i] = (int)EEPROM.read((byte)(eeprom_addr+i));   
}

void dof::eeprom_write(void){
  for(int i = 0;i<DATA_SIZE;i++)
     EEPROM.write((byte)(eeprom_addr+i),(byte)(data[i]));  
}

void dof::print_eeprom(void){
  UART_PORT.println(eeprom_addr);
}

void dof::attach_servo(void){
  dof_servo.attach(data[SERVO_PIN]);
  dof_servo.write(data[HOME_DEGREE]);  
}

void dof::detach_servo(void){
   dof_servo.detach();
}

void dof::set_position(int x,int _degree){
  if(x == 0)   dof_servo.write(_degree);
  else         dof_servo.write(map(_degree,data[MIN_DEGREE],data[MAX_DEGREE],data[MIN_SIGNAL],data[MAX_SIGNAL]));
}

void dof::test_servo(int _delay){
  int actual_pos = map(dof_servo.read(),data[MIN_SIGNAL],data[MAX_SIGNAL],data[MIN_DEGREE],data[MAX_DEGREE]);
  if(actual_pos > data[HOME_DEGREE]){
    for(int i = actual_pos;i >= data[HOME_DEGREE];i--){
      dof::set_position(1,i);
      delay(_delay);
    }
  }
  else{
    for(int i = actual_pos;i<=data[HOME_DEGREE];i++){
      dof::set_position(1,i);
      delay(_delay);
    }
  }
  delay(250);
  for(int i = data[HOME_DEGREE];i>= data[MIN_DEGREE];i--){
    dof::set_position(1,i);
    delay(_delay);
  }
  for(int i = data[MIN_DEGREE];i<= data[MAX_DEGREE];i++){
    dof::set_position(1,i);
    delay(_delay);
  }
  for(int i = data[MAX_DEGREE];i >= data[HOME_DEGREE];i--){
    dof::set_position(1,i);
    delay(_delay);
  }
}

int dof::get_pos(int x){
  if(x == 0) return dof_servo.read();
  else       return (map(dof_servo.read(),data[MIN_SIGNAL],data[MAX_SIGNAL],data[MIN_DEGREE],data[MAX_DEGREE]));
}

