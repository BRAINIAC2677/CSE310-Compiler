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
string gen_code(string _code);
string gen_code(string _code, string _comment);
string gen_push(string _reg);
string gen_push(string _reg, string _comment);
string gen_push(int _val);
string gen_push(int _val, string _comment);
string gen_pop(string _reg);
string gen_pop(string _reg, string _comment);
string gen_mov(string _reg1, string _reg2);
string gen_mov(string _reg1, string _reg2, string _comment);
string gen_mov(string _reg1, int _val);
string gen_mov(string _reg1, int _val, string _comment);
string gen_call(string _func_name);
string gen_call(string _func_name, string _comment);
string gen_sub(string _reg1, string _reg2);
string gen_sub(string _reg1, string _reg2, string _comment);
string gen_sub(string _reg, int _val);
string gen_sub(string _reg1, int _val, string _comment);
string gen_add(string _reg1, string _reg2);
string gen_add(string _reg1, string _reg2, string _comment);
string gen_add(string _reg, int _val);
string gen_add(string _reg1, int _val, string _comment);
string gen_neg(string _reg);
string gen_neg(string _reg, string _comment);
string gen_cmp(string _reg1, string _reg2);
string gen_cmp(string _reg1, string _reg2, string _comment);
string gen_cmp(string _reg1, int _val);
string gen_cmp(string _reg1, int _val, string _comment);
string gen_label(string _label);
string gen_label(string _label, string _comment);
string gen_imul(string _reg);
string gen_imul(string _reg, string _comment);
string gen_idiv(string _reg);
string gen_idiv(string _reg, string _comment);
string gen_xor(string _reg1, string _reg2);
string gen_xor(string _reg1, string _reg2, string _comment);
string gen_and(string _reg1, string _reg2);
string gen_and(string _reg1, string _reg2, string _comment);
string gen_or(string _reg1, string _reg2);
string gen_or(string _reg1, string _reg2, string _comment);

string get_lineno_comment(int _lineno);