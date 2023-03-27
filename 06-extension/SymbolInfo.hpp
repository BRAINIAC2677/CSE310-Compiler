#pragma once

#include <bits/stdc++.h>
using namespace std;

#include "parser.h"

typedef enum
{
    INT,
    FLOAT,
    CHAR,
    VOID,
    NULL_TYPE
} DataType;
extern map<DataType, string> data_type_to_string;

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
    SI_CONST_CHAR,
    SI_VAR_ID,
    SI_FUNC_DECL_ID,
    SI_FUNC_DEF_ID,
    SI_NULL
} TokenType;

class SymbolInfo
{
    string lexeme;
    TokenType type;
    SymbolInfo *next_symbol_info;

    DataType data_type;
    int array_size;
    bool global;
    int start_offset;

    vector<DataType> param_types;

    vector<int> truelist, falselist, nextlist;

public:
    SymbolInfo() noexcept;
    SymbolInfo(SymbolInfo *_symbol_info) noexcept;
    ~SymbolInfo() noexcept;

    string get_lexeme() const noexcept;
    TokenType get_type() const noexcept;
    SymbolInfo *get_next_symbol_info() const noexcept;
    DataType get_data_type() const noexcept;
    int get_array_size() const noexcept;
    bool is_global() const noexcept;
    int get_start_offset() const noexcept;
    DataType get_return_type() const noexcept;
    vector<DataType> get_param_types() const noexcept;
    vector<int> get_truelist() const noexcept;
    vector<int> get_falselist() const noexcept;
    vector<int> get_nextlist() const noexcept;

    SymbolInfo *set_lexeme(string _lexeme) noexcept;
    SymbolInfo *set_type(TokenType _type) noexcept;
    SymbolInfo *set_next_symbol_info(SymbolInfo *_next_symbol_info) noexcept;
    SymbolInfo *set_data_type(DataType _data_type) noexcept;
    SymbolInfo *set_array_size(int _array_size) noexcept;
    SymbolInfo *set_global(bool _global) noexcept;
    SymbolInfo *set_start_offset(int _start_offset) noexcept;
    SymbolInfo *set_return_type(DataType _return_type) noexcept;
    SymbolInfo *set_param_types(vector<DataType> _param_types) noexcept;
    SymbolInfo *set_truelist(vector<int> _truelist) noexcept;
    SymbolInfo *set_falselist(vector<int> _falselist) noexcept;
    SymbolInfo *set_nextlist(vector<int> _nextlist) noexcept;

    string get_address() const noexcept;
    bool is_compatible_with(SymbolInfo *symbol_info) noexcept;
    SymbolInfo *add_to_truelist(int _lineno) noexcept;
    SymbolInfo *add_to_falselist(int _lineno) noexcept;
    SymbolInfo *add_to_nextlist(int _lineno) noexcept;
    bool has_jump() const noexcept;
};

extern SymbolInfo *NULL_SYMBOL_INFO;
