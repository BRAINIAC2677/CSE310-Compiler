// Emitted in the header file, before the definition of YYSTYPE.
%code requires
{
  #ifndef YY_TYPEDEF_YY_SCANNER_T
  # define YY_TYPEDEF_YY_SCANNER_T
  typedef void* yyscan_t;
  #endif

  #include "SymbolInfo.hpp"
  #include "SymbolTable.hpp"
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

	SymbolTable symbol_table = SymbolTable(10);

	// error function

	void error_default(int lineno, string error_msg)
	{
		error_file << "Line# " << lineno << ": " << error_msg << "\n";
	}

	void error_parameter_redefinition(int lineno, string parameter_name)
	{
		error_file << "Line# " << lineno << ": " << "Redefinition of parameter '" << parameter_name << "'\n";
	}

	void error_conflicting_type(int lineno, string id_name)
	{
		error_file << "Line# " << lineno << ": " << "Conflicting types for '" << id_name << "'\n";
	}

	void error_redeclared_different_kind(int lineno, string id_name)
	{
		error_file << "Line# " << lineno << ": " << "'" << id_name << "' redeclared as different kind of symbol\n";
	}

	void error_void_variable(int lineno, string variable_name)
	{
		error_file << "Line# " << lineno << ": " << "Variable or field '" << variable_name << "' declared void\n";
	}

	void error_argument_type_mismatch(int lineno, int argno, string function_name)
	{
		error_file << "Line# " << lineno << ": Type mismatch for argument " << argno << " of '" << function_name << "'\n"; 
	}

	void error_too_few_arguments(int lineno, string function_name)
	{
		error_file << "Line# " << lineno << ": Too few arguments to function '" << function_name << "'\n";
	}

	void error_too_many_arguments(int lineno, string function_name)
	{
		error_file << "Line# " << lineno << ": Too many arguments to function '" << function_name << "'\n";
	}

	void error_undeclared_variable(int lineno, string variable_name)
	{
		error_file << "Line# " << lineno << ": " << "Undeclared variable '" << variable_name << "'\n";
	}

	void error_undeclared_function(int lineno, string function_name)
	{
		error_file << "Line# " << lineno << ": " << "Undeclared function '" << function_name << "'\n";
	}

	void error_not_an_array(int lineno, string variable_name)
	{
		error_file << "Line# " << lineno << ": " << "'" << variable_name << "' is not an array\n";
	}

	void error_array_index_not_integer(int lineno)
	{
		error_file << "Line# " << lineno << ": " << "Array index is not an integer\n";
	}

	void error_void_in_expression(int lineno)
	{
		error_file << "Line# " << lineno << ": " << "Void cannot be used in expression\n";
	}

	void warning_data_loss(int lineno, SYMBOLTYPE from, SYMBOLTYPE to)
	{
		error_file << "Line# " << lineno << ": " << "Warning: possible loss of data in assignment of "<<aa_terminal_symbols[from]<<" to "<<aa_terminal_symbols[to]<<"\n";
	}

	void warning_div_by_zero(int lineno)
	{
		error_file << "Line# " << lineno << ": " << "Warning: division by zero\n";
	}

	void error_nonint_mod_op(int lineno)
	{
		error_file << "Line# " << lineno << ": " << "Operands of modulus must be integers\n";
	}

	void error_redeclared_function(int lineno, string function_name)
	{
		error_file << "Line# " << lineno << ": " << "Redeclared function '" << function_name << "'\n";
	}

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
		log_file << "start : program\n";

		NonterminalNode* program_node = (NonterminalNode*)$1;

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::START, @1.first_line, @1.last_line);
		non_terminal_node->set_production_rule("start : program");

		non_terminal_node->add_child(program_node);

		$$ = (Node*)non_terminal_node;
		Node::print_parsetree($$, parsetree_file, 0);
	}
	;

program : program unit
	{
		log_file << "program : program unit\n";

		NonterminalNode* unit_node = (NonterminalNode*)$2;

		NonterminalNode* program_node = (NonterminalNode*)$1;

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::PROGRAM, @1.first_line, @2.last_line);
		non_terminal_node->set_production_rule("program : program unit");

		non_terminal_node->add_child(program_node);
		non_terminal_node->add_child(unit_node);

		$$ = (Node*)non_terminal_node;

	}
	| unit
	{
		log_file << "program : unit\n";

		NonterminalNode* unit_node = (NonterminalNode*)$1;

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::PROGRAM, @1.first_line, @1.last_line);
		non_terminal_node->set_production_rule("program : unit");

		non_terminal_node->add_child(unit_node);

		$$ = (Node*)non_terminal_node;
	}
	;
	
unit : var_declaration
	{
		log_file << "unit : var_declaration\n";

		NonterminalNode* var_declaration_node = (NonterminalNode*)$1;

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::UNIT, @1.first_line, @1.last_line);
		non_terminal_node->set_production_rule("unit : var_declaration");

		non_terminal_node->add_child(var_declaration_node);

		$$ = (Node*)non_terminal_node;

	}
    | func_declaration
	{
		log_file << "unit : func_declaration\n";

		NonterminalNode* func_declaration_node = (NonterminalNode*)$1;

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::UNIT, @1.first_line, @1.last_line);
		non_terminal_node->set_production_rule("unit : func_declaration");

		non_terminal_node->add_child(func_declaration_node);

		$$ = (Node*)non_terminal_node;
	}
    | func_definition
	{
		log_file << "unit : func_definition\n";

		NonterminalNode* func_definition_node = (NonterminalNode*)$1;

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::UNIT, @1.first_line, @1.last_line);
		non_terminal_node->set_production_rule("unit : func_definition");

		non_terminal_node->add_child(func_definition_node);

		$$ = (Node*)non_terminal_node;
	}
    ;
     
