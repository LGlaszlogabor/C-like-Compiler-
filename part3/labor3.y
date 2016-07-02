%{
#include <stdio.h>
#include <stdlib.h>  
#include <string.h>
#include <map>
#include <string>

using namespace std;

extern int yylex();
int yyerror(const char*);
void add_to_variable_table(string);
void check_variable_states(string);

map<string,string> variable_table;

%}

%token INTEGER
%token GIVE_VALUE
%token IN OUT
%token TEXT
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

%union {
	char *variable_name;
}

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

while: WHILE condition_expr DO s END_WHILE
	| WHILE condition DO s END_WHILE
;

decision: IF condition THEN s END_IF
	| IF condition THEN s ELSE s END_IF
	| IF condition_expr THEN s END_IF 
	| IF condition_expr THEN s ELSE s END_IF 
;

declaration: VARIABLE GIVE_VALUE expr {check_variable_states($<variable_name>1);}
	| INTEGER VARIABLE {add_to_variable_table($<variable_name>2);}
	| INTEGER VARIABLE GIVE_VALUE VALUE {add_to_variable_table($<variable_name>2);}
;

write: OUT expr
	| OUT TEXT
;

statement: IN VARIABLE {check_variable_states($<variable_name>2);}
	| write
	| decision
	| while
	| declaration
; 

%%

int main() {
   
	if (yyparse()==0)
		printf("running\n");
	printf("List of variables:\n");
	map<string,string>::iterator iterator;
	for(iterator = variable_table.begin(); iterator != variable_table.end(); ++iterator){
		printf("symbol: %s -> type: %s\n",iterator->first.c_str(),iterator->second.c_str());
	} 
}

int yyerror(const char* s) {
    printf("%s",s);
} 

void add_to_variable_table(string variable){
	if (variable_table.count(variable) == 0)	
		variable_table.insert(pair<string,string>(variable,"egesz"));
	else
		printf("Variable with this name(%s) already exists!!!\n",variable.c_str()); 
}

void check_variable_states(string variable){
	if (variable_table.count(variable) == 0)	
		printf("Variable '%s' was not declared before.\n",variable.c_str()); 
} 