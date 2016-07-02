%{
#include "labor2.tab.h"
#include <stdio.h>
#include <stdlib.h>  
#include <string.h>
%}

%option noyywrap
%option yylineno

%%

egesz { 
	return INTEGER;
	}


ha {
	return IF;
	}
akkor {
	return THEN;
	}
kulonben {
	return ELSE;
	}
vege_ha {
	return  END_IF;
	}

amig {
	return WHILE;
	}
csinald {
	return DO;
}
vege_amig {
	return END_WHILE;
	}
	
"*"	{
	return yytext[0];
	}

"+"	{
	return yytext[0];
	}

"-"	{
	return yytext[0];
	}

"/"	{
	return yytext[0];
	}

\(|\) {
	return yytext[0];
	}


= {
	return GIVE_VALUE;
	}
	
== {
	return EQUALS;
	}

!= {
	return NOT_EQUALS;
	}


beolvas {
	return IN;
	}

kiir {
	return OUT;
}

&& {
	return AND;
	}
\|\| {
	return OR;
	}

[a-zA-Z]+ {
	
	return VARIABLE;
	}

[0-9]* {
	return VALUE;
	}


" "|\t|\r|\n	{}
	
. {
	return yytext[0];
	}

%%

