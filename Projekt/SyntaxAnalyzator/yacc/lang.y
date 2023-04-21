%{
/* Original EBNF 

number = hexadecimal | decimal, [".", decimal];
decimal = digit, {digit};
hexadecimal = "0x", {digit | hexaextend};
digit = "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9";
hexaextend = "a" | "b" | "c" | "d" | "e" | "f";
factor = number | "(", expression, ")";
power = factor, {"^", factor};
term = power, {"*", power};
expression = term, {"+", term};
multiexpression=expression, {"|", expression};
syntax = multiexpression;

*/

#include <stdio.h>

int yylex();
void yyerror(const char *s);
void debug_print(const char *s);
extern int yylineno, yylval;

%}

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

/*LANG start*/
lang:
    lang multiexpression LINE_END           { debug_print("[OK] 1"); }
    | multiexpression LINE_END              { debug_print("[OK] 2"); }
    ;

multiexpression:
    expression                                      { debug_print("[OK] 3"); }
    | expression MULTIEXPRESSION multiexpression    { debug_print("[OK] 4"); }
 // |                                               { debug_print("[OK] 5"); }
    ;

expression:
    term                    { debug_print("[OK] 6"); }
    | term PLUS expression  { debug_print("[OK] 7"); }
  //|                       { debug_print("[OK] 8"); }
    ;

term:   
    power{ debug_print("[OK] 8"); } { debug_print("[OK] 9"); }
    | power MPY term                { debug_print("[OK] 10"); }
  //|                               { debug_print("[OK] 11"); }
    ;

power:
    factor                  { debug_print("[OK] 12"); }
    | factor POWER power    { debug_print("[OK] 13"); }
  //|                       { debug_print("[OK] 14"); }
    ;

factor:
    number                                  { debug_print("[OK] 15"); }
    | L_BR expression R_BR                  { debug_print("[OK] 16"); }
  //|                                       { debug_print("[OK] 17"); } nevím úplně spíš nemá být
    ;

number: 
    HEXADECIMAL                             { debug_print("[OK] 18"); }
    | FLOAT                                 { debug_print("[OK] 19"); }
    | INTEGER                               { debug_print("[OK] 20"); }
    ;

%%

void yyerror(const char* s) {   
    printf("%s\n",s);
}

void debug_print(const char *s) {
    //#ifdef VERBOSE
    printf("%s\n", s);
    //#endif
}

void main(){
    // yydebug = 1;
    debug_print("Entering the main");
    yyparse();
}

