/*  SSL 2021
    Curso K2004
    Tp 3
    Grupo 6
    Cabrera, Jeronimo
    Decima De Pietro, Marcos
    Lucana Delgadillo, Nahuel
*/

#include <stdio.h>
#include <stdlib.h>
#include "scanner.h"

char *tipoDeToken[] = {"Fin de texto","Programa","Entero","Leer","Escribir","Fin-Programa","Asignacion","Identificador","Constante"};

TOKEN token;

int main()
{
 do
	{
		token = yylex();
		if(token <= ASIGNACION){
			printf("Token: %s\n",tipoDeToken[token]);
		}
		else if(token == IDENTIFICADOR || token == CONSTANTE){
			printf("Token: %s\tlexema: %s\n",tipoDeToken[token],yytext);
		}
		else{
			printf("Token: \'%c\'\n",token);
		}
	} while(token != FDT);
    return EXIT_SUCCESS;
}
