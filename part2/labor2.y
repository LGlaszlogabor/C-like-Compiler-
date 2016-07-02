%{
#include <stdio.h>
#include <stdlib.h>    
#include <string.h>
extern int yylex();
int yyerror(const char*);
extern int yyparse();

%}

%token INTEGER
%token GIVE_VALUE
%token IN OUT
%token VARIABLE VALUE
%token EQUALS NOT_EQUALS
%token AND OR
%token IF THEN ELSE END_IF 
%token WHILE DO END_WHILE



%left INTEGER GIVE_VALUE IN OUT VARIABLE VALUE EQUALS NOT_EQUALS IF THEN ELSE END_IF WHILE DO END_WHILE
%left AND OR
%left '+' '-' 
%left '*' '/'

%start s

%%

s: statement
 | s statement
;


expr: VALUE
   | VARIABLE
   | expr '+' expr 
   | expr '-' expr 
   | expr '*' expr 
   | expr '/' expr 
;

condition_expr:
   | condition OR condition 
   | condition AND condition 
;

condition: expr EQUALS expr 
	| expr NOT_EQUALS expr 
;

statement: 
	VARIABLE GIVE_VALUE expr 
	| WHILE condition DO s END_WHILE 
	| IF condition THEN s END_IF 
	| IF condition THEN s ELSE s END_IF 
	| WHILE condition_expr DO s END_WHILE
	| IF condition_expr THEN s END_IF 
	| IF condition_expr THEN s ELSE s END_IF 
	| INTEGER VARIABLE 
	| INTEGER VARIABLE GIVE_VALUE VALUE 
	| OUT expr 
	| IN VARIABLE 
;

%%

int main() {
	if (yyparse()==0)
		printf("running");
}

int yyerror(const char* s) {
    printf("%s",s);
} 