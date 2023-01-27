#pragma once
#include <bits/stdc++.h>
using namespace std;

typedef enum
{
    INT,
    FLOAT,
    VOID,
    NULL_TYPE
} DataType;

extern map<DataType, string> data_type_to_string;

class ParseTreeNode
{
    int first_line, last_line;
    DataType data_type;
    string rule;
    vector<ParseTreeNode *> children;

public:
    ParseTreeNode();
    static void print_parsetree(ofstream &_output_file, ParseTreeNode *_root, int _depth = 0);

    int get_first_line();
    int get_last_line();
    DataType get_data_type();
    string get_rule();
    vector<ParseTreeNode *> get_children();

    ParseTreeNode *set_first_line(int _first_line);
    ParseTreeNode *set_last_line(int _last_line);
    ParseTreeNode *set_data_type(DataType _data_type);
    ParseTreeNode *set_rule(string _rule);
    ParseTreeNode *set_children(vector<ParseTreeNode *> _children);

    ParseTreeNode *add_child(ParseTreeNode *_child);
};