func_declaration : type_specifier ID LPAREN parameter_list RPAREN SEMICOLON
	{
		log_file << "func_declaration : type_specifier ID LPAREN parameter_list RPAREN SEMICOLON\n";

		TerminalNode* semicolon_node = new TerminalNode(SYMBOLTYPE::SEMICOLON, @6.first_line);
		semicolon_node->set_symbol_info($6);

		TerminalNode* rparen_node = new TerminalNode(SYMBOLTYPE::RPAREN, @5.first_line);
		rparen_node->set_symbol_info($5);

		ParameterListNode* parameter_list_node = (ParameterListNode*)$4;

		TerminalNode* lparen_node = new TerminalNode(SYMBOLTYPE::LPAREN, @3.first_line);
		lparen_node->set_symbol_info($3);

		TerminalNode* id_node = new TerminalNode(SYMBOLTYPE::ID, @2.first_line);
		id_node->set_symbol_info($2);

		TypedNonterminalNode* type_specifier_node = (TypedNonterminalNode*)$1;

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::FUNC_DECLARATION, @1.first_line, @6.last_line);
		non_terminal_node->set_production_rule("func_declaration : type_specifier ID LPAREN parameter_list RPAREN SEMICOLON");

		non_terminal_node->add_child(type_specifier_node);
		non_terminal_node->add_child(id_node);
		non_terminal_node->add_child(lparen_node);
		non_terminal_node->add_child(parameter_list_node);
		non_terminal_node->add_child(rparen_node);
		non_terminal_node->add_child(semicolon_node);



		$$ = (Node*)non_terminal_node;

		SymbolInfo* symbol_info = symbol_table.lookup($2->get_lexeme());

		if(symbol_info != NULL_SYMBOL_INFO)
		{
			if(symbol_info->get_type() == SYMBOLTYPE::FUNC_ID)
			{
				error_redeclared_function(@2.first_line, $2->get_lexeme());
			}
			else if(symbol_info->get_type() == SYMBOLTYPE::VAR_ID)
			{
				error_conflicting_type(@2.first_line, $2->get_lexeme());
			}
		}
		else 
		{
			//handling multiple parameters with same name
			map<string, int> parameter_count = parameter_list_node->get_parameter_count();
			for(auto p: parameter_count)
			{
				if(p.second > 1)
				{
					error_parameter_redefinition(@2.first_line, p.first);
				}
			}

			FuncInfo* func_info = new FuncInfo($2);
			func_info->set_return_type_specifier(type_specifier_node->get_type_specifier());
			func_info->set_param_type_specifiers(parameter_list_node->get_parameters());

			symbol_table.insert((SymbolInfo*)func_info);

		}
		
	}
	| type_specifier ID LPAREN RPAREN SEMICOLON
	{
		log_file << "func_declaration : type_specifier ID LPAREN RPAREN SEMICOLON\n";

		TerminalNode* semicolon_node = new TerminalNode(SYMBOLTYPE::SEMICOLON, @5.first_line);
		semicolon_node->set_symbol_info($5);

		TerminalNode* rparen_node = new TerminalNode(SYMBOLTYPE::RPAREN, @4.first_line);
		rparen_node->set_symbol_info($4);

		TerminalNode* lparen_node = new TerminalNode(SYMBOLTYPE::LPAREN, @3.first_line);
		lparen_node->set_symbol_info($3);

		TerminalNode* id_node = new TerminalNode(SYMBOLTYPE::ID, @2.first_line);
		id_node->set_symbol_info($2);

		TypedNonterminalNode* type_specifier_node = (TypedNonterminalNode*)$1;

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::FUNC_DECLARATION, @1.first_line, @5.last_line);
		non_terminal_node->set_production_rule("func_declaration : type_specifier ID LPAREN RPAREN SEMICOLON");

		non_terminal_node->add_child(type_specifier_node);
		non_terminal_node->add_child(id_node);
		non_terminal_node->add_child(lparen_node);
		non_terminal_node->add_child(rparen_node);
		non_terminal_node->add_child(semicolon_node);

		$$ = (Node*)non_terminal_node;
		SymbolInfo* symbol_info = symbol_table.lookup($2->get_lexeme());

		if(symbol_info != NULL_SYMBOL_INFO)
		{
			if(symbol_info->get_type() == SYMBOLTYPE::FUNC_ID)
			{
				error_redeclared_function(@2.first_line, $2->get_lexeme());
			}
			else if(symbol_info->get_type() == SYMBOLTYPE::VAR_ID)
			{
				error_conflicting_type(@2.first_line, $2->get_lexeme());
			}
		}
		else 
		{
			
			FuncInfo* func_info = new FuncInfo($2);
			func_info->set_return_type_specifier(type_specifier_node->get_type_specifier());
			symbol_table.insert((SymbolInfo*)func_info);

		}
	}
	;
		 
func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement
	{
		log_file << "func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement\n";

		NonterminalNode* compound_statement_node = (NonterminalNode*)$6;

		TerminalNode* rparen_node = new TerminalNode(SYMBOLTYPE::RPAREN, @5.first_line);
		rparen_node->set_symbol_info($5);

		ParameterListNode* parameter_list_node = (ParameterListNode*)$4;

		TerminalNode* lparen_node = new TerminalNode(SYMBOLTYPE::LPAREN, @3.first_line);
		lparen_node->set_symbol_info($3);

		TerminalNode* id_node = new TerminalNode(SYMBOLTYPE::ID, @2.first_line);
		id_node->set_symbol_info($2);

		TypedNonterminalNode* type_specifier_node = (TypedNonterminalNode*)$1;

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::FUNC_DEFINITION, @1.first_line, @6.last_line);
		non_terminal_node->set_production_rule("func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement");

		non_terminal_node->add_child(type_specifier_node);
		non_terminal_node->add_child(id_node);
		non_terminal_node->add_child(lparen_node);
		non_terminal_node->add_child(parameter_list_node);
		non_terminal_node->add_child(rparen_node);
		non_terminal_node->add_child(compound_statement_node);


		$$ = (Node*)non_terminal_node;

        SymbolInfo* symbol_info = symbol_table.lookup($2->get_lexeme());

		if(symbol_info == NULL_SYMBOL_INFO) 
		{
			//handling multiple parameters with same name
			map<string, int> parameter_count = parameter_list_node->get_parameter_count();
			for(auto p: parameter_count)
			{
				if(p.second > 1)
				{
					error_parameter_redefinition(@2.first_line, p.first);
				}
			}

			FuncInfo* func_info = new FuncInfo($2);
			func_info->set_return_type_specifier(type_specifier_node->get_type_specifier());
			func_info->set_param_type_specifiers(parameter_list_node->get_parameters());

			symbol_table.insert((SymbolInfo*)func_info);

		}
		else if(symbol_info->get_type() == SYMBOLTYPE::VAR_ID)
		{
			error_redeclared_different_kind(@2.first_line, $2->get_lexeme());
		}
		else if(symbol_info->get_type() == SYMBOLTYPE::FUNC_ID)
		{
			FuncInfo* func_info = (FuncInfo*)symbol_info;

			if(!func_info->is_return_type_same(type_specifier_node->get_type_specifier()))
			{
				error_conflicting_type(@2.first_line, $2->get_lexeme());
			}
			else if(!func_info->is_param_type_same(parameter_list_node->get_parameters()))
			{
				error_conflicting_type(@2.first_line, $2->get_lexeme());
			}
		}

	}
	| type_specifier ID LPAREN RPAREN compound_statement
	{
		log_file << "func_definition : type_specifier ID LPAREN RPAREN compound_statement\n";

		NonterminalNode* compound_statement_node = (NonterminalNode*)$5;

		TerminalNode* rparen_node = new TerminalNode(SYMBOLTYPE::RPAREN, @4.first_line);
		rparen_node->set_symbol_info($4);

		TerminalNode* lparen_node = new TerminalNode(SYMBOLTYPE::LPAREN, @3.first_line);
		lparen_node->set_symbol_info($3);

		TerminalNode* id_node = new TerminalNode(SYMBOLTYPE::ID, @2.first_line);
		id_node->set_symbol_info($2);

		TypedNonterminalNode* type_specifier_node = (TypedNonterminalNode*)$1;

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::FUNC_DEFINITION, @1.first_line, @5.last_line);
		non_terminal_node->set_production_rule("func_definition : type_specifier ID LPAREN RPAREN compound_statement");

		non_terminal_node->add_child(type_specifier_node);
		non_terminal_node->add_child(id_node);
		non_terminal_node->add_child(lparen_node);
		non_terminal_node->add_child(rparen_node);
		non_terminal_node->add_child(compound_statement_node);

		$$ = (Node*)non_terminal_node;

        SymbolInfo* symbol_info = symbol_table.lookup($2->get_lexeme());

		if(symbol_info == NULL_SYMBOL_INFO) 
		{
			FuncInfo* func_info = new FuncInfo($2);
			func_info->set_return_type_specifier(type_specifier_node->get_type_specifier());

			symbol_table.insert((SymbolInfo*)func_info);
		}
		else if(symbol_info->get_type() == SYMBOLTYPE::VAR_ID)
		{
			error_redeclared_different_kind(@2.first_line, $2->get_lexeme());
		}
		else if(symbol_info->get_type() == SYMBOLTYPE::FUNC_ID)
		{
			FuncInfo* func_info = (FuncInfo*)symbol_info;
			if(!func_info->is_return_type_same(type_specifier_node->get_type_specifier()))
			{
				error_conflicting_type(@2.first_line, $2->get_lexeme());
			}
		}
	}
 	;				


