#pragma once

#include <bits/stdc++.h>
using namespace std;

typedef enum
{
  START,
  PROGRAM,
  UNIT,
  FUNC_DECLARATION,
  FUNC_DEFINITION,
  PARAMETER_LIST,
  COMPOUND_STATEMENT,
  VAR_DECLARATION,
  TYPE_SPECIFIER,
  DECLARATION_LIST,
  STATEMENTS,
  STATEMENT,
  EXPRESSION_STATEMENT,
  VARIABLE,
  EXPRESSION,
  LOGIC_EXPRESSION,
  REL_EXPRESSION,
  SIMPLE_EXPRESSION,
  TERM,
  UNARY_EXPRESSION,
  FACTOR,
  ARGUMENT_LIST,
  ARGUMENTS,

  IF,
  ELSE,
  WHILE,
  FOR,
  RETURN,
  INT,
  FLOAT,
  VOID,
  ADDOP,
  MULOP,
  INCOP,
  DECOP,
  RELOP,
  ASSIGNOP,
  LOGICOP,
  NOT,
  LPAREN,
  RPAREN,
  LCURL,
  RCURL,
  LTHIRD,
  RTHIRD,
  SEMICOLON,
  COMMA,
  PRINTLN,
  ID,
  CONST_INT,
  CONST_FLOAT,

  FUNC_ID,
  VAR_ID,

  NULL_SYMBOL
} SYMBOLTYPE;

class SymbolInfo
{
private:
  string lexeme;
  SYMBOLTYPE type;
  SymbolInfo *next_symbol_info;

public:
  SymbolInfo() noexcept;
  SymbolInfo(SymbolInfo *symbol_info) noexcept;

  string get_lexeme() const noexcept;
  SYMBOLTYPE get_type() const noexcept;
  SymbolInfo *get_next_symbol_info() const noexcept;

  SymbolInfo *set_lexeme(string lexeme) noexcept;
  SymbolInfo *set_type(SYMBOLTYPE type) noexcept;
  SymbolInfo *set_next_symbol_info(SymbolInfo *next_symbol_info) noexcept;
};

class FuncInfo : public SymbolInfo
{
  SYMBOLTYPE return_type_specifier;
  vector<SYMBOLTYPE> param_type_specifier;

public:
  FuncInfo() noexcept;

  bool is_return_type_same(SYMBOLTYPE arg_return_type_specifier);
  bool is_param_type_same(vector<SYMBOLTYPE> arg_param_type_specifier);
};

class VarInfo : public SymbolInfo
{
  SYMBOLTYPE type_specifier;
  int array_size; //-1 means the variable is not an array

public:
  VarInfo() noexcept;
  VarInfo(SymbolInfo *symbol_info) noexcept;

  SYMBOLTYPE get_type_specifier();
  int get_array_size();

  VarInfo *set_type_specifier(SYMBOLTYPE type_specifier);
  VarInfo *set_array_size(int array_size);

  bool is_type_same(SYMBOLTYPE arg_type_specifier);
  bool is_array();
};

extern SymbolInfo *NULL_SYMBOL_INFO;
