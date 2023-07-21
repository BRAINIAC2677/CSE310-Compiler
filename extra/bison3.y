%{
#include <iostream>
using namespace std;

int yylex();
void yyerror(const char *s);
%}

%define parse.error detailed 

%token NUMBER RPAREN LPAREN
%left ADDOP SUBOP
%left MULOP DIVOP 
%token EOL 

%%
calc: expression EOL
    {
        cout<<"calc: expression EOL"<<endl;
        cout<<"-----------------------"<<endl;
        cout<<"result: "<<$1<<endl;
    }

expression: factor
    {
        cout<<"expression: factor"<<endl;
        $$ = $1;
    }
    |
    expression ADDOP factor
    {
        cout<<"expression: expression ADDOP factor"<<endl;
        $$ = $1+$3;
    }
    |
    expression SUBOP factor
    {
        cout<<"expression: expression SUBOP factor"<<endl;
        $$ = $1-$3;
    }


factor: term 
    {
        cout<<"factor: term"<<endl;
        $$ = $1;
    }
    |
    factor MULOP term
    {
        cout<<"factor: factor MULOP term"<<endl;
        $$ = $1*$3;
    }
    |
    factor DIVOP term
    {
        cout<<"factor: factor DIVOP term"<<endl;
        $$ = $1/$3;
    }

term: NUMBER
    {
        cout<<"term: NUMBER"<<endl;
        $$ = $1;
    }
    |
    LPAREN expression RPAREN
    {
        cout<<"term: LPAREN expression RPAREN"<<endl;
        $$ = $2;
    }

%%

void yyerror(const char *s)
{
    cout<<s<<endl;
}

int main()
{
    yyparse();
}