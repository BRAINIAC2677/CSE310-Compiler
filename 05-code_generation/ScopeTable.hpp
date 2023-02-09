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

    int current_offset;
    int base_offset;

public:
    ScopeTable(int scope_id, int number_of_buckets, ScopeTable *parent_scope = nullptr) noexcept;
    ~ScopeTable() noexcept;

    int get_scope_id() const noexcept;
    ScopeTable *get_parent_scope() const noexcept;
    int get_current_offset() const noexcept;
    int get_base_offset() const noexcept;

    ScopeTable *set_parent_scope(ScopeTable *parent_scope) noexcept;
    ScopeTable *set_current_offset(int _current_offset) noexcept;
    ScopeTable *set_base_offset(int _base_offset) noexcept;

    bool insert(SymbolInfo *symbol_info) noexcept;
    SymbolInfo *lookup(string symbol_lexeme) const noexcept;
    pair<int, int> find_position(string symbol_lexeme) const noexcept;
    bool remove(string symbol_lexeme) noexcept;
    friend ostream &operator<<(ostream &out, ScopeTable &scope_table) noexcept;
    ScopeTable *inc_current_offset(int _increment = 2) noexcept;

private:
    unsigned long long int SDBMHash(string str) const noexcept;
    SymbolInfo *get_last_symbol_info(int hashed_index) const noexcept;
};