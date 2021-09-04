#include "scanner.h"

bool esComa(char digito){
   bool valor = 0;
   if (digito == ','){
      valor = 1;
   }
   return valor;
}

bool esCadena(char digito){
   bool valor = 0;
   if (!esComa(digito) && isspace(digito)== 0){
      valor = 1;
   }
   return valor;
}

int lexema(char* buffer,int token){
   char digito = getchar();
   int posicion = 0;

   if(esComa(digito)){
   buffer[posicion] =  digito;
   token = SEP;
   }
   else{
   while( esCadena(digito) ){
      buffer[posicion] =  digito;
      posicion++;
      digito = getchar();
   }
   ungetc(digito,stdin);
   token = CAD;
   }
   return token;
}

int get_token(char* buffer){
    char digito=getchar();
    int valor = -1;
    memset(buffer,'\0',256);

    if(digito == EOF){
       return FDT;
    }

    if(isspace(digito)==0){
       ungetc(digito,stdin);
       valor = lexema(buffer,valor);
    }
    return valor;
}
