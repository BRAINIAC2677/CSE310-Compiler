#pragma once

#include <string>
using namespace std;

#include "SymbolInfo.hpp"

extern int code_segment_lineno;
extern int label;
extern fstream asmcode_file;
extern fstream code_segment_file;

void gen_starting_code();
string gen_newline();
string gen_2scomp();
string gen_print();
string gen_println();
void gen_ending_code();
void gen_func_starting_code(string _func_name);
void gen_func_ending_code(bool _is_main_func, int _arg_size);
void gen_code(string _code);
void gen_code(string _code, string _comment);
void gen_push(string _reg);
void gen_push(string _reg, string _comment);
void gen_push(int _val);
void gen_push(int _val, string _comment);
void gen_pop(string _reg);
void gen_pop(string _reg, string _comment);
void gen_mov(string _reg1, string _reg2);
void gen_mov(string _reg1, string _reg2, string _comment);
void gen_mov(string _reg1, int _val);
void gen_mov(string _reg1, int _val, string _comment);
void gen_call(string _func_name);
void gen_call(string _func_name, string _comment);
void gen_sub(string _reg1, string _reg2);
void gen_sub(string _reg1, string _reg2, string _comment);
void gen_sub(string _reg, int _val);
void gen_sub(string _reg1, int _val, string _comment);
void gen_add(string _reg1, string _reg2);
void gen_add(string _reg1, string _reg2, string _comment);
void gen_add(string _reg, int _val);
void gen_add(string _reg1, int _val, string _comment);
void gen_neg(string _reg);
void gen_neg(string _reg, string _comment);
void gen_cmp(string _reg1, string _reg2);
void gen_cmp(string _reg1, string _reg2, string _comment);
void gen_cmp(string _reg1, int _val);
void gen_cmp(string _reg1, int _val, string _comment);
void gen_label(string _label);
void gen_label(string _label, string _comment);
void gen_imul(string _reg);
void gen_imul(string _reg, string _comment);
void gen_idiv(string _reg);
void gen_idiv(string _reg, string _comment);
void gen_xor(string _reg1, string _reg2);
void gen_xor(string _reg1, string _reg2, string _comment);
void gen_and(string _reg1, string _reg2);
void gen_and(string _reg1, string _reg2, string _comment);
void gen_or(string _reg1, string _reg2);
void gen_or(string _reg1, string _reg2, string _comment);

void gen_global_var(string _var_name, int _size, string _comment);
string get_lineno_comment(int _lineno);
string get_newlabel();