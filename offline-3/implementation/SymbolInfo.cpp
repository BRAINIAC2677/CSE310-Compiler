#include "SymbolInfo.hpp"

SymbolInfo *NULL_SYMBOL_INFO = (new SymbolInfo())->set_name("nullptr")->set_type("nullptr")->set_array_size(0)->set_function_info(nullptr)->set_next_symbol_info(nullptr);

SymbolInfo::SymbolInfo() noexcept : name(""), type(""), array_size(0), function_info(nullptr), next_symbol_info(nullptr) {}

string SymbolInfo::get_name() const noexcept
{
    return this->name;
}

string SymbolInfo::get_type() const noexcept
{
    return this->type;
}

int SymbolInfo::get_array_size() const noexcept
{
    return this->array_size;
}

FunctionInfo *SymbolInfo::get_function_info() const noexcept
{
    return this->function_info;
}

SymbolInfo *SymbolInfo::get_next_symbol_info() const noexcept
{
    return this->next_symbol_info;
}

SymbolInfo *SymbolInfo::set_name(string name) noexcept
{
    this->name = name;
    return this;
}

SymbolInfo *SymbolInfo::set_type(string type) noexcept
{
    this->type = type;
    return this;
}

SymbolInfo *SymbolInfo::set_array_size(int array_size) noexcept
{
    this->array_size = array_size;
    return this;
}

SymbolInfo *SymbolInfo::set_function_info(FunctionInfo *function_info) noexcept
{
    this->function_info = function_info;
    return this;
}

SymbolInfo *SymbolInfo::set_next_symbol_info(SymbolInfo *next_symbol_info) noexcept
{
    this->next_symbol_info = next_symbol_info;
    return this;
}
