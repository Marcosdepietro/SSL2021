%code top{
#include <stdio.h>
#include "scanner.h"
#include "symbol.h"
#include "semantic.h"
}
%code provides {
void yyerror(const char*);
extern int errlex;
extern int yynerrs;
extern int errsemtc;
}

%defines "parser.h"					
%output "parser.c"
%define api.value.type{char *}
%define parse.error verbose
%start programa
%token FDT PROGRAMA ENTERO LEER ESCRIBIR FINPROGRAMA IDENTIFICADOR CONSTANTE
%token ASIGNACION "<<"
%left  '-'  '+'
%left  '*'  '%'
%precedence NEG

%%

programa 			            : {comenzar();} PROGRAMA nombreProg listaSentencias FINPROGRAMA {finalizar();} {if(yynerrs || errlex || errsemtc) YYABORT; else YYACCEPT;}
					            ;
nombreProg			            : IDENTIFICADOR {printf("%s\n", yylval);} //{printf("\nNombre del programa: %s\n", yylval);}
			 		            ;

listaSentencias 	            : sentencia 					
					            | sentencia listaSentencias
					            ;

sentencia 			            : LEER'('listaIdentificadores')'';'			
					            | ESCRIBIR'('listaExpresiones')'';'					
					            | ENTERO IDENTIFICADOR';'				    {if(declarar($2,4)) YYERROR;}
					            | identificador "<<"expresion';'		    {asignar($3,$1);}
					            | error';'
					            ;

listaIdentificadores 			: identificador 					        {leer($1);}
					            | listaIdentificadores','identificador		{leer($3);}
					            ;

listaExpresiones 			    : expresion 						        {escribir($1);}
					            | listaExpresiones','expresion			    {escribir($3);}
					            ;
						
expresion			            : valor			
					            | '-'valor %prec NEG				    	{$$ = generarUnario($2);}
					            | '('expresion')'				        	{$$ = $2;}
                       	    	| expresion '+' expresion 			    	{$$ = generarInfijo($1,'+',$3);}
                        		| expresion '-' expresion 			    	{$$ = generarInfijo($1,'-',$3);}
                        		| expresion '*' expresion 			    	{$$ = generarInfijo($1,'*',$3);}
                        		| expresion '%' expresion 			    	{$$ = generarInfijo($1,'%',$3);}
                      			;
                        
valor 				        	: identificador										
				              	| CONSTANTE
				            	;
identificador				    : IDENTIFICADOR					            {if(verificarIdentificador($1)) YYERROR;}
					            ;

void yyerror(char const *mensaje){
        printf("línea #%d: %s\n",yylineno,mensaje);
}