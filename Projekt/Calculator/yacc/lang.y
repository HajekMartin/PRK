%{

#include <stdio.h>
#include <math.h>
#include <ctype.h>

#define YYDEBUG 1

//Můj Debug output
//#define DEBUG_OUTPUT 1

int yylex();
void yyerror(const char *s);
//extern int yylineno, yylval;

void parser_out(const char* rule, float dolar) {
    #ifdef DEBUG_OUTPUT
        printf("Current value is %f\n", dolar);
        printf(" - The rule was: %s\n", rule);
    #endif
}

%}

%define api.value.type {double}

%token L_BR
%token R_BR
%token PLUS
%token MPY
%token POWER
%token MULTIEXPRESSION
%token FLOAT
%token HEXADECIMAL
%token INTEGER
%token LINE_END

%%

lang:
    lang multiexpression LINE_END   { $$=$2; printf("* Výsledek je %f\n", $$); parser_out("Lang", $$); }
    | multiexpression LINE_END      { $$=$1; printf("* Výsledek je %f\n", $$); parser_out("Lang2", $$); }
    ;

multiexpression:
    expression                                      { $$=$1; parser_out("expression", $$); }
    | expression MULTIEXPRESSION multiexpression    { $$=$1; parser_out("expression MULTIEXPRESSION multiexpression", $$);  }
    ;

expression:
    term                    { $$=$1; parser_out("term", $$); }
    | term PLUS expression  { $$=$1+$3; parser_out("term PLUS expression", $$);}
    ;

term:   
    power               { $$=$1; parser_out("power", $$); }
    | power MPY term    { $$=$1*$3; parser_out("power MPY term", $$); }
    ;

power:
    factor                  { $$=$1; parser_out("factor", $$); }
    | factor POWER power    { $$=pow($1, $3); parser_out("factor POWER power", $$); }
    ;

factor:
    number                  { $$=$1; parser_out("number", $$); }
    | L_BR expression R_BR  { $$=($2); parser_out("L_BR expression R_BR", $$); }
    ;

number: 
    HEXADECIMAL { $$=$1; parser_out("HEXADECIMAL", $$); }
    | FLOAT     { $$=$1; parser_out("FLOAT", $$); }
    | INTEGER   { $$=$1; parser_out("INTEGER", $$); }
    ;

%%

void yyerror(const char* s) {   
    printf("%s\n",s);
}

void main(){
    yydebug = 1;
    yyparse();
}
