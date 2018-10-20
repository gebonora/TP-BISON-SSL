%top{
#include <stdio.h>
#include "parser.h"
}

%{

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
{Digito}+{Letra}+{Alfanumerico}* 		{yylexerrs++; yyerror("Constante inválida:");}
{Otro}+						{yylexerrs++; yyerror("Cadena inválida:");}
{Letra}({Alfanumerico}|{Otro})+			{yylexerrs++; yyerror("Identificador inválido:");}
.						{yylexerrs++; yyerror("Caracter no definido:");}
