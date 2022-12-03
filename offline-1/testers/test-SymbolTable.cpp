#include "SymbolTable.hpp"

#include <iostream>
#include <tuple>
using namespace std;

int main()
{
    SymbolTable symbol_table;

    // testing getters
    cout << "Current scope: " << symbol_table.get_current_scope() << endl;

    // testing enter_scope()
    cout << symbol_table << endl;
    symbol_table.enter_scope();
    cout << symbol_table << endl;

    // testing exit_scope()
    symbol_table.exit_scope();
    cout << symbol_table << endl;

    // testing insert()
    symbol_table.insert(SymbolInfo("a", "int"));
    symbol_table.enter_scope();
    symbol_table.insert(SymbolInfo("b", "int"));
    cout << symbol_table << endl;

    // testing lookup()
    cout << "Look up a: " << (symbol_table.lookup("a")->get_name()) << endl;
    cout << "Look up b: " << (symbol_table.lookup("b")->get_name()) << endl;

    // testing remove()
    cout << symbol_table.remove("b") << endl;
    cout << symbol_table << endl;
    cout << symbol_table.remove("a") << endl;
    cout << symbol_table << endl;

    // testing find_position()
    cout << "Find position of a: " << get<0>(symbol_table.find_position("a")) << " " << get<1>(symbol_table.find_position("a")) << " " << get<2>(symbol_table.find_position("a")) << endl;

    // printing current scope
    (cout < symbol_table) << "\n";

    return 0;
}