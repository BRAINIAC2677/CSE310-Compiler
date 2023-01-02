#include "FunctionInfo.hpp"

string FunctionInfo::get_name()
{
    return name;
}

int FunctionInfo::get_no_of_params()
{
    return no_of_params;
}

Node *FunctionInfo::get_return_type()
{
    return return_type;
}

Node *FunctionInfo::get_params()
{
    return params;
}

Node *FunctionInfo::get_body()
{
    return body;
}

FunctionInfo *FunctionInfo::set_name(string name)
{
    this->name = name;
    return this;
}

FunctionInfo *FunctionInfo::set_no_of_params(int no_of_params)
{
    this->no_of_params = no_of_params;
    return this;
}

FunctionInfo *FunctionInfo::set_return_type(Node *return_type)
{
    this->return_type = return_type;
    return this;
}

FunctionInfo *FunctionInfo::set_params(Node *params)
{
    this->params = params;
    return this;
}

FunctionInfo *FunctionInfo::set_body(Node *body)
{
    this->body = body;
    return this;
}

bool FunctionInfo::match_params(Node *params)
{
    // todo: implement
}

bool FunctionInfo::match_return_type(Node *return_type)
{
    // todo: implement
}
