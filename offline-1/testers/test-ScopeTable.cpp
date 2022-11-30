#include "SymbolTable.hpp"

#include <iostream>
using namespace std;

int main()
{
    ScopeTable scope_table(1, 7);

    // testing getters
    cout << "scope id: " << scope_table.get_scope_id() << endl;
    cout << "parent scope: " << scope_table.get_parent_scope() << endl;

    // testing insertion
    cout << scope_table << endl;
    SymbolInfo symbol_info1("asif", "id");
    SymbolInfo symbol_info2("if", "if");
    scope_table.insert(symbol_info1);
    scope_table.insert(symbol_info2);
    cout << scope_table << endl;

    // testing lookup
    cout << scope_table.look_up("asif") << endl;
    cout << scope_table.look_up("if") << endl;
    cout << scope_table.look_up("ifas") << endl;

    // testing find_position
    cout << scope_table.find_position("asif").first << " " << scope_table.find_position("asif").second << endl;
    cout << scope_table.find_position("if").first << " " << scope_table.find_position("if").second << endl;
    cout << scope_table.find_position("ifas").first << " " << scope_table.find_position("ifas").second << endl;

    // testing remove
    cout << scope_table.remove("if") << endl;
    cout << scope_table << endl;

    return 0;
}