parameter_list  : parameter_list COMMA type_specifier ID
	{
		log_file << "parameter_list  : parameter_list COMMA type_specifier ID\n";

		TerminalNode* id_node = new TerminalNode(SYMBOLTYPE::ID, @4.first_line);
		id_node->set_symbol_info($4);

		TypedNonterminalNode* type_specifier_node = (TypedNonterminalNode*)$3;

		TerminalNode* comma_node = new TerminalNode(SYMBOLTYPE::COMMA, @2.first_line);
		comma_node->set_symbol_info($2);

		ParameterListNode* parameter_list_node = (ParameterListNode*)$1;

		ParameterListNode* non_terminal_node = new ParameterListNode(SYMBOLTYPE::PARAMETER_LIST, @1.first_line, @4.last_line);
		non_terminal_node->set_production_rule("parameter_list  : parameter_list COMMA type_specifier ID");
		non_terminal_node->set_parameters(parameter_list_node->get_parameters());
		non_terminal_node->add_parameter(type_specifier_node->get_type_specifier());
		non_terminal_node->set_parameter_count(parameter_list_node->get_parameter_count());
		non_terminal_node->increase_parameter_count($4->get_lexeme());

		non_terminal_node->add_child(parameter_list_node);
		non_terminal_node->add_child(comma_node);
		non_terminal_node->add_child(type_specifier_node);
		non_terminal_node->add_child(id_node);

		$$ = (Node*)non_terminal_node;
	}
	| parameter_list COMMA type_specifier
	{
		log_file << "parameter_list  : parameter_list COMMA type_specifier\n";

		TypedNonterminalNode* type_specifier_node = (TypedNonterminalNode*)$3;

		TerminalNode* comma_node = new TerminalNode(SYMBOLTYPE::COMMA, @2.first_line);
		comma_node->set_symbol_info($2);

		ParameterListNode* parameter_list_node = (ParameterListNode*)$1;

		ParameterListNode* non_terminal_node = new ParameterListNode(SYMBOLTYPE::PARAMETER_LIST, @1.first_line, @3.last_line);
		non_terminal_node->set_production_rule("parameter_list  : parameter_list COMMA type_specifier");
		non_terminal_node->set_parameters(parameter_list_node->get_parameters());
		non_terminal_node->add_parameter(type_specifier_node->get_type_specifier());
		non_terminal_node->set_parameter_count(parameter_list_node->get_parameter_count());

		non_terminal_node->add_child(parameter_list_node);
		non_terminal_node->add_child(comma_node);
		non_terminal_node->add_child(type_specifier_node);

		$$ = (Node*)non_terminal_node;
	}
 	| type_specifier ID
	{
		log_file << "parameter_list  : type_specifier ID\n";

		TerminalNode* id_node = new TerminalNode(SYMBOLTYPE::ID, @2.first_line);
		id_node->set_symbol_info($2);

		TypedNonterminalNode* type_specifier_node = (TypedNonterminalNode*)$1;

		ParameterListNode* non_terminal_node = new ParameterListNode(SYMBOLTYPE::PARAMETER_LIST, @1.first_line, @2.last_line);
		non_terminal_node->set_production_rule("parameter_list  : type_specifier ID");
		non_terminal_node->add_parameter(type_specifier_node->get_type_specifier());
		non_terminal_node->increase_parameter_count($2->get_lexeme());

		non_terminal_node->add_child(type_specifier_node);
		non_terminal_node->add_child(id_node);

		$$ = (Node*)non_terminal_node;
	}
	| type_specifier
	{
		log_file << "parameter_list  : type_specifier\n";

		TypedNonterminalNode* type_specifier_node = (TypedNonterminalNode*)$1;

		ParameterListNode* non_terminal_node = new ParameterListNode(SYMBOLTYPE::PARAMETER_LIST, @1.first_line, @1.last_line);
		non_terminal_node->set_production_rule("parameter_list  : type_specifier");
		non_terminal_node->add_parameter(type_specifier_node->get_type_specifier());

		non_terminal_node->add_child(type_specifier_node);

		$$ = (Node*)non_terminal_node;
	}
 	;

 		
compound_statement : LCURL scope statements RCURL
	{
		log_file << "compound_statement : LCURL statements RCURL\n";

		TerminalNode* rcurl_node = new TerminalNode(SYMBOLTYPE::RCURL, @4.first_line);
		rcurl_node->set_symbol_info($4);

		NonterminalNode* statements_node = (NonterminalNode*)$3;

		TerminalNode* lcurl_node = new TerminalNode(SYMBOLTYPE::LCURL, @1.first_line);
		lcurl_node->set_symbol_info($1);

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::COMPOUND_STATEMENT, @1.first_line, @4.last_line);
		non_terminal_node->set_production_rule("compound_statement : LCURL statements RCURL");

		non_terminal_node->add_child(lcurl_node);
		non_terminal_node->add_child(statements_node);
		non_terminal_node->add_child(rcurl_node);

		$$ = (Node*)non_terminal_node;

		log_file <<symbol_table;
		symbol_table.exit_scope();
	}
 	| LCURL scope RCURL
	{
		log_file << "compound_statement : LCURL RCURL\n";

		TerminalNode* rcurl_node = new TerminalNode(SYMBOLTYPE::RCURL, @3.first_line);
		rcurl_node->set_symbol_info($3);

		TerminalNode* lcurl_node = new TerminalNode(SYMBOLTYPE::LCURL, @1.first_line);
		lcurl_node->set_symbol_info($1);

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::COMPOUND_STATEMENT, @1.first_line, @3.last_line);
		non_terminal_node->set_production_rule("compound_statement : LCURL RCURL");

		non_terminal_node->add_child(lcurl_node);
		non_terminal_node->add_child(rcurl_node);

		$$ = (Node*)non_terminal_node;

		log_file <<symbol_table;
		symbol_table.exit_scope();
	}
 	;

scope : 
{
	symbol_table.enter_scope();
};	    
var_declaration : type_specifier declaration_list SEMICOLON
	{
		log_file << "var_declaration : type_specifier declaration_list SEMICOLON\n";

		TerminalNode* semicolon_node = new TerminalNode(SYMBOLTYPE::SEMICOLON, @3.first_line);
		semicolon_node->set_symbol_info($3);

		DeclarationListNode* declaration_list_node = (DeclarationListNode*)$2;

		TypedNonterminalNode* type_specifier_node = (TypedNonterminalNode*)$1;

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::VAR_DECLARATION, @1.first_line, @3.last_line);
		non_terminal_node->set_production_rule("var_declaration : type_specifier declaration_list SEMICOLON");

		non_terminal_node->add_child(type_specifier_node);
		non_terminal_node->add_child(declaration_list_node);
		non_terminal_node->add_child(semicolon_node);

		$$ = (Node*)non_terminal_node;

		// setting type_specifier of all the variables in the declaration_list
		
		for(auto var: declaration_list_node->get_declared_variables())
		{
            if(type_specifier_node->get_type_specifier() == SYMBOLTYPE::VOID)
			{
				error_void_variable(@1.first_line, var->get_lexeme());
			}
			else
			{
				SymbolInfo *symbol_info = symbol_table.lookup(var->get_lexeme());

				if(symbol_info == NULL_SYMBOL_INFO)
				{
					var->set_type_specifier(type_specifier_node->get_type_specifier());
					symbol_table.insert((SymbolInfo*)var);
				}
				else 
				{
					error_conflicting_type(@1.first_line, var->get_lexeme());
				}
			}
		}

	}
 	;
 		 
