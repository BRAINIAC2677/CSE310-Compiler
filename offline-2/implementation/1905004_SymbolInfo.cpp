#include "1905004_SymbolInfo.hpp"

SymbolInfo *NULL_SYMBOL_INFO = new SymbolInfo("nullptr", "nullptr");

SymbolInfo::SymbolInfo(string name, string type, SymbolInfo *next_symbol_info) noexcept : name(name), type(type), next_symbol_info(next_symbol_info) {}

SymbolInfo::~SymbolInfo() noexcept {}

string SymbolInfo::get_name() const noexcept
{
    return this->name;
}

string SymbolInfo::get_type() const noexcept
{
    return this->type;
}

SymbolInfo *SymbolInfo::get_next_symbol_info() const noexcept
{
    return this->next_symbol_info;
}

void SymbolInfo::set_name(string name) noexcept
{
    this->name = name;
}

void SymbolInfo::set_type(string type) noexcept
{
    this->type = type;
}

void SymbolInfo::set_next_symbol_info(SymbolInfo *next_symbol_info) noexcept
{
    this->next_symbol_info = next_symbol_info;
}
