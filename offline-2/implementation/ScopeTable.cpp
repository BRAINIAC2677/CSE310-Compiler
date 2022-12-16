#include "ScopeTable.hpp"

#include <iostream>
using namespace std;

ScopeTable::ScopeTable(int scope_id, int number_of_buckets, ScopeTable *parent_scope) noexcept : scope_id(scope_id), number_of_buckets(number_of_buckets), parent_scope(parent_scope)
{
    this->buckets = new SymbolInfo *[number_of_buckets];
    for (int i = 0; i < number_of_buckets; i++)
    {
        this->buckets[i] = nullptr;
    }
}

ScopeTable::~ScopeTable() noexcept
{
    for (int i = 0; i < number_of_buckets; i++)
    {
        auto current_symbol_info = buckets[i];
        while (current_symbol_info != nullptr)
        {
            auto next_symbol_info = current_symbol_info->get_next_symbol_info();
            delete current_symbol_info;
            current_symbol_info = next_symbol_info;
        }
    }
    delete[] buckets;
}

ScopeTable *ScopeTable::get_parent_scope() const noexcept
{
    return parent_scope;
}

int ScopeTable::get_scope_id() const noexcept
{
    return scope_id;
}

void ScopeTable::set_parent_scope(ScopeTable *parent_scope) noexcept
{
    this->parent_scope = parent_scope;
}

bool ScopeTable::insert(SymbolInfo symbol_info) noexcept
{
    if (lookup(symbol_info.get_name()) == NULL_SYMBOL_INFO)
    {
        SymbolInfo *new_symbol_info = new SymbolInfo(
            symbol_info.get_name(),
            symbol_info.get_type());

        auto hashed_index = SDBMHash(new_symbol_info->get_name());
        auto last_symbol_info = get_last_symbol_info(hashed_index);

        if (last_symbol_info == nullptr)
        {
            buckets[hashed_index] = new_symbol_info;
        }
        else
        {
            last_symbol_info->set_next_symbol_info(new_symbol_info);
        }
        return true;
    }
    else
    {
        return false;
    }
}

SymbolInfo *ScopeTable::lookup(string symbol_name) const noexcept
{
    auto hashed_index = SDBMHash(symbol_name);
    auto current_symbol_info = buckets[hashed_index];

    while (current_symbol_info != nullptr)
    {
        if (current_symbol_info->get_name() == symbol_name)
        {
            return current_symbol_info;
        }
        current_symbol_info = current_symbol_info->get_next_symbol_info();
    }

    return NULL_SYMBOL_INFO;
}

pair<int, int> ScopeTable::find_position(string symbol_name) const noexcept
{
    auto row_index = static_cast<int>(SDBMHash(symbol_name));
    auto col_index = 0;

    for (auto current_symbol_info = buckets[row_index]; current_symbol_info != nullptr; current_symbol_info = current_symbol_info->get_next_symbol_info(), col_index++)
    {
        if (current_symbol_info->get_name() == symbol_name)
        {
            return make_pair(row_index + 1, col_index + 1);
        }
    }
    return make_pair(-1, -1);
}

bool ScopeTable::remove(string symbol_name) noexcept
{
    auto hashed_index = SDBMHash(symbol_name);
    auto current_symbol_info = buckets[hashed_index];
    SymbolInfo *previous_symbol_info = nullptr;

    while (current_symbol_info != nullptr)
    {
        if (current_symbol_info->get_name() == symbol_name)
        {
            if (previous_symbol_info == nullptr)
            {
                buckets[hashed_index] = current_symbol_info->get_next_symbol_info();
            }
            else
            {
                previous_symbol_info->set_next_symbol_info(current_symbol_info->get_next_symbol_info());
            }
            delete current_symbol_info;
            return true;
        }
        previous_symbol_info = current_symbol_info;
        current_symbol_info = current_symbol_info->get_next_symbol_info();
    }

    return false;
}

ostream &operator<<(ostream &out, ScopeTable &scope_table) noexcept
{
    out << "\tScopeTable# " << scope_table.scope_id << endl;

    for (auto i = 0; i < scope_table.number_of_buckets; i++)
    {
        if (scope_table.buckets[i] == nullptr)
        {
            continue;
        }
        out << "\t" << (i + 1) << "--> ";
        auto current_symbol_info = scope_table.buckets[i];
        while (current_symbol_info != nullptr)
        {
            out << "<" << current_symbol_info->get_name() << "," << current_symbol_info->get_type() << "> ";
            current_symbol_info = current_symbol_info->get_next_symbol_info();
        }
        out << endl;
    }

    return out;
}

unsigned long long int ScopeTable::SDBMHash(string str) const noexcept
{
    auto hash = static_cast<unsigned long long int>(0);
    auto len = str.length();

    for (auto i = 0; i < len; i++)
    {
        hash = (str[i]) + (hash << 6) + (hash << 16) - hash;
    }

    return hash % number_of_buckets;
}

SymbolInfo *ScopeTable::get_last_symbol_info(int hashed_index) const noexcept
{
    auto last_symbol_info = buckets[hashed_index];
    while (last_symbol_info != nullptr && last_symbol_info->get_next_symbol_info() != nullptr)
    {
        last_symbol_info = last_symbol_info->get_next_symbol_info();
    }
    return last_symbol_info;
}