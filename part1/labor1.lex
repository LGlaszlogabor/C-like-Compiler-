%{
#include <stdio.h>
#include <stdlib.h>    

int column = 1;
%}

%option noyywrap
%option yylineno

%%
	
"+"|"*"|"-"|"/"	{
	printf("[line: %d,column: %d, length: %d]%s operator\n", yylineno, column, strlen(yytext), yytext);
	column++;
	}

= {
	printf("[line: %d,column: %d, length: %d]%s equality\n", yylineno, column, strlen(yytext), yytext);
	column++;
	}
	
==|!= {
	printf("[line: %d,column: %d, length: %d]%s equality test\n", yylineno, column, strlen(yytext), yytext);
	column++;
	}

&&|\|\| {
	printf("[line: %d,column: %d, length: %d]%s logical 'and' or 'or'\n", yylineno, column, strlen(yytext), yytext);
	column++;
	}

\) {
	printf("[line: %d,column: %d, length: %d]%s closing\n", yylineno, column, strlen(yytext), yytext);
	column++;
	}
egesz {
	printf("[line: %d,column: %d, length: %d]%s integer\n", yylineno, column, strlen(yytext), yytext);
	column++;
	}

beolvas {
	printf("[line: %d,column: %d, length: %d]%s read\n", yylineno, column, strlen(yytext), yytext);
	column++;
	}
kiir {
	printf("[line: %d,column: %d, length: %d]%s write\n", yylineno, column, strlen(yytext), yytext);
	column++;
	}

ha|akkor|kulonben|vege_ha {
	printf("[line: %d,column: %d, length: %d]%s decision handling\n", yylineno, column, strlen(yytext), yytext);
	column++;
	}
	
amig|csinald|vege_amig {
	printf("[line: %d,column: %d, length: %d]%s loop\n", yylineno, column, strlen(yytext), yytext);
	column++;
	}	
 	
[a-zA-Z]* {
	printf("[line: %d,column: %d, length: %d]%s variable\n", yylineno, column, strlen(yytext), yytext);
	column++;
	}
[0-9]* {
	printf("[line: %d,column: %d, length: %d]%s natural number\n", yylineno, column, strlen(yytext), yytext);
	column++;
	}
	

\( {
	printf("[line: %d,column: %d, length: %d]%s open\n", yylineno, column, strlen(yytext), yytext);
	column++;
	}

\n {
	column = 1;
	}

" "|\t	{
	column++;
	}
	
. {
	printf("[line: %d,column: %d, length: %d]$s invalid\n", yylineno, column, strlen(yytext), yytext);
	column++;
	}

%%

int main()
{
	yylex();
} 
