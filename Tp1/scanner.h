#ifndef SCANNER_H_INCLUDED
#define SCANNER_H_INCLUDED
#include<stdio.h>
#include<ctype.h>
#include<stdbool.h>
#include<string.h>

enum tokens{SEP,CAD,FDT};

int get_token(char* buffer);
bool esComa(char digito);
bool esCadena(char digito);
int lexema(char* buffer,int token);

#endif
