#include <bits/stdc++.h>
using namespace std;

#include "ast.hpp"

map<SYMBOLTYPE, string> aa_nonterminal_symbols = {
    {START, "START"},
    {PROGRAM, "PROGRAM"},
    {UNIT, "UNIT"},
    {FUNC_DECLARATION, "FUNC_DECLARATION"},
    {FUNC_DEFINITION, "FUNC_DEFINITION"},
    {PARAMETER_LIST, "PARAMETER_LIST"},
    {COMPOUND_STATEMENT, "COMPOUND_STATEMENT"},
    {VAR_DECLARATION, "VAR_DECLARATION"},
    {TYPE_SPECIFIER, "TYPE_SPECIFIER"},
    {DECLARATION_LIST, "DECLARATION_LIST"},
    {STATEMENTS, "STATEMENTS"},
    {STATEMENT, "STATEMENT"},
    {EXPRESSION_STATEMENT, "EXPRESSION_STATEMENT"},
    {VARIABLE, "VARIABLE"},
    {EXPRESSION, "EXPRESSION"},
    {LOGIC_EXPRESSION, "LOGIC_EXPRESSION"},
    {REL_EXPRESSION, "REL_EXPRESSION"},
    {SIMPLE_EXPRESSION, "SIMPLE_EXPRESSION"},
    {TERM, "TERM"},
    {UNARY_EXPRESSION, "UNARY_EXPRESSION"},
    {FACTOR, "FACTOR"},
    {ARGUMENT_LIST, "ARGUMENT_LIST"},
    {ARGUMENTS, "ARGUMENTS"}};
map<SYMBOLTYPE, string> aa_terminal_symbols = {
    {IF, "IF"},
    {WHILE, "WHILE"},
    {FOR, "FOR"},
    {RETURN, "RETURN"},
    {INT, "INT"},
    {FLOAT, "FLOAT"},
    {VOID, "VOID"},
    {ADDOP, "ADDOP"},
    {MULOP, "MULOP"},
    {INCOP, "INCOP"},
    {DECOP, "DECOP"},
    {RELOP, "RELOP"},
    {ASSIGNOP, "ASSIGNOP"},
    {LOGICOP, "LOGICOP"},
    {NOT, "NOT"},
    {LPAREN, "("},
    {RPAREN, ")"},
    {LCURL, "{"},
    {RCURL, "}"},
    {LTHIRD, "["},
    {RTHIRD, "]"},
    {SEMICOLON, "SEMICOLON"},
    {COMMA, "COMMA"},
    {PRINTLN, "PRINTLN"},
    {ID, "ID"},
    {CONST_INT, "CONST_INT"},
    {CONST_FLOAT, "CONST_FLOAT"}};

SYMBOLTYPE Node::get_symbol_type()
{
  return symbol_type;
}

int Node::get_start_lineno()
{
  return this->start_lineno;
}

int Node::get_end_lineno()
{
  return this->end_lineno;
}

string Node::get_production_rule()
{
  return production_rule;
}

Node *Node::set_symbol_type(SYMBOLTYPE symbol_type)
{
  this->symbol_type = symbol_type;
  return this;
}

Node *Node::set_start_lineno(int start_lineno)
{
  this->start_lineno = start_lineno;
  return this;
}

Node *Node::set_end_lineno(int end_lineno)
{
  this->end_lineno = end_lineno;
  return this;
}

Node *Node::set_production_rule(string production_rule)
{
  this->production_rule = production_rule;
  return this;
}

void Node::print_parsetree(Node *root, ofstream &out, int depth)
{
  if (root == nullptr)
  {
    return;
  }

  SYMBOLTYPE symbol_type = root->get_symbol_type();

  for (int i = 0; i < depth; i++)
  {
    out << " ";
  }

  if (aa_nonterminal_symbols.find(symbol_type) != aa_nonterminal_symbols.end())
  {
    NonterminalNode *nonterminal_node = (NonterminalNode *)root;
    out << (nonterminal_node->get_production_rule()) << " <Line: " << nonterminal_node->get_start_lineno() << "-" << nonterminal_node->get_end_lineno() << ">\n";
    for (Node *child : nonterminal_node->get_children())
    {
      print_parsetree(child, out, depth + 1);
    }
  }

  else if (aa_terminal_symbols.find(symbol_type) != aa_terminal_symbols.end())
  {
    TerminalNode *terminal_node = (TerminalNode *)root;
    out << aa_terminal_symbols[symbol_type] << " : " << (terminal_node->get_symbol_info()->get_lexeme()) << " <Line: " << terminal_node->get_start_lineno() << ">\n";
  }
}

