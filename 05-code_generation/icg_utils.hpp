#pragma once

#include <string>
using namespace std;

string gen_starting_code();
string gen_newline();
string gen_2scomp();
string gen_print();
string gen_println();
string gen_ending_code();
string gen_func_starting_code(string _func_name);
string gen_func_ending_code(string _func_name, int _arg_size);