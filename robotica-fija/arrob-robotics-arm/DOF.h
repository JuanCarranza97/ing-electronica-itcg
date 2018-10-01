#ifndef DOF_H
#define DOF_H

  #include <Arduino.h>
  #include <Servo.h>
  #include <EEPROM.h>
  
  #include "ARROB_CONFIG.h"

  #define DATA_SIZE       6

  #define SERVO_PIN       0
  #define MAX_SIGNAL      1
  #define MIN_SIGNAL      2
  #define MAX_DEGREE      3
  #define MIN_DEGREE      4
  #define HOME_DEGREE     5

  class dof{
     public:
        dof();
        void set(int _setup,int _val);
        int get_value(int _setup);
        void init_eeprom_at(int _addr);
        void eeprom_read(void);
        void eeprom_write(void); 
     private:
        int data[DATA_SIZE];
        int eeprom_addr;      
  };
#endif
