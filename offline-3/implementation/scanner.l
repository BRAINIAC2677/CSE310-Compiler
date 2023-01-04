/* Disable Flex features we don't need, to avoid warnings. */
%option nodefault noinput nounput noyywrap

%option reentrant

%x SINGLE_LINE_COMMENT_STATE
%x MULTI_LINE_COMMENT_STATE

%{
#include <assert.h>
#include <limits.h> /* INT_MIN */
#include <stdlib.h> /* strtol */

#include "parser.h"
%}

ALPHABET [a-zA-Z_]
ALPHANUMERIC [a-zA-Z0-9_]
ID {ALPHABET}{ALPHANUMERIC}*

DIGITS ([0-9]+)
INT {DIGITS}
EXPONENT ([E,e][+,-]?{DIGITS})

FLOAT {DIGITS}{EXPONENT}|{DIGITS}\.{DIGITS}?{EXPONENT}?|\.{DIGITS}{EXPONENT}?

ILLFORMED_EXPONENT [Ee][-+\.0-9]+[-+Ee\.0-9]*
ILLFORMED_NUMBER {DIGITS}(\.[0-9]*)?{ILLFORMED_EXPONENT}

TOO_MANY_DECIMAL_POINTS (\.)*({DIGITS}(\.)*)+

WHITESPACE [ \t\f\r\v]+ 
NEWLINE \n

%%

"if" {return TOK_IF;}
"else" {return TOK_ELSE;}
"while" {return TOK_WHILE;}
"for" {return TOK_FOR;}
"return" {return TOK_RETURN;}
"int" {return TOK_INT;}
"float" {return TOK_FLOAT;}
"void" {return TOK_VOID;}
"printf" {return TOK_PRINTLN;}
"+"|"-" {return TOK_ADDOP;}
"*"|"\/"|"%" {return TOK_MULOP;}
"++" {return TOK_INCOP;}
"--" {return TOK_DECOP;}
"<"|"<="|">"|">="|"=="|"!=" {return TOK_RELOP;}
"=" {return TOK_ASSIGNOP;}
"&&"|"||" {return TOK_LOGICOP;}
"!" {return TOK_NOT;}
"(" {return TOK_LPAREN;}
")" {return TOK_RPAREN;}
"{" {return TOK_LCURL;}
"}" {return TOK_RCURL;}
"[" {return TOK_LTHIRD;}
"]" {return TOK_RTHIRD;}
";" {return TOK_SEMICOLON;}
"," {return TOK_COMMA;}

{ID} {return TOK_ID;}
{INT} {return TOK_CONST_INT;}
{FLOAT} {return TOK_CONST_FLOAT;}

"\/\/" {
	BEGIN SINGLE_LINE_COMMENT_STATE;
}
<SINGLE_LINE_COMMENT_STATE>[\\][\r]?[\n] {
}
<SINGLE_LINE_COMMENT_STATE>[\r]?[\n] {
	BEGIN INITIAL;
}
<SINGLE_LINE_COMMENT_STATE><<EOF>> {
	BEGIN INITIAL;
}
<SINGLE_LINE_COMMENT_STATE>. {
}

"\/*" {
	BEGIN MULTI_LINE_COMMENT_STATE;
}
<MULTI_LINE_COMMENT_STATE>[\r]?[\n] {
}

<MULTI_LINE_COMMENT_STATE>"*\/" {
	BEGIN INITIAL;
}
<MULTI_LINE_COMMENT_STATE><<EOF>> {
	BEGIN INITIAL;
}
<MULTI_LINE_COMMENT_STATE>. {
}

{NEWLINE} {}
{WHITESPACE} {}

. {yyerror (yyscanner, "syntax error. unrecognized character");}
<<EOF>>  return TOK_YYEOF;
%%
/* Epilogue (C code). */
