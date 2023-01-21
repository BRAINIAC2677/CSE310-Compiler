#include "SymbolInfo.hpp"

SymbolInfo *NULL_SYMBOL_INFO = (new SymbolInfo())->set_lexeme("nullptr")->set_type(SYMBOLTYPE::NULL_SYMBOL)->set_next_symbol_info(nullptr);

SymbolInfo::SymbolInfo() noexcept : lexeme(""), type(SYMBOLTYPE::NULL_SYMBOL), next_symbol_info(nullptr) {}

SymbolInfo::SymbolInfo(SymbolInfo *symbol_info) noexcept : lexeme(symbol_info->get_lexeme()), type(symbol_info->get_type()), next_symbol_info(symbol_info->get_next_symbol_info()) {}

string SymbolInfo::get_lexeme() const noexcept
{
  return this->lexeme;
}

SYMBOLTYPE SymbolInfo::get_type() const noexcept
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

SymbolInfo *SymbolInfo::set_type(SYMBOLTYPE type) noexcept
{
  this->type = type;
  return this;
}

SymbolInfo *SymbolInfo::set_next_symbol_info(SymbolInfo *next_symbol_info) noexcept
{
  this->next_symbol_info = next_symbol_info;
  return this;
}

FuncInfo::FuncInfo() noexcept : SymbolInfo(), return_type_specifier(NULL_SYMBOL)
{
  this->param_type_specifiers = vector<SYMBOLTYPE>();
}

FuncInfo::FuncInfo(SymbolInfo *symbol_info) noexcept : SymbolInfo(), return_type_specifier(NULL_SYMBOL)
{
  this->param_type_specifiers = vector<SYMBOLTYPE>();
  this->set_lexeme(symbol_info->get_lexeme());
  this->set_type(SYMBOLTYPE::FUNC_ID);
  this->set_next_symbol_info(symbol_info->get_next_symbol_info());
}

SYMBOLTYPE FuncInfo::get_return_type_specifier()
{
  return this->return_type_specifier;
}

vector<SYMBOLTYPE> FuncInfo::get_param_type_specifiers()
{
  return this->param_type_specifiers;
}

FuncInfo *FuncInfo::set_return_type_specifier(SYMBOLTYPE return_type_specifier)
{
  this->return_type_specifier = return_type_specifier;
  return this;
}

FuncInfo *FuncInfo::set_param_type_specifiers(vector<SYMBOLTYPE> param_type_specifiers)
{
  this->param_type_specifiers = param_type_specifiers;
  return this;
}

bool FuncInfo::is_return_type_same(SYMBOLTYPE arg_return_type_specifier)
{
  return (this->return_type_specifier == arg_return_type_specifier);
}

bool FuncInfo::is_param_type_same(vector<SYMBOLTYPE> arg_param_type_specifier)
{
  if (arg_param_type_specifier.size() != this->param_type_specifiers.size())
  {
    return false;
  }
  for (int i = 0; i < arg_param_type_specifier.size(); i++)
  {
    // todo: handle implicit type-casting
    if (this->param_type_specifiers[i] != arg_param_type_specifier[i])
    {
      return true;
    }
  }
  return true;
}

VarInfo::VarInfo() noexcept : SymbolInfo(), type_specifier(NULL_SYMBOL), array_size(-2) {}

VarInfo::VarInfo(SymbolInfo *symbol_info) noexcept : SymbolInfo(), type_specifier(NULL_SYMBOL), array_size(-2)
{
  this->set_lexeme(symbol_info->get_lexeme());
  this->set_type(SYMBOLTYPE::VAR_ID);
  this->set_next_symbol_info(symbol_info->get_next_symbol_info());
}

SYMBOLTYPE VarInfo::get_type_specifier()
{
  return this->type_specifier;
}

int VarInfo::get_array_size()
{
  return this->array_size;
}

VarInfo *VarInfo::set_type_specifier(SYMBOLTYPE type_specifier)
{
  this->type_specifier = type_specifier;
  return this;
}

VarInfo *VarInfo::set_array_size(int array_size)
{
  this->array_size = array_size;
  return this;
}

bool VarInfo::is_type_same(SYMBOLTYPE arg_type_specifier)
{
  return (this->type_specifier == arg_type_specifier);
}

bool VarInfo::is_array()
{
  return (this->array_size >= 0);
}
