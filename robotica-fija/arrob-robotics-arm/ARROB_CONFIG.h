#ifndef ARROB_CONFIG_H
#define ARROB_CONFIG_H

  #include <Arduino.h>

  #include "TERMINAL.h"
  #include "UART.h"
  #include "DOF.h"  
  #include "EEPROM_16.h"

  #define SERVOS_SIZE   7
  
  #define WAIST         0
  #define SHOULDER_1    1
  #define SHOULDER_2    2
  #define ELBOW         3
  #define PRE_DOLL      4
  #define DOLL          5
  #define GRIPPER       6  

  void init_dof_eeprom(void);
  void eeprom_write(void);
  void eeprom_read(void);
#endif
