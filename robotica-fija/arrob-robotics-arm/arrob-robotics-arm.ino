#include "ARROB_CONFIG.h"

void setup() {
  uart_init();
  pinMode(13,OUTPUT);
}

void loop() {
 terminal_lab();
}