type_specifier	: INT
	{
		log_file << "type_specifier	: INT\n";

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::TYPE_SPECIFIER, @1.first_line, @1.last_line);
		non_terminal_node->set_production_rule("type_specifier : INT");
		non_terminal_node->set_type_specifier(SYMBOLTYPE::INT);

		TerminalNode* terminal_node = new TerminalNode(SYMBOLTYPE::INT, @1.first_line);
		terminal_node->set_symbol_info($1);

		non_terminal_node->add_child(terminal_node);
		$$ = (Node*)non_terminal_node;

	}
 	| FLOAT
	{
		log_file << "type_specifier	: FLOAT\n";

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::TYPE_SPECIFIER, @1.first_line, @1.last_line);
		non_terminal_node->set_production_rule("type_specifier : FLOAT");
		non_terminal_node->set_type_specifier(SYMBOLTYPE::FLOAT);

		TerminalNode* terminal_node = new TerminalNode(SYMBOLTYPE::FLOAT, @1.first_line);
		terminal_node->set_symbol_info($1);

		non_terminal_node->add_child(terminal_node);
		$$ = (Node*)non_terminal_node;
	}
 	| VOID
	{
		log_file << "type_specifier	: VOID\n";

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::TYPE_SPECIFIER, @1.first_line, @1.last_line);
		non_terminal_node->set_production_rule("type_specifier : VOID");
		non_terminal_node;
		non_terminal_node->set_type_specifier(SYMBOLTYPE::VOID);

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

		NonterminalNode* statement_node = (NonterminalNode*)$1;

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::STATEMENTS, @1.first_line, @1.last_line);
		non_terminal_node->set_production_rule("statements : statement");

		non_terminal_node->add_child(statement_node);

		$$ = (Node*)non_terminal_node;
	}
	| statements statement
	{
		log_file << "statements : statements statement\n";

		NonterminalNode* statement_node = (NonterminalNode*)$2;

		NonterminalNode* statements_node = (NonterminalNode*)$1;

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::STATEMENTS, @1.first_line, @2.last_line);
		non_terminal_node->set_production_rule("statements : statements statement");

		non_terminal_node->add_child(statements_node);
		non_terminal_node->add_child(statement_node);

		$$ = (Node*)non_terminal_node;
	}
	;
	   
statement : var_declaration
	{
		log_file << "statement : var_declaration\n";

		NonterminalNode* var_declaration_node = (NonterminalNode*)$1;

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::STATEMENT, @1.first_line, @1.last_line);
		non_terminal_node->set_production_rule("statement : var_declaration");

		non_terminal_node->add_child(var_declaration_node);

		$$ = (Node*)non_terminal_node;
	}
	| expression_statement
	{
		log_file << "statement : expression_statement\n";

		NonterminalNode* expression_statement_node = (NonterminalNode*)$1;

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::STATEMENT, @1.first_line, @1.last_line);
		non_terminal_node->set_production_rule("statement : expression_statement");

		non_terminal_node->add_child(expression_statement_node);

		$$ = (Node*)non_terminal_node;
	}
	| compound_statement
	{
		log_file << "statement : compound_statement\n";

		NonterminalNode* compound_statement_node = (NonterminalNode*)$1;

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::STATEMENT, @1.first_line, @1.last_line);
		non_terminal_node->set_production_rule("statement : compound_statement");

		non_terminal_node->add_child(compound_statement_node);

		$$ = (Node*)non_terminal_node;
	}
	| FOR LPAREN expression_statement expression_statement expression RPAREN statement
	{
		log_file << "statement : FOR LPAREN expression_statement expression_statement expression RPAREN statement\n";

		NonterminalNode* statement_node = (NonterminalNode*)$7;

		TerminalNode* rparen_node = new TerminalNode(SYMBOLTYPE::RPAREN, @6.first_line);
		rparen_node->set_symbol_info($6);

		TypedNonterminalNode* expression_node = (TypedNonterminalNode*)$5;

		NonterminalNode* expression_statement_node2 = (NonterminalNode*)$4;

		NonterminalNode* expression_statement_node1 = (NonterminalNode*)$3;

		TerminalNode* lparen_node = new TerminalNode(SYMBOLTYPE::LPAREN, @2.first_line);
		lparen_node->set_symbol_info($2);

		TerminalNode* for_node = new TerminalNode(SYMBOLTYPE::FOR, @1.first_line);
		for_node->set_symbol_info($1);

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::STATEMENT, @1.first_line, @7.last_line);
		non_terminal_node->set_production_rule("statement : FOR LPAREN expression_statement expression_statement expression RPAREN statement");

		non_terminal_node->add_child(for_node);
		non_terminal_node->add_child(lparen_node);
		non_terminal_node->add_child(expression_statement_node1);
		non_terminal_node->add_child(expression_statement_node2);
		non_terminal_node->add_child(expression_node);
		non_terminal_node->add_child(rparen_node);
		non_terminal_node->add_child(statement_node);

		$$ = (Node*)non_terminal_node;
	}
	| IF LPAREN expression RPAREN statement
	{
		log_file << "statement : IF LPAREN expression RPAREN statement\n";

		NonterminalNode* statement_node = (NonterminalNode*)$5;

		TerminalNode* rparen_node = new TerminalNode(SYMBOLTYPE::RPAREN, @4.first_line);
		rparen_node->set_symbol_info($4);

		TypedNonterminalNode* expression_node = (TypedNonterminalNode*)$3;

		TerminalNode* lparen_node = new TerminalNode(SYMBOLTYPE::LPAREN, @2.first_line);
		lparen_node->set_symbol_info($2);

		TerminalNode* if_node = new TerminalNode(SYMBOLTYPE::IF, @1.first_line);
		if_node->set_symbol_info($1);

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::STATEMENT, @1.first_line, @5.last_line);
		non_terminal_node->set_production_rule("statement : IF LPAREN expression RPAREN statement");

		non_terminal_node->add_child(if_node);
		non_terminal_node->add_child(lparen_node);
		non_terminal_node->add_child(expression_node);
		non_terminal_node->add_child(rparen_node);
		non_terminal_node->add_child(statement_node);

		$$ = (Node*)non_terminal_node;

		if(expression_node->get_type_specifier() == SYMBOLTYPE::VOID)
		{
			error_default(@3.first_line, "void expression cannot b e in a if statement");
		}
	}
	| IF LPAREN expression RPAREN statement ELSE statement
	{
		log_file << "statement : IF LPAREN expression RPAREN statement ELSE statement\n";

		NonterminalNode* statement_node2 = (NonterminalNode*)$7;

		TerminalNode* else_node = new TerminalNode(SYMBOLTYPE::ELSE, @6.first_line);
		else_node->set_symbol_info($6);

		NonterminalNode* statement_node1 = (NonterminalNode*)$5;

		TerminalNode* rparen_node = new TerminalNode(SYMBOLTYPE::RPAREN, @4.first_line);
		rparen_node->set_symbol_info($4);

		TypedNonterminalNode* expression_node = (TypedNonterminalNode*)$3;

		TerminalNode* lparen_node = new TerminalNode(SYMBOLTYPE::LPAREN, @2.first_line);
		lparen_node->set_symbol_info($2);

		TerminalNode* if_node = new TerminalNode(SYMBOLTYPE::IF, @1.first_line);
		if_node->set_symbol_info($1);

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::STATEMENT, @1.first_line, @7.last_line);
		non_terminal_node->set_production_rule("statement : IF LPAREN expression RPAREN statement ELSE statement");

		non_terminal_node->add_child(if_node);
		non_terminal_node->add_child(lparen_node);
		non_terminal_node->add_child(expression_node);
		non_terminal_node->add_child(rparen_node);
		non_terminal_node->add_child(statement_node1);
		non_terminal_node->add_child(else_node);
		non_terminal_node->add_child(statement_node2);

		$$ = (Node*)non_terminal_node;

		if(expression_node->get_type_specifier() == SYMBOLTYPE::VOID)
		{
			error_default(@3.first_line, "void expression cannot b e in a if statement");
		}
	}
	| WHILE LPAREN expression RPAREN statement
	{
		log_file << "statement : WHILE LPAREN expression RPAREN statement\n";

		NonterminalNode* statement_node = (NonterminalNode*)$5;

		TerminalNode* rparen_node = new TerminalNode(SYMBOLTYPE::RPAREN, @4.first_line);
		rparen_node->set_symbol_info($4);

		TypedNonterminalNode* expression_node = (TypedNonterminalNode*)$3;

		TerminalNode* lparen_node = new TerminalNode(SYMBOLTYPE::LPAREN, @2.first_line);
		lparen_node->set_symbol_info($2);

		TerminalNode* while_node = new TerminalNode(SYMBOLTYPE::WHILE, @1.first_line);
		while_node->set_symbol_info($1);

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::STATEMENT, @1.first_line, @5.last_line);
		non_terminal_node->set_production_rule("statement : WHILE LPAREN expression RPAREN statement");

		non_terminal_node->add_child(while_node);
		non_terminal_node->add_child(lparen_node);
		non_terminal_node->add_child(expression_node);
		non_terminal_node->add_child(rparen_node);
		non_terminal_node->add_child(statement_node);

		$$ = (Node*)non_terminal_node;

		if(expression_node->get_type_specifier() == SYMBOLTYPE::VOID)
		{
			error_default(@3.first_line, "void expression cannot b e in a while statement");
		}
	}
	| PRINTLN LPAREN ID RPAREN SEMICOLON
	{
		log_file << "statement : PRINTLN LPAREN ID RPAREN SEMICOLON\n";

		TerminalNode* semicolon_node = new TerminalNode(SYMBOLTYPE::SEMICOLON, @5.first_line);
		semicolon_node->set_symbol_info($5);

		TerminalNode* rparen_node = new TerminalNode(SYMBOLTYPE::RPAREN, @4.first_line);
		rparen_node->set_symbol_info($4);

		TerminalNode* id_node = new TerminalNode(SYMBOLTYPE::ID, @3.first_line);
		//todo: check if ID is declared and set symbol info
		id_node->set_symbol_info($3);

		TerminalNode* lparen_node = new TerminalNode(SYMBOLTYPE::LPAREN, @2.first_line);
		lparen_node->set_symbol_info($2);

		TerminalNode* println_node = new TerminalNode(SYMBOLTYPE::PRINTLN, @1.first_line);
		println_node->set_symbol_info($1);

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::STATEMENT, @1.first_line, @5.last_line);
		non_terminal_node->set_production_rule("statement : PRINTLN LPAREN ID RPAREN SEMICOLON");

		non_terminal_node->add_child(println_node);
		non_terminal_node->add_child(lparen_node);
		non_terminal_node->add_child(id_node);
		non_terminal_node->add_child(rparen_node);
		non_terminal_node->add_child(semicolon_node);

		$$ = (Node*)non_terminal_node;

		SymbolInfo* symbol_info = symbol_table.lookup($3->get_lexeme());
		if(symbol_info == NULL_SYMBOL_INFO)
		{
			error_undeclared_variable(@3.first_line, $3->get_lexeme());
		}
	}
	| RETURN expression SEMICOLON
	{
		log_file << "statement : RETURN expression SEMICOLON\n";

		TerminalNode* semicolon_node = new TerminalNode(SYMBOLTYPE::SEMICOLON, @3.first_line);
		semicolon_node->set_symbol_info($3);

		TypedNonterminalNode* expression_node = (TypedNonterminalNode*)$2;

		TerminalNode* return_node = new TerminalNode(SYMBOLTYPE::RETURN, @1.first_line);
		return_node->set_symbol_info($1);

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::STATEMENT, @1.first_line, @3.last_line);
		non_terminal_node->set_production_rule("statement : RETURN expression SEMICOLON");

		non_terminal_node->add_child(return_node);
		non_terminal_node->add_child(expression_node);
		non_terminal_node->add_child(semicolon_node);

		$$ = (Node*)non_terminal_node;

		if(expression_node->get_type_specifier() == SYMBOLTYPE::VOID)
		{
			error_default(@2.first_line, "void expression cannot b e in a return statement");
		}
	}
	;
	  
