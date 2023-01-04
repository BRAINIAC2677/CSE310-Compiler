/* Disable Flex features we don't need, to avoid warnings. */
%option nodefault noinput nounput noyywrap

%option reentrant

%{
#include <assert.h>
#include <limits.h> /* INT_MIN */
#include <stdlib.h> /* strtol */

#include "parser.h"
%}


%%

";" {return TOK_SEMICOLON;}
"int" {return TOK_INT;}
"float" {return TOK_FLOAT;}
"void" {return TOK_VOID;}
"," {return TOK_COMMA;}
"[" {return TOK_LTHIRD;}
"]" {return TOK_RTHIRD;}
[0-9]+ {return TOK_CONST_INT;}
"\n" {return TOK_EOL;}
[ \t]+ {continue;}
[a-zA-Z_][a-zA-Z0-9_]* {return TOK_ID;}
. {yyerror (yyscanner, "syntax error");}
<<EOF>>  return TOK_YYEOF;
%%
/* Epilogue (C code). */
