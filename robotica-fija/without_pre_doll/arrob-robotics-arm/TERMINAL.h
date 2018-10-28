#ifndef TERMINAL_H
#define TERMINAL_H

  #include <Arduino.h>

  #include "ARROB_CONFIG.h"
  
  typedef int (*terminalCallback)(int var[]);  

  typedef struct{
    terminalCallback Callback;
    const char caracter;
    int tam;
  }terminal_actions;

  void terminal_lab(void);
   
  int terminalAction_a(int var[]);
  int terminalAction_s(int var[]);
  int terminalAction_e(int var[]);
  int terminalAction_r(int var[]);
  int terminalAction_d(int var[]);
  int terminalAction_p(int var[]);
  int terminalAction_t(int var[]);
  int terminalAction_h(int var[]);
  /*void terminalAction_a(int var[],int tam);
  void terminalAction_B(int var[],int tam);
  void terminalAction_b(int var[],int tam);*/
#endif*/
