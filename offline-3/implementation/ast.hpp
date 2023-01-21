#pragma once

#include <vector>
using namespace std;

#include "SymbolInfo.hpp"

class Node
{
  SYMBOLTYPE symbol_type;
  int start_lineno, end_lineno;
  string production_rule;

public:
  SYMBOLTYPE get_symbol_type();
  int get_start_lineno();
  int get_end_lineno();
  string get_production_rule();

  Node *set_symbol_type(SYMBOLTYPE);
  Node *set_start_lineno(int);
  Node *set_end_lineno(int);
  Node *set_production_rule(string);

  static void print_parsetree(Node *root, ofstream &out, int depth = 0);

protected:
  Node(SYMBOLTYPE, int, int);
};

class NonterminalNode : public Node
{
  vector<Node *> children;

public:
  NonterminalNode(SYMBOLTYPE symbol_type, int start_lineno, int end_lineno);

  vector<Node *> get_children();
  NonterminalNode *set_children(vector<Node *> children);
  NonterminalNode *add_child(Node *child);
};

class TerminalNode : public Node
{
  SymbolInfo *symbol_info;

public:
  TerminalNode(SYMBOLTYPE symbol_type, int start_lineno);
  TerminalNode(SYMBOLTYPE symbol_type, int start_lineno, int end_lineno);

  TerminalNode *set_symbol_info(SymbolInfo *symbol_info);
  SymbolInfo *get_symbol_info();
};

class ParameterListNode : public NonterminalNode
{
  vector<SYMBOLTYPE> parameters;
  map<string, int> parameter_count;
  vector<VarInfo *> declared_variables;

public:
  ParameterListNode(SYMBOLTYPE symbol_type, int start_lineno, int end_lineno);

  vector<SYMBOLTYPE> get_parameters();
  map<string, int> get_parameter_count();
  vector<VarInfo *> get_declared_variables();

  ParameterListNode *set_parameters(vector<SYMBOLTYPE> parameters);
  ParameterListNode *set_parameter_count(map<string, int> parameter_count);
  ParameterListNode *set_declared_variables(vector<VarInfo *> declared_variables);

  ParameterListNode *add_parameter(SYMBOLTYPE parameter);
  ParameterListNode *add_declared_variable(VarInfo *declared_variable);
  ParameterListNode *increase_parameter_count(string parameter);

  bool is_parameters_compatible(ParameterListNode *parameter_list_node);
};

class DeclarationListNode : public NonterminalNode
{
  vector<VarInfo *> declared_variables;

public:
  DeclarationListNode(SYMBOLTYPE symbol_type, int start_lineno, int end_lineno);

  vector<VarInfo *> get_declared_variables();
  DeclarationListNode *set_declared_variables(vector<VarInfo *> declared_variables);
  DeclarationListNode *set_declared_variables(DeclarationListNode *declaration_list_node);

  DeclarationListNode *add_declared_variable(VarInfo *declared_variable);
};

class TypedNonterminalNode : public NonterminalNode
{
  SYMBOLTYPE type_specifier;

public:
  TypedNonterminalNode(SYMBOLTYPE symbol_type, int start_lineno, int end_lineno);

  SYMBOLTYPE get_type_specifier();
  TypedNonterminalNode *set_type_specifier(SYMBOLTYPE type_specifier);

  bool is_type_compatible(TypedNonterminalNode *expression_node);
};
