%option noyywrap
%{
    #include<iostream>
    using namespace std;

    typedef enum TokenType{
        NUMBER,
        MULOP,
        ADDOP
    } TokenType;
%}

%%
[0-9]+ {
    cout<<yytext<<"\n";
    // return NUMBER;
}

[*/] {
    cout<<yytext<<"\n";
    // return MULOP;
}

[-+] {
    cout<<yytext<<"\n";
    // return ADDOP;
}
%%

int main()
{
    // int token;
    // while(token = yylex())
    // {
    //     cout<<token<<"\n";
    // }
    yylex();
    return 0;
}