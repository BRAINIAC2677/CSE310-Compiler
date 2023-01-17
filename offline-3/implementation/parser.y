// Emitted in the header file, before the definition of YYSTYPE.
%code requires
{
  #ifndef YY_TYPEDEF_YY_SCANNER_T
  # define YY_TYPEDEF_YY_SCANNER_T
  typedef void* yyscan_t;
  #endif

  #include "SymbolInfo.hpp"
  #include "ast.hpp"
  using namespace ast;

  typedef struct CustomScannerData{
    ofstream* log_file_p;

    CustomScannerData(ofstream* log_file_p)
    {
      this->log_file_p = log_file_p;
    }
  }custom_scanner_data;
}


// Emitted in the header file, after the definition of YYSTYPE.
%code provides
{
  // Tell Flex the expected prototype of yylex.
  // The scanner argument must be named yyscanner.
#define YY_DECL\
  yytoken_kind_t yylex (YYSTYPE* yylval, YYLTYPE* yylloc, yyscan_t yyscanner)

  YY_DECL;
  void yyerror (const YYLTYPE *loc, yyscan_t scanner, const char *msg, ...);
}


// Emitted on top of the implementation file.
%code top
{
#include <stdarg.h> // va_list.
#include <stdio.h>  // printf.
#include <stdlib.h> // getenv.
#include <string.h>

#include <bits/stdc++.h>
using namespace std;
}


%code
{
	ofstream parsetree_file;
    ofstream log_file;
    ofstream error_file;
}

// Include the header in the implementation rather than duplicating it.
%define api.header.include {"parser.h"}

// Don't share global variables between the scanner and the parser.
%define api.pure full

// To avoid name clashes (e.g., with C's EOF) prefix token definitions
// with TOK_ (e.g., TOK_EOF).
%define api.token.prefix {TOK_}

// Generate YYSTYPE from the types assigned to symbols.
%define api.value.type union

// Error messages with "unexpected XXX, expected XXX...".
%define parse.error detailed

// with locations.
%locations

// Enable run-time traces (yydebug).
%define parse.trace

// Generate the parser description file (parse.output).
%verbose

// Scanner and error count are exchanged between main, yyparse and yylex.
%param {yyscan_t scanner}

%type <Node*> statement
%type <BasicNode*> start program unit parameter_list compound_statement var_declaration type_specifier declaration_list statements expression_statement variable expression logic_expression rel_expression simple_expression term unary_expression factor argument_list arguments
%type <TerminalTokenNode*> func_declaration func_definition

%token IF WHILE FOR RETURN INT FLOAT VOID LPAREN LCURL RCURL LTHIRD RTHIRD SEMICOLON COMMA PRINTLN

%token <SymbolInfo*> ID 

%precedence RPAREN
%precedence ELSE

%right ASSIGNOP
%left <SymbolInfo*> LOGICOP
%left <SymbolInfo*> RELOP
%left <SymbolInfo*> ADDOP
%left <SymbolInfo*> MULOP
%right NOT
%right INCOP DECOP

%token <int> CONST_INT
%token <float> CONST_FLOAT


%%
// Rules.
start : program
	{
		//write your code in this block in all the similar blocks below
		log_file << "start : program\n";
	}
	;

program : program unit
	{
		log_file << "program : program unit\n";
	}
	| unit
	{
		log_file << "program : unit\n";
	}
	;
	
unit : var_declaration
	{
		log_file << "unit : var_declaration\n";
	}
    | func_declaration
	{
		log_file << "unit : func_declaration\n";
	}
    | func_definition
	{
		log_file << "unit : func_definition\n";
	}
    ;
     
func_declaration : type_specifier ID LPAREN parameter_list RPAREN SEMICOLON
	{
		log_file << "func_declaration : type_specifier ID LPAREN parameter_list RPAREN SEMICOLON\n";
	}
	| type_specifier ID LPAREN RPAREN SEMICOLON
	{
		log_file << "func_declaration : type_specifier ID LPAREN RPAREN SEMICOLON\n";
	}
	;
		 