expression_statement : SEMICOLON			
	{
		log_file << "expression_statement : SEMICOLON\n";

		TerminalNode* semicolon_node = new TerminalNode(SYMBOLTYPE::SEMICOLON, @1.first_line);
		semicolon_node->set_symbol_info($1);

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::EXPRESSION_STATEMENT, @1.first_line, @1.last_line);
		non_terminal_node->set_production_rule("expression_statement : SEMICOLON");

		non_terminal_node->add_child(semicolon_node);

		$$ = (Node*)non_terminal_node;
	}
	| expression SEMICOLON 
	{
		log_file << "expression_statement : expression SEMICOLON\n";

		TerminalNode* semicolon_node = new TerminalNode(SYMBOLTYPE::SEMICOLON, @2.first_line);
		semicolon_node->set_symbol_info($2);

		TypedNonterminalNode* expression_node = (TypedNonterminalNode*)$1;

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::EXPRESSION_STATEMENT, @1.first_line, @2.last_line);
		non_terminal_node->set_production_rule("expression_statement : expression SEMICOLON");

		non_terminal_node->add_child(expression_node);
		non_terminal_node->add_child(semicolon_node);

		$$ = (Node*)non_terminal_node;
	}
	;
	  
variable : ID 		
	{
		log_file << "variable : ID\n";

		TerminalNode* id_node = new TerminalNode(SYMBOLTYPE::ID, @1.first_line);
		id_node->set_symbol_info($1);

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::VARIABLE, @1.first_line, @1.last_line);
		non_terminal_node->set_production_rule("variable : ID");
		SymbolInfo* symbol_info = symbol_table.lookup($1->get_lexeme());
		if(symbol_info == NULL_SYMBOL_INFO)
		{
			//error
			error_undeclared_variable( @1.first_line, $1->get_lexeme());
		}
		else if(symbol_info->get_type() == SYMBOLTYPE::FUNC_ID)
		{
			//error
		}
		else
		{
			VarInfo* var_info = (VarInfo*)symbol_info;   	
			non_terminal_node->set_type_specifier(var_info->get_type_specifier());
		}

		non_terminal_node->add_child(id_node);

		$$ = (Node*)non_terminal_node;

	}
	| ID LTHIRD expression RTHIRD 
	{
		log_file << "variable : ID LTHIRD expression RTHIRD\n";

		TerminalNode* rthird_node = new TerminalNode(SYMBOLTYPE::RTHIRD, @4.first_line);
		rthird_node->set_symbol_info($4);

		TypedNonterminalNode* expression_node = (TypedNonterminalNode*)$3;

		TerminalNode* lthird_node = new TerminalNode(SYMBOLTYPE::LTHIRD, @2.first_line);
		lthird_node->set_symbol_info($2);

		TerminalNode* id_node = new TerminalNode(SYMBOLTYPE::ID, @1.first_line);
		id_node->set_symbol_info($1);

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::VARIABLE, @1.first_line, @4.last_line);
		non_terminal_node->set_production_rule("variable : ID LTHIRD expression RTHIRD");

        SymbolInfo* symbol_info = symbol_table.lookup($1->get_lexeme());
		if(symbol_info == NULL_SYMBOL_INFO)
		{
			//error
			error_undeclared_variable( @1.first_line, $1->get_lexeme());
		}
		else if(symbol_info->get_type() == SYMBOLTYPE::FUNC_ID)
		{
			error_default(@1.first_line, "function cannot be used as an array");
		}
		else
		{
			VarInfo* var_info = (VarInfo*)symbol_info;

			if(var_info->get_array_size() < 0)
			{
				error_not_an_array(@1.first_line, $1->get_lexeme());
			}
		    	
		    non_terminal_node->set_type_specifier(var_info->get_type_specifier());
		}

		non_terminal_node->add_child(id_node);
		non_terminal_node->add_child(lthird_node);
		non_terminal_node->add_child(expression_node);
		non_terminal_node->add_child(rthird_node);

		$$ = (Node*)non_terminal_node;

		if(expression_node->get_type_specifier() != SYMBOLTYPE::INT)
		{
			//error
			error_array_index_not_integer( @3.first_line);
		}
	}
	;
	 
