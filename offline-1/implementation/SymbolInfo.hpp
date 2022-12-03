#pragma once

#include <string>
using namespace std;

class SymbolInfo
{
private:
    string name, type;
    SymbolInfo *next_symbol_info;

public:
    SymbolInfo(string name, string type, SymbolInfo *next_symbol_info = nullptr) noexcept;
    ~SymbolInfo() noexcept;

    string get_name() const noexcept;
    string get_type() const noexcept;
    SymbolInfo *get_next_symbol_info() const noexcept;

    void set_name(string name) noexcept;
    void set_type(string type) noexcept;
    void set_next_symbol_info(SymbolInfo *next_symbol_info) noexcept;
};

extern SymbolInfo *NULL_SYMBOL_INFO;