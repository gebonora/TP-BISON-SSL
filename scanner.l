%top{
#include <stdio.h>
#include "parser.h"
}

%{
char buffer[90];

%}

%option outfile="scanner.c"
%option header-file="scanner.h"
%option noinput
%option nounput
%option yylineno


Letra [[:alpha:]]
Digito [0-9]
Alfanumerico [[:alnum:]]
Espacio [[:space:]]
Otro [[:punct:]]{-}[+*/.,()-]  
%% 

programa					return PROGRAMA;
variables					return VARIABLES;
definir						return DEFINIR;
leer						return LEER;
escribir					return ESCRIBIR;
codigo						return CODIGO;
fin						return FIN;
"+"						return '+';
"-"						return '-';
"*"						return '*';
"/"						return '/';
"<-"						return ASIGNACION;
"."						return '.';
","						return ',';
"("						return '(';
")"						return ')';
{Letra}{Alfanumerico}*				{yylval = strdup(yytext); return IDENTIFICADOR;}
{Digito}+					{yylval = strdup(yytext); return CONSTANTE;}
{Espacio}+					/* ignorar espacios */
"//"(.*)\n					/* ignorar comentarios */	
{Digito}+{Letra}+{Alfanumerico}* 		{yylexerrs++; strcpy(buffer,"Constante inválida: "); strcat(buffer, yytext), yyerror(buffer);}
{Otro}+						{yylexerrs++; strcpy(buffer,"Cadena inválida: "); strcat(buffer, yytext), yyerror(buffer);}
{Letra}({Alfanumerico}|{Otro})+			{yylexerrs++; strcpy(buffer,"Identificador inválido: "); strcat(buffer, yytext), yyerror(buffer);}
.						{yylexerrs++; strcpy(buffer,"Caracter no definido: "); strcat(buffer, yytext), yyerror(buffer);}