expression : logic_expression	
	{
		log_file << "expression : logic_expression\n";

		TypedNonterminalNode* logic_expression_node = (TypedNonterminalNode*)$1;

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::EXPRESSION, @1.first_line, @1.last_line);
		non_terminal_node->set_production_rule("expression : logic_expression");
		non_terminal_node->set_type_specifier(logic_expression_node->get_type_specifier());

		non_terminal_node->add_child(logic_expression_node);

		$$ = (Node*)non_terminal_node;
	}
	| variable ASSIGNOP logic_expression 	
	{
		log_file << "expression : variable ASSIGNOP logic_expression\n";

		TypedNonterminalNode* logic_expression_node = (TypedNonterminalNode*)$3;

		TerminalNode* assignop_node = new TerminalNode(SYMBOLTYPE::ASSIGNOP, @2.first_line);
		assignop_node->set_symbol_info($2);

		TypedNonterminalNode* variable_node = (TypedNonterminalNode*)$1;

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::EXPRESSION, @1.first_line, @3.last_line);
		non_terminal_node->set_production_rule("expression : variable ASSIGNOP logic_expression");

		//todo: check type_specifier

        if(variable_node->get_type_specifier() == SYMBOLTYPE::VOID || logic_expression_node->get_type_specifier() == SYMBOLTYPE::VOID)
		{
			error_default(@1.first_line, "void type is not allowed in assignment expression");
			non_terminal_node->set_type_specifier(SYMBOLTYPE::VOID);
		}
		else if(variable_node->get_type_specifier() == SYMBOLTYPE::INT && logic_expression_node->get_type_specifier() == SYMBOLTYPE::FLOAT)
		{
			warning_data_loss(@1.first_line, SYMBOLTYPE::FLOAT, SYMBOLTYPE::INT);
		}


		non_terminal_node->add_child(variable_node);
		non_terminal_node->add_child(assignop_node);
		non_terminal_node->add_child(logic_expression_node);

		$$ = (Node*)non_terminal_node;
	}
	;
			
logic_expression : rel_expression 	
	{
		log_file << "logic_expression : rel_expression\n";

		TypedNonterminalNode* rel_expression_node = (TypedNonterminalNode*)$1;

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::LOGIC_EXPRESSION, @1.first_line, @1.last_line);
		non_terminal_node->set_production_rule("logic_expression : rel_expression");
		non_terminal_node->set_type_specifier(rel_expression_node->get_type_specifier());

		non_terminal_node->add_child(rel_expression_node);

		$$ = (Node*)non_terminal_node;
	}
	| rel_expression LOGICOP rel_expression 	
	{
		log_file << "logic_expression : rel_expression LOGICOP rel_expression\n";

		TypedNonterminalNode* rel_expression_node2 = (TypedNonterminalNode*)$3;

		TerminalNode* logicop_node = new TerminalNode(SYMBOLTYPE::LOGICOP, @2.first_line);
		logicop_node->set_symbol_info($2);

		TypedNonterminalNode* rel_expression_node1 = (TypedNonterminalNode*)$1;

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::LOGIC_EXPRESSION, @1.first_line, @3.last_line);
		non_terminal_node->set_production_rule("logic_expression : rel_expression LOGICOP rel_expression");
		//todo: handle type_specifier 

        if(rel_expression_node1->get_type_specifier() == SYMBOLTYPE::VOID || rel_expression_node2->get_type_specifier() == SYMBOLTYPE::VOID)
		{
			error_default(@1.first_line, "void type is not allowed in logical expression");
			non_terminal_node->set_type_specifier(SYMBOLTYPE::VOID);
		}
		else if(rel_expression_node1->get_type_specifier() == SYMBOLTYPE::FLOAT || rel_expression_node2->get_type_specifier() == SYMBOLTYPE::FLOAT)
		{
			non_terminal_node->set_type_specifier(SYMBOLTYPE::FLOAT);
		}
		else
		{
			non_terminal_node->set_type_specifier(SYMBOLTYPE::INT);
		}

		non_terminal_node->add_child(rel_expression_node1);
		non_terminal_node->add_child(logicop_node);
		non_terminal_node->add_child(rel_expression_node2);

		$$ = (Node*)non_terminal_node;
	}
	;
			
rel_expression	: simple_expression 
	{
		log_file << "rel_expression	: simple_expression\n";

		TypedNonterminalNode* simple_expression_node = (TypedNonterminalNode*)$1;

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::REL_EXPRESSION, @1.first_line, @1.last_line);
		non_terminal_node->set_production_rule("rel_expression	: simple_expression");
		non_terminal_node->set_type_specifier(simple_expression_node->get_type_specifier());

		non_terminal_node->add_child(simple_expression_node);

		$$ = (Node*)non_terminal_node;
	}
	| simple_expression RELOP simple_expression	
	{
		log_file << "rel_expression	: simple_expression RELOP simple_expression\n";

		TypedNonterminalNode* simple_expression_node2 = (TypedNonterminalNode*)$3;

		TerminalNode* relop_node = new TerminalNode(SYMBOLTYPE::RELOP, @2.first_line);
		relop_node->set_symbol_info($2);

		TypedNonterminalNode* simple_expression_node1 = (TypedNonterminalNode*)$1;

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::REL_EXPRESSION, @1.first_line, @3.last_line);
		non_terminal_node->set_production_rule("rel_expression	: simple_expression RELOP simple_expression");

		//todo: handle type_specifier
    	if(simple_expression_node1->get_type_specifier() == SYMBOLTYPE::VOID || simple_expression_node2->get_type_specifier() == SYMBOLTYPE::VOID)
		{
			error_default(@1.first_line, "void type is not allowed in relational expression");
			non_terminal_node->set_type_specifier(SYMBOLTYPE::VOID);
		}
		else if(simple_expression_node1->get_type_specifier() == SYMBOLTYPE::FLOAT || simple_expression_node2->get_type_specifier() == SYMBOLTYPE::FLOAT)
		{
			non_terminal_node->set_type_specifier(SYMBOLTYPE::FLOAT);
		}
		else
		{
			non_terminal_node->set_type_specifier(SYMBOLTYPE::INT);
		}

		non_terminal_node->add_child(simple_expression_node1);
		non_terminal_node->add_child(relop_node);
		non_terminal_node->add_child(simple_expression_node2);

		$$ = (Node*)non_terminal_node;
	}
	;
				
