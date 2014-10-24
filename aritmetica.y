%{
    #include "head.h"
    void yyerror(char *);
    int yylex(void);
    int sym[26];
%}

%start line
%token INTEGER ID PRINT EXIT_COMMAND
%left '+' '-'
%left '*' '/'

%%
line:
        line statement ';'	{;}
        | /* cadena vacia */
        ;
statement:
        expr                { printf("%d\n", $1); }
        | ID '=' expr       { sym[$1] = $3; }
	| PRINT expr		{ printf("%d\n", $2); }
	| EXIT_COMMAND		{ exit(EXIT_SUCCESS);}
        ;
expr:
        INTEGER
        | ID                { $$ = sym[$1]; }
        | expr '+' expr     { $$ = $1 + $3; }
        | expr '-' expr     { $$ = $1 - $3; }
        | expr '*' expr     { $$ = $1 * $3; }
        | expr '/' expr     { $$ = $1 / $3; }
        | '(' expr ')'      { $$ = $2; }
        ;
%%
void yyerror(char *s)
{
  extern int yylineno;	// predefinida en lex.c
  extern char *yytext;	// predefinida en lex.c

  printf("ERROR: %s en simbolo \"%s\" en linea %d \n",s,yytext,yylineno); 
  exit(1);
}
