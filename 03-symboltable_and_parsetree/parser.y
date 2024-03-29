// Emitted in the header file, before the definition of YYSTYPE.
%code requires
{
  #ifndef YY_TYPEDEF_YY_SCANNER_T
  # define YY_TYPEDEF_YY_SCANNER_T
  typedef void* yyscan_t;
  #endif
  class SymbolInfo;
  class ParseTreeNode;
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
#include <bits/stdc++.h>
using namespace std;

#include "scanner.h"
#include "ParseTree.hpp"
#include "SymbolInfo.hpp"
#include "SymbolTable.hpp"
}


%code
{
	ofstream parsetree_file;
	SymbolTable symbol_table;
	vector<pair<pair<SymbolInfo*, int>, ParseTreeNode*>> var_decl_list; // first.second is the array size, -1 if not array
	vector<pair<DataType, string>> func_params;
	vector<DataType> func_arg_types;
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

// Scanner exchanged between main, yyparse and yylex.
%param {yyscan_t scanner}

%type <ParseTreeNode*> start program unit func_declaration func_definition parameter_list compound_statement var_declaration type_specifier declaration_list statements statement expression_statement variable expression logic_expression rel_expression simple_expression term unary_expression factor argument_list arguments

%token IF WHILE FOR RETURN INT FLOAT VOID LPAREN LCURL RCURL LTHIRD RTHIRD SEMICOLON COMMA PRINTLN 
%token <SymbolInfo*> ID CONST_INT CONST_FLOAT

%precedence RPAREN
%precedence ELSE

%right  ASSIGNOP
%left <SymbolInfo*> LOGICOP
%left  <SymbolInfo*> RELOP
%left  <SymbolInfo*> ADDOP
%left  <SymbolInfo*> MULOP
%right  NOT
%right  INCOP DECOP


%%
// Rules.
start : program
	{
		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("start : program");
		$$->add_child($1);

		ParseTreeNode::print_parsetree(parsetree_file,$$, 0);
	}
	;

program : 
	program unit 
	{
		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("program : program unit");
		$$->add_child($1)->add_child($2);
	}
	| 
	unit
	{
		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("program : unit");
		$$->add_child($1);
	}
	;
	
unit : 
	var_declaration
	{
		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("unit : var_declaration");
		$$->add_child($1);
	}
    | 
	func_declaration
	{
		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("unit : func_declaration");
		$$->add_child($1);
	}
    | 
	func_definition
	{
		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("unit : func_definition");
		$$->add_child($1);
	}
    ;
     
func_declaration : 
		type_specifier ID LPAREN parameter_list RPAREN SEMICOLON
		{
			ParseTreeNode* id_node = (new ParseTreeNode())->set_first_line(@2.first_line)->set_last_line(@2.last_line)->set_rule("ID : " + $2->get_lexeme());
			ParseTreeNode* lparen_node = (new ParseTreeNode())->set_first_line(@3.first_line)->set_last_line(@3.last_line)->set_rule("LPAREN : (");
			ParseTreeNode* rparen_node = (new ParseTreeNode())->set_first_line(@5.first_line)->set_last_line(@5.last_line)->set_rule("RPAREN : )");
			ParseTreeNode* semicolon_node = (new ParseTreeNode())->set_first_line(@6.first_line)->set_last_line(@6.last_line)->set_rule("SEMICOLON : ;");

			$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("func_declaration : type_specifier ID LPAREN parameter_list RPAREN SEMICOLON");
			$$->add_child($1)->add_child(id_node)->add_child(lparen_node)->add_child($4)->add_child(rparen_node)->add_child(semicolon_node);

			vector<DataType> param_types;
			for(auto param : func_params)
			{
				param_types.push_back(param.first);
			}
			FuncInfo* func_info = (new FuncInfo())->set_lexeme($2->get_lexeme())->set_type(SI_FUNC_ID)->set_return_type($1->get_data_type())->set_param_types(param_types);
			symbol_table.insert((SymbolInfo*)func_info);
			func_params.clear();
		}
		| 
		type_specifier ID LPAREN RPAREN SEMICOLON
		{
			ParseTreeNode* id_node = (new ParseTreeNode())->set_first_line(@2.first_line)->set_last_line(@2.last_line)->set_rule("ID : " + $2->get_lexeme());
			ParseTreeNode* lparen_node = (new ParseTreeNode())->set_first_line(@3.first_line)->set_last_line(@3.last_line)->set_rule("LPAREN : (");
			ParseTreeNode* rparen_node = (new ParseTreeNode())->set_first_line(@4.first_line)->set_last_line(@4.last_line)->set_rule("RPAREN : )");
			ParseTreeNode* semicolon_node = (new ParseTreeNode())->set_first_line(@5.first_line)->set_last_line(@5.last_line)->set_rule("SEMICOLON : ;");

			$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("func_declaration : type_specifier ID LPAREN RPAREN SEMICOLON");
			$$->add_child($1)->add_child(id_node)->add_child(lparen_node)->add_child(rparen_node)->add_child(semicolon_node);

			FuncInfo* func_info = (new FuncInfo())->set_lexeme($2->get_lexeme())->set_type(SI_FUNC_ID)->set_return_type($1->get_data_type());
			symbol_table.insert((SymbolInfo*)func_info);
		}
		;
		 
func_definition : 
	type_specifier ID LPAREN parameter_list RPAREN compound_statement
	{
		ParseTreeNode* id_node = (new ParseTreeNode())->set_first_line(@2.first_line)->set_last_line(@2.last_line)->set_rule("ID : " + $2->get_lexeme());
		ParseTreeNode* lparen_node = (new ParseTreeNode())->set_first_line(@3.first_line)->set_last_line(@3.last_line)->set_rule("LPAREN : (");
		ParseTreeNode* rparen_node = (new ParseTreeNode())->set_first_line(@5.first_line)->set_last_line(@5.last_line)->set_rule("RPAREN : )");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement");
		$$->add_child($1)->add_child(id_node)->add_child(lparen_node)->add_child($4)->add_child(rparen_node)->add_child($6);

		vector<DataType> param_types;
		for(auto param: func_params)
		{
			param_types.push_back(param.first);
		}
		FuncInfo* func_info = (new FuncInfo())->set_lexeme($2->get_lexeme())->set_type(SI_FUNC_ID)->set_return_type($1->get_data_type())->set_param_types(param_types);
		symbol_table.insert((SymbolInfo*)func_info);

	}
	| 
	type_specifier ID LPAREN RPAREN compound_statement
	{
		ParseTreeNode* id_node = (new ParseTreeNode())->set_first_line(@2.first_line)->set_last_line(@2.last_line)->set_rule("ID : " + $2->get_lexeme());
		ParseTreeNode* lparen_node = (new ParseTreeNode())->set_first_line(@3.first_line)->set_last_line(@3.last_line)->set_rule("LPAREN : (");
		ParseTreeNode* rparen_node = (new ParseTreeNode())->set_first_line(@4.first_line)->set_last_line(@4.last_line)->set_rule("RPAREN : )");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("func_definition : type_specifier ID LPAREN RPAREN compound_statement");
		$$->add_child($1)->add_child(id_node)->add_child(lparen_node)->add_child(rparen_node)->add_child($5);

		FuncInfo* func_info = (new FuncInfo())->set_lexeme($2->get_lexeme())->set_type(SI_FUNC_ID)->set_return_type($1->get_data_type());
		symbol_table.insert((SymbolInfo*)func_info);
	}
 	;				


parameter_list  : 
		parameter_list COMMA type_specifier ID
		{
			ParseTreeNode* comma_node = (new ParseTreeNode())->set_first_line(@2.first_line)->set_last_line(@2.last_line)->set_rule("COMMA : ,");
			ParseTreeNode* id_node = (new ParseTreeNode())->set_first_line(@4.first_line)->set_last_line(@4.last_line)->set_data_type($3->get_data_type())->set_rule("ID : " + $4->get_lexeme());

			$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("parameter_list  : parameter_list COMMA type_specifier ID");
			$$->add_child($1)->add_child(comma_node)->add_child($3)->add_child(id_node);

			func_params.push_back({$3->get_data_type(), $4->get_lexeme()});
		}
		| 
		parameter_list COMMA type_specifier
		{
			ParseTreeNode* comma_node = (new ParseTreeNode())->set_first_line(@2.first_line)->set_last_line(@2.last_line)->set_rule("COMMA : ,");

			$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("parameter_list  : parameter_list COMMA type_specifier");
			$$->add_child($1)->add_child(comma_node)->add_child($3);

			func_params.push_back({$3->get_data_type(), ""});
		}
 		| 
		type_specifier ID
		{
			ParseTreeNode* id_node = (new ParseTreeNode())->set_first_line(@2.first_line)->set_last_line(@2.last_line)->set_data_type($1->get_data_type())->set_rule("ID : " + $2->get_lexeme());

			$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("parameter_list  : type_specifier ID");
			$$->add_child($1)->add_child(id_node);

			func_params.push_back({$1->get_data_type(), $2->get_lexeme()});
		}
		| 
		type_specifier
		{
			$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("parameter_list  : type_specifier");
			$$->add_child($1);

			func_params.push_back({$1->get_data_type(), ""});
		}
 		;

 		
compound_statement : 
	LCURL 
	{
		symbol_table.enter_scope();
		cout<<"Entering scope: "<<(symbol_table.get_current_scope()->get_scope_id())<<"\n";
		cout<<symbol_table<<"\n";

		if(func_params.size() > 0)
		{
			for(auto param: func_params)
			{
				VarInfo* var_info = (new VarInfo())->set_lexeme(param.second)->set_type(SI_VAR_ID)->set_data_type(param.first);
				symbol_table.insert((SymbolInfo*)var_info);
			}
			func_params.clear();
		}
	}
	statements RCURL
	{
		ParseTreeNode* lcurl_node = (new ParseTreeNode())->set_first_line(@1.first_line)->set_last_line(@1.last_line)->set_rule("LCURL : {");
		ParseTreeNode* rcurl_node = (new ParseTreeNode())->set_first_line(@4.first_line)->set_last_line(@4.last_line)->set_rule("RCURL : }");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("compound_statement : LCURL statements RCURL");
		$$->add_child(lcurl_node)->add_child($3)->add_child(rcurl_node);

		cout << symbol_table;
		cout << "Exiting scope: " << (symbol_table.get_current_scope()->get_scope_id()) << "\n\n";
		symbol_table.exit_scope();
	}
 	| 
	LCURL RCURL
	{
		ParseTreeNode* lcurl_node = (new ParseTreeNode())->set_first_line(@1.first_line)->set_last_line(@1.last_line)->set_rule("LCURL : {");
		ParseTreeNode* rcurl_node = (new ParseTreeNode())->set_first_line(@2.first_line)->set_last_line(@2.last_line)->set_rule("RCURL : }");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("compound_statement : LCURL RCURL");
		$$->add_child(lcurl_node)->add_child(rcurl_node);
	}
 	;

var_declaration : 
	type_specifier declaration_list SEMICOLON
	{
		ParseTreeNode* semi_colon_node = (new ParseTreeNode())->set_first_line(@3.first_line)->set_last_line(@3.last_line)->set_rule("SEMICOLON : ;");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("var_declaration : type_specifier declaration_list SEMICOLON");
		$$->add_child($1)->add_child($2)->add_child(semi_colon_node);

		for(auto var : var_decl_list)
		{
			var.second->set_data_type($1->get_data_type());
			VarInfo* var_info = (new VarInfo())->set_lexeme(var.first.first->get_lexeme())->set_type(TokenType::SI_VAR_ID)->set_data_type($1->get_data_type())->set_array_size(var.first.second);
			symbol_table.insert((SymbolInfo*)var_info);
		}
		var_decl_list.clear();
	}
 	;
 		 
type_specifier	: INT 
	{
		ParseTreeNode* int_node = (new ParseTreeNode())->set_first_line(@1.first_line)->set_last_line(@1.last_line)->set_data_type(DataType::INT)->set_rule("INT : int");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type(DataType::INT)->set_rule("type_specifier : INT")->add_child(int_node);

	}
 	| FLOAT
	{
		ParseTreeNode* float_node = (new ParseTreeNode())->set_first_line(@1.first_line)->set_last_line(@1.last_line)->set_data_type(DataType::FLOAT)->set_rule("FLOAT : float");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type(DataType::FLOAT)->set_rule("type_specifier : FLOAT")->add_child(float_node);
	}
 	| VOID
	{
		ParseTreeNode* void_node = (new ParseTreeNode())->set_first_line(@1.first_line)->set_last_line(@1.last_line)->set_data_type(DataType::VOID)->set_rule("VOID : void");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type(DataType::VOID)->set_rule("type_specifier : VOID")->add_child(void_node);
	}
 	;
 		
declaration_list : declaration_list COMMA ID
	{
		ParseTreeNode* comma_node = (new ParseTreeNode())->set_first_line(@1.first_line)->set_last_line(@1.last_line)->set_rule("COMMA : ,");
		ParseTreeNode* id_node = (new ParseTreeNode())->set_first_line(@3.first_line)->set_last_line(@3.last_line)->set_rule("ID : "+$3->get_lexeme());

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("declaration_list : declaration_list COMMA ID");
		$$->add_child($1)->add_child(comma_node)->add_child(id_node);

		var_decl_list.push_back({{$3, -1}, id_node});
	}
 	| declaration_list COMMA ID LTHIRD CONST_INT RTHIRD
	{
		ParseTreeNode* comma_node = (new ParseTreeNode())->set_first_line(@2.first_line)->set_last_line(@2.last_line)->set_rule("COMMA : ,");
		ParseTreeNode* id_node = (new ParseTreeNode())->set_first_line(@3.first_line)->set_last_line(@3.last_line)->set_rule("ID : "+$3->get_lexeme());
		ParseTreeNode* lthird_node = (new ParseTreeNode())->set_first_line(@4.first_line)->set_last_line(@4.last_line)->set_rule("LTHIRD : [");
		ParseTreeNode* const_int_node = (new ParseTreeNode())->set_first_line(@5.first_line)->set_last_line(@5.last_line)->set_rule("CONST_INT : "+$5->get_lexeme());
		ParseTreeNode* rthird_node = (new ParseTreeNode())->set_first_line(@6.first_line)->set_last_line(@6.last_line)->set_rule("RTHIRD : ]");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("declaration_list : declaration_list COMMA ID LTHIRD CONST_INT RTHIRD");
		$$->add_child($1)->add_child(comma_node)->add_child(id_node)->add_child(lthird_node)->add_child(const_int_node)->add_child(rthird_node);

		var_decl_list.push_back({{$3, stoi($5->get_lexeme())}, id_node});
	}
 	| ID 
	{
		ParseTreeNode* id_node = (new ParseTreeNode())->set_first_line(@1.first_line)->set_last_line(@1.last_line)->set_rule("ID : "+$1->get_lexeme());

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("declaration_list : ID");
		$$->add_child(id_node);

		var_decl_list.push_back({{$1, -1}, id_node});
	}
 	| ID LTHIRD CONST_INT RTHIRD
	{
		ParseTreeNode* id_node = (new ParseTreeNode())->set_first_line(@1.first_line)->set_last_line(@1.last_line)->set_rule("ID : "+$1->get_lexeme());
		ParseTreeNode* lthird_node = (new ParseTreeNode())->set_first_line(@2.first_line)->set_last_line(@2.last_line)->set_rule("LTHIRD : [");
		ParseTreeNode* const_int_node = (new ParseTreeNode())->set_first_line(@3.first_line)->set_last_line(@3.last_line)->set_rule("CONST_INT : "+$3->get_lexeme());
		ParseTreeNode* rthird_node = (new ParseTreeNode())->set_first_line(@4.first_line)->set_last_line(@4.last_line)->set_rule("RTHIRD : ]");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("declaration_list : ID LTHIRD CONST_INT RTHIRD");
		$$->add_child(id_node)->add_child(lthird_node)->add_child(const_int_node)->add_child(rthird_node);

		var_decl_list.push_back({{$1, stoi($3->get_lexeme())}, id_node});
	}
 	;
 		  
statements : 
	statement
	{
		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("statements : statement");
		$$->add_child($1);
	}
	| 
	statements statement
	{
		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("statements : statements statement");
		$$->add_child($1)->add_child($2);
	}
	;
	   
statement : 
	var_declaration
	{
		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("statement : var_declaration");
		$$->add_child($1);
	}
	|
	expression_statement
	{
		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("statement : expression_statement");
		$$->add_child($1);
	}
	| 
	compound_statement
	{
		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("statement : compound_statement");
		$$->add_child($1);
	}
	| 
	FOR LPAREN expression_statement expression_statement expression RPAREN statement
	{
		ParseTreeNode* for_node = (new ParseTreeNode())->set_first_line(@1.first_line)->set_last_line(@1.last_line)->set_rule("FOR : for");
		ParseTreeNode* lparen_node = (new ParseTreeNode())->set_first_line(@2.first_line)->set_last_line(@2.last_line)->set_rule("LPAREN : (");
		ParseTreeNode* rparen_node = (new ParseTreeNode())->set_first_line(@6.first_line)->set_last_line(@6.last_line)->set_rule("RPAREN : )");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("statement : FOR LPAREN expression_statement expression_statement expression RPAREN statement");
		$$->add_child(for_node)->add_child(lparen_node)->add_child($3)->add_child($4)->add_child($5)->add_child(rparen_node)->add_child($7);
	}
	| 
	IF LPAREN expression RPAREN statement
	{
		ParseTreeNode* if_node = (new ParseTreeNode())->set_first_line(@1.first_line)->set_last_line(@1.last_line)->set_rule("IF : if");
		ParseTreeNode* lparen_node = (new ParseTreeNode())->set_first_line(@2.first_line)->set_last_line(@2.last_line)->set_rule("LPAREN : (");
		ParseTreeNode* rparen_node = (new ParseTreeNode())->set_first_line(@4.first_line)->set_last_line(@4.last_line)->set_rule("RPAREN : )");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("statement : IF LPAREN expression RPAREN statement");
		$$->add_child(if_node)->add_child(lparen_node)->add_child($3)->add_child(rparen_node)->add_child($5);
	}
	| 
	IF LPAREN expression RPAREN statement ELSE statement
	{
		ParseTreeNode* if_node = (new ParseTreeNode())->set_first_line(@1.first_line)->set_last_line(@1.last_line)->set_rule("IF : if");
		ParseTreeNode* lparen_node = (new ParseTreeNode())->set_first_line(@2.first_line)->set_last_line(@2.last_line)->set_rule("LPAREN : (");
		ParseTreeNode* rparen_node = (new ParseTreeNode())->set_first_line(@4.first_line)->set_last_line(@4.last_line)->set_rule("RPAREN : )");
		ParseTreeNode* else_node = (new ParseTreeNode())->set_first_line(@6.first_line)->set_last_line(@6.last_line)->set_rule("ELSE : else");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("statement : IF LPAREN expression RPAREN statement ELSE statement");
		$$->add_child(if_node)->add_child(lparen_node)->add_child($3)->add_child(rparen_node)->add_child($5)->add_child(else_node)->add_child($7);
	}
	| 
	WHILE LPAREN expression RPAREN statement
	{
		ParseTreeNode* while_node = (new ParseTreeNode())->set_first_line(@1.first_line)->set_last_line(@1.last_line)->set_rule("WHILE : while");
		ParseTreeNode* lparen_node = (new ParseTreeNode())->set_first_line(@2.first_line)->set_last_line(@2.last_line)->set_rule("LPAREN : (");
		ParseTreeNode* rparen_node = (new ParseTreeNode())->set_first_line(@4.first_line)->set_last_line(@4.last_line)->set_rule("RPAREN : )");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("statement : WHILE LPAREN expression RPAREN statement");
		$$->add_child(while_node)->add_child(lparen_node)->add_child($3)->add_child(rparen_node)->add_child($5);
	}
	| 
	PRINTLN LPAREN ID RPAREN SEMICOLON
	{
		ParseTreeNode* println_node = (new ParseTreeNode())->set_first_line(@1.first_line)->set_last_line(@1.last_line)->set_rule("PRINTLN : println");
		ParseTreeNode* lparen_node = (new ParseTreeNode())->set_first_line(@2.first_line)->set_last_line(@2.last_line)->set_rule("LPAREN : (");
		ParseTreeNode* id_node = (new ParseTreeNode())->set_first_line(@3.first_line)->set_last_line(@3.last_line)->set_rule("ID : " + $3->get_lexeme());
		ParseTreeNode* rparen_node = (new ParseTreeNode())->set_first_line(@4.first_line)->set_last_line(@4.last_line)->set_rule("RPAREN : )");
		ParseTreeNode* semicolon_node = (new ParseTreeNode())->set_first_line(@5.first_line)->set_last_line(@5.last_line)->set_rule("SEMICOLON : ;");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("statement : PRINTLN LPAREN ID RPAREN SEMICOLON");
		$$->add_child(println_node)->add_child(lparen_node)->add_child(id_node)->add_child(rparen_node)->add_child(semicolon_node);
	}
	| 
	RETURN expression SEMICOLON
	{
		ParseTreeNode* return_node = (new ParseTreeNode())->set_first_line(@1.first_line)->set_last_line(@1.last_line)->set_rule("RETURN : return");
		ParseTreeNode* semicolon_node = (new ParseTreeNode())->set_first_line(@3.first_line)->set_last_line(@3.last_line)->set_rule("SEMICOLON : ;");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("statement : RETURN expression SEMICOLON");
		$$->add_child(return_node)->add_child($2)->add_child(semicolon_node);
	}
	;
	  
expression_statement : 
	SEMICOLON
	{
		ParseTreeNode* semicolon_node = (new ParseTreeNode())->set_first_line(@1.first_line)->set_last_line(@1.last_line)->set_rule("SEMICOLON : ;");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("expression_statement : SEMICOLON");
		$$->add_child(semicolon_node);
	}			
	| 
	expression SEMICOLON 
	{
		ParseTreeNode* semicolon_node = (new ParseTreeNode())->set_first_line(@2.first_line)->set_last_line(@2.last_line)->set_rule("SEMICOLON : ;");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("expression_statement : expression SEMICOLON");
		$$->add_child($1)->add_child(semicolon_node);
	}
	;
	  
variable : 
	ID
	{
		VarInfo* var_info = (VarInfo*)symbol_table.lookup($1->get_lexeme());
		ParseTreeNode* id_node = (new ParseTreeNode())->set_first_line(@1.first_line)->set_last_line(@1.last_line)->set_data_type(var_info->get_data_type())->set_rule("ID : "+$1->get_lexeme());

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("variable : ID");
		$$->add_child(id_node);
	} 		
	| 
	ID LTHIRD expression RTHIRD 
	{
        VarInfo* var_info = (VarInfo*)symbol_table.lookup($1->get_lexeme());
		ParseTreeNode* id_node = (new ParseTreeNode())->set_first_line(@1.first_line)->set_last_line(@1.last_line)->set_data_type(var_info->get_data_type())->set_rule("ID : "+$1->get_lexeme());
		ParseTreeNode* lthird_node = (new ParseTreeNode())->set_first_line(@2.first_line)->set_last_line(@2.last_line)->set_rule("LTHIRD : [");
		ParseTreeNode* rthird_node = (new ParseTreeNode())->set_first_line(@4.first_line)->set_last_line(@4.last_line)->set_rule("RTHIRD : ]");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("variable : ID LTHIRD expression RTHIRD");
		$$->add_child(id_node)->add_child(lthird_node)->add_child($3)->add_child(rthird_node);
	}
	;
	 
expression : 
	logic_expression	
	{
		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type($1->get_data_type())->set_rule("expression : logic_expression");
		$$->add_child($1);
	}
	| 
	variable ASSIGNOP logic_expression 	
	{
		ParseTreeNode* assignop_node = (new ParseTreeNode())->set_first_line(@2.first_line)->set_last_line(@2.last_line)->set_rule("ASSIGNOP : =");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type($1->get_data_type())->set_rule("expression : variable ASSIGNOP logic_expression");
		$$->add_child($1)->add_child(assignop_node)->add_child($3);
	}
	;
			
logic_expression : 
	rel_expression 	
	{
		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type($1->get_data_type())->set_rule("logic_expression : rel_expression");
		$$->add_child($1);
	}
	| 
	rel_expression LOGICOP rel_expression 	
	{
		ParseTreeNode* logicop_node = (new ParseTreeNode())->set_first_line(@2.first_line)->set_last_line(@2.last_line)->set_rule("LOGICOP : "+$2->get_lexeme());

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type($1->get_data_type())->set_rule("logic_expression : rel_expression LOGICOP rel_expression");
		$$->add_child($1)->add_child(logicop_node)->add_child($3);
	}
	;
			
rel_expression	: 
	simple_expression 
	{
		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type($1->get_data_type())->set_rule("rel_expression : simple_expression");
		$$->add_child($1);
	}
	| 
	simple_expression RELOP simple_expression	
	{
		ParseTreeNode* relop_node = (new ParseTreeNode())->set_first_line(@2.first_line)->set_last_line(@2.last_line)->set_rule("RELOP : "+$2->get_lexeme());

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type($1->get_data_type())->set_rule("rel_expression : simple_expression RELOP simple_expression");
		$$->add_child($1)->add_child(relop_node)->add_child($3);
	}
	;
				
simple_expression : 
	term
	{
		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type($1->get_data_type())->set_rule("simple_expression : term");
		$$->add_child($1);
	} 
	| simple_expression ADDOP term 
	{
		ParseTreeNode* add_node = (new ParseTreeNode())->set_first_line(@2.first_line)->set_last_line(@2.last_line)->set_rule("ADDOP : +");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type($1->get_data_type())->set_rule("simple_expression : simple_expression ADDOP term");
		$$->add_child($1)->add_child(add_node)->add_child($3);
	}
	;
					
term :	
	unary_expression
	{
		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type($1->get_data_type())->set_rule("term : unary_expression");
		$$->add_child($1);
	}
    |  
	term MULOP unary_expression
	{
		ParseTreeNode* mul_node = (new ParseTreeNode())->set_first_line(@2.first_line)->set_last_line(@2.last_line)->set_rule("MULOP : *");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type($1->get_data_type())->set_rule("term : term MULOP unary_expression");
		$$->add_child($1)->add_child(mul_node)->add_child($3);
	}
    ;

unary_expression : 
	ADDOP unary_expression 
	{
		ParseTreeNode* add_node = (new ParseTreeNode())->set_first_line(@1.first_line)->set_last_line(@1.last_line)->set_rule("ADDOP : +");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type($2->get_data_type())->set_rule("unary_expression : ADDOP unary_expression");
		$$->add_child(add_node)->add_child($2);
	} 
	| 
	NOT unary_expression 
	{
		ParseTreeNode* not_node = (new ParseTreeNode())->set_first_line(@1.first_line)->set_last_line(@1.last_line)->set_rule("NOT : !");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type($2->get_data_type())->set_rule("unary_expression : NOT unary_expression");
		$$->add_child(not_node)->add_child($2);
	}
	|
	factor 
	{
		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type($1->get_data_type())->set_rule("unary_expression : factor");
		$$->add_child($1);
	}
	;
	
factor	: 
	variable
	{
		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type($1->get_data_type())->set_rule("factor : variable");
		$$->add_child($1);
	}
	| 
	ID LPAREN argument_list RPAREN
	{
		ParseTreeNode* id_node = (new ParseTreeNode())->set_first_line(@1.first_line)->set_last_line(@1.last_line)->set_rule("ID : "+$1->get_lexeme());
		ParseTreeNode* lparen_node = (new ParseTreeNode())->set_first_line(@2.first_line)->set_last_line(@2.last_line)->set_rule("LPAREN : (");
		ParseTreeNode* rparen_node = (new ParseTreeNode())->set_first_line(@4.first_line)->set_last_line(@4.last_line)->set_rule("RPAREN : )");

		FuncInfo* func_info = (FuncInfo*)symbol_table.lookup($1->get_lexeme());
		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type(func_info->get_return_type())->set_rule("factor : ID LPAREN argument_list RPAREN");
		$$->add_child(id_node)->add_child(lparen_node)->add_child($3)->add_child(rparen_node);
	}
	| 
	LPAREN expression RPAREN
	{
		ParseTreeNode* lparen_node = (new ParseTreeNode())->set_first_line(@1.first_line)->set_last_line(@1.last_line)->set_rule("LPAREN : (");
		ParseTreeNode* rparen_node = (new ParseTreeNode())->set_first_line(@3.first_line)->set_last_line(@3.last_line)->set_rule("RPAREN : )");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type($2->get_data_type())->set_data_type($2->get_data_type())->set_rule("factor : LPAREN expression RPAREN");
		$$->add_child(lparen_node)->add_child($2)->add_child(rparen_node);
	}
	| 
	CONST_INT 
	{
		ParseTreeNode* const_int_node = (new ParseTreeNode())->set_first_line(@1.first_line)->set_last_line(@1.last_line)->set_data_type(DataType::INT)->set_rule("CONST_INT : "+$1->get_lexeme());

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type(DataType::INT)->set_rule("factor : CONST_INT");
		$$->add_child(const_int_node);
	}
	| 
	CONST_FLOAT
	{
		ParseTreeNode* const_float_node = (new ParseTreeNode())->set_first_line(@1.first_line)->set_last_line(@1.last_line)->set_data_type(DataType::FLOAT)->set_rule("CONST_FLOAT : "+$1->get_lexeme());

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type(DataType::FLOAT)->set_rule("factor : CONST_FLOAT");
		$$->add_child(const_float_node);
	}
	| 
	variable INCOP 
	{
		ParseTreeNode* incop_node = (new ParseTreeNode())->set_first_line(@2.first_line)->set_last_line(@2.last_line)->set_rule("INCOP : ++");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type($1->get_data_type())->set_rule("factor : variable INCOP");
		$$->add_child($1)->add_child(incop_node);
	}
	| 
	variable DECOP
	{
		ParseTreeNode* decop_node = (new ParseTreeNode())->set_first_line(@2.first_line)->set_last_line(@2.last_line)->set_rule("DECOP : --");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type($1->get_data_type())->set_rule("factor : variable DECOP");
		$$->add_child($1)->add_child(decop_node);
	}
	;
	
argument_list : 
	arguments
	{
		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("argument_list : arguments");
		$$->add_child($1);
	}
	|
	{
		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("argument_list : ");
	}
	;
	
arguments : 
	arguments COMMA logic_expression
	{
		ParseTreeNode* comma_node = (new ParseTreeNode())->set_first_line(@2.first_line)->set_last_line(@2.last_line)->set_rule("COMMA : ,");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("arguments : arguments COMMA logic_expression");
		$$->add_child($1)->add_child(comma_node)->add_child($3);

		func_arg_types.push_back($3->get_data_type());
	}
	| 
	logic_expression
	{
		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("arguments : logic_expression");
		$$->add_child($1);

		func_arg_types.push_back($1->get_data_type());
	}
	;
 

%%

// Epilogue (C code).

void yyerror (const YYLTYPE* loc, yyscan_t scanner, const char *msg, ...)
{
	cout<<"Error at line "<<loc->first_line<<":"<<loc->first_column<<" : "<<msg<<endl;
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
	parsetree_file.open(parsetree_file_name);

  	yyscan_t scanner_context;
	yylex_init( &scanner_context);
	yyset_in(input_file,scanner_context);
	yyparse(scanner_context);
	yylex_destroy(scanner_context);

	cout<<symbol_table<<endl;

	fclose(input_file);
	parsetree_file.close();
  	return 0;
}
