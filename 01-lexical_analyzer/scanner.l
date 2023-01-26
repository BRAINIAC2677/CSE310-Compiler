/* Disable Flex features we don't need, to avoid warnings. */
%option nodefault noinput nounput noyywrap
%option reentrant

%{
#include "bits/stdc++.h"
using namespace std;

enum yytokentype
{
    TOK_YYEMPTY = -2,
    TOK_YYEOF = 0,                 /* "end of file"  */
    TOK_YYerror = 256,             /* error  */
    TOK_YYUNDEF = 257,             /* "invalid token"  */
    TOK_IF = 258,                  /* IF  */
    TOK_WHILE = 259,               /* WHILE  */
    TOK_FOR = 260,                 /* FOR  */
    TOK_RETURN = 261,              /* RETURN  */
    TOK_INT = 262,                 /* INT  */
    TOK_FLOAT = 263,               /* FLOAT  */
    TOK_VOID = 264,                /* VOID  */
    TOK_LPAREN = 265,              /* LPAREN  */
    TOK_LCURL = 266,               /* LCURL  */
    TOK_RCURL = 267,               /* RCURL  */
    TOK_LTHIRD = 268,              /* LTHIRD  */
    TOK_RTHIRD = 269,              /* RTHIRD  */
    TOK_SEMICOLON = 270,           /* SEMICOLON  */
    TOK_COMMA = 271,               /* COMMA  */
    TOK_PRINTLN = 272,             /* PRINTLN  */
    TOK_ID = 273,                  /* ID  */
    TOK_RPAREN = 274,              /* RPAREN  */
    TOK_ELSE = 275,                /* ELSE  */
    TOK_ASSIGNOP = 276,            /* ASSIGNOP  */
    TOK_LOGICOP = 277,             /* LOGICOP  */
    TOK_RELOP = 278,               /* RELOP  */
    TOK_ADDOP = 279,               /* ADDOP  */
    TOK_MULOP = 280,               /* MULOP  */
    TOK_NOT = 281,                 /* NOT  */
    TOK_INCOP = 282,               /* INCOP  */
    TOK_DECOP = 283,               /* DECOP  */
    TOK_CONST_INT = 284,           /* CONST_INT  */
    TOK_CONST_FLOAT = 285,         /* CONST_FLOAT  */
    TOK_MULTI_COMMENT = 286,       /* MULTI_COMMENT  */
    TOK_SINGLE_COMMENT = 287       /* SINGLE_COMMENT  */
    };
typedef enum yytokentype yytoken_kind_t;

map<yytoken_kind_t, string> token_map = {
    {TOK_YYEMPTY, "TOK_YYEMPTY"},
    {TOK_YYEOF, "TOK_YYEOF"},
    {TOK_YYerror, "TOK_YYerror"},
    {TOK_YYUNDEF, "TOK_YYUNDEF"},
    {TOK_IF, "TOK_IF"},
    {TOK_WHILE, "TOK_WHILE"},
    {TOK_FOR, "TOK_FOR"},
    {TOK_RETURN, "TOK_RETURN"},
    {TOK_INT, "TOK_INT"},
    {TOK_FLOAT, "TOK_FLOAT"},
    {TOK_VOID, "TOK_VOID"},
    {TOK_LPAREN, "TOK_LPAREN"},
    {TOK_LCURL, "TOK_LCURL"},
    {TOK_RCURL, "TOK_RCURL"},
    {TOK_LTHIRD, "TOK_LTHIRD"},
    {TOK_RTHIRD, "TOK_RTHIRD"},
    {TOK_SEMICOLON, "TOK_SEMICOLON"},
    {TOK_COMMA, "TOK_COMMA"},
    {TOK_PRINTLN, "TOK_PRINTLN"},
    {TOK_ID, "TOK_ID"},
    {TOK_RPAREN, "TOK_RPAREN"},
    {TOK_ELSE, "TOK_ELSE"},
    {TOK_ASSIGNOP, "TOK_ASSIGNOP"},
    {TOK_LOGICOP, "TOK_LOGICOP"},
    {TOK_RELOP, "TOK_RELOP"},
    {TOK_ADDOP, "TOK_ADDOP"},
    {TOK_MULOP, "TOK_MULOP"},
    {TOK_NOT, "TOK_NOT"},
    {TOK_INCOP, "TOK_INCOP"},
    {TOK_DECOP, "TOK_DECOP"},
    {TOK_CONST_INT, "TOK_CONST_INT"},
    {TOK_CONST_FLOAT, "TOK_CONST_FLOAT"},
    {TOK_MULTI_COMMENT, "TOK_MULTI_COMMENT"},
    {TOK_SINGLE_COMMENT, "TOK_SINGLE_COMMENT"}
};

ofstream output_file("output.txt");

typedef void* yyscan_t;
#define YY_DECL\
  yytoken_kind_t yylex (yyscan_t yyscanner)
YY_DECL;
void yyerror(ofstream& output_file, const char* msg);

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
  yyerror (output_file, "syntax error. illformed number");
}

{TOO_MANY_DECIMAL_POINTS} {
  yyerror (output_file, "syntax error. too many decimal points");
}

\/\/.*(\\(\r)?\n.*)* {
  return TOK_SINGLE_COMMENT;
}
 

\/\*([^\*]|\*[^\/])*\*\/ {
  return TOK_MULTI_COMMENT;
}

{NEWLINE} {}

{WHITESPACE} {}

. {yyerror (output_file, "syntax error. unrecognized character");}
<<EOF>>  return TOK_YYEOF;

%%
void yyerror(ofstream& output_file, const char* error_msg)
{
  output_file<<error_msg<<"\n";
}

int main(int argc, char const* argv[])
{
  if (argc != 2)
    {
        cout<< "Usage: ./a.out <input_file>" << endl;
        exit(1);
    }

	FILE *input_file = fopen(argv[1],"r");
	if(input_file == NULL)
	{
		cout<<"Cannot Open Input File.\n";
		exit(1);
	} 
  
  yyscan_t scanner_context; 
  yylex_init(&scanner_context);
  yyset_in(input_file, scanner_context);
  yytoken_kind_t token;
  while((token = yylex(scanner_context)) != TOK_YYEOF)
  {
    output_file<<token_map[token]<<"\n";
  }
  yylex_destroy(scanner_context);
  fclose(input_file);
  output_file.close();

  return 0;
}