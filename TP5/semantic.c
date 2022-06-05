#include <stdio.h>
#include <string.h>
#include "symbol.h"
#include "parser.h"
#include "semantic.h"

int errsemtc = 0;
char buffer2[250];
char temporal[100];
int nro_temporal = 1;

int declarar(char* identificador, int bytes){
	if(existe(identificador)){
		sprintf(buffer2,"Error semántico: identificador %s ya declarado", identificador);
		errsemtc++;
		yyerror(buffer2);
		return 1;
	}
	else{
		agregar(identificador);
		printf("Reserve %s,%d\n", identificador,bytes);	
		return 0;		
	}
}

void comenzar(void){
	printf("Load rtlib,");
}
void leer(char* identificador){
	printf("Read %s,Integer\n", identificador);
}
void escribir(char* identificador){
	printf("Write %s,Integer\n", identificador);
}
void asignar(char* resultado, char* identificador) {
	printf("Store %s,%s \n", resultado, identificador);
}
void finalizar(void){
	printf("Exit,\n");
}
int verificarIdentificador(char* identificador){
	if(!existe(identificador)){
		sprintf(buffer2,"Error semántico: identificador %s no declarado", identificador);
		errsemtc++;
		yyerror(buffer2);
		return 1;
	}
	return 0;
}
char* generarNuevoTemporal(void){
  	sprintf(temporal,"Temp@%d",nro_temporal);
  	nro_temporal++;
  	return strdup(temporal);	
}

char* generarInfijo(char* entrada1, char operador, char* entrada2){
	char* nuevoTemp = generarNuevoTemporal();
	declarar(nuevoTemp,4);
	switch(operador){
		case '+':
			printf("ADD %s,%s,%s\n", entrada1, entrada2, nuevoTemp);
			break;
		case '*':
			printf("MUL %s,%s,%s\n", entrada1, entrada2, nuevoTemp);
			break;
		case '-':
			printf("SUB %s,%s,%s\n", entrada1, entrada2, nuevoTemp);
			break;
		case '%':
			printf("MOD %s,%s,%s\n", entrada1, entrada2, nuevoTemp);
			break;
	}
	return nuevoTemp;
}

char* generarUnario(char* entrada){
  	char* nuevoTemp = generarNuevoTemporal();
  	declarar(nuevoTemp,4);
	printf("INV %s,%s,%s\n", entrada, "", nuevoTemp);
	return nuevoTemp;
}
