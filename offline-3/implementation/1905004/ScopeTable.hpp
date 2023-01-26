#pragma once

#include "SymbolInfo.hpp"

#include <iostream>
using namespace std;

class ScopeTable
{
private:
    int scope_id, number_of_buckets;
    ScopeTable *parent_scope;
    SymbolInfo **buckets;

public:
    ScopeTable(int scope_id, int number_of_buckets, ScopeTable *parent_scope = nullptr) noexcept;
    ~ScopeTable() noexcept;

    int get_scope_id() const noexcept;
    ScopeTable *get_parent_scope() const noexcept;

    void set_parent_scope(ScopeTable *parent_scope) noexcept;

    bool insert(SymbolInfo *symbol_info) noexcept;
    SymbolInfo *lookup(string symbol_lexeme) const noexcept;
    pair<int, int> find_position(string symbol_lexeme) const noexcept;
    bool remove(string symbol_lexeme) noexcept;
    friend ostream &operator<<(ostream &out, ScopeTable &scope_table) noexcept;

private:
    unsigned long long int SDBMHash(string str) const noexcept;
    SymbolInfo *get_last_symbol_info(int hashed_index) const noexcept;
};
