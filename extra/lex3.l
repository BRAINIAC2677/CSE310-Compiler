%option noyywrap
%{
    #include<iostream>
    using namespace std;

    #include "bison3.h"
%}

%%
[0-9]+ {
    yylval = atoi(yytext);
    return NUMBER;
}

"*" {
    return MULOP;
}

"/" {
    return DIVOP;
}

"+" {
    return ADDOP;
}

"-" {
    return SUBOP;
}

"(" {
    return LPAREN;
}

")" {
    return RPAREN;
}

"\n" {
    return EOL;
}
%%
