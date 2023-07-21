%option noyywrap
%{
#include<iostream>
using namespace std;
%}

%%
[0-9]+ cout<<yytext<<"\n";

%%
int main()
{
    yylex();
    return 0;
}