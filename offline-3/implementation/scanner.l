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

#include "bits/stdc++.h"
using namespace std;

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

//custom scanner data 
ofstream* log_file_p;

//helper functions
void log_out(int line_no, string token, string lexeme)
{
  (*log_file_p)<<"Line# " << line_no<<": Token <"<<token<<"> Lexeme "<<lexeme<< " found\n";
}
%}

%option extra-type="custom_scanner_data*"

ALPHABET [a-zA-Z_]
ALPHANUMERIC [a-zA-Z0-9_]
ID {ALPHABET}{ALPHANUMERIC}*

DIGITS ([0-9]+)
INT {DIGITS}
EXPONENT ([Ee][+-]?{DIGITS})

FLOAT {DIGITS}{EXPONENT}|{DIGITS}\.{DIGITS}?{EXPONENT}?|\.{DIGITS}{EXPONENT}?

ILLFORMED_EXPONENT [Ee][-+\.0-9]+[-+Ee\.0-9]*
ILLFORMED_NUMBER {DIGITS}(\.[0-9]*)?{ILLFORMED_EXPONENT}

TOO_MANY_DECIMAL_POINTS (\.)*({DIGITS}(\.)*)+

WHITESPACE [ \t\f\r\v]+ 
NEWLINE \n

%%

%{
  //this code block goes at the top of yylex
  LOCATION_INIT;
  custom_scanner_data* scandata = yyextra;
  log_file_p = scandata->log_file_p;
%}

"if" {
	log_out(yylloc->first_line, "IF", yytext);
	return TOK_IF;
}
"else" {
	log_out(yylloc->first_line, "ELSE", yytext);
	return TOK_ELSE;
}
"while" {
	log_out(yylloc->first_line, "WHILE", yytext);
	return TOK_WHILE;
}
"for" {
	log_out(yylloc->first_line, "FOR", yytext);
	return TOK_FOR;
}
"return" {
  log_out(yylloc->first_line, "RETURN", yytext);
	return TOK_RETURN;
}
"int" {
	log_out(yylloc->first_line, "INT", yytext);
	return TOK_INT;
}
"float" {
	log_out(yylloc->first_line, "FLOAT", yytext);
	return TOK_FLOAT;
}
"void" {
	log_out(yylloc->first_line, "VOID", yytext);
	return TOK_VOID;
}
"printf" {
	log_out(yylloc->first_line, "PRINTF", yytext);
	return TOK_PRINTLN;
}
"+"|"-" {
	log_out(yylloc->first_line, "ADDOP", yytext);
	return TOK_ADDOP;
}
"*"|"\/"|"%" {
	log_out(yylloc->first_line, "MULOP", yytext);
	return TOK_MULOP;
}
"++" {
	log_out(yylloc->first_line, "INCOP", yytext);
	return TOK_INCOP;
}
"--" {
	log_out(yylloc->first_line, "DECOP", yytext); 
	return TOK_DECOP;
}
"<"|"<="|">"|">="|"=="|"!=" {
	log_out(yylloc->first_line, "RELOP", yytext); 
	return TOK_RELOP;
}
"=" {
	log_out(yylloc->first_line, "ASSIGNOP", yytext);
	return TOK_ASSIGNOP;
}
"&&"|"||" {
	log_out(yylloc->first_line, "LOGICOP", yytext); 
	return TOK_LOGICOP;
}
"!" {
	log_out(yylloc->first_line, "NOT", yytext); 
	return TOK_NOT;
}
"(" {
	log_out(yylloc->first_line, "LPAREN", yytext); 
	return TOK_LPAREN;
}
")" {
	log_out(yylloc->first_line, "RPAREN", yytext); 
	return TOK_RPAREN;
}
"{" {
	log_out(yylloc->first_line, "LCURL", yytext); 
	return TOK_LCURL;
}
"}" {
	log_out(yylloc->first_line, "RCURL", yytext); 
	return TOK_RCURL;
}
"[" {
	log_out(yylloc->first_line, "LTHIRD", yytext);
	return TOK_LTHIRD;
}
"]" {
	log_out(yylloc->first_line, "RTHIRD", yytext);
	return TOK_RTHIRD;
}
";" {
	log_out(yylloc->first_line, "SEMICOLON", yytext);
	return TOK_SEMICOLON;
}
"," {
	log_out(yylloc->first_line, "COMMA", yytext);
	return TOK_COMMA;
}

{ID} {
	log_out(yylloc->first_line, "ID", yytext);
	return TOK_ID;
}
{INT} {
	log_out(yylloc->first_line, "CONST_INT", yytext);
	return TOK_CONST_INT;
}
{FLOAT} {
	log_out(yylloc->first_line, "CONST_FLOAT", yytext);
	return TOK_CONST_FLOAT;
}

"\/\/" {
	BEGIN SINGLE_LINE_COMMENT_STATE;
}
<SINGLE_LINE_COMMENT_STATE>[\\][\r]?[\n] {
  LOCATION_NEWLINE;
}
<SINGLE_LINE_COMMENT_STATE>[\r]?[\n] {
  LOCATION_NEWLINE;
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
  LOCATION_NEWLINE;
}

<MULTI_LINE_COMMENT_STATE>"*\/" {
  LOCATION_INIT;
	BEGIN INITIAL;
}
<MULTI_LINE_COMMENT_STATE><<EOF>> {
	BEGIN INITIAL;
}
<MULTI_LINE_COMMENT_STATE>. {
}

{NEWLINE} {
  LOCATION_NEWLINE;
}
{WHITESPACE} {}

. {yyerror (yylloc, yyscanner, "syntax error. unrecognized character");}
<<EOF>>  return TOK_YYEOF;
%%
/* Epilogue (C code). */