simple_expression : term 
	{
		log_file << "simple_expression : term\n";

		TypedNonterminalNode* term_node = (TypedNonterminalNode*)$1;

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::SIMPLE_EXPRESSION, @1.first_line, @1.last_line);
		non_terminal_node->set_production_rule("simple_expression : term");
		non_terminal_node->set_type_specifier(term_node->get_type_specifier());

		non_terminal_node->add_child(term_node);

		$$ = (Node*)non_terminal_node;
	}
	| simple_expression ADDOP term 
	{
		log_file << "simple_expression : simple_expression ADDOP term\n";

		TypedNonterminalNode* term_node = (TypedNonterminalNode*)$3;

		TerminalNode* addop_node = new TerminalNode(SYMBOLTYPE::ADDOP, @2.first_line);
		addop_node->set_symbol_info($2);

		TypedNonterminalNode* simple_expression_node = (TypedNonterminalNode*)$1;

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::SIMPLE_EXPRESSION, @1.first_line, @3.last_line);
		non_terminal_node->set_production_rule("simple_expression : simple_expression ADDOP term");

		//todo: handle type_specifier
		if(simple_expression_node->get_type_specifier() == SYMBOLTYPE::VOID || term_node->get_type_specifier() == SYMBOLTYPE::VOID)
		{
			error_default(@1.first_line, "void type is not allowed in arithmetic expression");
			non_terminal_node->set_type_specifier(SYMBOLTYPE::VOID);
		}
		else if(simple_expression_node->get_type_specifier() == SYMBOLTYPE::FLOAT || term_node->get_type_specifier() == SYMBOLTYPE::FLOAT)
		{
			non_terminal_node->set_type_specifier(SYMBOLTYPE::FLOAT);
		}
		else
		{
			non_terminal_node->set_type_specifier(SYMBOLTYPE::INT);
		}
		non_terminal_node->add_child(simple_expression_node);
		non_terminal_node->add_child(addop_node);
		non_terminal_node->add_child(term_node);

		$$ = (Node*)non_terminal_node;
	}
	;
					
term :	unary_expression
	{
		log_file << "term : unary_expression\n";

		TypedNonterminalNode* unary_expression_node = (TypedNonterminalNode*)$1;

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::TERM, @1.first_line, @1.last_line);
		non_terminal_node->set_production_rule("term : unary_expression");
		non_terminal_node->set_type_specifier(unary_expression_node->get_type_specifier());

		non_terminal_node->add_child(unary_expression_node);

		$$ = (Node*)non_terminal_node;
	}
    |  term MULOP unary_expression
	{
		log_file << "term :	term MULOP unary_expression\n";

		TypedNonterminalNode* unary_expression_node = (TypedNonterminalNode*)$3;

		TerminalNode* mulop_node = new TerminalNode(SYMBOLTYPE::MULOP, @2.first_line);
		mulop_node->set_symbol_info($2);

		TypedNonterminalNode* term_node = (TypedNonterminalNode*)$1;

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::TERM, @1.first_line, @3.last_line);
		non_terminal_node->set_production_rule("term :	term MULOP unary_expression");

		// todo: handle type_specifier
		if(($2->get_lexeme() == "%") && !(term_node->get_type_specifier() == SYMBOLTYPE::INT && unary_expression_node->get_type_specifier() == SYMBOLTYPE::INT))
		{
			error_nonint_mod_op(@2.first_line);
			
		}

		else if(term_node->get_type_specifier() == SYMBOLTYPE::VOID || unary_expression_node->get_type_specifier() == SYMBOLTYPE::VOID)
		{
			error_default(@1.first_line, "void type is not allowed in arithmetic expression");
			non_terminal_node->set_type_specifier(SYMBOLTYPE::VOID);
		}
		else if(term_node->get_type_specifier() == SYMBOLTYPE::FLOAT || unary_expression_node->get_type_specifier() == SYMBOLTYPE::FLOAT)
		{
			non_terminal_node->set_type_specifier(SYMBOLTYPE::FLOAT);
		}
		else
		{
			non_terminal_node->set_type_specifier(SYMBOLTYPE::INT);
		}

		non_terminal_node->add_child(term_node);
		non_terminal_node->add_child(mulop_node);
		non_terminal_node->add_child(unary_expression_node);

		$$ = (Node*)non_terminal_node;
	}
    ;

unary_expression : ADDOP unary_expression  
	{
		log_file << "unary_expression : ADDOP unary_expression\n";

		TypedNonterminalNode* unary_expression_node = (TypedNonterminalNode*)$2;

		TerminalNode* addop_node = new TerminalNode(SYMBOLTYPE::ADDOP, @1.first_line);
		addop_node->set_symbol_info($1);

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::UNARY_EXPRESSION, @1.first_line, @2.last_line);
		non_terminal_node->set_production_rule("unary_expression : ADDOP unary_expression");
		non_terminal_node->set_type_specifier(unary_expression_node->get_type_specifier());

		non_terminal_node->add_child(addop_node);
		non_terminal_node->add_child(unary_expression_node);

		$$ = (Node*)non_terminal_node;

		//show void in expression error
		if (unary_expression_node->get_type_specifier() == SYMBOLTYPE::VOID)
		{
			error_void_in_expression(@2.first_line);
		}
	}
	| NOT unary_expression 
	{
		log_file << "unary_expression : NOT unary_expression\n";

		TypedNonterminalNode* unary_expression_node = (TypedNonterminalNode*)$2;

		TerminalNode* not_node = new TerminalNode(SYMBOLTYPE::NOT, @1.first_line);
		not_node->set_symbol_info($1);

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::UNARY_EXPRESSION, @1.first_line, @2.last_line);
		non_terminal_node->set_production_rule("unary_expression : NOT unary_expression");
		non_terminal_node->set_type_specifier(unary_expression_node->get_type_specifier());

		non_terminal_node->add_child(not_node);
		non_terminal_node->add_child(unary_expression_node);

		$$ = (Node*)non_terminal_node;
		
		if(unary_expression_node->get_type_specifier()!= SYMBOLTYPE::INT)
		{
			error_default(@2.first_line, "not expression must be int");
		}
	}
	| factor 
	{
		log_file << "unary_expression : factor\n";

		TypedNonterminalNode* factor_node = (TypedNonterminalNode*)$1;

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::UNARY_EXPRESSION, @1.first_line, @1.last_line);
		non_terminal_node->set_production_rule("unary_expression : factor");
		non_terminal_node->set_type_specifier(factor_node->get_type_specifier());

		non_terminal_node->add_child(factor_node);

		$$ = (Node*)non_terminal_node;
	}
	;
	
