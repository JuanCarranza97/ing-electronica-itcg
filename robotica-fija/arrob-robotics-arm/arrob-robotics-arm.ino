#include "ARROB_CONFIG.h"

void setup() {
  uart_init();
  init_dof_eeprom();
  pinMode(13,OUTPUT);
}

void loop() {
  terminal_lab();
}