func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement
	{
		log_file << "func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement\n";
	}
	| type_specifier ID LPAREN RPAREN compound_statement
	{
		log_file << "func_definition : type_specifier ID LPAREN RPAREN compound_statement\n";
	}
 	;				


parameter_list  : parameter_list COMMA type_specifier ID
	{
		log_file << "parameter_list  : parameter_list COMMA type_specifier ID\n";
	}
	| parameter_list COMMA type_specifier
	{
		log_file << "parameter_list  : parameter_list COMMA type_specifier\n";
	}
 	| type_specifier ID
	{
		log_file << "parameter_list  : type_specifier ID\n";
	}
	| type_specifier
	{
		log_file << "parameter_list  : type_specifier\n";
	}
 	;

 		
compound_statement : LCURL statements RCURL
	{
		log_file << "compound_statement : LCURL statements RCURL\n";
	}
 	| LCURL RCURL
	{
		log_file << "compound_statement : LCURL RCURL\n";
	}
 	;
 		    
var_declaration : type_specifier declaration_list SEMICOLON
	{
		log_file << "var_declaration : type_specifier declaration_list SEMICOLON\n";
	}
 	;
 		 
type_specifier	: INT
	{
		log_file << "type_specifier	: INT\n";
	}
 	| FLOAT
	{
		log_file << "type_specifier	: FLOAT\n";
	}
 	| VOID
	{
		log_file << "type_specifier	: VOID\n";
	}
	;
 	
declaration_list : declaration_list COMMA ID
	{
		log_file << "declaration_list : declaration_list COMMA ID\n";
	}
 	| declaration_list COMMA ID LTHIRD CONST_INT RTHIRD
	{
		log_file << "declaration_list : declaration_list COMMA ID LTHIRD CONST_INT RTHIRD\n";
	}
 	| ID
	{
		log_file << "declaration_list : ID\n";
	}
 	| ID LTHIRD CONST_INT RTHIRD
	{
		log_file << "declaration_list : ID LTHIRD CONST_INT RTHIRD\n";
	}
 	;
 		  
statements : statement
	{
		log_file << "statements : statement\n";
	}
	| statements statement
	{
		log_file << "statements : statements statement\n";
	}
	;
	   
statement : var_declaration
	{
		log_file << "statement : var_declaration\n";
	}
	| expression_statement
	{
		log_file << "statement : expression_statement\n";
	}
	| compound_statement
	{
		log_file << "statement : compound_statement\n";
	}
	| FOR LPAREN expression_statement expression_statement expression RPAREN statement
	{
		log_file << "statement : FOR LPAREN expression_statement expression_statement expression RPAREN statement\n";
	}
	| IF LPAREN expression RPAREN statement
	{
		log_file << "statement : IF LPAREN expression RPAREN statement\n";
	}
	| IF LPAREN expression RPAREN statement ELSE statement
	{
		log_file << "statement : IF LPAREN expression RPAREN statement ELSE statement\n";
	}
	| WHILE LPAREN expression RPAREN statement
	{
		log_file << "statement : WHILE LPAREN expression RPAREN statement\n";
	}
	| PRINTLN LPAREN ID RPAREN SEMICOLON
	{
		log_file << "statement : PRINTLN LPAREN ID RPAREN SEMICOLON\n";
	}
	| RETURN expression SEMICOLON
	{
		log_file << "statement : RETURN expression SEMICOLON\n";
	}
	;
	  
expression_statement : SEMICOLON			
	{
		log_file << "expression_statement : SEMICOLON\n";
	}
	| expression SEMICOLON 
	{
		log_file << "expression_statement : expression SEMICOLON\n";
	}
	;
	  
variable : ID 		
	{
		log_file << "variable : ID\n";
	}
	| ID LTHIRD expression RTHIRD 
	{
		log_file << "variable : ID LTHIRD expression RTHIRD\n";
	}
	;
	 
