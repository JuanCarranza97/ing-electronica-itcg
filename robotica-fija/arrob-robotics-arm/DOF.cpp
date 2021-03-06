#include "DOF.h"

dof::dof(){
  
}

void dof::set(int _setup,int _val){
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
    data[SERVO_PIN]   = (int)EEPROM.read((byte)(eeprom_addr));  
    data[MAX_SIGNAL]  = (int)EEPROM.read((byte)(eeprom_addr+1));  
    data[MIN_SIGNAL]  = (int)EEPROM.read((byte)(eeprom_addr+2)); 
    data[MAX_DEGREE]  = eeprom_read_16(eeprom_addr+3);
    data[MIN_DEGREE]  = eeprom_read_16(eeprom_addr+5);
    data[HOME_DEGREE] = eeprom_read_16(eeprom_addr+7);     
}

void dof::eeprom_write(void){
     EEPROM.write((byte)(eeprom_addr),(byte)(data[SERVO_PIN]));     //0
     EEPROM.write((byte)(eeprom_addr+1),(byte)(data[MAX_SIGNAL]));  //1
     EEPROM.write((byte)(eeprom_addr+2),(byte)(data[MIN_SIGNAL]));  //2
     eeprom_write_16(eeprom_addr+3,data[MAX_DEGREE]);               // 3 - 4
     eeprom_write_16(eeprom_addr+5,data[MIN_DEGREE]);               // 5 -6
     eeprom_write_16(eeprom_addr+7,data[HOME_DEGREE]);              // 7 -8
}

void dof::print_eeprom(void){
  UART_PORT.println(eeprom_addr);
}

void dof::attach_servo(void){
  dof_servo.attach(data[SERVO_PIN]);
  dof_servo.write(map(data[HOME_DEGREE],data[MIN_DEGREE],data[MAX_DEGREE],data[MIN_SIGNAL],data[MAX_SIGNAL])); 
  attached=true; 
}

void dof::detach_servo(void){
   dof_servo.detach();
   attached=false;
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

void dof::go_home(int _delay){
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
}

