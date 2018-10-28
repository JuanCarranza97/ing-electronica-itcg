#include "EEPROM_16.h"

int eeprom_read_16(int addr){
  int LSB=EEPROM.read(addr);
  int MSB=EEPROM.read(addr+1)<<8;
  int x= MSB|LSB;
  x = x-32767;
  return x;
}

void eeprom_write_16(int addr, int val){
    val = val+32767;
    int LSB= val&0x00FF;
    int MSB= (val&0xFF00)>>8;
    EEPROM.write(addr, (byte)(LSB));
    EEPROM.write(addr+1,(byte)(MSB));
}

