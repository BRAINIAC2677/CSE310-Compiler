// Emitted in the header file, before the definition of YYSTYPE.
%code requires
{
	#ifndef YY_TYPEDEF_YY_SCANNER_T
	# define YY_TYPEDEF_YY_SCANNER_T
  	typedef void* yyscan_t;
  	#endif
  	class SymbolInfo;
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
	#include "SymbolInfo.hpp"
	#include "SymbolTable.hpp"
	#include "icg_utils.hpp"


}


%code
{
	//global variables
	bool is_global_scope = true;
	bool is_main_func = false;
	bool is_func_compound_statement = false;
	bool is_rel_exp = false;
	int current_func_base_offset = 0;
	int array_index = -1; // -1 means not array index
	SymbolInfo* last_expression; // for if statements
	string input_file_name, error_file_name, asmcode_file_name, optimized_asmcode_file_name, code_segment_file_name;
	ofstream error_file;
	SymbolTable symbol_table;
	vector<SymbolInfo*> var_decl_list; 
	vector<SymbolInfo*> func_params;
	vector<DataType> func_arg_types;
	map<int, string> jumping_label;


	void backpatch(vector<int> lines, string label)
	{
		for(auto line: lines)
		{
			jumping_label[line] = label;
		}
	}

	vector<int> merge(vector<int> a, vector<int> b)
	{
		vector<int> ret = a;
		for(auto i:b)
		{
			ret.push_back(i);
		}
		return ret;
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

	void warning_data_loss(int lineno)
	{
		error_file << "Line# " << lineno << ": " << "Warning: possible loss of data in assignment of float to int\n";
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


%type <SymbolInfo*> start program unit func_declaration func_definition parameter_list var_declaration type_specifier declaration_list expression_statement expression simple_expression term unary_expression factor argument_list arguments

%type <SymbolInfo*> rel_expression logic_expression statement statements compound_statement
%type <SymbolInfo*> variable
%type <SymbolInfo*> marker1 marker2 marker3

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
		gen_starting_code();
	}
	program
	{
		int lineno = 1;
		asmcode_file << "\n.CODE\n";
		code_segment_file.seekg(0, ios::beg);
		string line;
		while(getline(code_segment_file, line))
		{
			asmcode_file << line + (jumping_label[lineno] == ""?"":" "+jumping_label[lineno]) << endl;
			lineno++;
		}
		gen_ending_code();
		code_segment_file.close();
		asmcode_file.close();

		peephole_optimization(asmcode_file_name, optimized_asmcode_file_name);
	}
	;

program : 
	program unit 
	{
	}
	| 
	unit
	{
	}
	;
	
unit : 
	var_declaration
	{
	}
    | 
	func_declaration
	{
	}
    | 
	func_definition
	{
	}
    ;
     
func_declaration : 
		type_specifier ID LPAREN parameter_list RPAREN SEMICOLON
		{
			vector<DataType> param_types = vector<DataType>();
			for(auto param : func_params)
			{
				param_types.push_back(param->get_data_type());
			}
			SymbolInfo* func_info = (new SymbolInfo())->set_lexeme($2->get_lexeme())->set_type(SI_FUNC_DECL_ID)->set_return_type($1->get_data_type())->set_param_types(param_types);
			
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
			else if((symbol_info->get_type() == TokenType::SI_FUNC_DECL_ID || symbol_info->get_type() == TokenType::SI_FUNC_DEF_ID) && (!func_info->is_compatible_with((SymbolInfo*)symbol_info)))
			{
				error_conflicting_type(@2.first_line, $2->get_lexeme());
			}
			func_params.clear();
		}
		| 
		type_specifier ID LPAREN RPAREN SEMICOLON
		{
			SymbolInfo* func_info = (new SymbolInfo())->set_lexeme($2->get_lexeme())->set_type(SI_FUNC_DECL_ID)->set_return_type($1->get_data_type());

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
			else if((symbol_info->get_type() == TokenType::SI_FUNC_DECL_ID || symbol_info->get_type() == TokenType::SI_FUNC_DEF_ID) && (!func_info->is_compatible_with((SymbolInfo*)symbol_info)))
			{
				error_conflicting_type(@2.first_line, $2->get_lexeme());
			}
		}
		;
		 
func_definition : 
	type_specifier ID LPAREN parameter_list RPAREN 
	{
		is_global_scope = false;
		is_func_compound_statement = true;
		if($2->get_lexeme() == "main")
		{
			is_main_func = true;
		}
		current_func_base_offset = symbol_table.get_current_scope()->get_current_offset();
		vector<DataType> param_types = vector<DataType>();
		for(auto param: func_params)
		{
			param_types.push_back(param->get_data_type());
		}
		SymbolInfo* func_info = (new SymbolInfo())->set_lexeme($2->get_lexeme())->set_type(SI_FUNC_DEF_ID)->set_return_type($1->get_data_type())->set_param_types(param_types);

		//semantic errors
		SymbolInfo* symbol_info = symbol_table.lookup($2->get_lexeme());
		if(symbol_info == NULL_SYMBOL_INFO)
		{
			symbol_table.insert((SymbolInfo*)func_info);
			gen_func_starting_code($2->get_lexeme());
		}
		else if(symbol_info->get_type() == TokenType::SI_VAR_ID)
		{
			error_redeclared_different_kind(@2.first_line, $2->get_lexeme());
		}
		else if(symbol_info->get_type() == TokenType::SI_FUNC_DEF_ID)
		{
			error_multiple_definition(@2.first_line, $2->get_lexeme());
		}
		else if(symbol_info->get_type() == TokenType::SI_FUNC_DECL_ID && (!func_info->is_compatible_with((SymbolInfo*)symbol_info)))
		{
			error_conflicting_type(@2.first_line, $2->get_lexeme());
		}
	}
	compound_statement
	{
		gen_func_ending_code(is_main_func, func_params.size());
		gen_endp($2->get_lexeme());
		func_params.clear();
		is_global_scope = true;
		if(is_main_func)
		{
			is_main_func = false;
		}
	}
	| 
	type_specifier ID LPAREN RPAREN
	{
		is_global_scope = false;
		is_func_compound_statement = true;
		if($2->get_lexeme() == "main")
		{
			is_main_func = true;
		}
		current_func_base_offset = symbol_table.get_current_scope()->get_current_offset();
		SymbolInfo* func_info = (new SymbolInfo())->set_lexeme($2->get_lexeme())->set_type(SI_FUNC_DEF_ID)->set_return_type($1->get_data_type());

		//semantic errors
		SymbolInfo* symbol_info = symbol_table.lookup($2->get_lexeme());
		if(symbol_info == NULL_SYMBOL_INFO)
		{
			symbol_table.insert((SymbolInfo*)func_info);
			gen_func_starting_code($2->get_lexeme());
		}
		else if(symbol_info->get_type() == TokenType::SI_VAR_ID)
		{
			error_redeclared_different_kind(@2.first_line, $2->get_lexeme());
		}
		else if(symbol_info->get_type() == TokenType::SI_FUNC_DEF_ID)
		{
			error_multiple_definition(@2.first_line, $2->get_lexeme());
		}
		else if(symbol_info->get_type() == TokenType::SI_FUNC_DECL_ID && (!func_info->is_compatible_with((SymbolInfo*)symbol_info)))
		{
			error_conflicting_type(@2.first_line, $2->get_lexeme());
		}

	} 
	compound_statement
	{
		gen_func_ending_code(is_main_func, 0);
		gen_endp($2->get_lexeme());
		is_global_scope = true;
		if(is_main_func)
		{
			is_main_func = false;
		}
	}
 	;				


parameter_list  : 
		parameter_list COMMA type_specifier ID
		{
			$4->set_data_type($3->get_data_type());
			func_params.push_back($4);
		}
		| 
		parameter_list COMMA type_specifier
		{

			func_params.push_back((new SymbolInfo())->set_data_type($3->get_data_type()));
		}
 		| 
		type_specifier ID
		{
			$2->set_data_type($1->get_data_type());
			func_params.push_back($2);
		}
		| 
		type_specifier
		{
			func_params.push_back((new SymbolInfo())->set_data_type($1->get_data_type()));
		}
		|
		error
		{
			yyclearin;
		}
 		;

 		
compound_statement : 
	LCURL 
	{
		int prev_scope_current_offset = symbol_table.get_current_scope()->get_current_offset();
		symbol_table.enter_scope();
		symbol_table.get_current_scope()->set_current_offset(prev_scope_current_offset);
		symbol_table.get_current_scope()->set_base_offset(prev_scope_current_offset);

		// inserting parameters of function definition
		if(is_func_compound_statement)
		{
			is_func_compound_statement = false;
			symbol_table.get_current_scope()->set_current_offset(0);
			symbol_table.get_current_scope()->set_base_offset(0);
			for(int i = func_params.size() - 1, j = 0; i >= 0; i--, j++)
			{
				SymbolInfo* var_info = (new SymbolInfo())->set_lexeme(func_params[i]->get_lexeme())->set_type(SI_VAR_ID)->set_data_type(func_params[i]->get_data_type())->set_start_offset(4 + 2*j)->set_global(false);

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
	statements marker1 RCURL
	{
		$$ = new SymbolInfo($3);
		backpatch($3->get_nextlist(), $4->get_lexeme());
		$$->set_nextlist(vector<int>());

		// popping stack space for declared variables in this scope
		if(symbol_table.get_current_scope()->get_current_offset() - symbol_table.get_current_scope()->get_base_offset() > 0)
		{
			gen_add("SP", symbol_table.get_current_scope()->get_current_offset() - symbol_table.get_current_scope()->get_base_offset(), get_lineno_comment(@3.first_line, @3.last_line));
		}
		symbol_table.exit_scope();
	}
 	| 
	LCURL RCURL
	{
		$$ = new SymbolInfo();
	}
 	;

var_declaration : 
	type_specifier declaration_list SEMICOLON
	{
		for(auto var : var_decl_list)
		{

			SymbolInfo* var_info = (new SymbolInfo())->set_lexeme(var->get_lexeme())->set_type(TokenType::SI_VAR_ID)->set_data_type($1->get_data_type())->set_array_size(var->get_array_size())->set_global(is_global_scope);
			SymbolInfo* symbol_info = symbol_table.get_current_scope()->lookup(var_info->get_lexeme());

			if(var_info->get_data_type() == DataType::VOID)
			{
				error_void_variable(@$.first_line, var_info->get_lexeme());
			}
			else if(symbol_info == NULL_SYMBOL_INFO)
			{
				if(!is_global_scope)
				{
					if(var_info->get_array_size() > 0)
					{
						symbol_table.get_current_scope()->inc_current_offset(var_info->get_array_size()*2);	
					}
					else 
					{
						symbol_table.get_current_scope()->inc_current_offset();
					}
					var_info->set_start_offset(-symbol_table.get_current_scope()->get_current_offset());

				}
				else 
				{
					gen_global_var(var_info->get_lexeme(), var_info->get_array_size(), get_lineno_comment(@3.first_line));
				}
				symbol_table.insert((SymbolInfo*)var_info);
			}
			else 
			{
				error_conflicting_type(@$.first_line, var_info->get_lexeme());
			}
		}
		if(!is_global_scope)
		{
			gen_mov("SP", "BP", get_lineno_comment(@3.first_line));
			gen_sub("SP", symbol_table.get_current_scope()->get_current_offset(), get_lineno_comment(@3.first_line));
		}
		var_decl_list.clear();
	}
 	;
 		 
type_specifier	: 
	INT 
	{
		$$ = (new SymbolInfo())->set_data_type(DataType::INT);
	}
 	| 
	FLOAT
	{
		$$ = (new SymbolInfo())->set_data_type(DataType::FLOAT);
	}
 	| 
	VOID
	{
		$$ = (new SymbolInfo())->set_data_type(DataType::VOID);
	}
 	;
 		
declaration_list : 
	declaration_list COMMA ID
	{
		var_decl_list.push_back($3);
	}
 	| 
	declaration_list COMMA ID LTHIRD CONST_INT RTHIRD
	{
		$3->set_array_size(stoi($5->get_lexeme()));
		var_decl_list.push_back($3);
	}
 	| 
	ID 
	{
		var_decl_list.push_back($1);
	}
 	| 
	ID LTHIRD CONST_INT RTHIRD
	{
		$1->set_array_size(stoi($3->get_lexeme()));
		var_decl_list.push_back($1);
	}
	|
	error
	{
		yyclearin;
	}
 	;
 		  
statements : 
	statement
	{
		$$ = $1;
	}
	| 
	statements marker1 statement
	{
		backpatch($1->get_nextlist(), $2->get_lexeme());
		$$ = new SymbolInfo($3);
	}
	;
	   
statement : 
	var_declaration
	{
		$$ = new SymbolInfo();
	}
	|
	expression_statement
	{
		$$ = new SymbolInfo();
	}
	| 
	compound_statement
	{
		$$ = $1;
	}
	| 
	FOR LPAREN expression_statement marker1 expression_statement
	{
		if(!($5->has_jump()))
		{
			gen_cmp("AX", "0", get_lineno_comment(@2.first_line));
			gen_code("JNE");
			$5->add_to_truelist(code_segment_lineno);
			gen_code("JMP");
			$5->add_to_falselist(code_segment_lineno);
		}
	} 
	marker1 expression
	{
		if(!($8->has_jump()))
		{
			gen_pop("AX", get_lineno_comment(@1.first_line));
		}
		gen_code("JMP "+$4->get_lexeme(), get_lineno_comment(@1.first_line));
	}
	RPAREN marker1 statement
	{
		backpatch($12->get_nextlist(), $7->get_lexeme());
		backpatch($5->get_truelist(), $11->get_lexeme());
		$$ = (new SymbolInfo())->set_nextlist($5->get_falselist());
		gen_code("JMP "+$7->get_lexeme(), get_lineno_comment(@1.first_line));
	}
	| 
	IF LPAREN expression marker3 RPAREN marker1 statement
	{

		backpatch($3->get_truelist(), $6->get_lexeme());
		$$ = (new SymbolInfo())->set_nextlist(merge($3->get_falselist(), $7->get_nextlist()));
	}
	| 
	IF LPAREN expression marker3 RPAREN marker1 statement ELSE marker2 marker1 statement
	{
		$$ = new SymbolInfo();
		backpatch($3->get_truelist(), $6->get_lexeme());
		backpatch($3->get_falselist(), $10->get_lexeme());
		$$->set_nextlist(merge(merge($7->get_nextlist(), $9->get_nextlist()), $11->get_nextlist()));
	}
	| 
	WHILE marker1 LPAREN expression
	{
		if(!($4->has_jump()))
		{
			gen_pop("AX", get_lineno_comment(@1.first_line));
			gen_cmp("AX", "0", get_lineno_comment(@1.first_line));
			gen_code("JNE");
			$4->add_to_truelist(code_segment_lineno);
			gen_code("JMP");
			$4->add_to_falselist(code_segment_lineno);
		}
	} 
	RPAREN marker1 statement
	{
		backpatch($8->get_nextlist(), $2->get_lexeme());
		backpatch($4->get_truelist(), $7->get_lexeme());
		$$ = (new SymbolInfo())->set_nextlist($4->get_falselist());
		gen_code("JMP " + $2->get_lexeme(), get_lineno_comment(@1.first_line));
	}
	| 
	PRINTLN LPAREN ID RPAREN SEMICOLON
	{
		$$ = new SymbolInfo();

		SymbolInfo* var_info = (SymbolInfo*) symbol_table.lookup($3->get_lexeme());

		gen_mov("AX",var_info->get_address(), get_lineno_comment(@1.first_line));
		gen_call("PRINTLN_INT", get_lineno_comment(@1.first_line));
	}
	| 
	RETURN expression SEMICOLON
	{
		$$ = new SymbolInfo();
		if($2->has_jump())
		{
			string label1 = get_newlabel();
			string label2 = get_newlabel();
			string label3 = get_newlabel();

			backpatch($2->get_truelist(), label1);
			backpatch($2->get_falselist(), label2);
			$2->set_truelist(vector<int>());
			$2->set_falselist(vector<int>());

			gen_label(label1, get_lineno_comment(@1.first_line));
			gen_mov("AX", "1", get_lineno_comment(@1.first_line));
			gen_code("JMP " + label3, get_lineno_comment(@1.first_line));
			gen_label(label2, get_lineno_comment(@1.first_line));
			gen_mov("AX", "0", get_lineno_comment(@1.first_line));
			gen_label(label3, get_lineno_comment(@1.first_line));
		}
		else 
		{
			gen_pop("AX", get_lineno_comment(@2.first_line));
		}

		if(symbol_table.get_current_scope()->get_current_offset() - current_func_base_offset > 0)
		{
			gen_add("SP", symbol_table.get_current_scope()->get_current_offset() - current_func_base_offset, get_lineno_comment(@1.first_line));
		}
		gen_func_ending_code(is_main_func, func_params.size());
	}
	;
marker2 : 
	{
		gen_code("JMP");
		$$ = (new SymbolInfo())->add_to_nextlist(code_segment_lineno);
	}
	;
marker3:
	{
		if(!(last_expression->has_jump()))
		{
			gen_pop("AX");
			gen_cmp("AX", "0");
			gen_code("JNE");
			last_expression->add_to_truelist(code_segment_lineno);
			gen_code("JMP");
			last_expression->add_to_falselist(code_segment_lineno);
		}
	}
	;
expression_statement : 
	SEMICOLON
	{
	}			
	| 
	expression SEMICOLON 
	{
		if(!($1->has_jump()))
		{
			gen_pop("AX", get_lineno_comment(@1.first_line));
		}
	}
	;
	  
variable : 
	ID
	{
		SymbolInfo* var_info = (SymbolInfo*) symbol_table.lookup($1->get_lexeme());
		$$ = var_info;

		//semantic error checking
		SymbolInfo* symbol_info = symbol_table.lookup($1->get_lexeme());
		if(symbol_info->get_type() == TokenType::SI_VAR_ID)
		{
			if(!var_info->is_global())
			{
				gen_push(var_info->get_start_offset(), get_lineno_comment(@1.first_line));
			}
		}
		else 
		{
			error_undeclared_variable(@1.first_line, $1->get_lexeme());
		}
	} 		
	| 
	ID LTHIRD expression RTHIRD 
	{
		SymbolInfo* var_info = (SymbolInfo*) symbol_table.lookup($1->get_lexeme());
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
		else if(symbol_info->get_type() == TokenType::SI_VAR_ID && ((SymbolInfo*)symbol_info)->get_array_size() == -1)
		{
			error_not_an_array(@1.first_line, $1->get_lexeme());
		}
		else if($3->get_data_type() != DataType::INT)
		{
			error_array_index_not_integer(@2.first_line);
		}
		else if(symbol_info->get_type() == TokenType::SI_VAR_ID && ((SymbolInfo*)symbol_info)->get_array_size() > -1)
		{
			gen_pop("SI", get_lineno_comment(@1.first_line));
			gen_code("SHL SI, 1", get_lineno_comment(@1.first_line));
			if(!var_info->is_global())
			{
				gen_sub("SI", abs(var_info->get_start_offset()), get_lineno_comment(@1.first_line));
			}
			gen_push("SI", get_lineno_comment(@1.first_line));
			
		}
	}
	;
	 
expression : 
	logic_expression	
	{
		$$ = $1;
		last_expression = $$;
	}
	| 
	variable ASSIGNOP logic_expression 	
	{
		//semantic error checking
		$$ = new SymbolInfo($1);
		if($3->get_data_type() == DataType::VOID)
		{
			error_default(@2.first_line, "void cannot be assigned to a variable");
		}
		else if($3->get_data_type() == DataType::FLOAT && $1->get_data_type() == DataType::INT)
		{
			warning_data_loss(@1.first_line);
		}
		else 
		{
			if($3->has_jump())
			{
				string label1 = get_newlabel();
				string label2 = get_newlabel();
				string label3 = get_newlabel();

				backpatch($3->get_truelist(), label1);
				backpatch($3->get_falselist(), label2);
				$3->set_truelist(vector<int>());
				$3->set_falselist(vector<int>());

				gen_label(label1, get_lineno_comment(@2.first_line));
				gen_mov("AX", "1", get_lineno_comment(@2.first_line));
				gen_code("JMP " + label3, get_lineno_comment(@2.first_line));
				gen_label(label2, get_lineno_comment(@2.first_line));
				gen_mov("AX", "0", get_lineno_comment(@2.first_line));
				gen_label(label3, get_lineno_comment(@2.first_line));
			}
			else 
			{
				gen_pop("AX", get_lineno_comment(@2.first_line)); 
			}
			if($1->is_global())
			{
				if($1->get_array_size() < 0)
				{
					gen_mov($1->get_lexeme(), "AX", get_lineno_comment(@2.first_line));
				}
				else 
				{
					gen_pop("SI", get_lineno_comment(@2.first_line));
					gen_mov($1->get_lexeme() + "[SI]", "AX", get_lineno_comment(@2.first_line));
				}
			}
			else 
			{
				gen_pop("SI", get_lineno_comment(@1.first_line));
				gen_mov("[BP+SI]", "AX", get_lineno_comment(@1.first_line));
			}
			gen_push("AX", get_lineno_comment(@2.first_line));
		}
		last_expression = $$;
	}
	|
	error
	{
		yyclearin;
		$$ = new SymbolInfo();
		last_expression = $$;
	}
	;
			
logic_expression : 
	rel_expression 	
	{
		$$ = $1;
	}
	| 
	rel_expression LOGICOP
	{
		if(!($1->has_jump()))
		{
			gen_pop("AX", get_lineno_comment(@2.first_line));
			gen_cmp("AX", "0", get_lineno_comment(@2.first_line));
			gen_code("JNE");
			$1->add_to_truelist(code_segment_lineno);
			gen_code("JMP");
			$1->add_to_falselist(code_segment_lineno);
		}
	} 
	marker1 rel_expression 	
	{
		$$ = new SymbolInfo($1);

		//semantic error checking
		if($1->get_data_type() == DataType::VOID || $5->get_data_type() == DataType::VOID)
		{
			error_default(@2.first_line, "void cannot be used in logical expression");
		}
		else 
		{
			if(!($5->has_jump()))
			{
				gen_pop("AX", get_lineno_comment(@2.first_line));
				gen_cmp("AX", "0", get_lineno_comment(@2.first_line));
				gen_code("JNE");
				$5->add_to_truelist(code_segment_lineno);
				gen_code("JMP");
				$5->add_to_falselist(code_segment_lineno);
			}
			if($2->get_lexeme() == "&&")
			{
				backpatch($1->get_truelist(), $4->get_lexeme());
				$$->set_truelist($5->get_truelist());
				$$->set_falselist(merge($1->get_falselist(), $5->get_falselist()));
			}
			else if($2->get_lexeme() == "||")
			{
				backpatch($1->get_falselist(), $4->get_lexeme());
				$$->set_truelist(merge($1->get_truelist(), $5->get_truelist()));
				$$->set_falselist($5->get_falselist());
			}
		}
	}
	;

marker1 : 
	{
		$$ = (new SymbolInfo())->set_lexeme(get_newlabel());
		gen_label($$->get_lexeme());
	}
	;
			
rel_expression	: 
	simple_expression 
	{
		$$ = $1;
	}
	| 
	simple_expression RELOP simple_expression	
	{
		$$ = new SymbolInfo($1);

		//semantic error checking
		if($1->get_data_type() == DataType::VOID || $3->get_data_type() == DataType::VOID)
		{
			error_default(@2.first_line, "cannot use relational operator on void type");
		}
		else 
		{
			if($3->has_jump())
			{
				string label1 = get_newlabel();
				string label2 = get_newlabel();
				string label3 = get_newlabel();

				backpatch($3->get_truelist(), label1);
				backpatch($3->get_falselist(), label2);
				$3->set_truelist(vector<int>());
				$3->set_falselist(vector<int>());

				gen_label(label1, get_lineno_comment(@2.first_line));
				gen_mov("AX", "1", get_lineno_comment(@2.first_line));
				gen_code("JMP " + label3, get_lineno_comment(@2.first_line));
				gen_label(label2, get_lineno_comment(@2.first_line));
				gen_mov("AX", "0", get_lineno_comment(@2.first_line));
				gen_label(label3, get_lineno_comment(@2.first_line));
			}
			else 
			{
				gen_pop("AX", get_lineno_comment(@2.first_line));
			}

			if($1->has_jump())
			{
				string label1 = get_newlabel();
				string label2 = get_newlabel();
				string label3 = get_newlabel();

				backpatch($1->get_truelist(), label1);
				backpatch($1->get_falselist(), label2);
				$1->set_truelist(vector<int>());
				$1->set_falselist(vector<int>());

				gen_label(label1, get_lineno_comment(@2.first_line));
				gen_mov("BX", "1", get_lineno_comment(@2.first_line));
				gen_code("JMP " + label3, get_lineno_comment(@2.first_line));
				gen_label(label2, get_lineno_comment(@2.first_line));
				gen_mov("BX", "0", get_lineno_comment(@2.first_line));
				gen_label(label3, get_lineno_comment(@2.first_line));
			}
			else 
			{
				gen_pop("BX", get_lineno_comment(@2.first_line));
			}
		
			gen_cmp("BX", "AX", get_lineno_comment(@2.first_line));
			if($2->get_lexeme() == "<")
			{
				gen_code("JL");
			}
			else if($2->get_lexeme() == ">")
			{
				gen_code("JG");
			}
			else if($2->get_lexeme() == "<=")
			{
				gen_code("JLE");
			}
			else if($2->get_lexeme() == ">=")
			{
				gen_code("JGE");
			}
			else if($2->get_lexeme() == "==")
			{
				gen_code("JE");
			}
			else if($2->get_lexeme() == "!=")
			{
				gen_code("JNE");
			}
			$$->add_to_truelist(code_segment_lineno);
			gen_code("JMP");
			$$->add_to_falselist(code_segment_lineno);
		}
	}
	;
				
simple_expression : 
	term
	{
		$$ = $1;
	} 
	| simple_expression ADDOP term 
	{
		$$ = new SymbolInfo($1);
		//semantic error checking
		if($1->get_data_type() == DataType::VOID || $3->get_data_type() == DataType::VOID)
		{
			error_default(@2.first_line, "cannot use arithmetic operator on void type");
		}
		else
		{
			if($3->has_jump())
			{
				string label1 = get_newlabel();
				string label2 = get_newlabel();
				string label3 = get_newlabel();

				backpatch($3->get_truelist(), label1);
				backpatch($3->get_falselist(), label2);
				$3->set_truelist(vector<int>());
				$3->set_falselist(vector<int>());

				gen_label(label1, get_lineno_comment(@2.first_line));
				gen_mov("AX", "1", get_lineno_comment(@2.first_line));
				gen_code("JMP " + label3, get_lineno_comment(@2.first_line));
				gen_label(label2, get_lineno_comment(@2.first_line));
				gen_mov("AX", "0", get_lineno_comment(@2.first_line));
				gen_label(label3, get_lineno_comment(@2.first_line));
			}
			else 
			{
				gen_pop("AX", get_lineno_comment(@2.first_line));
			}

			if($1->has_jump())
			{
				string label1 = get_newlabel();
				string label2 = get_newlabel();
				string label3 = get_newlabel();

				backpatch($1->get_truelist(), label1);
				backpatch($1->get_falselist(), label2);
				$1->set_truelist(vector<int>());
				$1->set_falselist(vector<int>());

				gen_label(label1, get_lineno_comment(@2.first_line));
				gen_mov("BX", "1", get_lineno_comment(@2.first_line));
				gen_code("JMP " + label3, get_lineno_comment(@2.first_line));
				gen_label(label2, get_lineno_comment(@2.first_line));
				gen_mov("BX", "0", get_lineno_comment(@2.first_line));
				gen_label(label3, get_lineno_comment(@2.first_line));
			}
			else 
			{
				gen_pop("BX", get_lineno_comment(@2.first_line));
			}

			if($2->get_lexeme() == "+")
			{
				gen_add("AX", "BX", get_lineno_comment(@2.first_line));
				gen_push("AX", get_lineno_comment(@2.first_line));
			}
			else if($2->get_lexeme() == "-")
			{
				gen_sub("BX", "AX", get_lineno_comment(@2.first_line));
				gen_mov("AX", "BX", get_lineno_comment(@2.first_line));
				gen_push("AX", get_lineno_comment(@2.first_line));
			}
		}
	}
	;
					
term :	
	unary_expression
	{
		$$ = $1;
	}
    |  
	term MULOP unary_expression
	{
		$$ = new SymbolInfo($1);
		//semantic error checking
		if($1->get_data_type() == DataType::VOID || $3->get_data_type() == DataType::VOID)
		{
			error_default(@2.first_line, "Cannot use arithmetic operator on void type");
		}
		else if(($2->get_lexeme() == "%") && ($1->get_data_type() != DataType::INT || $3->get_data_type() != DataType::INT))
		{
			error_nonint_mod_op(@2.first_line);
		}
		else
		{
			if($3->has_jump())
			{
				string label1 = get_newlabel();
				string label2 = get_newlabel();
				string label3 = get_newlabel();

				backpatch($3->get_truelist(), label1);
				backpatch($3->get_falselist(), label2);
				$3->set_truelist(vector<int>());
				$3->set_falselist(vector<int>());

				gen_label(label1, get_lineno_comment(@2.first_line));
				gen_mov("BX", "1", get_lineno_comment(@2.first_line));
				gen_code("JMP " + label3, get_lineno_comment(@2.first_line));
				gen_label(label2, get_lineno_comment(@2.first_line));
				gen_mov("BX", "0", get_lineno_comment(@2.first_line));
				gen_label(label3, get_lineno_comment(@2.first_line));
			}
			else 
			{
				gen_pop("BX", get_lineno_comment(@2.first_line));
			}

			if($1->has_jump())
			{
				string label1 = get_newlabel();
				string label2 = get_newlabel();
				string label3 = get_newlabel();

				backpatch($1->get_truelist(), label1);
				backpatch($1->get_falselist(), label2);
				$1->set_truelist(vector<int>());
				$1->set_falselist(vector<int>());

				gen_label(label1, get_lineno_comment(@2.first_line));
				gen_mov("AX", "1", get_lineno_comment(@2.first_line));
				gen_code("JMP " + label3, get_lineno_comment(@2.first_line));
				gen_label(label2, get_lineno_comment(@2.first_line));
				gen_mov("AX", "0", get_lineno_comment(@2.first_line));
				gen_label(label3, get_lineno_comment(@2.first_line));
			}
			else 
			{
				gen_pop("AX", get_lineno_comment(@1.first_line));
			}

			if($2->get_lexeme() == "*")
			{
				gen_imul("BX", get_lineno_comment(@2.first_line));
				gen_push("AX", get_lineno_comment(@2.first_line));
			}
			else if($2->get_lexeme() == "/")
			{
				gen_code("CWD", get_lineno_comment(@2.first_line));
				gen_idiv("BX", get_lineno_comment(@2.first_line));
				gen_push("AX", get_lineno_comment(@2.first_line));
			}
			else if($2->get_lexeme() == "%")
			{
				gen_code("CWD",get_lineno_comment(@2.first_line));
				gen_idiv("BX", get_lineno_comment(@2.first_line));
				gen_push("DX", get_lineno_comment(@2.first_line));
			}

		}
	}
    ;

unary_expression : 
	ADDOP unary_expression 
	{
		$$ = new SymbolInfo($2);
		if($2->get_data_type() == DataType::VOID)
		{
			error_default(@1.first_line, "Cannot use unary operator on void type");
		}
		else if($1->get_lexeme() == "-")
		{
			if($$->has_jump())
			{
				string label1 = get_newlabel();
				string label2 = get_newlabel();
				string label3 = get_newlabel();

				backpatch($$->get_truelist(), label1);
				backpatch($$->get_falselist(), label2);
				$$->set_truelist(vector<int>());
				$$->set_falselist(vector<int>());

				gen_label(label1, get_lineno_comment(@1.first_line));
				gen_mov("AX", 1, get_lineno_comment(@1.first_line));
				gen_code("JMP " + label3, get_lineno_comment(@1.first_line));
				gen_label(label2, get_lineno_comment(@1.first_line));
				gen_mov("AX", 0, get_lineno_comment(@1.first_line));
				gen_label(label3, get_lineno_comment(@1.first_line));
			}
			else 
			{
				gen_pop("AX", get_lineno_comment(@1.first_line));
			}
			gen_neg("AX", get_lineno_comment(@1.first_line));
			gen_push("AX", get_lineno_comment(@1.first_line));
		}
	} 
	| 
	NOT unary_expression 
	{
		$$ = new SymbolInfo($2);
		if($2->get_data_type() == DataType::VOID)
		{
			error_default(@1.first_line, "Cannot use unary operator on void type");
		}
		else 
		{
			$$->set_truelist($2->get_falselist());
			$$->set_falselist($2->get_truelist());
		}
	}
	|
	factor 
	{
		$$ = $1;
	}
	;
	
factor	: 
	variable
	{
		$$ = new SymbolInfo($1);
		if($1->is_global())
		{
			if($1->get_array_size() < 0)
			{
				gen_push($1->get_lexeme(), get_lineno_comment(@1.first_line));
			}
			else 
			{
				gen_pop("SI", get_lineno_comment(@1.first_line));
				gen_push($1->get_lexeme()+"[SI]", get_lineno_comment(@1.first_line));
			}
		}
		else 
		{
			gen_pop("SI", get_lineno_comment(@1.first_line));
			gen_push("[BP+SI]", get_lineno_comment(@1.first_line));
		}	
	}
	| 
	ID LPAREN argument_list RPAREN
	{
		//semantic error checking
		SymbolInfo* symbol_info = symbol_table.lookup($1->get_lexeme());
		$$ = new SymbolInfo(symbol_info);

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
			SymbolInfo* func_info = (SymbolInfo*)symbol_info;
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
				gen_call($1->get_lexeme());
				gen_push("AX", get_lineno_comment(@1.first_line)); // push return value
			}
		}
		func_arg_types.clear();
	}
	| 
	LPAREN expression RPAREN
	{
		$$ = new SymbolInfo($2);
	}
	| 
	CONST_INT 
	{
		$1->set_data_type(DataType::INT);
		$$ = $1;
		gen_mov("AX", stoi($1->get_lexeme()), get_lineno_comment(@1.first_line));
		gen_push("AX", get_lineno_comment(@1.first_line));
	}
	| 
	CONST_FLOAT
	{
		$1->set_data_type(DataType::FLOAT);
		$$ = $1;
	}
	| 
	variable INCOP 
	{
		$$ = new SymbolInfo($1);
		if($1->is_global())
		{
			if($1->get_array_size() < 0)
			{
				gen_push($1->get_lexeme(), get_lineno_comment(@1.first_line));
				gen_code("INC W. " + $1->get_lexeme(), get_lineno_comment(@1.first_line));
			}
			else 
			{
				gen_pop("SI", get_lineno_comment(@1.first_line));
				gen_push($1->get_lexeme()+"[SI]", get_lineno_comment(@1.first_line));
				gen_code( "INC W. " + $1->get_lexeme()+"[SI]", get_lineno_comment(@1.first_line));
			}
		}
		else 
		{
			gen_pop("SI", get_lineno_comment(@1.first_line));
			gen_push("[BP+SI]", get_lineno_comment(@1.first_line));
			gen_code("INC W. [BP+SI]", get_lineno_comment(@1.first_line));
		}	
	}
	| 
	variable DECOP
	{
		$$ = new SymbolInfo($1);
		if($1->is_global())
		{
			if($1->get_array_size() < 0)
			{
				gen_push($1->get_lexeme(), get_lineno_comment(@1.first_line));
				gen_code("DEC W. " + $1->get_lexeme(), get_lineno_comment(@1.first_line));
			}
			else 
			{
				gen_pop("SI", get_lineno_comment(@1.first_line));
				gen_push($1->get_lexeme()+"[SI]", get_lineno_comment(@1.first_line));
				gen_code("DEC W. " + $1->get_lexeme()+"[SI]", get_lineno_comment(@1.first_line));
			}
		}
		else 
		{
			gen_pop("SI", get_lineno_comment(@1.first_line));
			gen_push("[BP+SI]", get_lineno_comment(@1.first_line));
			gen_code("DEC W. [BP+SI]", get_lineno_comment(@1.first_line));
		}	

	}
	;
	
argument_list : 
	arguments
	{
	}
	|
	{
	}
	;
	
arguments : 
	arguments COMMA logic_expression
	{
		func_arg_types.push_back($3->get_data_type());
	}
	| 
	logic_expression
	{
		func_arg_types.push_back($1->get_data_type());
	}
	;
 

%%


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
	error_file_name = input_file_name.substr(0,input_file_name.size()-2) + "_error.txt";
	asmcode_file_name = input_file_name.substr(0,input_file_name.size()-2) + "_asmcode.asm";
	optimized_asmcode_file_name = input_file_name.substr(0,input_file_name.size()-2) + "_optimized_asmcode.asm";
	code_segment_file_name = input_file_name.substr(0,input_file_name.size()-2) + "_code_segment.asm";

	error_file.open(error_file_name);
  	yyscan_t scanner_context;
	yylex_init( &scanner_context);
	yyset_in(input_file,scanner_context);
	yyparse(scanner_context);
	yylex_destroy(scanner_context);

	fclose(input_file);
	error_file.close();

  	return 0;
}
