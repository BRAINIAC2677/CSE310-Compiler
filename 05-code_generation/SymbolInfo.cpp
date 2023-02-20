#include "SymbolInfo.hpp"

map<DataType, string> data_type_to_string = {
    {DataType::INT, "int"},
    {DataType::FLOAT, "float"},
    {DataType::VOID, "void"},
    {DataType::NULL_TYPE, "null"}};

SymbolInfo *NULL_SYMBOL_INFO = new SymbolInfo();

SymbolInfo::SymbolInfo() noexcept : lexeme(""), type(TokenType::SI_NULL), next_symbol_info(nullptr), data_type(DataType::NULL_TYPE), array_size(-1), global(false), start_offset(0)
{
    this->param_types = vector<DataType>();
    this->truelist = vector<int>();
    this->falselist = vector<int>();
    this->nextlist = vector<int>();
}

SymbolInfo::SymbolInfo(SymbolInfo *_symbol_info) noexcept : lexeme(_symbol_info->get_lexeme()), type(_symbol_info->get_type()), next_symbol_info(_symbol_info->get_next_symbol_info()), data_type(_symbol_info->get_data_type()), array_size(_symbol_info->get_array_size()), global(_symbol_info->is_global()), start_offset(_symbol_info->get_start_offset())
{
    this->param_types = _symbol_info->get_param_types();
    this->truelist = _symbol_info->get_truelist();
    this->falselist = _symbol_info->get_falselist();
    this->nextlist = _symbol_info->get_nextlist();
}

SymbolInfo::~SymbolInfo() noexcept
{
}

string SymbolInfo::get_lexeme() const noexcept
{
    return this->lexeme;
}

TokenType SymbolInfo::get_type() const noexcept
{
    return this->type;
}

SymbolInfo *SymbolInfo::get_next_symbol_info() const noexcept
{
    return this->next_symbol_info;
}

DataType SymbolInfo::get_data_type() const noexcept
{
    return this->data_type;
}

int SymbolInfo::get_array_size() const noexcept
{
    return this->array_size;
}

bool SymbolInfo::is_global() const noexcept
{
    return this->global;
}

int SymbolInfo::get_start_offset() const noexcept
{
    return this->start_offset;
}

DataType SymbolInfo::get_return_type() const noexcept
{
    return this->data_type;
}

vector<DataType> SymbolInfo::get_param_types() const noexcept
{
    return this->param_types;
}

vector<int> SymbolInfo::get_truelist() const noexcept
{
    return this->truelist;
}

vector<int> SymbolInfo::get_falselist() const noexcept
{
    return this->falselist;
}

vector<int> SymbolInfo::get_nextlist() const noexcept
{
    return this->nextlist;
}

SymbolInfo *SymbolInfo::set_lexeme(string _lexeme) noexcept
{
    this->lexeme = _lexeme;
    return this;
}

SymbolInfo *SymbolInfo::set_type(TokenType type) noexcept
{
    this->type = type;
    return this;
}

SymbolInfo *SymbolInfo::set_next_symbol_info(SymbolInfo *next_symbol_info) noexcept
{
    this->next_symbol_info = next_symbol_info;
    return this;
}

SymbolInfo *SymbolInfo::set_data_type(DataType _data_type) noexcept
{
    this->data_type = _data_type;
    return this;
}

SymbolInfo *SymbolInfo::set_array_size(int _array_size) noexcept
{
    this->array_size = _array_size;
    return this;
}

SymbolInfo *SymbolInfo::set_global(bool _global) noexcept
{
    this->global = _global;
    return this;
}

SymbolInfo *SymbolInfo::set_start_offset(int _start_offset) noexcept
{
    this->start_offset = _start_offset;
    return this;
}

SymbolInfo *SymbolInfo::set_return_type(DataType _return_type) noexcept
{
    this->data_type = _return_type;
    return this;
}

SymbolInfo *SymbolInfo::set_param_types(vector<DataType> _param_types) noexcept
{
    this->param_types = _param_types;
    return this;
}

SymbolInfo *SymbolInfo::set_truelist(vector<int> _truelist) noexcept
{
    this->truelist = _truelist;
    return this;
}

SymbolInfo *SymbolInfo::set_falselist(vector<int> _falselist) noexcept
{
    this->falselist = _falselist;
    return this;
}

SymbolInfo *SymbolInfo::set_nextlist(vector<int> _nextlist) noexcept
{
    this->nextlist = _nextlist;
    return this;
}

string SymbolInfo::get_address() const noexcept
{
    if (this->global)
    {
        return this->lexeme;
    }
    else
    {
        string op = (this->start_offset < 0) ? "-" : "+";
        return "[BP" + op + to_string(abs(this->start_offset)) + "]";
    }
}

bool SymbolInfo::is_compatible_with(SymbolInfo *_symbol_info) noexcept
{
    if (this->lexeme != _symbol_info->get_lexeme())
    {
        return false;
    }
    if (this->get_return_type() != _symbol_info->get_return_type())
    {
        return false;
    }
    if (this->param_types.size() != _symbol_info->get_param_types().size())
    {
        return false;
    }
    for (int i = 0; i < this->param_types.size(); i++)
    {
        if (this->param_types[i] != _symbol_info->get_param_types()[i])
        {
            return false;
        }
    }
    return true;
}

SymbolInfo *SymbolInfo::add_to_truelist(int _lineno) noexcept
{
    this->truelist.push_back(_lineno);
    return this;
}

SymbolInfo *SymbolInfo::add_to_falselist(int _lineno) noexcept
{
    this->falselist.push_back(_lineno);
    return this;
}

SymbolInfo *SymbolInfo::add_to_nextlist(int _lineno) noexcept
{
    this->nextlist.push_back(_lineno);
    return this;
}

bool SymbolInfo::has_jump() const noexcept
{
    return this->truelist.size() > 0 || this->falselist.size() > 0;
}
