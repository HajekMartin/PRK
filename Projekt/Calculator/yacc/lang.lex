%{
/* Nepotřebný v podstatě */
int lines_done=0;
int void_lines_done=0;
int lines_comment=0;

/* Sčítání */
int add_ops=0;
/* Násobení */
int mpy_ops=0;
/* Mocnina */
int pow_ops=0;

/* Závorky */
int br_left=0;
int br_right=0;

/* Datové typy */
int integer_numbers=0;
int float_numbers=0;
int hexadecimal_numbers=0;

/* Multipleexpressions */
int multipleexpressions=0;

int errors_detected=0;

#include "lang.h"
#include "y.tab.h"
#include <stdlib.h>


/* Function prototypes */

int process_pattern(int number, char *Message, int Pattern);
void print_error(int ERRNO);
int hexstr2int(char *hexstr);
void print_msg(char *msg);

%}


INTEGER             [0-9]+
FLOAT               {INTEGER}+\.{INTEGER}+
HEXADECIMAL         0x[0-9a-f]+
PLUS                \+
MULTIPLICATION      \*
BRACKET_LEFT        \(
BRACKET_RIGHT       \)
POWER               \^
MULTIEXPRESSION     \|

%%
^#.*\n {lines_comment=process_pattern(lines_comment,"Comment deleted.\n",PATT_NO);}
{PLUS} {
        add_ops=process_pattern(add_ops,"Add operator detected.\n",PATT_PLUS);        
        return PLUS; 
        }
{MULTIPLICATION} {
        mpy_ops=process_pattern(mpy_ops,"Multiplication operator detected.\n",PATT_MPY);
        return MPY;
        }
{BRACKET_LEFT} {
        br_left=process_pattern(br_left,"Opening bracket detected.\n",PATT_L_BR);
        return L_BR;
        }
{BRACKET_RIGHT} {
        br_right=process_pattern(br_right,"Closing bracket detected.\n", PATT_R_BR);
        return R_BR;
        } 
{POWER} { 
        pow_ops=process_pattern(pow_ops,"Power operator detected.\n", PATT_POWER);
        return POWER;
}
{MULTIEXPRESSION} { 
        multipleexpressions=process_pattern(multipleexpressions,"Multipleexpression detected.\n", PATT_MULTIEXPRESSION);
        return MULTIEXPRESSION;
}
{FLOAT} {
        float_numbers=process_pattern(float_numbers,"Float number detected.\n", PATT_FLOAT);      
        yylval = atof(yytext);
        //printf("LANG.LEX yytext: %s yylval: %f\n", yytext, yylval); //Testovací výpis
        return FLOAT;
        } 
{HEXADECIMAL} {
        hexadecimal_numbers=process_pattern(hexadecimal_numbers,"Binary number detected.\n", PATT_HEXADECIMAL);   
        yylval = hexstr2int(yytext);              
        return HEXADECIMAL;
        }
{INTEGER} {
        integer_numbers=process_pattern(integer_numbers,"Integer number detected.\n", PATT_INTEGER);   
        yylval = atoi(yytext);              
        return INTEGER;
        }
^\n    {        
        void_lines_done++;        
        print_msg("Void line detected.\n");}       
^\r\n    {        
        void_lines_done++;        
        print_msg("Void line detected.\n");}   
\n     {
        lines_done++;
        print_msg("Line detected.\n");
        return LINE_END;
        }
\r\n     {
        lines_done++;
        print_msg("Line detected.\n");
        return LINE_END;
        }

[ \t]+ ; /*Skip whitespace*/

.      {errors_detected=process_pattern(errors_detected,"An error detected.\n",PATT_ERR);} /* What is not from alphabet: lexer error  */
%%

/* Function declaration */

int yywrap(void) {
   return 1;
}

int hexstr2int(char *hexstr){
   return (int) strtol(hexstr, NULL, 16);
}

void print_msg(char *msg){
    #ifdef VERBOSE
        printf("%s",msg);
    #endif
}

void print_error(int ERRNO){
    #ifdef VERBOSE
        char *message = Err_Messages[ERRNO];
        printf("%s - %d - %s\n",ErrMsgMain,ERR_PATTERN,message);
    #endif
}

int process_pattern(int number,char* Message, int Pattern) {
    if (Pattern == PATT_ERR) {       
        print_error(ERR_PATTERN);        
        exit(ERR_PATTERN);
    }    

    print_msg(Message);
    
    number++;
    return number;
}
