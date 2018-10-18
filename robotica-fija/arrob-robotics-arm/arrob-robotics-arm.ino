
#include "ARROB_CONFIG.h"

void setup() {
  uart_init();
  init_dof_eeprom();
  eeprom_read();
  pinMode(13,OUTPUT);
}

void loop() {
  terminal_lab();
}
