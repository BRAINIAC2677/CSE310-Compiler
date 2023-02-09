// Emitted in the header file, before the definition of YYSTYPE.
%code requires
{
	#ifndef YY_TYPEDEF_YY_SCANNER_T
	# define YY_TYPEDEF_YY_SCANNER_T
  	typedef void* yyscan_t;
  	#endif
  	class SymbolInfo;
	class VarInfo;
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
	#include "icg_utils.hpp"


}


%code
{
	//global variables
	bool is_global_scope = true;
	int label = 0;
	string input_file_name, parsetree_file_name, error_file_name, asmcode_file_name, code_segment_file_name;
	ofstream parsetree_file, error_file, asmcode_file;
	fstream code_segment_file;
	SymbolTable symbol_table;
	vector<pair<pair<SymbolInfo*, int>, ParseTreeNode*>> var_decl_list; // first.second is the array size, -1 if not array
	vector<pair<DataType, string>> func_params;
	vector<DataType> func_arg_types;

	string get_newlabel()
	{
		return "label_" + to_string(label++);
	}

	//error functions
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

	void warning_data_loss(int lineno, DataType from, DataType to)
	{
		error_file << "Line# " << lineno << ": " << "Warning: possible loss of data in assignment of "<<data_type_to_string[from]<<" to "<<data_type_to_string[to]<<"\n";
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

	void error_redeclared_variable(int lineno, string variable_name)
	{
		error_file << "Line# " << lineno << ": " << "Redeclared variable '" << variable_name << "'\n";
	}

	void error_multiple_definition(int lineno, string id_name)
	{
		error_file << "Line# " << lineno << ": " << "Multiple definition of '" << id_name << "'\n";
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
// Scanner exchanged between main, yyparse and yylex.
%param {yyscan_t scanner}


%type <ParseTreeNode*> start program unit func_declaration func_definition parameter_list compound_statement var_declaration type_specifier declaration_list statements statement expression_statement expression logic_expression rel_expression simple_expression term unary_expression factor argument_list arguments

%type <VarInfo*> variable

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
start : 
	{
		asmcode_file.open(asmcode_file_name, ios::out | ios::trunc);
		code_segment_file.open(code_segment_file_name, ios::out | ios::in | ios::trunc);
		asmcode_file << gen_starting_code();
		code_segment_file << "\n.CODE\n\n";
	}
	program
	{
		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("start : program");
		$$->add_child($2);

		ParseTreeNode::print_parsetree(parsetree_file,$$, 0);

		code_segment_file.seekg(0, ios::beg);
		string line;
		while(getline(code_segment_file, line))
		{
			asmcode_file << line << endl;
		}
		asmcode_file << gen_ending_code();
		code_segment_file.close();
		asmcode_file.close();
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

			vector<DataType> param_types = vector<DataType>();
			for(auto param : func_params)
			{
				param_types.push_back(param.first);
			}
			FuncInfo* func_info = (new FuncInfo())->set_lexeme($2->get_lexeme())->set_type(SI_FUNC_DECL_ID)->set_return_type($1->get_data_type())->set_param_types(param_types);
			
			//semantic errors
			SymbolInfo* symbol_info = symbol_table.lookup($2->get_lexeme());
			if(symbol_info == NULL_SYMBOL_INFO)
			{
				symbol_table.insert((SymbolInfo*)func_info);
			}
			else if(symbol_info->get_type() == TokenType::SI_VAR_ID)
			{
				error_redeclared_different_kind(@2.first_line, $2->get_lexeme());
			}
			else if((symbol_info->get_type() == TokenType::SI_FUNC_DECL_ID || symbol_info->get_type() == TokenType::SI_FUNC_DEF_ID) && (!func_info->is_compatible_with((FuncInfo*)symbol_info)))
			{
				error_conflicting_type(@2.first_line, $2->get_lexeme());
			}
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

			FuncInfo* func_info = (new FuncInfo())->set_lexeme($2->get_lexeme())->set_type(SI_FUNC_DECL_ID)->set_return_type($1->get_data_type());

			//semantic errors
            SymbolInfo* symbol_info = symbol_table.lookup($2->get_lexeme());
			if(symbol_info == NULL_SYMBOL_INFO)
			{
				symbol_table.insert((SymbolInfo*)func_info);
			}
			else if(symbol_info->get_type() == TokenType::SI_VAR_ID)
			{
				error_redeclared_different_kind(@2.first_line, $2->get_lexeme());
			}
			else if((symbol_info->get_type() == TokenType::SI_FUNC_DECL_ID || symbol_info->get_type() == TokenType::SI_FUNC_DEF_ID) && (!func_info->is_compatible_with((FuncInfo*)symbol_info)))
			{
				error_conflicting_type(@2.first_line, $2->get_lexeme());
			}
		}
		;
		 
func_definition : 
	type_specifier ID LPAREN parameter_list RPAREN 
	{
		is_global_scope = false;
		vector<DataType> param_types = vector<DataType>();
		for(auto param: func_params)
		{
			param_types.push_back(param.first);
		}
		FuncInfo* func_info = (new FuncInfo())->set_lexeme($2->get_lexeme())->set_type(SI_FUNC_DEF_ID)->set_return_type($1->get_data_type())->set_param_types(param_types);

		//semantic errors
		SymbolInfo* symbol_info = symbol_table.lookup($2->get_lexeme());
		if(symbol_info == NULL_SYMBOL_INFO)
		{
			symbol_table.insert((SymbolInfo*)func_info);
			code_segment_file << gen_func_starting_code($2->get_lexeme());
		}
		else if(symbol_info->get_type() == TokenType::SI_VAR_ID)
		{
			error_redeclared_different_kind(@2.first_line, $2->get_lexeme());
		}
		else if(symbol_info->get_type() == TokenType::SI_FUNC_DEF_ID)
		{
			error_multiple_definition(@2.first_line, $2->get_lexeme());
		}
		else if(symbol_info->get_type() == TokenType::SI_FUNC_DECL_ID && (!func_info->is_compatible_with((FuncInfo*)symbol_info)))
		{
			error_conflicting_type(@2.first_line, $2->get_lexeme());
		}
	}
	compound_statement
	{
		ParseTreeNode* id_node = (new ParseTreeNode())->set_first_line(@2.first_line)->set_last_line(@2.last_line)->set_rule("ID : " + $2->get_lexeme());
		ParseTreeNode* lparen_node = (new ParseTreeNode())->set_first_line(@3.first_line)->set_last_line(@3.last_line)->set_rule("LPAREN : (");
		ParseTreeNode* rparen_node = (new ParseTreeNode())->set_first_line(@5.first_line)->set_last_line(@5.last_line)->set_rule("RPAREN : )");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement");
		$$->add_child($1)->add_child(id_node)->add_child(lparen_node)->add_child($4)->add_child(rparen_node)->add_child($7);

		code_segment_file << gen_func_ending_code($2->get_lexeme(), func_params.size());
		func_params.clear();
		is_global_scope = true;
	}
	| 
	type_specifier ID LPAREN RPAREN
	{
		is_global_scope = false;
		FuncInfo* func_info = (new FuncInfo())->set_lexeme($2->get_lexeme())->set_type(SI_FUNC_DEF_ID)->set_return_type($1->get_data_type());

		//semantic errors
		SymbolInfo* symbol_info = symbol_table.lookup($2->get_lexeme());
		if(symbol_info == NULL_SYMBOL_INFO)
		{
			symbol_table.insert((SymbolInfo*)func_info);
			code_segment_file<<gen_func_starting_code($2->get_lexeme());
		}
		else if(symbol_info->get_type() == TokenType::SI_VAR_ID)
		{
			error_redeclared_different_kind(@2.first_line, $2->get_lexeme());
		}
		else if(symbol_info->get_type() == TokenType::SI_FUNC_DEF_ID)
		{
			error_multiple_definition(@2.first_line, $2->get_lexeme());
		}
		else if(symbol_info->get_type() == TokenType::SI_FUNC_DECL_ID && (!func_info->is_compatible_with((FuncInfo*)symbol_info)))
		{
			error_conflicting_type(@2.first_line, $2->get_lexeme());
		}

	} 
	compound_statement
	{
		ParseTreeNode* id_node = (new ParseTreeNode())->set_first_line(@2.first_line)->set_last_line(@2.last_line)->set_rule("ID : " + $2->get_lexeme());
		ParseTreeNode* lparen_node = (new ParseTreeNode())->set_first_line(@3.first_line)->set_last_line(@3.last_line)->set_rule("LPAREN : (");
		ParseTreeNode* rparen_node = (new ParseTreeNode())->set_first_line(@4.first_line)->set_last_line(@4.last_line)->set_rule("RPAREN : )");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("func_definition : type_specifier ID LPAREN RPAREN compound_statement");
		$$->add_child($1)->add_child(id_node)->add_child(lparen_node)->add_child(rparen_node)->add_child($6);

		code_segment_file << gen_func_ending_code($2->get_lexeme(), 0);
		is_global_scope = true;
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
		|
		error
		{
			yyclearin;
			$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("parameter_list  : error");
		}
 		;

 		
compound_statement : 
	LCURL 
	{
		int prev_scope_current_offset = symbol_table.get_current_scope()->get_current_offset();
		symbol_table.enter_scope();
		symbol_table.get_current_scope()->set_current_offset(prev_scope_current_offset);
		symbol_table.get_current_scope()->set_base_offset(prev_scope_current_offset);
		// cout<<"entering scope\n";
		// cout<<symbol_table<<endl;

		// inserting parameters of function definition
		if(func_params.size() > 0)
		{
			symbol_table.get_current_scope()->set_current_offset(0);
			symbol_table.get_current_scope()->set_base_offset(0);
			for(int i = 0; i < func_params.size(); i++)
			{
				VarInfo* var_info = (new VarInfo())->set_lexeme(func_params[i].second)->set_type(SI_VAR_ID)->set_data_type(func_params[i].first)->set_offset(4 + 2*i)->set_global(false);

				//semantic errors
				SymbolInfo* symbol_info = symbol_table.get_current_scope()->lookup(var_info->get_lexeme());
				if(symbol_info != NULL_SYMBOL_INFO)
				{
					error_parameter_redefinition(@1.first_line, var_info->get_lexeme());	
				}
				else 
				{
					symbol_table.insert((SymbolInfo*)var_info);
				}
			}
		}
	}
	statements RCURL
	{
		ParseTreeNode* lcurl_node = (new ParseTreeNode())->set_first_line(@1.first_line)->set_last_line(@1.last_line)->set_rule("LCURL : {");
		ParseTreeNode* rcurl_node = (new ParseTreeNode())->set_first_line(@4.first_line)->set_last_line(@4.last_line)->set_rule("RCURL : }");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("compound_statement : LCURL statements RCURL");
		$$->add_child(lcurl_node)->add_child($3)->add_child(rcurl_node);

		// cout<<"exiting scope\n";
		// cout<<symbol_table<<endl;

		// popping stack space for declared variables in this scope
		if(symbol_table.get_current_scope()->get_current_offset() - symbol_table.get_current_scope()->get_base_offset() > 0)
		{
			code_segment_file<<gen_add("SP", symbol_table.get_current_scope()->get_current_offset() - symbol_table.get_current_scope()->get_base_offset());
		}
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

			VarInfo* var_info = (new VarInfo())->set_lexeme(var.first.first->get_lexeme())->set_type(TokenType::SI_VAR_ID)->set_data_type($1->get_data_type())->set_array_size(var.first.second)->set_global(is_global_scope);
			SymbolInfo* symbol_info = symbol_table.get_current_scope()->lookup(var_info->get_lexeme());

			if(var_info->get_data_type() == DataType::VOID)
			{
				error_void_variable(@$.first_line, var_info->get_lexeme());
			}
			else if(symbol_info == NULL_SYMBOL_INFO)
			{
				if(!is_global_scope)
				{
					symbol_table.get_current_scope()->inc_current_offset();
					var_info->set_offset(-symbol_table.get_current_scope()->get_current_offset());
				}
				symbol_table.insert((SymbolInfo*)var_info);
			}
			else 
			{
				error_conflicting_type(@$.first_line, var_info->get_lexeme());
			}
		}
		code_segment_file<<gen_mov("SP", "BP");
		code_segment_file<<gen_sub("SP", symbol_table.get_current_scope()->get_current_offset());
		var_decl_list.clear();
	}
 	;
 		 
type_specifier	: 
	INT 
	{
		ParseTreeNode* int_node = (new ParseTreeNode())->set_first_line(@1.first_line)->set_last_line(@1.last_line)->set_data_type(DataType::INT)->set_rule("INT : int");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type(DataType::INT)->set_rule("type_specifier : INT")->add_child(int_node);
	}
 	| 
	FLOAT
	{
		ParseTreeNode* float_node = (new ParseTreeNode())->set_first_line(@1.first_line)->set_last_line(@1.last_line)->set_data_type(DataType::FLOAT)->set_rule("FLOAT : float");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type(DataType::FLOAT)->set_rule("type_specifier : FLOAT")->add_child(float_node);
	}
 	| 
	VOID
	{
		ParseTreeNode* void_node = (new ParseTreeNode())->set_first_line(@1.first_line)->set_last_line(@1.last_line)->set_data_type(DataType::VOID)->set_rule("VOID : void");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type(DataType::VOID)->set_rule("type_specifier : VOID")->add_child(void_node);
	}
 	;
 		
declaration_list : 
	declaration_list COMMA ID
	{
		ParseTreeNode* comma_node = (new ParseTreeNode())->set_first_line(@1.first_line)->set_last_line(@1.last_line)->set_rule("COMMA : ,");
		ParseTreeNode* id_node = (new ParseTreeNode())->set_first_line(@3.first_line)->set_last_line(@3.last_line)->set_rule("ID : "+$3->get_lexeme());

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("declaration_list : declaration_list COMMA ID");
		$$->add_child($1)->add_child(comma_node)->add_child(id_node);

		var_decl_list.push_back({{$3, -1}, id_node});
	}
 	| 
	declaration_list COMMA ID LTHIRD CONST_INT RTHIRD
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
 	| 
	ID 
	{
		ParseTreeNode* id_node = (new ParseTreeNode())->set_first_line(@1.first_line)->set_last_line(@1.last_line)->set_rule("ID : "+$1->get_lexeme());

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("declaration_list : ID");
		$$->add_child(id_node);

		var_decl_list.push_back({{$1, -1}, id_node});
	}
 	| 
	ID LTHIRD CONST_INT RTHIRD
	{
		ParseTreeNode* id_node = (new ParseTreeNode())->set_first_line(@1.first_line)->set_last_line(@1.last_line)->set_rule("ID : "+$1->get_lexeme());
		ParseTreeNode* lthird_node = (new ParseTreeNode())->set_first_line(@2.first_line)->set_last_line(@2.last_line)->set_rule("LTHIRD : [");
		ParseTreeNode* const_int_node = (new ParseTreeNode())->set_first_line(@3.first_line)->set_last_line(@3.last_line)->set_rule("CONST_INT : "+$3->get_lexeme());
		ParseTreeNode* rthird_node = (new ParseTreeNode())->set_first_line(@4.first_line)->set_last_line(@4.last_line)->set_rule("RTHIRD : ]");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("declaration_list : ID LTHIRD CONST_INT RTHIRD");
		$$->add_child(id_node)->add_child(lthird_node)->add_child(const_int_node)->add_child(rthird_node);

		var_decl_list.push_back({{$1, stoi($3->get_lexeme())}, id_node});
	}
	|
	error
	{
		yyclearin;
		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("declaration_list : error");
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

		VarInfo* var_info = (VarInfo*) symbol_table.lookup($3->get_lexeme());
		code_segment_file << gen_mov("DX",var_info->get_address(), get_lineno_comment(@1.first_line));
		code_segment_file << gen_call("PRINTLN_INT", get_lineno_comment(@1.first_line));
	}
	| 
	RETURN expression SEMICOLON
	{
		ParseTreeNode* return_node = (new ParseTreeNode())->set_first_line(@1.first_line)->set_last_line(@1.last_line)->set_rule("RETURN : return");
		ParseTreeNode* semicolon_node = (new ParseTreeNode())->set_first_line(@3.first_line)->set_last_line(@3.last_line)->set_rule("SEMICOLON : ;");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("statement : RETURN expression SEMICOLON");
		$$->add_child(return_node)->add_child($2)->add_child(semicolon_node);

		code_segment_file << gen_pop("AX", get_lineno_comment(@1.first_line));
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
		VarInfo* var_info = (VarInfo*) symbol_table.lookup($1->get_lexeme());
		$$ = var_info;

		//semantic error checking
		SymbolInfo* symbol_info = symbol_table.lookup($1->get_lexeme());
		if(symbol_info->get_type() == TokenType::SI_VAR_ID)
		{
			code_segment_file << gen_push(var_info->get_address(), get_lineno_comment(@1.first_line));
		}
		else 
		{
			error_undeclared_variable(@1.first_line, $1->get_lexeme());
		}
	} 		
	| 
	ID LTHIRD expression RTHIRD 
	{
		VarInfo* var_info = (VarInfo*) symbol_table.lookup($1->get_lexeme());
		$$ = var_info;

		//semantic error checking
		SymbolInfo* symbol_info = symbol_table.lookup($1->get_lexeme());
		if(symbol_info == NULL_SYMBOL_INFO)
		{
			error_undeclared_variable(@1.first_line, $1->get_lexeme());
		}
		else if((symbol_info->get_type() == TokenType::SI_FUNC_DECL_ID) || (symbol_info->get_type() == TokenType::SI_FUNC_DEF_ID))
		{
			error_undeclared_variable(@1.first_line, $1->get_lexeme());
		}
		else if(symbol_info->get_type() == TokenType::SI_VAR_ID && ((VarInfo*)symbol_info)->get_array_size() == -1)
		{
			error_not_an_array(@1.first_line, $1->get_lexeme());
		}
		else if($3->get_data_type() != DataType::INT)
		{
			error_array_index_not_integer(@2.first_line);
		}
		else if(symbol_info->get_type() == TokenType::SI_VAR_ID && ((VarInfo*)symbol_info)->get_array_size() > -1)
		{
			//code generation
		}
	}
	;
	 
expression : 
	logic_expression	
	{
		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type($1->get_data_type())->set_rule("expression : logic_expression");
		$$->add_child($1);
	}
	| 
	variable
	{
	}
	ASSIGNOP logic_expression 	
	{

		ParseTreeNode* assignop_node = (new ParseTreeNode())->set_first_line(@3.first_line)->set_last_line(@3.last_line)->set_rule("ASSIGNOP : =");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type($1->get_data_type())->set_rule("expression : variable ASSIGNOP logic_expression");
		$$->add_child(assignop_node)->add_child($4);

		//semantic error checking
		if($4->get_data_type() == DataType::VOID)
		{
			error_default(@3.first_line, "void cannot be assigned to a variable");
		}
		else if($4->get_data_type() == DataType::FLOAT && $1->get_data_type() == DataType::INT)
		{
			warning_data_loss(@1.first_line, DataType::FLOAT, DataType::INT);
		}
		else 
		{
			code_segment_file <<gen_pop("BX", get_lineno_comment(@3.first_line)); 
			code_segment_file << gen_pop("AX", get_lineno_comment(@1.first_line));
			code_segment_file << gen_mov($1->get_address(), "BX", get_lineno_comment(@1.first_line));
		}
	}
	|
	error
	{
		yyclearin;
		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_rule("expression : error");
	}
	;
			
logic_expression : 
	rel_expression 	
	{
		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type($1->get_data_type())->set_rule("logic_expression : rel_expression");
		$$->add_child($1);
	}
	| 
	rel_expression
	{
	} 
	LOGICOP rel_expression 	
	{
		ParseTreeNode* logicop_node = (new ParseTreeNode())->set_first_line(@3.first_line)->set_last_line(@3.last_line)->set_rule("LOGICOP : "+$3->get_lexeme());

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type($1->get_data_type())->set_rule("logic_expression : rel_expression LOGICOP rel_expression");
		$$->add_child($1)->add_child(logicop_node)->add_child($4);

		//semantic error checking
		if($1->get_data_type() == DataType::VOID || $4->get_data_type() == DataType::VOID)
		{
			error_default(@3.first_line, "void cannot be used in logical expression");
		}
		else 
		{
			code_segment_file <<gen_pop("BX", get_lineno_comment(@3.first_line));
			code_segment_file << gen_pop("AX", get_lineno_comment(@1.first_line));

			string label = get_newlabel();
			code_segment_file << gen_cmp("AX", "0", get_lineno_comment(@1.first_line));
			code_segment_file << gen_code("JE " + label, get_lineno_comment(@1.first_line));
			code_segment_file << gen_mov("AX", "1", get_lineno_comment(@1.first_line));
			code_segment_file << gen_label(label, get_lineno_comment(@1.first_line));

			label = get_newlabel();
			code_segment_file << gen_cmp("BX", "0", get_lineno_comment(@1.first_line));
			code_segment_file << gen_code("JE " + label, get_lineno_comment(@1.first_line));
			code_segment_file << gen_mov("BX", "1", get_lineno_comment(@1.first_line));
			code_segment_file << gen_label(label, get_lineno_comment(@1.first_line));

			if($3->get_lexeme() == "&&")
			{
				code_segment_file << gen_and("AX", "BX", get_lineno_comment(@3.first_line));
			}
			else if($3->get_lexeme() == "||")
			{
				code_segment_file << gen_or("AX", "BX", get_lineno_comment(@3.first_line));
			}
			code_segment_file << gen_push("AX", get_lineno_comment(@3.first_line));
		}
	}
	;
			
rel_expression	: 
	simple_expression 
	{
		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type($1->get_data_type())->set_rule("rel_expression : simple_expression");
		$$->add_child($1);
	}
	| 
	simple_expression
	{
	} 
	RELOP simple_expression	
	{
		ParseTreeNode* relop_node = (new ParseTreeNode())->set_first_line(@3.first_line)->set_last_line(@3.last_line)->set_rule("RELOP : "+$3->get_lexeme());

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type($1->get_data_type())->set_rule("rel_expression : simple_expression RELOP simple_expression");
		$$->add_child($1)->add_child(relop_node)->add_child($4);

		//semantic error checking
		if($1->get_data_type() == DataType::VOID || $4->get_data_type() == DataType::VOID)
		{
			error_default(@2.first_line, "cannot use relational operator on void type");
		}
		else 
		{
			string label1 = get_newlabel();
			string label2 = get_newlabel();

			code_segment_file<<gen_pop("BX", get_lineno_comment(@3.first_line));
			code_segment_file << gen_pop("AX", get_lineno_comment(@1.first_line));
			code_segment_file<<gen_cmp("AX", "BX", get_lineno_comment(@3.first_line));
			if($3->get_lexeme() == "<")
			{
				code_segment_file<<gen_code("JL " + label1, get_lineno_comment(@3.first_line));
			}
			else if($3->get_lexeme() == ">")
			{
				code_segment_file<<gen_code("JG " + label1, get_lineno_comment(@3.first_line));
			}
			else if($3->get_lexeme() == "<=")
			{
				code_segment_file<<gen_code("JLE " + label1, get_lineno_comment(@3.first_line));
			}
			else if($3->get_lexeme() == ">=")
			{
				code_segment_file<<gen_code("JGE " + label1, get_lineno_comment(@3.first_line));
			}
			else if($3->get_lexeme() == "==")
			{
				code_segment_file<<gen_code("JE " + label1, get_lineno_comment(@3.first_line));
			}
			else if($3->get_lexeme() == "!=")
			{
				code_segment_file<<gen_code("JNE " + label1, get_lineno_comment(@3.first_line));
			}
			code_segment_file<<gen_push("0", get_lineno_comment(@3.first_line));
			code_segment_file<<gen_code("JMP " + label2, get_lineno_comment(@3.first_line));
			code_segment_file<<gen_label(label1, get_lineno_comment(@3.first_line));
			code_segment_file<<gen_push("1", get_lineno_comment(@3.first_line));
			code_segment_file<<gen_label(label2, get_lineno_comment(@3.first_line));
		
		}
	}
	;
				
simple_expression : 
	term
	{
		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type($1->get_data_type())->set_rule("simple_expression : term");
		$$->add_child($1);
	} 
	| simple_expression
	{
	} 
	ADDOP term 
	{
		ParseTreeNode* add_node = (new ParseTreeNode())->set_first_line(@3.first_line)->set_last_line(@3.last_line)->set_rule("ADDOP : +");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type($1->get_data_type())->set_rule("simple_expression : simple_expression ADDOP term");
		$$->add_child($1)->add_child(add_node)->add_child($4);

		//semantic error checking
		if($1->get_data_type() == DataType::VOID || $4->get_data_type() == DataType::VOID)
		{
			error_default(@2.first_line, "cannot use arithmetic operator on void type");
		}
		else if($3->get_lexeme() == "+")
		{
			code_segment_file << gen_pop("BX", get_lineno_comment(@3.first_line));
			code_segment_file << gen_pop("AX", get_lineno_comment(@1.first_line));
			code_segment_file << gen_add("AX", "BX", get_lineno_comment(@3.first_line));
			code_segment_file << gen_push("AX", get_lineno_comment(@3.first_line));
		}
		else if($3->get_lexeme() == "-")
		{
			code_segment_file << gen_pop("BX", get_lineno_comment(@3.first_line));
			code_segment_file << gen_pop("AX", get_lineno_comment(@1.first_line));
			code_segment_file << gen_sub("AX", "BX", get_lineno_comment(@3.first_line));
			code_segment_file << gen_push("AX", get_lineno_comment(@3.first_line));
		}
		
	}
	;
					
term :	
	unary_expression
	{
		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type($1->get_data_type())->set_rule("term : unary_expression");
		$$->add_child($1);
	}
    |  
	term
	{
	} 
	MULOP unary_expression
	{
		ParseTreeNode* mul_node = (new ParseTreeNode())->set_first_line(@3.first_line)->set_last_line(@3.last_line)->set_rule("MULOP : *");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type($1->get_data_type())->set_rule("term : term MULOP unary_expression");
		$$->add_child($1)->add_child(mul_node)->add_child($4);

		//semantic error checking
		if($1->get_data_type() == DataType::VOID || $4->get_data_type() == DataType::VOID)
		{
			error_default(@2.first_line, "Cannot use arithmetic operator on void type");
		}
		else if(($3->get_lexeme() == "%") && ($1->get_data_type() != DataType::INT || $4->get_data_type() != DataType::INT))
		{
			error_nonint_mod_op(@2.first_line);
		}
		else if($3->get_lexeme() == "*")
		{
			code_segment_file<<gen_pop("BX", get_lineno_comment(@3.first_line));
			code_segment_file<<gen_pop("AX", get_lineno_comment(@1.first_line));
			code_segment_file<<gen_imul("BX", get_lineno_comment(@3.first_line));
			code_segment_file<<gen_push("AX", get_lineno_comment(@3.first_line));
		}
		else if($3->get_lexeme() == "/")
		{
			code_segment_file<<gen_pop("BX", get_lineno_comment(@3.first_line));
			code_segment_file<<gen_pop("AX", get_lineno_comment(@1.first_line));
			code_segment_file<<gen_xor("DX", "DX", get_lineno_comment(@3.first_line));
			code_segment_file<<gen_idiv("BX", get_lineno_comment(@3.first_line));
			code_segment_file<<gen_push("AX", get_lineno_comment(@3.first_line));
		}
		else if($3->get_lexeme() == "%")
		{
			code_segment_file<<gen_pop("BX", get_lineno_comment(@3.first_line));
			code_segment_file<<gen_pop("AX", get_lineno_comment(@1.first_line));
			code_segment_file<<gen_xor("DX", "DX", get_lineno_comment(@3.first_line));
			code_segment_file<<gen_idiv("BX", get_lineno_comment(@3.first_line));
			code_segment_file<<gen_push("DX", get_lineno_comment(@3.first_line));
		}
	}
    ;

unary_expression : 
	ADDOP unary_expression 
	{
		ParseTreeNode* add_node = (new ParseTreeNode())->set_first_line(@1.first_line)->set_last_line(@1.last_line)->set_rule("ADDOP : +");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type($2->get_data_type())->set_rule("unary_expression : ADDOP unary_expression");
		$$->add_child(add_node)->add_child($2);

		if($2->get_data_type() == DataType::VOID)
		{
			error_default(@1.first_line, "Cannot use unary operator on void type");
		}
		else if($1->get_lexeme() == "-")
		{
			code_segment_file << gen_pop("AX", get_lineno_comment(@1.first_line));
			code_segment_file << gen_neg("AX", get_lineno_comment(@1.first_line));
			code_segment_file << gen_push("AX", get_lineno_comment(@1.first_line));
		}
	} 
	| 
	NOT unary_expression 
	{
		ParseTreeNode* not_node = (new ParseTreeNode())->set_first_line(@1.first_line)->set_last_line(@1.last_line)->set_rule("NOT : !");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type($2->get_data_type())->set_rule("unary_expression : NOT unary_expression");
		$$->add_child(not_node)->add_child($2);

		if($2->get_data_type() == DataType::VOID)
		{
			error_default(@1.first_line, "Cannot use unary operator on void type");
		}
		else 
		{
			string label1 = get_newlabel();
			string label2 = get_newlabel();

			code_segment_file << gen_pop("AX", get_lineno_comment(@1.first_line));
			code_segment_file << gen_cmp("AX", 0, get_lineno_comment(@1.first_line));
			code_segment_file << gen_code("JE " + label1, get_lineno_comment(@1.first_line));
			code_segment_file << gen_push(0, get_lineno_comment(@1.first_line));
			code_segment_file << gen_code("JMP " + label2, get_lineno_comment(@1.first_line));
			code_segment_file << gen_label(label1, get_lineno_comment(@1.first_line));
			code_segment_file << gen_push(1, get_lineno_comment(@1.first_line));
			code_segment_file << gen_label(label2, get_lineno_comment(@1.first_line));
		}
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
		
	}
	| 
	ID LPAREN
	{

	} 
	argument_list RPAREN
	{
		ParseTreeNode* id_node = (new ParseTreeNode())->set_first_line(@1.first_line)->set_last_line(@1.last_line)->set_rule("ID : "+$1->get_lexeme());
		ParseTreeNode* lparen_node = (new ParseTreeNode())->set_first_line(@2.first_line)->set_last_line(@2.last_line)->set_rule("LPAREN : (");
		ParseTreeNode* rparen_node = (new ParseTreeNode())->set_first_line(@5.first_line)->set_last_line(@5.last_line)->set_rule("RPAREN : )");
		
		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type(DataType::NULL_TYPE)->set_rule("factor : ID LPAREN argument_list RPAREN");
		$$->add_child(id_node)->add_child(lparen_node)->add_child($4)->add_child(rparen_node);

		//semantic error checking
		SymbolInfo* symbol_info = symbol_table.lookup($1->get_lexeme());
		if(symbol_info == NULL_SYMBOL_INFO)
		{
			error_undeclared_function(@1.first_line, $1->get_lexeme());
		}
		else if(symbol_info->get_type() == TokenType::SI_VAR_ID)
		{
			error_undeclared_function(@1.first_line, $1->get_lexeme());
		}
		else if((symbol_info->get_type() == TokenType::SI_FUNC_DECL_ID) || (symbol_info->get_type() == TokenType::SI_FUNC_DEF_ID))
		{
			bool no_mismatch = true;
			FuncInfo* func_info = (FuncInfo*)symbol_info;
			int param_size = func_info->get_param_types().size();
			int arg_size = func_arg_types.size();

			if(param_size < arg_size)
			{
				error_too_many_arguments(@1.first_line, $1->get_lexeme());
				no_mismatch = false;
			}
			else if(param_size > arg_size)
			{
				error_too_few_arguments(@1.first_line, $1->get_lexeme());
				no_mismatch = false;
			}
			else
			{
				vector<DataType> param_types = func_info->get_param_types();
				for(int i = 0; i < param_size; i++)
				{
					if(param_types[i] != func_arg_types[i])
					{
						error_argument_type_mismatch(@1.first_line, i+1, $1->get_lexeme());
						no_mismatch = false;
					}
				}
			}
			if(no_mismatch)
			{
				$$->set_data_type(func_info->get_return_type());
				code_segment_file << gen_call($1->get_lexeme());
				code_segment_file << gen_push("AX", get_lineno_comment(@1.first_line)); // push return value
			}
		}
		func_arg_types.clear();
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

		code_segment_file << gen_push(stoi($1->get_lexeme()), get_lineno_comment(@1.first_line));
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
		$$->add_child(incop_node);
	}
	| 
	variable DECOP
	{

		ParseTreeNode* decop_node = (new ParseTreeNode())->set_first_line(@2.first_line)->set_last_line(@2.last_line)->set_rule("DECOP : --");

		$$ = (new ParseTreeNode())->set_first_line(@$.first_line)->set_last_line(@$.last_line)->set_data_type($1->get_data_type())->set_rule("factor : variable DECOP");
		$$->add_child(decop_node);
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
	error_file<<"Line "<<loc->first_line<<":"<<loc->first_column<<" | Error: "<<msg<<endl;
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
	
	input_file_name = argv[1];
	parsetree_file_name = input_file_name.substr(0,input_file_name.size()-2) + "_parsetree.txt";
	error_file_name = input_file_name.substr(0,input_file_name.size()-2) + "_error.txt";
	asmcode_file_name = input_file_name.substr(0,input_file_name.size()-2) + "_asmcode.asm";
	code_segment_file_name = input_file_name.substr(0,input_file_name.size()-2) + "_code_segment.asm";
	parsetree_file.open(parsetree_file_name);
	error_file.open(error_file_name);

  	yyscan_t scanner_context;
	yylex_init( &scanner_context);
	yyset_in(input_file,scanner_context);
	yyparse(scanner_context);
	yylex_destroy(scanner_context);

	fclose(input_file);
	error_file.close();
	parsetree_file.close();
  	return 0;
}
