#include "ARROB_CONFIG.h"

dof axis[6];

void init_dof_eeprom(void){
  axis[WAIST].init_eeprom_at(DATA_SIZE*0);
  axis[SHOULDER_1].init_eeprom_at(DATA_SIZE*1);
  axis[SHOULDER_2].init_eeprom_at(DATA_SIZE*2);
  axis[ELBOW].init_eeprom_at(DATA_SIZE*3);
  axis[DOLL].init_eeprom_at(DATA_SIZE*4);
  axis[GRIPPER].init_eeprom_at(DATA_SIZE*5);
}

void eeprom_write(void){
  for(int i = 0;i<6;i++)
    axis[i].eeprom_write();
  #ifdef TERMINAL_LOG
    UART_PORT.println(" Write EEPROM finished");
  #endif
}

void eeprom_read(void){
  for(int i = 0;i<6;i++)
    axis[i].eeprom_write();
  #ifdef TERMINAL_LOG
    UART_PORT.println(" Read EEPROM finished");
  #endif
}

