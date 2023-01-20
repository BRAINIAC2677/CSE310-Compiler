// Emitted in the header file, before the definition of YYSTYPE.
%code requires
{
  #ifndef YY_TYPEDEF_YY_SCANNER_T
  # define YY_TYPEDEF_YY_SCANNER_T
  typedef void* yyscan_t;
  #endif

  #include "SymbolInfo.hpp"
  #include "ast.hpp"

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

%type <Node*> start program unit func_declaration func_definition parameter_list compound_statement var_declaration type_specifier declaration_list statements statement expression_statement variable expression logic_expression rel_expression simple_expression term unary_expression factor argument_list arguments
%token <SymbolInfo*> IF WHILE FOR RETURN INT FLOAT VOID LPAREN LCURL RCURL LTHIRD RTHIRD SEMICOLON COMMA PRINTLN

%token <SymbolInfo*> ID 

%precedence<SymbolInfo*> RPAREN
%precedence<SymbolInfo*> ELSE

%right <SymbolInfo*> ASSIGNOP
%left <SymbolInfo*> LOGICOP
%left <SymbolInfo*> RELOP
%left <SymbolInfo*> ADDOP
%left <SymbolInfo*> MULOP
%right <SymbolInfo*> NOT
%right <SymbolInfo*> INCOP DECOP

%token <SymbolInfo*> CONST_INT CONST_FLOAT


%%
// Rules.
start : program
	{
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

		Node::print_parsetree($1, parsetree_file, 0);
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

		TerminalNode* semicolon_node = new TerminalNode(SYMBOLTYPE::SEMICOLON, @3.first_line);
		semicolon_node->set_symbol_info($3);

		DeclarationListNode* declaration_list_node = (DeclarationListNode*)$2;

		NonterminalNode* type_specifier_node = (NonterminalNode*)$1;

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::VAR_DECLARATION, @1.first_line, @3.last_line);
		non_terminal_node->set_production_rule("var_declaration : type_specifier declaration_list SEMICOLON");

		non_terminal_node->add_child(type_specifier_node);
		non_terminal_node->add_child(declaration_list_node);
		non_terminal_node->add_child(semicolon_node);

		$$ = (Node*)non_terminal_node;

		// setting type_specifier of all the variables in the declaration_list
		for(auto var: declaration_list_node->get_declared_variables())
		{
			var->set_type_specifier(type_specifier_node->get_children()[0]->get_symbol_type());
		}

	}
 	;
 		 
type_specifier	: INT
	{
		log_file << "type_specifier	: INT\n";

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::TYPE_SPECIFIER, @1.first_line, @1.last_line);
		non_terminal_node->set_production_rule("type_specifier : INT");

		TerminalNode* terminal_node = new TerminalNode(SYMBOLTYPE::INT, @1.first_line);
		terminal_node->set_symbol_info($1);

		non_terminal_node->add_child(terminal_node);
		$$ = (Node*)non_terminal_node;

	}
 	| FLOAT
	{
		log_file << "type_specifier	: FLOAT\n";

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::TYPE_SPECIFIER, @1.first_line, @1.last_line);
		non_terminal_node->set_production_rule("type_specifier : FLOAT");

		TerminalNode* terminal_node = new TerminalNode(SYMBOLTYPE::FLOAT, @1.first_line);
		terminal_node->set_symbol_info($1);

		non_terminal_node->add_child(terminal_node);
		$$ = (Node*)non_terminal_node;
	}
 	| VOID
	{
		log_file << "type_specifier	: VOID\n";

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::TYPE_SPECIFIER, @1.first_line, @1.last_line);
		non_terminal_node->set_production_rule("type_specifier : VOID");

		TerminalNode* terminal_node = new TerminalNode(SYMBOLTYPE::VOID, @1.first_line);
		terminal_node->set_symbol_info($1);

		non_terminal_node->add_child(terminal_node);
		$$ = (Node*)non_terminal_node;
	}
	;
 	
