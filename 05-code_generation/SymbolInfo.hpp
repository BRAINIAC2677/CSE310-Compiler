#pragma once

#include <string>
using namespace std;

#include "parser.h"
#include "ParseTree.hpp"

typedef enum TokenType
{
    SI_IF,
    SI_WHILE,
    SI_FOR,
    SI_RETURN,
    SI_INT,
    SI_FLOAT,
    SI_VOID,
    SI_LPAREN,
    SI_LCURL,
    SI_RCURL,
    SI_LTHIRD,
    SI_RTHIRD,
    SI_SEMICOLON,
    SI_COMMA,
    SI_PRINTLN,
    SI_ID,
    SI_RPAREN,
    SI_ELSE,
    SI_ASSIGNOP,
    SI_LOGICOP,
    SI_RELOP,
    SI_ADDOP,
    SI_MULOP,
    SI_NOT,
    SI_INCOP,
    SI_DECOP,
    SI_CONST_INT,
    SI_CONST_FLOAT,
    SI_VAR_ID,
    SI_FUNC_DECL_ID,
    SI_FUNC_DEF_ID,
    SI_NULL
} TokenType;

class SymbolInfo
{
protected:
    string lexeme;
    TokenType type;
    SymbolInfo *next_symbol_info;

public:
    SymbolInfo() noexcept;
    ~SymbolInfo() noexcept;

    string get_lexeme() const noexcept;
    TokenType get_type() const noexcept;
    SymbolInfo *get_next_symbol_info() const noexcept;

    SymbolInfo *set_lexeme(string lexeme) noexcept;
    SymbolInfo *set_type(TokenType type) noexcept;
    SymbolInfo *set_next_symbol_info(SymbolInfo *next_symbol_info) noexcept;
};

class VarInfo : public SymbolInfo
{
    DataType data_type;
    int array_size; //-1 means not an array

    bool global;
    int start_offset;

public:
    VarInfo() noexcept;
    ~VarInfo() noexcept;

    DataType get_data_type() const noexcept;
    int get_array_size() const noexcept;
    bool is_global() const noexcept;
    int get_start_offset() const noexcept;

    VarInfo *set_lexeme(string lexeme) noexcept;
    VarInfo *set_type(TokenType type) noexcept;
    VarInfo *set_data_type(DataType _data_type) noexcept;
    VarInfo *set_array_size(int _array_size) noexcept;
    VarInfo *set_global(bool _global) noexcept;
    VarInfo *set_start_offset(int _start_offset) noexcept;

    string
    get_address() const noexcept;
};

class FuncInfo : public SymbolInfo
{
    DataType return_type;
    vector<DataType> param_types;

public:
    FuncInfo() noexcept;
    ~FuncInfo() noexcept;

    DataType get_return_type() const noexcept;
    vector<DataType> get_param_types() const noexcept;

    FuncInfo *set_lexeme(string lexeme) noexcept;
    FuncInfo *set_type(TokenType type) noexcept;
    FuncInfo *set_return_type(DataType _return_type) noexcept;
    FuncInfo *set_param_types(vector<DataType> _param_types) noexcept;

    bool is_compatible_with(FuncInfo *func_info) noexcept;
};

extern SymbolInfo *NULL_SYMBOL_INFO;
