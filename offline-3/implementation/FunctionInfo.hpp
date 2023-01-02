#pragma once

#include <string>
using namespace std;

#include "ast.hpp"
using namespace ast;

class FunctionInfo
{
    string name;
    int no_of_params;
    Node *return_type;
    Node *params;
    Node *body;

public:
    string get_name();
    int get_no_of_params();
    Node *get_return_type();
    Node *get_params();
    Node *get_body();

    FunctionInfo *set_name(string);
    FunctionInfo *set_no_of_params(int);
    FunctionInfo *set_return_type(Node *);
    FunctionInfo *set_params(Node *);
    FunctionInfo *set_body(Node *);

    bool match_params(Node *params);
    bool match_return_type(Node *return_type);
};