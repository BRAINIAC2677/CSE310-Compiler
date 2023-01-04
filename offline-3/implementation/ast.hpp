#pragma once

class SymbolInfo;

namespace ast
{

  typedef enum
  {
    BASIC_NODE,
  } NodeType;

  class Node
  {
    NodeType node_type;
    int start_lineno, end_lineno;

  public:
    NodeType get_node_type();
    int get_start_lineno();
    int get_end_lineno();
    void set_node_type(NodeType);
    void set_start_lineno(int);
    void set_end_lineno(int);

    void print_ast();
    // TokenType get_type_specifiers();

  protected:
    Node(NodeType, int, int);
  };

  class BasicNode : public Node
  {
    Node *left, *right;

  public:
    BasicNode(NodeType, int, int);

    Node *get_left();
    Node *get_right();
    BasicNode *set_left(Node *);
    BasicNode *set_right(Node *);
  };

  class ConstNode : public Node
  {
    float value;

  public:
    ConstNode(NodeType, int, int);

    float get_value();
    ConstNode *set_value(float);
  };

  class IfNode : public Node
  {
    Node *condition, *if_branch, *else_branch;

  public:
    IfNode(NodeType, int, int);

    Node *get_condition();
    Node *get_if_branch();
    Node *get_else_branch();
    IfNode *set_condition(Node *);
    IfNode *set_if_branch(Node *);
    IfNode *set_else_branch(Node *);
  };

  class ForNode : public Node
  {
    Node *init, *condition, *update, *body;

  public:
    ForNode(NodeType, int, int);

    Node *get_init();
    Node *get_condition();
    Node *get_update();
    Node *get_body();
    ForNode *set_init(Node *);
    ForNode *set_condition(Node *);
    ForNode *set_update(Node *);
    ForNode *set_body(Node *);
  };

  class WhileNode : public Node
  {
    Node *condition, *body;

  public:
    WhileNode(NodeType, int, int);

    Node *get_condition();
    Node *get_body();
    WhileNode *set_condition(Node *);
    WhileNode *set_body(Node *);
  };

  class TerminalTokenNode : public Node
  {
    SymbolInfo *symbol_info;

  public:
    TerminalTokenNode(NodeType, int, int);

    SymbolInfo *get_symbol_info();
    TerminalTokenNode *set_symbol_info(SymbolInfo *);
  };

}
