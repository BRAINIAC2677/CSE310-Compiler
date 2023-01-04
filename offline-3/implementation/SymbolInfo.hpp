#pragma once

#include <string>
using namespace std;

#include "FunctionInfo.hpp"

class SymbolInfo
{
private:
    string name, type;
    int array_size;
    FunctionInfo *function_info;
    SymbolInfo *next_symbol_info;

public:
    SymbolInfo() noexcept;

    string get_name() const noexcept;
    string get_type() const noexcept;
    int get_array_size() const noexcept;
    FunctionInfo *get_function_info() const noexcept;
    SymbolInfo *get_next_symbol_info() const noexcept;

    SymbolInfo *set_name(string name) noexcept;
    SymbolInfo *set_type(string type) noexcept;
    SymbolInfo *set_array_size(int array_size) noexcept;
    SymbolInfo *set_function_info(FunctionInfo *function_info) noexcept;
    SymbolInfo *set_next_symbol_info(SymbolInfo *next_symbol_info) noexcept;
};

extern SymbolInfo *NULL_SYMBOL_INFO;
