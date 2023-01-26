#pragma once

#include "ScopeTable.hpp"

class SymbolTable
{
private:
    int next_scope_id, number_of_buckets_in_scopes;
    ScopeTable *current_scope;

public:
    SymbolTable(int number_of_buckets_in_scopes = 7) noexcept;
    ~SymbolTable() noexcept;

    ScopeTable *get_current_scope() const noexcept;

    void enter_scope() noexcept;
    bool exit_scope() noexcept;
    bool insert(SymbolInfo *symbol_info) noexcept;
    bool remove(string symbol_lexeme) noexcept;
    SymbolInfo *lookup(string symbol_lexeme) const;
    tuple<int, int, int> find_position(string symbol_lexeme) const noexcept;
    friend ostream &operator<<(ostream &out, SymbolTable &symbol_table) noexcept;
};
