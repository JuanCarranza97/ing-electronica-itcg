#include "ARROB_CONFIG.h"

dof axis[6];

void init_dof_eeprom(void){
  axis[WAIST].init_eeprom_at(0);
  axis[SHOULDER_1].init_eeprom_at(6);
  axis[SHOULDER_2].init_eeprom_at(12);
  axis[ELBOW].init_eeprom_at(18);
  axis[DOLL].init_eeprom_at(24);
  axis[GRIPPER].init_eeprom_at(30);
}

void eeprom_write(void){
  for(int i = 0;i<6;i++)
    axis[i].eeprom_write();
}

void eeprom_read(void){
  for(int i = 0;i<6;i++)
    axis[i].eeprom_read();
}

