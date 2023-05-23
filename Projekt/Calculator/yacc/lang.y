%{

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <ctype.h>

#define YYDEBUG 1

// Můj Debug output
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

// Moje funkce pro výpis
float* floatArray;
int* position;

void createFloatArray(int size, int start) { 
    if (start == 0) {
        free(floatArray);
    }
    // Size se zamozrejme meni na zaklade poctu toho kolik mam multiexpression - zde pouzivam 10 - pokud by se prevysilo spadlo by to kvuli chybe v pridani...
    // Pokud bych chtel univerzalni muselo by se pridat zdvojnasobeni pole pokud bych dosahnul maxima
    floatArray = (float*)malloc(size * sizeof(float));
    if (floatArray == NULL) {
        printf("Memory allocation failed.\n");
    }
    position = (int*)malloc(sizeof(int));
    *position = 0;
    return;
}

void addToArray(float number) {
    #ifdef DEBUG_OUTPUT
        printf("[addToArray] number: %f position: %i \n", number, *position);
    #endif
    floatArray[*position] = number;
    (*position)++;
}

void printArray() {
    printf("Output: ");
    int i;
    for (i = *position - 1; i >= 0; i--) {
        printf("%f", floatArray[i]);
        if (i != 0) {
            printf("|");
        }
    }
    printf("\n");
}


%}

%define api.value.type {double} // Aby bylo všechno double prostě

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
    lang multiexpression LINE_END { 
            printArray(); // Výpis pole - jsem na konci gramatiky
            createFloatArray(10, 0); // Vytvoření prázdeného pro další vstupy
            $$=$2; 
            #ifdef DEBUG_OUTPUT
                printf("#1 lang: %f multiexpression:  %f\n", $1, $2);
            #endif
            parser_out("Lang", $$); 
        } 
    | multiexpression LINE_END { 
            printArray(); // Výpis pole - jsem na konci gramatiky
            createFloatArray(10, 0); // Vytvoření prázdeného pro další vstupy
            $$=$1; 
            #ifdef DEBUG_OUTPUT
                printf("#2 multiexpression: %f\n", $1);
            #endif
            parser_out("Lang2", $$); 
        } 
    ;

multiexpression:
    expression { 
        addToArray($1); // Přidání do pole
        #ifdef DEBUG_OUTPUT
            printf("#3 expression: %f\n", $1);
        #endif
        $$=$1; parser_out("expression", $$); 
    } 
    | expression MULTIEXPRESSION multiexpression { 
            addToArray($1); // Přidání do pole
            #ifdef DEBUG_OUTPUT
                printf("#4 expression: %f\n", $1);
            #endif
            $$=$1; parser_out("expression MULTIEXPRESSION multiexpression", $$);  
            $$=$3; 
        } 
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
    createFloatArray(10, 1); // Vytvoření pole nového se start argumentem 1
    yydebug = 0;
    yyparse();
}
