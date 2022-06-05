%code top{
#include <stdio.h>
#include "scanner.h"
}

%code provides{
void yyerror(const char *);
extern int errlex;
extern int yynerrs;
}

%define api.value.type{char *}
%defines "parser.h"
%output "parser.c"
%start programa-mini
%define parse.error verbose

%token FDT PROGRAMA ENTERO LEER ESCRIBIR FINPROGRAMA IDENTIFICADOR CONSTANTE
%token ASIGNACION "<<"
%left '-' '+'
%left '*' '%'
%precedence NEG
%%

programa-mini           : PROGRAMA nombreProg lista-sentencias FINPROGRAMA {if (yynerrs || errlex) YYABORT;}
                        ;

nombreProg		        : IDENTIFICADOR {printf("Nombre del programa: %s\n", yylval);}
			            ;

lista-sentencias        : sentencia
                        | sentencia lista-sentencias
                        ;

sentencia               : LEER'('lista-identificadores')'';' {printf("leer\n");}
                        | ESCRIBIR'('lista-expresion')'';' {printf("escribir\n");}
                        | ENTERO IDENTIFICADOR';' {printf("entero %s\n", $IDENTIFICADOR);}
                        | IDENTIFICADOR ASIGNACION expresion';' {printf("asignacion\n");}
                        | error';'
                        ;

lista-identificadores   : IDENTIFICADOR
                        | IDENTIFICADOR','lista-identificadores
                        ;

lista-expresion         : expresion
                        | expresion','lista-expresion
                        ;

expresion               : valor
			            | '-'valor %prec NEG {printf("inversion\n");}
                        | '('expresion')' {printf("parentesis\n");}
                        | expresion '+' expresion {printf("suma\n");}
                        | expresion '-' expresion {printf("resta\n");}
                        | expresion '*' expresion {printf("multiplicacion\n");}
                        | expresion '%' expresion {printf("modulo\n");}
			            ;                     

valor                   : IDENTIFICADOR
	    	            | CONSTANTE
			            ;

%%
int errlex = 0;

void yyerror(const char *s){
 printf("Línea #%d: %s\n", yylineno, s);

}