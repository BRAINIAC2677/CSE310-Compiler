#include "SymbolTable.hpp"

#include <bits/stdc++.h>
#include <fstream>
#include <vector>
using namespace std;

vector<string> tokenize(string line, char delimiter = ' ')
{
    char carriage_return = '\r';
    if (line.back() == carriage_return)
    {
        line.pop_back();
    }
    vector<string> tokens;
    string token;
    stringstream line_stream(line);
    while (getline(line_stream, token, delimiter))
    {
        tokens.push_back(token);
    }
    return tokens;
}

bool is_valid_insertion(vector<string> tokens)
{
    return tokens.size() == 3;
}

bool is_valid_lookup(vector<string> tokens)
{
    return tokens.size() == 2;
}

bool is_valid_deletion(vector<string> tokens)
{
    return tokens.size() == 2;
}

bool is_valid_print(vector<string> tokens)
{
    return tokens.size() == 2 && (tokens[1] == "A" || tokens[1] == "C");
}

bool is_valid_enter_scope(vector<string> tokens)
{
    return tokens.size() == 1;
}

bool is_valid_exit_scope(vector<string> tokens)
{
    return tokens.size() == 1;
}

int main()
{
    ifstream fin("input.txt");
    ofstream fout("output.txt");

    int number_of_buckets_in_scope;
    fin >> number_of_buckets_in_scope;

    string waste;
    getline(fin, waste);

    SymbolTable symbol_table(number_of_buckets_in_scope);
    fout << "    ScopeTable# " << symbol_table.get_current_scope()->get_scope_id() << " created\n";

    for (auto command_count = 1;; command_count++)
    {
        string line;
        getline(fin, line);
        fout << "Cmd " << command_count << ": " << line << "\n";
        // fout << symbol_table << "\n";

        auto tokens = tokenize(line);
        auto code = tokens[0];

        if (code == "I")
        {
            if (is_valid_insertion(tokens))
            {
                auto name = tokens[1];
                auto type = tokens[2];
                auto symbol_info = SymbolInfo(name, type);
                auto is_inserted = symbol_table.insert(symbol_info);
                if (is_inserted)
                {
                    auto position = symbol_table.find_position(name);
                    fout << "    Inserted in ScopeTable# " << get<0>(position) << " at position " << get<1>(position) << ", " << get<2>(position) << "\n";
                }
                else
                {
                    fout << "    '" << name << "' already exists in the current ScopeTable\n";
                }
            }
            else
            {
                fout << "    Numbers of parameters mismatch for the command I\n";
            }
        }
        else if (code == "L")
        {
            if (is_valid_lookup(tokens))
            {
                auto name = tokens[1];
                auto position = symbol_table.find_position(name);
                if (get<0>(position) == -1)
                {
                    fout << "   '" << name << "' not found in any of the ScopeTables\n";
                }
                else
                {
                    fout << "    '" << name << "' found in ScopeTable# " << get<0>(position) << " at position " << get<1>(position) << ", " << get<2>(position) << "\n";
                }
            }
            else
            {
                fout << "    Number of parameters mismatch for the command L\n";
            }
        }
        else if (code == "D")
        {
            if (is_valid_deletion(tokens))
            {
                auto name = tokens[1];
                auto position = symbol_table.find_position(name);
                if (get<0>(position) != symbol_table.get_current_scope()->get_scope_id())
                {
                    fout << "     Not found in the current ScopeTable\n";
                }
                else
                {
                    auto is_deleted = symbol_table.remove(name);
                    fout << "   Deleted '" << name << "' from ScopeTable# " << get<0>(position) << " at position " << get<1>(position) << ", " << get<2>(position) << "\n";
                }
            }
            else
            {
                fout << "    Numbers of parameters mismatch for the command D\n";
            }
        }
        else if (code == "P")
        {
            if (is_valid_print(tokens))
            {
                if (tokens[1] == "A")
                {
                    fout << symbol_table;
                }
                else if (tokens[1] == "C")
                {
                    fout << *(symbol_table.get_current_scope());
                }
            }
            else
            {
                fout << "    Numbers of parameters mismatch or invalid parameters for the command P\n";
            }
        }
        else if (code == "S")
        {
            if (is_valid_enter_scope(tokens))
            {
                symbol_table.enter_scope();
                fout << "    ScopeTable# " << symbol_table.get_current_scope()->get_scope_id() << " created\n";
            }
            else
            {
                fout << "    Numbers of parameters mismatch for the command S\n";
            }
        }
        else if (code == "E")
        {
            if (is_valid_exit_scope(tokens))
            {
                if (symbol_table.get_current_scope()->get_parent_scope() != nullptr)
                {
                    fout << "    ScopeTable# " << symbol_table.get_current_scope()->get_scope_id() << " removed\n";
                    symbol_table.exit_scope();
                }
                else
                {
                    fout << "    ScopeTable# " << symbol_table.get_current_scope()->get_scope_id() << " cannot be removed\n";
                }
            }
            else
            {
                fout << "    Numbers of parameters mismatch for the command E\n";
            }
        }
        else if (code == "Q")
        {
            while (symbol_table.get_current_scope() != nullptr)
            {
                fout << "    ScopeTable# " << symbol_table.get_current_scope()->get_scope_id() << " removed\n";
                symbol_table.exit_scope();
            }
            break;
        }
    }

    return 0;
}