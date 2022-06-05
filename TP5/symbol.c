#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#define TAM 200


char* tablaDeSimbolos[TAM];
int proxPosiDisponible = 0;

int existe(char* cadena){
	for (int i = 0; i < proxPosiDisponible; i++){
		if (!strcmp(tablaDeSimbolos[i], cadena)) 			
			return 1;	
	}	
	return 0;
}

void agregar(char* cadena){
	if(proxPosiDisponible < TAM){
		tablaDeSimbolos[proxPosiDisponible] = cadena;
		proxPosiDisponible++;
	}
	else{
		printf("Se lleno la tabla de símbolos!");
	}
}