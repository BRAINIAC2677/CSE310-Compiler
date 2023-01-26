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
#include "SymbolInfo.hpp"

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
CONST_INT {DIGITS}
EXPONENT ([Ee][+-]?{DIGITS})

CONST_FLOAT {DIGITS}{EXPONENT}|{DIGITS}\.{DIGITS}?{EXPONENT}?|\.{DIGITS}{EXPONENT}?

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
	yylval->TOK_IF = (new SymbolInfo())->set_lexeme(yytext)->set_type(SYMBOLTYPE::IF);
	return TOK_IF;
}
"else" {
	log_out(yylloc->first_line, "ELSE", yytext);
	yylval->TOK_ELSE = (new SymbolInfo())->set_lexeme(yytext)->set_type(SYMBOLTYPE::ELSE);
	return TOK_ELSE;
}
"while" {
	log_out(yylloc->first_line, "WHILE", yytext);
	yylval->TOK_WHILE = (new SymbolInfo())->set_lexeme(yytext)->set_type(SYMBOLTYPE::WHILE);
	return TOK_WHILE;
}
"for" {
	log_out(yylloc->first_line, "FOR", yytext);
	yylval->TOK_FOR = (new SymbolInfo())->set_lexeme(yytext)->set_type(SYMBOLTYPE::FOR);
	return TOK_FOR;
}
"return" {
  	log_out(yylloc->first_line, "RETURN", yytext);
	yylval->TOK_RETURN = (new SymbolInfo())->set_lexeme(yytext)->set_type(SYMBOLTYPE::RETURN);
	return TOK_RETURN;
}
"int" {
	log_out(yylloc->first_line, "INT", yytext);
	yylval->TOK_INT = (new SymbolInfo())->set_lexeme(yytext)->set_type(SYMBOLTYPE::INT);
	return TOK_INT;
}
"float" {
	log_out(yylloc->first_line, "FLOAT", yytext);
	yylval->TOK_FLOAT = (new SymbolInfo())->set_lexeme(yytext)->set_type(SYMBOLTYPE::FLOAT);
	return TOK_FLOAT;
}
"void" {
	log_out(yylloc->first_line, "VOID", yytext);
	yylval->TOK_VOID = (new SymbolInfo())->set_lexeme(yytext)->set_type(SYMBOLTYPE::VOID);
	return TOK_VOID;
}
"println" {
	log_out(yylloc->first_line, "PRINTF", yytext);
	yylval->TOK_PRINTLN = (new SymbolInfo())->set_lexeme(yytext)->set_type(SYMBOLTYPE::PRINTLN);
	return TOK_PRINTLN;
}
"+"|"-" {
	log_out(yylloc->first_line, "ADDOP", yytext);
	yylval->TOK_ADDOP = (new SymbolInfo())->set_lexeme(yytext)->set_type(SYMBOLTYPE::ADDOP);
	return TOK_ADDOP;
}
"*"|"\/"|"%" {
	log_out(yylloc->first_line, "MULOP", yytext);
	yylval->TOK_MULOP = (new SymbolInfo())->set_lexeme(yytext)->set_type(SYMBOLTYPE::MULOP);
	return TOK_MULOP;
}
"++" {
	log_out(yylloc->first_line, "INCOP", yytext);
	yylval->TOK_INCOP = (new SymbolInfo())->set_lexeme(yytext)->set_type(SYMBOLTYPE::INCOP);
	return TOK_INCOP;
}
"--" {
	log_out(yylloc->first_line, "DECOP", yytext); 
	yylval->TOK_DECOP = (new SymbolInfo())->set_lexeme(yytext)->set_type(SYMBOLTYPE::DECOP);
	return TOK_DECOP;
}
"<"|"<="|">"|">="|"=="|"!=" {
	log_out(yylloc->first_line, "RELOP", yytext); 
	yylval->TOK_RELOP = (new SymbolInfo())->set_lexeme(yytext)->set_type(SYMBOLTYPE::RELOP);
	return TOK_RELOP;
}
"=" {
	log_out(yylloc->first_line, "ASSIGNOP", yytext);
	yylval->TOK_ASSIGNOP = (new SymbolInfo())->set_lexeme(yytext)->set_type(SYMBOLTYPE::ASSIGNOP);
	return TOK_ASSIGNOP;
}
"&&"|"||" {
	log_out(yylloc->first_line, "LOGICOP", yytext); 
	yylval->TOK_LOGICOP = (new SymbolInfo())->set_lexeme(yytext)->set_type(SYMBOLTYPE::LOGICOP);
	return TOK_LOGICOP;
}
"!" {
	log_out(yylloc->first_line, "NOT", yytext); 
	yylval->TOK_NOT = (new SymbolInfo())->set_lexeme(yytext)->set_type(SYMBOLTYPE::NOT);
	return TOK_NOT;
}
"(" {
	log_out(yylloc->first_line, "LPAREN", yytext); 
	yylval->TOK_LPAREN = (new SymbolInfo())->set_lexeme(yytext)->set_type(SYMBOLTYPE::LPAREN);
	return TOK_LPAREN;
}
")" {
	log_out(yylloc->first_line, "RPAREN", yytext); 
	yylval->TOK_RPAREN = (new SymbolInfo())->set_lexeme(yytext)->set_type(SYMBOLTYPE::RPAREN);
	return TOK_RPAREN;
}
"{" {
	log_out(yylloc->first_line, "LCURL", yytext); 
	yylval->TOK_LCURL = (new SymbolInfo())->set_lexeme(yytext)->set_type(SYMBOLTYPE::LCURL);
	return TOK_LCURL;
}
"}" {
	log_out(yylloc->first_line, "RCURL", yytext); 
	yylval->TOK_RCURL = (new SymbolInfo())->set_lexeme(yytext)->set_type(SYMBOLTYPE::RCURL);
	return TOK_RCURL;
}
"[" {
	log_out(yylloc->first_line, "LTHIRD", yytext);
	yylval->TOK_LTHIRD = (new SymbolInfo())->set_lexeme(yytext)->set_type(SYMBOLTYPE::LTHIRD);
	return TOK_LTHIRD;
}
"]" {
	log_out(yylloc->first_line, "RTHIRD", yytext);
	yylval->TOK_RTHIRD = (new SymbolInfo())->set_lexeme(yytext)->set_type(SYMBOLTYPE::RTHIRD);
	return TOK_RTHIRD;
}
";" {
	log_out(yylloc->first_line, "SEMICOLON", yytext);
	yylval->TOK_SEMICOLON = (new SymbolInfo())->set_lexeme(yytext)->set_type(SYMBOLTYPE::SEMICOLON);
	return TOK_SEMICOLON;
}
"," {
	log_out(yylloc->first_line, "COMMA", yytext);
	yylval->TOK_COMMA = (new SymbolInfo())->set_lexeme(yytext)->set_type(SYMBOLTYPE::COMMA);
	return TOK_COMMA;
}

{ID} {
	log_out(yylloc->first_line, "ID", yytext);
	yylval->TOK_ID = (new SymbolInfo())->set_lexeme(yytext)->set_type(SYMBOLTYPE::ID);
	return TOK_ID;
}
{CONST_INT} {
	log_out(yylloc->first_line, "CONST_INT", yytext);
	yylval->TOK_CONST_INT = (new SymbolInfo())->set_lexeme(yytext)->set_type(SYMBOLTYPE::CONST_INT);
	return TOK_CONST_INT;
}
{CONST_FLOAT} {
	log_out(yylloc->first_line, "CONST_FLOAT", yytext);
	yylval->TOK_CONST_FLOAT = (new SymbolInfo())->set_lexeme(yytext)->set_type(SYMBOLTYPE::CONST_FLOAT);
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