expression : logic_expression	
	{
		log_file << "expression : logic_expression\n";
	}
	| variable ASSIGNOP logic_expression 	
	{
		log_file << "expression : variable ASSIGNOP logic_expression\n";
	}
	;
			
logic_expression : rel_expression 	
	{
		log_file << "logic_expression : rel_expression\n";
	}
	| rel_expression LOGICOP rel_expression 	
	{
		log_file << "logic_expression : rel_expression LOGICOP rel_expression\n";
	}
	;
			
rel_expression	: simple_expression 
	{
		log_file << "rel_expression	: simple_expression\n";
	}
	| simple_expression RELOP simple_expression	
	{
		log_file << "rel_expression	: simple_expression RELOP simple_expression\n";
	}
	;
				
simple_expression : term 
	{
		log_file << "simple_expression : term\n";
	}
	| simple_expression ADDOP term 
	{
		log_file << "simple_expression : simple_expression ADDOP term\n";
	}
	;
					
term :	unary_expression
	{
		log_file << "term :	unary_expression\n";
	}
    |  term MULOP unary_expression
	{
		log_file << "term :	term MULOP unary_expression\n";
	}
     ;

unary_expression : ADDOP unary_expression  
	{
		log_file << "unary_expression : ADDOP unary_expression\n";
	}
	| NOT unary_expression 
	{
		log_file << "unary_expression : NOT unary_expression\n";
	}
	| factor 
	{
		log_file << "unary_expression : factor\n";
	}
	;
	
factor	: variable 
	{
		log_file << "factor	: variable\n";
	}
	| ID LPAREN argument_list RPAREN
	{
		log_file << "factor	: ID LPAREN argument_list RPAREN\n";
	}
	| LPAREN expression RPAREN
	{
		log_file << "factor	: LPAREN expression RPAREN\n";
	}
	| CONST_INT 
	{
		log_file << "factor	: CONST_INT\n";
	}
	| CONST_FLOAT
	{
		log_file << "factor	: CONST_FLOAT\n";
	}
	| variable INCOP 
	{
		log_file << "factor	: variable INCOP\n";
	}
	| variable DECOP
	{
		log_file << "factor	: variable DECOP\n";
	}
	;
	
argument_list : arguments
	{
		log_file << "argument_list : arguments\n";
	}
	|
	{
		log_file << "argument_list : \n";
	}
	;
	
arguments : arguments COMMA logic_expression
	{
		log_file << "arguments : arguments COMMA logic_expression\n";
	}
	| logic_expression
	{
		log_file << "arguments : logic_expression\n";
	}
	;
 

%%

// Epilogue (C code).
#include "scanner.h"

void yyerror (const YYLTYPE* loc, yyscan_t scanner, const char *msg, ...)
{
  (void) scanner;
  va_list args;
  va_start (args, msg);
  vfprintf (stderr, msg, args);
  va_end (args);
  fputc ('\n', stderr);
}


int main(int argc, char const *argv[])
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

	string input_file_name = argv[1];
	string parsetree_file_name = input_file_name.substr(0,input_file_name.size()-2) + "_parsetree.txt";
	string log_file_name = input_file_name.substr(0,input_file_name.size()-2) + "_log.txt";
	string error_file_name = input_file_name.substr(0,input_file_name.size()-2) + "_error.txt";

	parsetree_file.open(parsetree_file_name);
	log_file.open(log_file_name);
	error_file.open(error_file_name);
  
  custom_scanner_data scandata(&log_file);
  yyscan_t scaninfo;
	yylex_init_extra(&scandata, &scaninfo);
	yyset_in(input_file,scaninfo);
	yyparse(scaninfo);
	yylex_destroy(scaninfo);

	fclose(input_file);

  parsetree_file.close();
  log_file.close();
  error_file.close();

  return 0;
}
