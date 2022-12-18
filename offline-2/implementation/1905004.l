%option yylineno
%option noyywrap

%x STRING_STATE
%x SINGLE_LINE_COMMENT_STATE
%x MULTI_LINE_COMMENT_STATE


%{

#include "1905004_SymbolInfo.hpp"
#include "1905004_SymbolTable.hpp"

#include <bits/stdc++.h>
using namespace std;

int error_count = 0;
int string_line_count = 1, comment_line_count = 1;
string raw_string_text, string_text;
string single_line_comment_text, multi_line_comment_text;

SymbolTable symbol_table(10);

ofstream logout;
ofstream tokenout;

string uppercase(string s)
{
	transform(s.begin(), s.end(), s.begin(), ::toupper);
	return s;
}

void tout(string type, int line_no = yylineno, string lexeme = yytext)
{
	tokenout<<"<"<<type<<", "<<lexeme<<">\n";
	logout<<"Line# "<<line_no<<": Token <"<<type<<"> Lexeme "<<lexeme<<" found\n";
}

void terr(string type, int line_no = yylineno, string lexeme = yytext)
{
	logout<<"Error at line# "<<line_no<<": "<<type<<" "<<lexeme<<"\n";
}

void handle_error(string type, int line_no = yylineno, string lexeme = yytext)
{
	error_count++;
	terr(type, line_no, lexeme);
}

string clean_escape_sequence(string s)
{
	if(s == "\\'")
	{
		return "\'";
	}
	else if(s == "\\\"")
	{
		return "\"";
	}
	else if(s == "\\n")
	{
		return "\n";
	}
	else if(s == "\\t")
	{
		return "\t";
	}
	else if(s == "\\\\")
	{
		return "\\";
	}
	else if(s == "\\a")
	{
		return "\a";
	}
	else if(s == "\\f")
	{
		return "\f";
	}
	else if(s == "\\r")
	{
		return "\r";
	}
	else if(s == "\\b")
	{
		return "\b";
	}
	else if(s == "\\v")
	{
		return "\v";
	}
	else if(s == "\\0")
	{
		return "\0";
	}
	else 
	{
		return s;
	}
}

%}

ALPHABET [a-zA-Z_]
ALPHANUMERIC [a-zA-Z0-9_]
ID {ALPHABET}{ALPHANUMERIC}*

DIGIT [0-9]
DIGITS ([0-9]+)
INT {DIGITS}
EXPONENT ([E,e][+,-]?{DIGITS})

FLOAT {DIGITS}{EXPONENT}|{DIGITS}\.{DIGITS}?{EXPONENT}?|\.{DIGITS}{EXPONENT}?

ILLFORMED_EXPONENT [Ee][-+\.0-9]+[-+Ee\.0-9]*
ILLFORMED_NUMBER {DIGITS}(\.[0-9]*)?{ILLFORMED_EXPONENT}

TOO_MANY_DECIMAL_POINTS (\.)*({DIGITS}(\.)*)+

