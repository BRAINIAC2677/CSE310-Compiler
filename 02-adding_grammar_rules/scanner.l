/* Disable Flex features we don't need, to avoid warnings. */
%option nodefault noinput nounput noyywrap
%option reentrant

%{
#include "bits/stdc++.h"
using namespace std;

#include "parser.h"

// Each time a rule is matched, advance the end cursor/position.
#define YY_USER_ACTION                          \
  yylloc->last_column += (int) yyleng;

  // Move the first position onto the last.
#define LOCATION_INIT                           \
  {                                             \
    yylloc->first_line = yylloc->last_line;     \
    yylloc->first_column = yylloc->last_column; \
  }

#define LOCATION_NEWLINE       \
  {                            \
    yylloc->last_line++;       \
    yylloc->last_column = 1;   \
    LOCATION_INIT;             \
  }

// helper functions
void count_newlines(YYLTYPE* yylloc, string s)
{
  for(int i = 0; i< s.size(); i++)
  {
    if(s[i] == '\n')
    {
      LOCATION_NEWLINE
    }
  }
}

%}

/*regex for tokens*/
ALPHABET [a-zA-Z_]
ALPHANUMERIC [a-zA-Z0-9_]
ID {ALPHABET}{ALPHANUMERIC}*

DIGITS ([0-9]+)
CONST_INT {DIGITS}
EXPONENT ([Ee][+-]?{DIGITS})

CONST_FLOAT {DIGITS}{EXPONENT}|{DIGITS}\.{DIGITS}?{EXPONENT}?|\.{DIGITS}{EXPONENT}?

ILLFORMED_EXPONENT [Ee][-+\.0-9]+[-+Ee\.0-9]*
ILLFORMED_NUMBER {DIGITS}(\.[0-9]*)?{ILLFORMED_EXPONENT}

TOO_MANY_DECIMAL_POINTS (\.)*({DIGITS}(\.)*)+

WHITESPACE [ \t\f\r\v]+ 
NEWLINE \n
/*end of regex for tokens*/

%%

%{
  LOCATION_INIT
%}

"if" {
	return TOK_IF;
}
"else" {
	return TOK_ELSE;
}
"while" {
	return TOK_WHILE;
}
"for" {
	return TOK_FOR;
}
"return" {
	return TOK_RETURN;
}
"int" {
	return TOK_INT;
}
"float" {
	return TOK_FLOAT;
}
"void" {
	return TOK_VOID;
}
"println" {
	return TOK_PRINTLN;
}
"+"|"-" {
	return TOK_ADDOP;
}
"*"|"\/"|"%" {
	return TOK_MULOP;
}
"++" {
	return TOK_INCOP;
}
"--" {
	return TOK_DECOP;
}
"<"|"<="|">"|">="|"=="|"!=" {
	return TOK_RELOP;
}
"=" {
	return TOK_ASSIGNOP;
}
"&&"|"||" {
	return TOK_LOGICOP;
}
"!" {
	return TOK_NOT;
}
"(" {
	return TOK_LPAREN;
}
")" {
	return TOK_RPAREN;
}
"{" {
	return TOK_LCURL;
}
"}" {
	return TOK_RCURL;
}
"[" {
	return TOK_LTHIRD;
}
"]" {
	return TOK_RTHIRD;
}
";" {
	return TOK_SEMICOLON;
}
"," {
	return TOK_COMMA;
}

{ID} {
	return TOK_ID;
}
{CONST_INT} {
	return TOK_CONST_INT;
}
{CONST_FLOAT} {
	return TOK_CONST_FLOAT;
}

{ILLFORMED_NUMBER} {
  yyerror (yylloc, yyscanner, "syntax error. illformed number");
}

{TOO_MANY_DECIMAL_POINTS} {
  yyerror (yylloc, yyscanner, "syntax error. too many decimal points");
}

\/\/.*(\\(\r)?\n.*)* {
	count_newlines(yylloc, yytext);
}
 

\/\*([^\*]|\*[^\/])*\*\/ {
	count_newlines(yylloc, yytext);
}

{NEWLINE} {
	LOCATION_NEWLINE
}

{WHITESPACE} {}

. {yyerror (yylloc, yyscanner, "syntax error. unrecognized character");}
<<EOF>>  return TOK_YYEOF;

%%