Node::Node(SYMBOLTYPE symbol_type, int start_lineno, int end_lineno) : symbol_type(symbol_type), start_lineno(start_lineno), end_lineno(end_lineno) {}

NonterminalNode::NonterminalNode(SYMBOLTYPE symbol_type, int start_lineno, int end_lineno) : Node(symbol_type, start_lineno, end_lineno)
{
  this->children = vector<Node *>();
}

vector<Node *> NonterminalNode::get_children()
{
  return this->children;
}

NonterminalNode *NonterminalNode::set_children(vector<Node *> children)
{
  this->children = children;
  return this;
}

NonterminalNode *NonterminalNode::add_child(Node *child)
{
  this->children.push_back(child);
  return this;
}

TerminalNode::TerminalNode(SYMBOLTYPE symbol_type, int start_lineno, int end_lineno) : Node(symbol_type, start_lineno, end_lineno) {}

TerminalNode::TerminalNode(SYMBOLTYPE symbol_type, int start_lineno) : Node(symbol_type, start_lineno, start_lineno) {}

TerminalNode *TerminalNode::set_symbol_info(SymbolInfo *symbol_info)
{
  this->symbol_info = symbol_info;
  return this;
}

SymbolInfo *TerminalNode::get_symbol_info()
{
  return this->symbol_info;
}

ParameterListNode::ParameterListNode(SYMBOLTYPE symbol_type, int start_lineno, int end_lineno) : NonterminalNode(symbol_type, start_lineno, end_lineno)
{
  this->parameters = vector<SYMBOLTYPE>();
}

vector<SYMBOLTYPE> ParameterListNode::get_parameters()
{
  return this->parameters;
}

ParameterListNode *ParameterListNode::set_parameters(vector<SYMBOLTYPE> parameters)
{
  this->parameters = parameters;
  return this;
}

ParameterListNode *ParameterListNode::add_parameter(SYMBOLTYPE parameter)
{
  this->parameters.push_back(parameter);
  return this;
}

bool ParameterListNode::is_parameters_compatible(ParameterListNode *parameter_list_node)
{
  if (this->parameters.size() != parameter_list_node->get_parameters().size())
  {
    return false;
  }
  for (int i = 0; i < this->parameters.size(); i++)
  {
    if (this->parameters[i] != parameter_list_node->get_parameters()[i])
    {
      return false;
    }
  }
  return true;
}

DeclarationListNode::DeclarationListNode(SYMBOLTYPE symbol_type, int start_lineno, int end_lineno) : NonterminalNode(symbol_type, start_lineno, end_lineno)
{
  this->declared_variables = vector<VarInfo *>();
}

vector<VarInfo *> DeclarationListNode::get_declared_variables()
{
  return this->declared_variables;
}

DeclarationListNode *DeclarationListNode::set_declared_variables(vector<VarInfo *> declared_variables)
{
  for (VarInfo *declared_variable : declared_variables)
  {
    this->declared_variables.push_back(declared_variable);
  }
  return this;
}

DeclarationListNode *DeclarationListNode::set_declared_variables(DeclarationListNode *declaration_list_node)
{
  for (VarInfo *declared_variable : declaration_list_node->declared_variables)
  {
    this->declared_variables.push_back(declared_variable);
  }
  return this;
}

DeclarationListNode *DeclarationListNode::add_declared_variable(VarInfo *declared_variable)
{
  this->declared_variables.push_back(declared_variable);
  return this;
}

TypedNonterminalNode::TypedNonterminalNode(SYMBOLTYPE symbol_type, int start_lineno, int end_lineno) : NonterminalNode(symbol_type, start_lineno, end_lineno)
{
  this->type_specifier = SYMBOLTYPE::NULL_SYMBOL;
}

SYMBOLTYPE TypedNonterminalNode::get_type_specifier()
{
  return this->type_specifier;
}

TypedNonterminalNode *TypedNonterminalNode::set_type_specifier(SYMBOLTYPE type_specifier)
{
  this->type_specifier = type_specifier;
  return this;
}

bool TypedNonterminalNode::is_type_compatible(TypedNonterminalNode *expression_node)
{
  if (this->type_specifier == expression_node->get_type_specifier())
  {
    return true;
  }
  return false;
}
