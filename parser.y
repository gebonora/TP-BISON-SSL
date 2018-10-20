%code top{
#include <stdio.h>
#include "scanner.h"
}

%code provides{
void yyerror(const char *);
extern int yylexerrs;
extern int yynerrs;
}

%defines "parser.h"
%output "parser.c"
%define api.value.type {char *}
%define parse.error verbose
%token FDT IDENTIFICADOR CONSTANTE PROGRAMA VARIABLES DEFINIR LEER ESCRIBIR CODIGO FIN
%token ASIGNACION "<-"
//tabla precedencias

%right ASIGNACION
%left '+' '-'
%left '/' '*'
%precedence NEG

%% 
todo			: programa { if (yynerrs || yylexerrs) YYABORT;}
			;
programa             	: PROGRAMA VARIABLES variable CODIGO codigo FIN
                     	;

variable             	: variable DEFINIR IDENTIFICADOR '.' {printf("Definir: %s\n", $3);} 
			| %empty 
			| error '.'
                     	;

codigo               	: codigo sentencia '.' 
			| sentencia '.' 
			| error '.'
                     	;
	
sentencia            	: LEER '('listaIdentificadores')' {printf("Leer\n");}
                     	| ESCRIBIR '('listaExpresiones')' {printf("Escribir\n");}
                     	| IDENTIFICADOR ASIGNACION expresion {printf("Asignación\n");}
                     	;

listaIdentificadores 	: IDENTIFICADOR 
                     	|  listaIdentificadores ',' IDENTIFICADOR 
                    	;

listaExpresiones     	: expresion
                     	| listaExpresiones ','  expresion 
                    	;

expresion            	: expresion '+' expresion {printf("Suma\n");}
                     	| expresion '-' expresion {printf("Resta\n");}
			| expresion '*' expresion {printf("Multiplicación\n");}
                     	| expresion '/' expresion {printf("División\n");}
			| IDENTIFICADOR
			| CONSTANTE
                        | '-' expresion %prec NEG {printf("Inversión\n");}
			| '('expresion')' {printf("Paréntesis\n");}
			;

%%

void yyerror(const char* s){
	printf("Línea: %d\t%s\n", yylineno, s);
}

