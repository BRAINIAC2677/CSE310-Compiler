%option noyywrap

%x CHAR_STATE
%x STRING_STATE
%x SINGLE_LINE_COMMENT_STATE
%x MULTI_LINE_COMMENT_STATE

%{

#include "SymbolInfo.hpp"
#include "SymbolTable.hpp"

#include <bits/stdc++.h>
using namespace std;

int line_count=1, error_count = 0, string_line_count = 1, comment_line_count = 1;
string raw_char_text, char_text;
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

%}

ALPHABET [a-zA-Z_]
ALPHANUMERIC [a-zA-Z0-9_]
ID {ALPHABET}{ALPHANUMERIC}*

DIGIT [0-9]
DIGITS ([0-9]+)
INT {DIGITS}
EXPONENT ([E,e][+,-]?[0-9]+)
FLOAT {DIGITS}{EXPONENT}|{DIGITS}?\.{DIGITS}{EXPONENT}?

WHITESPACE [ \t\f\r\v]+ 
NEWLINE \n

%%

"if"|"for"|"do"|"int"|"float"|"void"|"switch"|"default"|"else"|"while"|"break"|"char"|"double"|"return"|"case"|"continue" {
	tokenout<<"<"<<uppercase(yytext)<<", "<<yytext<<">\n";
	logout<<"Line# "<<line_count<<": Token <"<<uppercase(yytext)<<"> Lexeme "<<yytext<<" found\n";
}

{INT} {
	tokenout<<"<CONST_INT, "<<yytext<<">\n";
	logout<<"Line# "<<line_count<<": Token <CONST_INT> Lexeme "<<yytext<<" found\n";
}

{FLOAT} {
	tokenout<<"<CONST_FLOAT, "<<yytext<<">\n";
	logout<<"Line# "<<line_count<<": Token <CONST_FLOAT> Lexeme "<<yytext<<" found\n";
}

{DIGITS}{EXPONENT}\.[0-9]*|{DIGITS}\.{EXPONENT}? {
	error_count++;
	logout<<"Error at line# "<<line_count<<": ILLFORMED_NUMBER "<<yytext<<"\n";
}

{DIGITS}?\.{DIGITS}{EXPONENT}?(\.{DIGITS}{EXPONENT}?)+ {
	error_count++;
	logout<<"Error at line# "<<line_count<<": TOO_MANY_DECIMAL_POINTS "<<yytext<<"\n";
}

"\'" {
	raw_char_text.clear();
	char_text.clear();
	BEGIN CHAR_STATE;
}

<CHAR_STATE>"\\'" {
	char_text += "\'";
	raw_char_text += "\\'";
}

<CHAR_STATE>"\\\"" {
	char_text += "\"";
	raw_char_text += "\\\"";
}

<CHAR_STATE>"\\n" {
	char_text += "\n";
	raw_char_text += "\\n";
}

<CHAR_STATE>"\\t" {
	char_text += "\t";
	raw_char_text += "\\t";
}

<CHAR_STATE>"\\\\" {
	char_text += "\\";
	raw_char_text += "\\\\";
}

<CHAR_STATE>"\\a" {
	char_text += "\a";
	raw_char_text += "\\a";
}

<CHAR_STATE>"\\f" {
	char_text += "\f";
	raw_char_text += "\\f";
}

<CHAR_STATE>"\\r" {
	char_text += "\r";
	raw_char_text += "\\r";
}

<CHAR_STATE>"\\b" {
	char_text += "\b";
	raw_char_text += "\\b";
}

<CHAR_STATE>"\\v" {
	char_text += "\v";
	raw_char_text += "\\v";
}

<CHAR_STATE>"\\0" {
	char_text += "\0";
	raw_char_text += "\\0";
}

<CHAR_STATE><<EOF>> {
	error_count++;
	logout<<"Error at line# "<<line_count<<": UNFINISHED_CONST_CHAR '"<<raw_char_text<<"\n";
	BEGIN INITIAL;
}

<CHAR_STATE>[\r]?[\n] {
	error_count++;
	logout<<"Error at line# "<<line_count<<": UNFINISHED_CONST_CHAR '"<<raw_char_text<<"\n";
	line_count++;
	BEGIN INITIAL;
}

