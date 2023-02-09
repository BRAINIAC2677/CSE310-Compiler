#include "SymbolInfo.hpp"

SymbolInfo *NULL_SYMBOL_INFO = new SymbolInfo();

SymbolInfo::SymbolInfo() noexcept : lexeme(""), type(TokenType::SI_NULL), next_symbol_info(nullptr) {}

SymbolInfo::~SymbolInfo() noexcept {}

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

SymbolInfo *SymbolInfo::set_lexeme(string lexeme) noexcept
{
    this->lexeme = lexeme;
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

VarInfo::VarInfo() noexcept : SymbolInfo(), data_type(DataType::NULL_TYPE), array_size(-1) {}

VarInfo::~VarInfo() noexcept {}

DataType VarInfo::get_data_type() const noexcept
{
    return this->data_type;
}

int VarInfo::get_array_size() const noexcept
{
    return this->array_size;
}

bool VarInfo::is_global() const noexcept
{
    return this->global;
}

int VarInfo::get_offset() const noexcept
{
    return this->offset;
}

VarInfo *VarInfo::set_lexeme(string lexeme) noexcept
{
    this->lexeme = lexeme;
    return this;
}

VarInfo *VarInfo::set_type(TokenType type) noexcept
{
    this->type = type;
    return this;
}

VarInfo *VarInfo::set_data_type(DataType _data_type) noexcept
{
    this->data_type = _data_type;
    return this;
}

VarInfo *VarInfo::set_array_size(int _array_size) noexcept
{
    this->array_size = _array_size;
    return this;
}

VarInfo *VarInfo::set_global(bool _global) noexcept
{
    this->global = _global;
    return this;
}

VarInfo *VarInfo::set_offset(int _offset) noexcept
{
    this->offset = _offset;
    return this;
}

string VarInfo::get_address() const noexcept
{
    if (this->global)
    {
        return this->lexeme;
    }
    else
    {
        string op = (this->offset < 0) ? "-" : "+";
        return "[BP" + op + to_string(abs(this->offset)) + "]";
    }
}

FuncInfo::FuncInfo() noexcept : SymbolInfo(), return_type(DataType::NULL_TYPE), param_types(vector<DataType>()) {}

FuncInfo::~FuncInfo() noexcept {}

DataType FuncInfo::get_return_type() const noexcept
{
    return this->return_type;
}

vector<DataType> FuncInfo::get_param_types() const noexcept
{
    return this->param_types;
}

FuncInfo *FuncInfo::set_lexeme(string _lexeme) noexcept
{
    this->lexeme = _lexeme;
    return this;
}

FuncInfo *FuncInfo::set_type(TokenType _type) noexcept
{
    this->type = _type;
    return this;
}

FuncInfo *FuncInfo::set_return_type(DataType _return_type) noexcept
{
    this->return_type = _return_type;
    return this;
}

FuncInfo *FuncInfo::set_param_types(vector<DataType> _param_types) noexcept
{
    this->param_types = _param_types;
    return this;
}

bool FuncInfo::is_compatible_with(FuncInfo *func_info) noexcept
{
    if (this->lexeme != func_info->get_lexeme())
    {
        return false;
    }
    if (this->return_type != func_info->get_return_type())
    {
        return false;
    }
    if (this->param_types.size() != func_info->get_param_types().size())
    {
        return false;
    }
    for (int i = 0; i < this->param_types.size(); i++)
    {
        if (this->param_types[i] != func_info->get_param_types()[i])
        {
            return false;
        }
    }
    return true;
}