factor	: variable 
	{
		log_file << "factor	: variable\n";

		TypedNonterminalNode* variable_node = (TypedNonterminalNode*)$1;

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::FACTOR, @1.first_line, @1.last_line);
		non_terminal_node->set_production_rule("factor : variable");
		non_terminal_node->set_type_specifier(variable_node->get_type_specifier());

		non_terminal_node->add_child(variable_node);

		$$ = (Node*)non_terminal_node;
	}
	| ID LPAREN argument_list RPAREN
	{
		log_file << "factor	: ID LPAREN argument_list RPAREN\n";

		TerminalNode* rparen_node = new TerminalNode(SYMBOLTYPE::RPAREN, @4.first_line);
		rparen_node->set_symbol_info($4);

		ParameterListNode* argument_list_node = (ParameterListNode*)$3;

		TerminalNode* lparen_node = new TerminalNode(SYMBOLTYPE::LPAREN, @2.first_line);
		lparen_node->set_symbol_info($2);

		TerminalNode* id_node = new TerminalNode(SYMBOLTYPE::ID, @1.first_line);
		id_node->set_symbol_info($1);

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::FACTOR, @1.first_line, @4.last_line);
		non_terminal_node->set_production_rule("factor : ID LPAREN argument_list RPAREN");
		//todo: handle type_specifier

		non_terminal_node->add_child(id_node);
		non_terminal_node->add_child(lparen_node);
		non_terminal_node->add_child(argument_list_node);
		non_terminal_node->add_child(rparen_node);

		$$ = (Node*)non_terminal_node;

		SymbolInfo* symbol_info = symbol_table.lookup($1->get_lexeme());
		if(symbol_info == NULL_SYMBOL_INFO)
		{
			error_undeclared_function(@1.first_line, $1->get_lexeme());
		}
		else if(symbol_info->get_type() != SYMBOLTYPE::FUNC_ID)
		{
			error_conflicting_type(@1.first_line, $1->get_lexeme());
		}
		else
		{
			FuncInfo* func_info = (FuncInfo*)symbol_info;
			int num_of_params = func_info->get_param_type_specifiers().size();
			int num_of_args = argument_list_node->get_parameters().size();
			
			if(num_of_params > num_of_args)
			{
				error_too_few_arguments(@1.first_line, $1->get_lexeme());
			}
			else if(num_of_params < num_of_args)
			{
				error_too_many_arguments(@1.first_line, $1->get_lexeme());
			}
			else 
			{
				for(int i = 0; i < num_of_params; i++)
				{
					if(func_info->get_param_type_specifiers()[i] != argument_list_node->get_parameters()[i])
					{
						error_argument_type_mismatch(@1.first_line,i+1, $1->get_lexeme());
					}
				}
			}
		}

	}
	| LPAREN expression RPAREN
	{
		log_file << "factor	: LPAREN expression RPAREN\n";

		TerminalNode* rparen_node = new TerminalNode(SYMBOLTYPE::RPAREN, @3.first_line);
		rparen_node->set_symbol_info($3);

		TypedNonterminalNode* expression_node = (TypedNonterminalNode*)$2;

		TerminalNode* lparen_node = new TerminalNode(SYMBOLTYPE::LPAREN, @1.first_line);
		lparen_node->set_symbol_info($1);

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::FACTOR, @1.first_line, @3.last_line);
		non_terminal_node->set_production_rule("factor : LPAREN expression RPAREN");
		non_terminal_node->set_type_specifier(expression_node->get_type_specifier());

		non_terminal_node->add_child(lparen_node);
		non_terminal_node->add_child(expression_node);
		non_terminal_node->add_child(rparen_node);

		$$ = (Node*)non_terminal_node;
	}
	| CONST_INT 
	{
		log_file << "factor	: CONST_INT\n";

		TerminalNode* const_int_node = new TerminalNode(SYMBOLTYPE::CONST_INT, @1.first_line);
		const_int_node->set_symbol_info($1);

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::FACTOR, @1.first_line, @1.last_line);
		non_terminal_node->set_production_rule("factor : CONST_INT");
		non_terminal_node->set_type_specifier(SYMBOLTYPE::INT);

		non_terminal_node->add_child(const_int_node);

		$$ = (Node*)non_terminal_node;
	}
	| CONST_FLOAT
	{
		log_file << "factor	: CONST_FLOAT\n";

		TerminalNode* const_float_node = new TerminalNode(SYMBOLTYPE::CONST_FLOAT, @1.first_line);
		const_float_node->set_symbol_info($1);

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::FACTOR, @1.first_line, @1.last_line);
		non_terminal_node->set_production_rule("factor : CONST_FLOAT");
		non_terminal_node->set_type_specifier(SYMBOLTYPE::FLOAT);

		non_terminal_node->add_child(const_float_node);

		$$ = (Node*)non_terminal_node;
	}
	| variable INCOP 
	{
		log_file << "factor	: variable INCOP\n";

		TerminalNode* incop_node = new TerminalNode(SYMBOLTYPE::INCOP, @2.first_line);
		incop_node->set_symbol_info($2);

		TypedNonterminalNode* variable_node = (TypedNonterminalNode*)$1;

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::FACTOR, @1.first_line, @2.last_line);
		non_terminal_node->set_production_rule("factor : variable INCOP");
		non_terminal_node->set_type_specifier(variable_node->get_type_specifier());

		non_terminal_node->add_child(variable_node);
		non_terminal_node->add_child(incop_node);

		$$ = (Node*)non_terminal_node;
	}
	| variable DECOP
	{
		log_file << "factor	: variable DECOP\n";

		TerminalNode* decop_node = new TerminalNode(SYMBOLTYPE::DECOP, @2.first_line);
		decop_node->set_symbol_info($2);

		TypedNonterminalNode* variable_node = (TypedNonterminalNode*)$1;

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::FACTOR, @1.first_line, @2.last_line);
		non_terminal_node->set_production_rule("factor : variable DECOP");
		non_terminal_node->set_type_specifier(variable_node->get_type_specifier());

		non_terminal_node->add_child(variable_node);
		non_terminal_node->add_child(decop_node);

		$$ = (Node*)non_terminal_node;
	}
	;
	
argument_list : arguments
	{
		log_file << "argument_list : arguments\n";

		ParameterListNode* arguments_node = (ParameterListNode*)$1;

		ParameterListNode* non_terminal_node = new ParameterListNode(SYMBOLTYPE::ARGUMENT_LIST, @1.first_line, @1.last_line);
		non_terminal_node->set_production_rule("argument_list : arguments");
		non_terminal_node->set_parameters(arguments_node->get_parameters());

		non_terminal_node->add_child(arguments_node);

		$$ = (Node*)non_terminal_node;
	}
	|
	{
		log_file << "argument_list : \n";
	}
	;
	
arguments : arguments COMMA logic_expression
	{
		log_file << "arguments : arguments COMMA logic_expression\n";

		TypedNonterminalNode* logic_expression_node = (TypedNonterminalNode*)$3;

		TerminalNode* comma_node = new TerminalNode(SYMBOLTYPE::COMMA, @2.first_line);
		comma_node->set_symbol_info($2);

		ParameterListNode* arguments_node = (ParameterListNode*)$1;

		ParameterListNode* non_terminal_node = new ParameterListNode(SYMBOLTYPE::PARAMETER_LIST, @1.first_line, @3.last_line);
		non_terminal_node->set_production_rule("arguments : arguments COMMA logic_expression");
		non_terminal_node->set_parameters(arguments_node->get_parameters());
		non_terminal_node->add_parameter(logic_expression_node->get_type_specifier());

		non_terminal_node->add_child(arguments_node);
		non_terminal_node->add_child(comma_node);
		non_terminal_node->add_child(logic_expression_node);

		$$ = (Node*)non_terminal_node;
	}
	| logic_expression
	{
		log_file << "arguments : logic_expression\n";

		TypedNonterminalNode* logic_expression_node = (TypedNonterminalNode*)$1;

		ParameterListNode* non_terminal_node = new ParameterListNode(SYMBOLTYPE::PARAMETER_LIST, @1.first_line, @1.last_line);
		non_terminal_node->set_production_rule("arguments : logic_expression");
		non_terminal_node->add_parameter(logic_expression_node->get_type_specifier());

		non_terminal_node->add_child(logic_expression_node);

		$$ = (Node*)non_terminal_node;
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
