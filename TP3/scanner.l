%top{
#include <stdio.h>
#include "tokens.h"
}
%option header-file="scanner.h"
%option outfile="scanner.c"
%option noinput
%option nounput

Letra			                       [[:alpha:]]
Digito				                   [0-9]
Letra_Digito	                 	 [[:alnum:]]
Espacio			      	             [[:space:]]
OperadorAsignacion	             "<<"
Comentario	    		             "//".*
Otros			        	             [[:punct:]]{-}[();,+\-*/]
%%

programa 												return PROGRAMA;
entero											    return ENTERO;
leer														return LEER;
escribir												return ESCRIBIR;
fin-programa										return FIN_PROGRAMA;
{Letra}{Letra_Digito}*					return IDENTIFICADOR;
{Digito}+												return CONSTANTE;
"("															return '(';
")"															return ')';
","															return ',';
"+"															return '+';
"-"															return '-';
"*"															return '*';
"%"															return '%';
";"															return ';';
{OperadorAsignacion} 						return ASIGNACION;
{Otros}+											  printf("Error lexico: cadena invalida: %s\n",yytext);
{Letra}{Letra_Digito}*{Otros}+({Letra_Digito}|{Otros})*		printf("Error lexico: identificador inválido: %s\n",yytext);
{Digito}+{Letra}+{Letra_Digito}*						            	printf("Error lexico: constante invalida: %s\n",yytext);
{Espacio}+							       |
{Comentario}									 ;
%%