declaration_list : declaration_list COMMA ID
	{
		log_file << "declaration_list : declaration_list COMMA ID\n";

		TerminalNode* id_node = new TerminalNode(SYMBOLTYPE::ID, @3.first_line);
		id_node->set_symbol_info($3);

		TerminalNode* comma_node = new TerminalNode(SYMBOLTYPE::COMMA, @2.first_line);
		comma_node->set_symbol_info($2);

		DeclarationListNode* declaration_list_node = (DeclarationListNode*)$1;

		DeclarationListNode* non_terminal_node = new DeclarationListNode(SYMBOLTYPE::DECLARATION_LIST, @1.first_line, @3.last_line);
		non_terminal_node->set_production_rule("declaration_list : declaration_list COMMA ID");
		non_terminal_node->add_child(declaration_list_node);
		non_terminal_node->add_child(comma_node);
		non_terminal_node->add_child(id_node);

		VarInfo* var_info = new VarInfo($3); //type_specifier will be set in var_declaration rule

		non_terminal_node->set_declared_variables(declaration_list_node->get_declared_variables());
		non_terminal_node->add_declared_variable(var_info);

		$$ = (Node*)non_terminal_node;

	}
 	| declaration_list COMMA ID LTHIRD CONST_INT RTHIRD
	{
		log_file << "declaration_list : declaration_list COMMA ID LTHIRD CONST_INT RTHIRD\n";

		TerminalNode* rthird_node = new TerminalNode(SYMBOLTYPE::RTHIRD, @6.first_line);
		rthird_node->set_symbol_info($6);

		TerminalNode* const_int_node = new TerminalNode(SYMBOLTYPE::CONST_INT, @5.first_line);
		const_int_node->set_symbol_info($5);

		TerminalNode* lthird_node = new TerminalNode(SYMBOLTYPE::LTHIRD, @4.first_line);
		lthird_node->set_symbol_info($4);

		TerminalNode* id_node = new TerminalNode(SYMBOLTYPE::ID, @3.first_line);
		id_node->set_symbol_info($3);

		TerminalNode* comma_node = new TerminalNode(SYMBOLTYPE::COMMA, @2.first_line);
		comma_node->set_symbol_info($2);

		DeclarationListNode* declaration_list_node = (DeclarationListNode*)$1;

		DeclarationListNode* non_terminal_node = new DeclarationListNode(SYMBOLTYPE::DECLARATION_LIST, @1.first_line, @6.last_line);
		non_terminal_node->set_production_rule("declaration_list : declaration_list COMMA ID LTHIRD CONST_INT RTHIRD");

		non_terminal_node->add_child(declaration_list_node);
		non_terminal_node->add_child(comma_node);
		non_terminal_node->add_child(id_node);
		non_terminal_node->add_child(lthird_node);
		non_terminal_node->add_child(const_int_node);
		non_terminal_node->add_child(rthird_node);

		VarInfo* var_info = new VarInfo($3); //type_specifier will be set in var_declaration rule
		var_info->set_array_size(stoi($5->get_lexeme()));

		non_terminal_node->set_declared_variables(declaration_list_node->get_declared_variables());
		non_terminal_node->add_declared_variable(var_info);

		$$ = (Node*)non_terminal_node;
	}
 	| ID
	{
		log_file << "declaration_list : ID\n";

		TerminalNode* id_node = new TerminalNode(SYMBOLTYPE::ID, @1.first_line);
		id_node->set_symbol_info($1);

		DeclarationListNode* non_terminal_node = new DeclarationListNode(SYMBOLTYPE::DECLARATION_LIST, @1.first_line, @1.last_line);
		non_terminal_node->set_production_rule("declaration_list : ID");

		non_terminal_node->add_child(id_node);

		VarInfo* var_info = new VarInfo($1); //type_specifier will be set in var_declaration rule
		non_terminal_node->add_declared_variable(var_info);

		$$ = (Node*)non_terminal_node;
	}
 	| ID LTHIRD CONST_INT RTHIRD
	{
		log_file << "declaration_list : ID LTHIRD CONST_INT RTHIRD\n";

		TerminalNode* rthird_node = new TerminalNode(SYMBOLTYPE::RTHIRD, @4.first_line);
		rthird_node->set_symbol_info($4);

		TerminalNode* const_int_node = new TerminalNode(SYMBOLTYPE::CONST_INT, @3.first_line);
		const_int_node->set_symbol_info($3);

		TerminalNode* lthird_node = new TerminalNode(SYMBOLTYPE::LTHIRD, @2.first_line);
		lthird_node->set_symbol_info($2);

		TerminalNode* id_node = new TerminalNode(SYMBOLTYPE::ID, @1.first_line);
		id_node->set_symbol_info($1);		

		DeclarationListNode* non_terminal_node = new DeclarationListNode(SYMBOLTYPE::DECLARATION_LIST, @1.first_line, @4.last_line);
		non_terminal_node->set_production_rule("declaration_list : ID LTHIRD CONST_INT RTHIRD");

		non_terminal_node->add_child(id_node);
		non_terminal_node->add_child(lthird_node);
		non_terminal_node->add_child(const_int_node);
		non_terminal_node->add_child(rthird_node);

		VarInfo* var_info = new VarInfo($1); //type_specifier will be set in var_declaration rule
		var_info->set_array_size(stoi($3->get_lexeme()));

		non_terminal_node->add_declared_variable(var_info);

		$$ = (Node*)non_terminal_node;
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
