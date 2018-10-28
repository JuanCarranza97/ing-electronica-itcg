#include "ARROB_CONFIG.h"

dof axis[SERVOS_SIZE];


void init_dof_eeprom(void){
  axis[WAIST].init_eeprom_at(int(SERVOS_SIZE+3)*0);
  axis[SHOULDER_1].init_eeprom_at(int(SERVOS_SIZE+3)*1);
  axis[SHOULDER_2].init_eeprom_at(int(SERVOS_SIZE+3)*2);
  axis[ELBOW].init_eeprom_at(int(SERVOS_SIZE+3)*3);
  axis[PRE_DOLL].init_eeprom_at(int(SERVOS_SIZE+3)*4);
  axis[DOLL].init_eeprom_at(int(SERVOS_SIZE+3)*5);
  axis[GRIPPER].init_eeprom_at(int(SERVOS_SIZE+3)*6);
}

void eeprom_write(void){
  for(int i = 0;i<SERVOS_SIZE;i++)
    axis[i].eeprom_write();
}

void eeprom_read(void){
  for(int i = 0;i<SERVOS_SIZE;i++)
    axis[i].eeprom_read();
}