CHAR (\'([^'\\]|\\['"?\\abvfrnt0])\')
MULTICHAR (\'..+\')
UNFINISHED_CHAR (\'([^']|\\['"?\\abvfrnt0]))

WHITESPACE [ \t\f\r\v]+ 
NEWLINE \n

%%

"if"|"for"|"do"|"int"|"float"|"void"|"switch"|"default"|"else"|"while"|"break"|"char"|"double"|"return"|"case"|"continue" {
	tout(uppercase(yytext));
}


"+"|"-" {
	tout("ADDOP");
}
"*"|"\/"|"%" {
	tout("MULOP");
}
"++"|"--" {
	tout("INCOP");
}
"<"|"<="|">"|">="|"=="|"!=" {
	tout("RELOP");
}
"=" {
	tout("ASSIGNOP");
}
"&&"|"||" {
	tout("LOGICOP");
}
"&"|"|"|"^"|"<<"|">>" {
	tout("BITOP");
}
"!" {
	tout("NOT");
}
"(" {
	tout("LPAREN");
}
")" {
	tout("RPAREN");
}
"{" {
	tout("LCURL");
	symbol_table.enter_scope();
}
"}" {
	tout("RCURL");
	symbol_table.exit_scope();
}
"[" {
	tout("LSQUARE");
}
"]" {
	tout("RSQUARE");
}
"," {
	tout("COMMA");
}
";" {
	tout("SEMICOLON");
}


{ID} {
	tout("ID");
	bool is_inserted = symbol_table.insert(SymbolInfo(yytext, "ID"));
	if(is_inserted)
	{
		logout<<symbol_table;
	}
	else 
	{
		logout<<"\t"<<yytext<<" already exists in the current ScopeTable\n";
	}
}



{INT} {
	tout("CONST_INT");
}
{FLOAT} {
	tout("CONST_FLOAT");
}
{ILLFORMED_NUMBER} {
	handle_error("ILLFORMED_NUMBER");
}
{TOO_MANY_DECIMAL_POINTS} {
	handle_error("TOO_MANY_DECIMAL_POINTS");
}
({FLOAT}|{INT}){ID} {
	handle_error("INVALID_ID_SUFFIX_NUM_PREFIX");
}


{CHAR} {
	string string_text = yytext;
	string_text = string_text.substr(1, (int)string_text.size() - 2);
	string_text = clean_escape_sequence(string_text);
	tout("CONST_CHAR", yylineno, string_text);
}
"''" {
	handle_error("EMPTY_CONST_CHAR", yylineno, "''");
}
{MULTICHAR} {
	handle_error("MULTICHAR_CONST_CHAR", yylineno, yytext);
}
{UNFINISHED_CHAR} {
	handle_error("UNFINISHED_CONST_CHAR", yylineno, yytext);
}


"\"" {
	raw_string_text.clear();
	string_text.clear();
	string_line_count = 1;
	BEGIN STRING_STATE;
}
<STRING_STATE>\\['\"?\\abvfrnt0] {
	string_text += clean_escape_sequence(yytext);
	raw_string_text += yytext;
}
<STRING_STATE>[\\][\r]?[\n] {
	string_line_count++;
	raw_string_text += "\\\n";
}
<STRING_STATE><<EOF>> {
	handle_error("UNFINISHED_STRING", yylineno-string_line_count+1, "\""+raw_string_text);
	BEGIN INITIAL;
}
<STRING_STATE>[\r]?[\n] {
	handle_error("UNFINISHED_STRING", yylineno-1,"\""+raw_string_text);
	BEGIN INITIAL;
}
<STRING_STATE>"\"" {

	if(string_line_count == 1)
	{		
		tokenout<<"<SINGLE LINE STRING, "<<string_text<<">\n";
		logout<<"Line# "<<(yylineno-string_line_count + 1)<<": Token <SINGLE LINE STRING> Lexeme \""<<raw_string_text<<"\" found\n";
	}
	else
	{
		tokenout<<"<MULTI LINE STRING, "<<string_text<<">\n";
		logout<<"Line# "<<(yylineno-string_line_count+1)<<": Token <MULTI LINE STRING> Lexeme \""<<raw_string_text<<"\" found\n";
	}
	BEGIN INITIAL;
}
<STRING_STATE>. {
	raw_string_text += yytext;
	string_text += yytext;
}


"\/\/" {
	single_line_comment_text.clear();
	comment_line_count = 1;
	BEGIN SINGLE_LINE_COMMENT_STATE;
}
<SINGLE_LINE_COMMENT_STATE>[\\][\r]?[\n] {
	comment_line_count++;
	single_line_comment_text += "\\\n";
}
<SINGLE_LINE_COMMENT_STATE><<EOF>> {
	logout<<"Line# "<<(yylineno-comment_line_count+1)<<": Token <SINGLE LINE COMMENT> Lexeme //"<<single_line_comment_text<<" found\n";	
	BEGIN INITIAL;
}
<SINGLE_LINE_COMMENT_STATE>[\r]?[\n] {
	logout<<"Line# "<<(yylineno-comment_line_count)<<": Token <SINGLE LINE COMMENT> Lexeme //"<<single_line_comment_text<<" found\n";
	BEGIN INITIAL;
}
<SINGLE_LINE_COMMENT_STATE>. {
	single_line_comment_text += yytext;
}


"\/*" {
	multi_line_comment_text = "/*";
	comment_line_count = 1;
	BEGIN MULTI_LINE_COMMENT_STATE;
}
<MULTI_LINE_COMMENT_STATE>[\r]?[\n] {
	comment_line_count++;
	multi_line_comment_text += "\n";
}
<MULTI_LINE_COMMENT_STATE><<EOF>> {
	error_count++;
	logout<<"Error at line# "<<yylineno<<": UNFINISHED_COMMENT "<<multi_line_comment_text<<"\n";
	BEGIN INITIAL;
}
<MULTI_LINE_COMMENT_STATE>"*\/" {
	multi_line_comment_text += "*/";
	logout<<"Line# "<<(yylineno-comment_line_count+1)<<": Token <MULTI LINE COMMENT> Lexeme "<<multi_line_comment_text<<" found\n";	
	BEGIN INITIAL;
}
<MULTI_LINE_COMMENT_STATE>. {
	multi_line_comment_text += yytext;
}


{NEWLINE} {}
{WHITESPACE} {}


. {
	handle_error("UNRECOGNIZED_CHAR");
}

%%

int main(int argc, char** argv) {

	if(argc!=2){
		printf("Please provide input file name and try again\n");
		return 0;
	}
	
	FILE *fin=fopen(argv[1],"r");
	if(fin==NULL){
		printf("Cannot open specified file\n");
		return 0;
	}
	
	tokenout.open("1905004_token.txt");
	logout.open("1905004_log.txt");

	yyin= fin;
	yylineno = 1;
	yylex();
	fclose(yyin);

	logout<<symbol_table;
  	logout<<"Total lines: "<<yylineno<<"\n";
  	logout<<"Total errors: "<<error_count<<"\n";

  	tokenout.close();
  	logout.close();
	return 0;
}
