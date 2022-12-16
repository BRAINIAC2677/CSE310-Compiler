#include "SymbolTable.hpp"

#include <tuple>
using namespace std;

SymbolTable::SymbolTable(int number_of_buckets_in_scopes) noexcept : next_scope_id(1), number_of_buckets_in_scopes(number_of_buckets_in_scopes), current_scope(nullptr)
{
    enter_scope();
}

SymbolTable::~SymbolTable() noexcept {}

ScopeTable *SymbolTable::get_current_scope() const noexcept
{
    return current_scope;
}

void SymbolTable::enter_scope() noexcept
{
    auto new_scope = new ScopeTable(next_scope_id++, number_of_buckets_in_scopes);
    new_scope->set_parent_scope(current_scope);
    current_scope = new_scope;
}

bool SymbolTable::exit_scope() noexcept
{
    if (current_scope->get_parent_scope() != nullptr)
    {
        current_scope = current_scope->get_parent_scope();
        return true;
    }
    return false;
}

bool SymbolTable::insert(SymbolInfo symbol_info) noexcept
{
    return current_scope->insert(symbol_info);
}

bool SymbolTable::remove(string symbol_name) noexcept
{
    return current_scope->remove(symbol_name);
}

SymbolInfo *SymbolTable::lookup(string symbol_name) const
{
    for (auto scope = current_scope; scope != nullptr; scope = scope->get_parent_scope())
    {
        auto symbol_info_from_scope = scope->lookup(symbol_name);
        if (symbol_info_from_scope != NULL_SYMBOL_INFO)
        {
            return symbol_info_from_scope;
        }
    }
    return NULL_SYMBOL_INFO;
}

tuple<int, int, int> SymbolTable::find_position(string symbol_name) const noexcept
{
    for (auto scope = current_scope; scope != nullptr; scope = scope->get_parent_scope())
    {
        auto position_in_scope_table = scope->find_position(symbol_name);
        if (position_in_scope_table.first != -1)
        {
            return make_tuple(scope->get_scope_id(), position_in_scope_table.first, position_in_scope_table.second);
        }
    }
    return make_tuple(-1, -1, -1);
}

ostream &operator<<(ostream &out, SymbolTable &symbol_table) noexcept
{
    for (auto scope = symbol_table.get_current_scope(); scope != nullptr; scope = scope->get_parent_scope())
    {
        out << *scope;
    }
    return out;
}