#include "ParseTree.hpp"

ParseTreeNode::ParseTreeNode() : first_line(-1), last_line(-1), data_type(DataType::NULL_TYPE), rule("")
{
    this->children = vector<ParseTreeNode *>();
}

void ParseTreeNode::print_parsetree(ofstream &_output_file, ParseTreeNode *_root, int _depth)
{
    if (_root == nullptr)
    {
        return;
    }
    for (int i = 0; i < _depth; i++)
    {
        _output_file << " ";
    }
    _output_file << _root->get_rule() << "\t<Line: " << _root->get_first_line() << "-" << _root->get_last_line() << ">\n";
    for (auto child : _root->get_children())
    {
        ParseTreeNode::print_parsetree(_output_file, child, _depth + 1);
    }
}

int ParseTreeNode::get_first_line()
{
    return this->first_line;
}

int ParseTreeNode::get_last_line()
{
    return this->last_line;
}

DataType ParseTreeNode::get_data_type()
{
    return this->data_type;
}

string ParseTreeNode::get_rule()
{
    return this->rule;
}

vector<ParseTreeNode *> ParseTreeNode::get_children()
{
    return this->children;
}

ParseTreeNode *ParseTreeNode::set_first_line(int _first_line)
{
    this->first_line = _first_line;
    return this;
}

ParseTreeNode *ParseTreeNode::set_last_line(int _last_line)
{
    this->last_line = _last_line;
    return this;
}

ParseTreeNode *ParseTreeNode::set_data_type(DataType _data_type)
{
    this->data_type = _data_type;
    return this;
}

ParseTreeNode *ParseTreeNode::set_rule(string _rule)
{
    this->rule = _rule;
    return this;
}

ParseTreeNode *ParseTreeNode::set_children(vector<ParseTreeNode *> _children)
{
    this->children = _children;
    return this;
}

ParseTreeNode *ParseTreeNode::add_child(ParseTreeNode *_child)
{
    this->children.push_back(_child);
    return this;
}
