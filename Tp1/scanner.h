#ifndef SCANNER_H_INCLUDED
#define SCANNER_H_INCLUDED
#include<stdio.h>
#include<ctype.h>
#include<stdbool.h>
#include<string.h>

enum tokens{SEP,CAD,FDT};

int get_token(char* buffer);
bool esComa(char digito);
bool esCAD(char digito);
int obtenerLexema(char* buffer,int token);

#endif
