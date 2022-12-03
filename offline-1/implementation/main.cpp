#include "SymbolTable.hpp"

#include <fstream>
#include <sstream>
#include <tuple>
#include <vector>
using namespace std;

enum class CommandCode : char
{
    INSERT = 'I',
    LOOKUP = 'L',
    DELETE = 'D',
    PRINT = 'P',
    ENTER_SCOPE = 'S',
    EXIT_SCOPE = 'E',
    QUIT = 'Q'
};

string remove_crlf(string line)
{
    char carriage_return = '\r';
    char line_feed = '\n';

    if (line.back() == carriage_return)
    {
        line.pop_back();
    }
    if (line.back() == line_feed)
    {
        line.pop_back();
    }

    return line;
}

vector<string> tokenize(string line, char delimiter = ' ')
{
    line = remove_crlf(line);

    string token;
    vector<string> tokens;
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

    int number_of_buckets_in_scopes;
    fin >> number_of_buckets_in_scopes;

    string waste;
    getline(fin, waste);

    SymbolTable symbol_table(number_of_buckets_in_scopes);
    fout << "\tScopeTable# " << symbol_table.get_current_scope()->get_scope_id() << " created\n";

    for (auto command_count = 1;; command_count++)
    {
        string line;
        getline(fin, line);
        fout << "Cmd " << command_count << ": " << line << "\n";

        auto tokens = tokenize(line);
        auto code = static_cast<CommandCode>(tokens[0][0]);

        if (code == CommandCode::INSERT)
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
                    fout << "\tInserted in ScopeTable# " << get<0>(position) << " at position " << get<1>(position) << ", " << get<2>(position) << "\n";
                }
                else
                {
                    fout << "\t'" << name << "' already exists in the current ScopeTable\n";
                }
            }
            else
            {
                fout << "\tNumber of parameters mismatch for the command I\n";
            }
        }
        else if (code == CommandCode::LOOKUP)
        {
            if (is_valid_lookup(tokens))
            {
                auto name = tokens[1];
                auto position = symbol_table.find_position(name);

                if (get<0>(position) == -1)
                {
                    fout << "\t'" << name << "' not found in any of the ScopeTables\n";
                }
                else
                {
                    fout << "\t'" << name << "' found in ScopeTable# " << get<0>(position) << " at position " << get<1>(position) << ", " << get<2>(position) << "\n";
                }
            }
            else
            {
                fout << "\tNumber of parameters mismatch for the command L\n";
            }
        }
        else if (code == CommandCode::DELETE)
        {
            if (is_valid_deletion(tokens))
            {
                auto name = tokens[1];
                auto position = symbol_table.find_position(name);

                if (get<0>(position) != symbol_table.get_current_scope()->get_scope_id())
                {
                    fout << "\tNot found in the current ScopeTable\n";
                }
                else
                {
                    auto is_deleted = symbol_table.remove(name);
                    fout << "\tDeleted '" << name << "' from ScopeTable# " << get<0>(position) << " at position " << get<1>(position) << ", " << get<2>(position) << "\n";
                }
            }
            else
            {
                fout << "\tNumber of parameters mismatch for the command D\n";
            }
        }
        else if (code == CommandCode::PRINT)
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
                fout << "\tNumber of parameters mismatch or invalid parameters for the command P\n";
            }
        }
        else if (code == CommandCode::ENTER_SCOPE)
        {
            if (is_valid_enter_scope(tokens))
            {
                symbol_table.enter_scope();
                fout << "\tScopeTable# " << symbol_table.get_current_scope()->get_scope_id() << " created\n";
            }
            else
            {
                fout << "\tNumber of parameters mismatch for the command S\n";
            }
        }
        else if (code == CommandCode::EXIT_SCOPE)
        {
            if (is_valid_exit_scope(tokens))
            {
                if (symbol_table.get_current_scope()->get_parent_scope() != nullptr)
                {
                    fout << "\tScopeTable# " << symbol_table.get_current_scope()->get_scope_id() << " removed\n";
                    symbol_table.exit_scope();
                }
                else
                {
                    fout << "\tScopeTable# " << symbol_table.get_current_scope()->get_scope_id() << " cannot be removed\n";
                }
            }
            else
            {
                fout << "\tNumber of parameters mismatch for the command E\n";
            }
        }
        else if (code == CommandCode::QUIT)
        {
            while (symbol_table.get_current_scope() != nullptr)
            {
                fout << "\tScopeTable# " << symbol_table.get_current_scope()->get_scope_id() << " removed\n";
                symbol_table.exit_scope();
            }
            break;
        }
    }

    return 0;
}