<CHAR_STATE>"\'" {
	int char_text_size = char_text.size();

	if(char_text_size == 0)
	{
		if(raw_char_text == "\\0")
		{
			tokenout<<"<CONST_CHAR, "<<char_text<<">\n";
			logout<<"Line# "<<line_count<<": Token <CONST_CHAR> Lexeme "<<char_text<<" found\n";
		}
		else 
		{
			error_count++;
			logout<<"Error at line# "<<line_count<<": EMPTY_CONST_CHAR ''\n";
		}
	}
	else if(char_text_size == 1)
	{
		tokenout<<"<CONST_CHAR, "<<char_text<<">\n";
		logout<<"Line# "<<line_count<<": Token <CONST_CHAR> Lexeme "<<char_text<<" found\n";
	}
	else 
	{
		error_count++;
		logout<<"Error at line# "<<line_count<<": MULTICHAR_CONST_CHAR '"<<raw_char_text<<"'\n";
	}
	BEGIN INITIAL;
}

<CHAR_STATE>. {
	raw_char_text += yytext;
	char_text += yytext;
}

"\"" {
	raw_string_text.clear();
	string_text.clear();
	string_line_count = 1;
	BEGIN STRING_STATE;
}

<STRING_STATE>"\\'" {
	string_text += "\'";
	raw_string_text += "\\'";
}

<STRING_STATE>"\\\"" {
	string_text += "\"";
	raw_string_text += "\\\"";
}

<STRING_STATE>"\\n" {
	string_text += "\n";
	raw_string_text += "\\n";
}

<STRING_STATE>"\\t" {
	string_text += "\t";
	raw_string_text += "\\t";
}

<STRING_STATE>"\\\\" {
	string_text += "\\";
	raw_string_text += "\\\\";
}

<STRING_STATE>"\\a" {
	string_text += "\a";
	raw_string_text += "\\a";
}

<STRING_STATE>"\\f" {
	string_text += "\f";
	raw_string_text += "\\f";
}

<STRING_STATE>"\\r" {
	string_text += "\r";
	raw_string_text += "\\r";
}

<STRING_STATE>"\\b" {
	string_text += "\b";
	raw_string_text += "\\b";
}

<STRING_STATE>"\\v" {
	string_text += "\v";
	raw_string_text += "\\v";
}

<STRING_STATE>"\\0" {
	string_text += "\0";
	raw_string_text += "\\0";
}

<STRING_STATE>[\\][\r]?[\n] {
	line_count++;
	string_line_count++;
	raw_string_text += "\\\n";
}

<STRING_STATE><<EOF>> {
	error_count++;
	logout<<"Error at line# "<<(line_count-string_line_count+1)<<": UNFINISHED_STRING \""<<raw_string_text<<"\n";
	BEGIN INITIAL;
}

<STRING_STATE>[\r]?[\n] {
	error_count++;
	logout<<"Error at line# "<<line_count<<": UNFINISHED_STRING \""<<raw_string_text<<"\n";
	line_count++;
	BEGIN INITIAL;
}

