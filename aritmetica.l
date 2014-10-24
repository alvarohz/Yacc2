%{
    #include "head.h"
    #include "y.tab.h"
    void yyerror(char *);
   // int yylineno = 1; //en windows se declara
%}

%%
"print"		{return PRINT;}
"exit"		{return EXIT_COMMAND;}    
[a-z]       	{yylval = *yytext - 'a';return ID;} 	/* identificadores */
[0-9]+      	{yylval = atoi(yytext);return INTEGER;} /* enteros */
[-+()=/*;] 	{ return *yytext; }			/* operadores */    
[ \t]     	; 					/* whitespaces */
[\n]		{ yylineno++;	}   			/* contar lineas */
	/* cualquier otra cosa es un error */
.           {ECHO;yyerror("caracter invalido"); } 	/* error */
%%
int yywrap(void) {
    return 1;
}
