/*
UTNFRBA
Tp4 - año 2018
Materia: Sintaxis y semantica de los lenguajes.
Curso: K2055
Profesor: Eduardo Zuñiga.
Grupo: 3
Integrantes:
            Mariano Antico, Legajo: 164549-3
            Nicolás D. Felicetti, Legajo: 163608-0
            Enzo Nuñez, Legajo: 164949-8
            Gonzalo Bonora, Legajo: 156036-0 
*/


# include <stdio.h>
# include "parser.h"
# include "scanner.h"

int yylexerrs = 0;
int yynerrs = 0;

int main () {
	
	switch( yyparse() ){
		case 0:
			puts("Compilación exitosa"); 
			break;
		case 1:
			puts("Errores de compilación");
			break;
		case 2:
			puts("Memoria insuficiente"); 
			break;
	}
	printf("Errores sintácticos: %d.\t Errores léxicos: %d\n",yynerrs ,yylexerrs); 
	return 0;
}


