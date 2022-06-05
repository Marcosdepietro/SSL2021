/*  SSL 2021
    Curso K2004
    Tp 4
    Grupo 6
    Cabrera, Jeronimo
    Decima De Pietro, Marcos
    Lucana Delgadillo, Nahuel
*/

#include <stdio.h>
#include "parser.h"

int main(void){
    switch(yyparse()) {
        case 0:
            printf("\nCompilacion exitosa\n");
            break;
        case 1:
            printf("\nErrores de compilación\n");
            break;
        case 2:
            printf("\nMemoria insuficiente\n");
            break;
	}
	printf("\nErrores sintacticos: %d - Errores lexicos: %d\n", yynerrs, errlex);
	return 0;

}