<STRING_STATE>"\"" {

	if(string_line_count == 1)
	{
		tokenout<<"<SINGLE LINE STRING, "<<string_text<<">\n";
		logout<<"Line# "<<(line_count-string_line_count + 1)<<": Token <SINGLE LINE STRING> Lexeme \""<<raw_string_text<<"\" found\n";
	}
	else
	{
		tokenout<<"<MULTI LINE STRING, "<<string_text<<">\n";
		logout<<"Line# "<<(line_count-string_line_count+1)<<": Token <MULTI LINE STRING> Lexeme \""<<raw_string_text<<"\" found\n";
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
	line_count++;
	comment_line_count++;
	single_line_comment_text += "\\\n";
}

<SINGLE_LINE_COMMENT_STATE><<EOF>> {
	error_count++;
	logout<<"Line# "<<(line_count-comment_line_count+1)<<": Token <SINGLE LINE COMMENT> Lexeme //"<<single_line_comment_text<<" found\n";	
	BEGIN INITIAL;
}

<SINGLE_LINE_COMMENT_STATE>[\r]?[\n] {
	logout<<"Line# "<<(line_count-comment_line_count+1)<<": Token <SINGLE LINE COMMENT> Lexeme //"<<single_line_comment_text<<" found\n";
	line_count++;
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
	line_count++;
	comment_line_count++;
	multi_line_comment_text += "\n";
}

<MULTI_LINE_COMMENT_STATE><<EOF>> {
	error_count++;
	logout<<"Error at line# "<<line_count<<": UNFINISHED_COMMENT "<<multi_line_comment_text<<"\n";
	BEGIN INITIAL;
}

<MULTI_LINE_COMMENT_STATE>"*\/" {
	multi_line_comment_text += "*/";
	logout<<"Line# "<<(line_count-comment_line_count+1)<<": Token <MULTI LINE COMMENT> Lexeme "<<multi_line_comment_text<<" found\n";	
	BEGIN INITIAL;
}

<MULTI_LINE_COMMENT_STATE>. {
	multi_line_comment_text += yytext;
}

"+"|"-" {
	tokenout<<"<ADDOP, "<<yytext<<">\n";
	logout<<"Line# "<<line_count<<": Token <ADDOP> Lexeme "<<yytext<<" found\n";
}

"*"|"\/"|"%" {
	tokenout<<"<MULOP, "<<yytext<<">\n";
	logout<<"Line# "<<line_count<<": Token <MULOP> Lexeme "<<yytext<<" found\n";
}

"++"|"--" {
	tokenout<<"<INCOP, "<<yytext<<">\n";
	logout<<"Line# "<<line_count<<": Token <INCOP> Lexeme "<<yytext<<" found\n";
}

"<"|"<="|">"|">="|"=="|"!=" {
	tokenout<<"<RELOP, "<<yytext<<">\n";
	logout<<"Line# "<<line_count<<": Token <RELOP> Lexeme "<<yytext<<" found\n";
}

"=" {
	tokenout<<"<ASSIGNOP, "<<yytext<<">\n";
	logout<<"Line# "<<line_count<<": Token <ASSIGNOP> Lexeme "<<yytext<<" found\n";
}

"&&"|"||" {
	tokenout<<"<LOGICOP, "<<yytext<<">\n";
	logout<<"Line# "<<line_count<<": Token <LOGICOP> Lexeme "<<yytext<<" found\n";
}

"&"|"|"|"^"|"<<"|">>" {
	tokenout<<"<BITOP, "<<yytext<<">\n";
	logout<<"Line# "<<line_count<<": Token <BITOP> Lexeme "<<yytext<<" found\n";
}

"!" {
	tokenout<<"<NOT, "<<yytext<<">\n";
	logout<<"Line# "<<line_count<<": Token <NOT> Lexeme "<<yytext<<" found\n";
}

"(" {
	tokenout<<"<LPAREN, "<<yytext<<">\n";
	logout<<"Line# "<<line_count<<": Token <LPAREN> Lexeme "<<yytext<<" found\n";
}

")" {
	tokenout<<"<RPAREN, "<<yytext<<">\n";
	logout<<"Line# "<<line_count<<": Token <RPAREN> Lexeme "<<yytext<<" found\n";
}

"{" {
	tokenout<<"<LCURL, "<<yytext<<">\n";
	logout<<"Line# "<<line_count<<": Token <LCURL> Lexeme "<<yytext<<" found\n";
	symbol_table.enter_scope();
}

"}" {
	tokenout<<"<RCURL, "<<yytext<<">\n";
	logout<<"Line# "<<line_count<<": Token <RCURL> Lexeme "<<yytext<<" found\n";
	symbol_table.exit_scope();
}

"[" {
	tokenout<<"<LSQUARE, "<<yytext<<">\n";
	logout<<"Line# "<<line_count<<": Token <LSQUARE> Lexeme "<<yytext<<" found\n";
}

"]" {
	tokenout<<"<RSQUARE, "<<yytext<<">\n";
	logout<<"Line# "<<line_count<<": Token <RSQUARE> Lexeme "<<yytext<<" found\n";
}

"," {
	tokenout<<"<COMMA, "<<yytext<<">\n";
	logout<<"Line# "<<line_count<<": Token <COMMA> Lexeme "<<yytext<<" found\n";
}

";" {
	tokenout<<"<SEMICOLON, "<<yytext<<">\n";
	logout<<"Line# "<<line_count<<": Token <SEMICOLON> Lexeme "<<yytext<<" found\n";
}

{ID} {
	tokenout<<"<ID, "<<yytext<<">\n";
	logout<<"Line# "<<line_count<<": Token <ID> Lexeme "<<yytext<<" found\n";
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

({FLOAT}|{INT}){ID} {
	error_count++;
	logout<<"Error at line# "<<line_count<<": INVALID_ID_SUFFIX_NUM_PREFIX "<<yytext<<"\n";
}


{NEWLINE} {line_count++;}

{WHITESPACE} {}

. {
	error_count++;
	logout<<"Error at line# "<<line_count<<": UNRECOGNIZED_CHAR "<<yytext<<"\n";
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
	yylex();
	fclose(yyin);

	logout<<symbol_table;
  	logout<<"Total lines: "<<line_count<<"\n";
  	logout<<"Total errors: "<<error_count<<"\n";

  	tokenout.close();
  	logout.close();
	return 0;
}
