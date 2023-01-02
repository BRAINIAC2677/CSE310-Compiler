#include "ast.hpp"
using namespace ast;

NodeType Node::get_node_type()
{
    return node_type;
}

int Node::get_start_lineno()
{
    return start_lineno;
}

int Node::get_end_lineno()
{
    return end_lineno;
}

void Node::set_node_type(NodeType node_type)
{
    this->node_type = node_type;
}

void Node::set_start_lineno(int start_lineno)
{
    this->start_lineno = start_lineno;
}

void Node::set_end_lineno(int end_lineno)
{
    this->end_lineno = end_lineno;
}

Node::Node(NodeType node_type, int start_lineno, int end_lineno) : node_type(node_type), start_lineno(start_lineno), end_lineno(end_lineno) {}

void Node::print_ast()
{
    // todo: implement
}

BasicNode::BasicNode(NodeType node_type, int start_lineno, int end_lineno) : Node(node_type, start_lineno, end_lineno), left(nullptr), right(nullptr) {}

Node *BasicNode::get_left()
{
    return left;
}

Node *BasicNode::get_right()
{
    return right;
}

BasicNode *BasicNode::set_left(Node *left)
{
    this->left = left;
    return this;
}

BasicNode *BasicNode::set_right(Node *right)
{
    this->right = right;
    return this;
}

ConstNode::ConstNode(NodeType node_type, int start_lineno, int end_lineno) : Node(node_type, start_lineno, end_lineno), value(0) {}

float ConstNode::get_value()
{
    return value;
}

ConstNode *ConstNode::set_value(float value)
{
    this->value = value;
    return this;
}

IfNode::IfNode(NodeType node_type, int start_lineno, int end_lineno) : Node(node_type, start_lineno, end_lineno), condition(nullptr), if_branch(nullptr), else_branch(nullptr) {}

Node *IfNode::get_condition()
{
    return condition;
}

Node *IfNode::get_if_branch()
{
    return if_branch;
}

Node *IfNode::get_else_branch()
{
    return else_branch;
}

IfNode *IfNode::set_condition(Node *condition)
{
    this->condition = condition;
    return this;
}

IfNode *IfNode::set_if_branch(Node *if_branch)
{
    this->if_branch = if_branch;
    return this;
}

IfNode *IfNode::set_else_branch(Node *else_branch)
{
    this->else_branch = else_branch;
    return this;
}

ForNode::ForNode(NodeType node_type, int start_lineno, int end_lineno) : Node(node_type, start_lineno, end_lineno), init(nullptr), condition(nullptr), update(nullptr), body(nullptr) {}

Node *ForNode::get_init()
{
    return init;
}

Node *ForNode::get_condition()
{
    return condition;
}

Node *ForNode::get_update()
{
    return update;
}

Node *ForNode::get_body()
{
    return body;
}

ForNode *ForNode::set_init(Node *init)
{
    this->init = init;
    return this;
}

ForNode *ForNode::set_condition(Node *condition)
{
    this->condition = condition;
    return this;
}

ForNode *ForNode::set_update(Node *update)
{
    this->update = update;
    return this;
}

ForNode *ForNode::set_body(Node *body)
{
    this->body = body;
    return this;
}

WhileNode::WhileNode(NodeType node_type, int start_lineno, int end_lineno) : Node(node_type, start_lineno, end_lineno), condition(nullptr), body(nullptr) {}

Node *WhileNode::get_condition()
{
    return condition;
}

Node *WhileNode::get_body()
{
    return body;
}

WhileNode *WhileNode::set_condition(Node *condition)
{
    this->condition = condition;
    return this;
}

WhileNode *WhileNode::set_body(Node *body)
{
    this->body = body;
    return this;
}

TerminalTokenNode::TerminalTokenNode(NodeType node_type, int start_lineno, int end_lineno) : Node(node_type, start_lineno, end_lineno), symbol_info(nullptr) {}

SymbolInfo *TerminalTokenNode::get_symbol_info()
{
    return symbol_info;
}

TerminalTokenNode *TerminalTokenNode::set_symbol_info(SymbolInfo *symbol_info)
{
    this->symbol_info = symbol_info;
    return this;
}
