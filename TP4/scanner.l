%{
#include <stdio.h>
#include <strings.h>
#include "parser.h"
char msg[120];
int errlex;
%}
%option outfile="scanner.c"
%option header-file="scanner.h"
%option noinput
%option nounput
%option yylineno

Letra			                    	                    [[:alpha:]]
Digito				               	  		                [0-9]
Letra_Digito	                 		  	  	            [[:alnum:]]
Espacio			      	           	  		                [[:space:]]
OperadorAsignacion	           			 		            "<<"
Comentario	    		          		  		            "//".*
Otros			        	            	  	            [[:punct:]]{-}[();,+\-*%]
%%

programa 					  	  		                    return PROGRAMA;
entero							  		                    return ENTERO;
leer							  		                    return LEER;
escribir						  		                    return ESCRIBIR;
fin-programa						  	                    return FINPROGRAMA;
{Letra}{Letra_Digito}*					                    {yylval = strdup(yytext); return IDENTIFICADOR;}
{Digito}+						  		                    return CONSTANTE;
"("									                        return '(';
")"									                        return ')';
","									                        return ',';
"+"									                        return '+';
"-"									                        return '-';
"*"									                        return '*';
"%"									                        return '%';
";"									                        return ';';
{OperadorAsignacion} 					            		return ASIGNACION;
{Otros}+					                            	{errlex++; sprintf(msg,"Error lexico: cadena desconocida: %s", yytext); yyerror(msg);}
{Letra}{Letra_Digito}*{Otros}+({Letra_Digito}|{Otros})*     {errlex++; sprintf(msg, "Error lexico: identificador invalido: %s", yytext); yyerror(msg);}
{Digito}+{Letra}+{Letra_Digito}*		                	{errlex++; sprintf(msg, "Error lexico: constante invalida: %s", yytext); yyerror(msg);}
{Espacio}+													|
{Comentario}												;
%%
