%option noyywrap
%{
    #include<iostream>
    using namespace std;
%}
SPECIAL_SYMBOL [~!@#$%^]
NUMERIC [0-9]
CAPTIAL [A-Z]
PASSWORD [a-zA-Z0-9~!@#$%^]
VALID_PASSWORD {PASSWORD}*{CAPTIAL}{PASSWORD}*{NUMERIC}{PASSWORD}*{SPECIAL_SYMBOL}{PASSWORD}*|{PASSWORD}*{CAPTIAL}{PASSWORD}*{SPECIAL_SYMBOL}{PASSWORD}*{NUMERIC}{PASSWORD}*|{PASSWORD}*{NUMERIC}{PASSWORD}*{CAPTIAL}{PASSWORD}*{SPECIAL_SYMBOL}{PASSWORD}*|{PASSWORD}*{NUMERIC}{PASSWORD}*{SPECIAL_SYMBOL}{PASSWORD}*{CAPTIAL}{PASSWORD}*|{PASSWORD}*{SPECIAL_SYMBOL}{PASSWORD}*{CAPTIAL}{PASSWORD}*{NUMERIC}{PASSWORD}*|{PASSWORD}*{SPECIAL_SYMBOL}{PASSWORD}*{NUMERIC}{PASSWORD}*{CAPTIAL}{PASSWORD}*

%%
{VALID_PASSWORD} {cout<<"Valid Password: "<<yytext<<endl;}
. {cout<<"Invalid Password: "<<yytext<<endl;}
%%

int main()
{
    yylex();
    return 0;
}