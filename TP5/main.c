#include <stdio.h>
#include "parser.h"

int main(void)
{	
	switch(yyparse()){
		case 0:
			printf("Compilación terminada con éxito\n");
			break;
		case 1:
			printf("Errores de compilación\n"); 
			break;
		case 2:
			printf("Memoria insuficiente\n");
			break;
	}
	printf("Errores sintácticos: %d - Errores léxicos: %d - Errores semánticos: %d\n",yynerrs,errlex,errsemtc);
	return 0;
}