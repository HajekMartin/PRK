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

/* Function prototypes */

int process_pattern(int number, char *Message);

%}

INTEGER [0-9]+
FLOAT   [0-9]+\.[0-9]+
HEXADECIMAL 0x[0-9a-f]+

%%
^#.*\n      {lines_comment=process_pattern(lines_comment,"Comment deleted.\n");}
\+          {add_ops=process_pattern(add_ops,"Add operator detected.");}
\*          {mpy_ops=process_pattern(mpy_ops,"Multiplication operator detected.");}
pow\({INTEGER},{INTEGER}\) {pow_ops=process_pattern(pow_ops,"Power operator (int,int) detected."); integer_numbers++; integer_numbers++;}
pow\({INTEGER},{FLOAT}\) {pow_ops=process_pattern(pow_ops,"Power operator (int,float) detected."); integer_numbers++; float_numbers++;}
pow\({INTEGER},{HEXADECIMAL}\) {pow_ops=process_pattern(pow_ops,"Power operator (int,hexa) detected."); integer_numbers++; hexadecimal_numbers++;}
pow\({FLOAT},{FLOAT}\) {pow_ops=process_pattern(pow_ops,"Power operator (float,float) detected."); float_numbers++; float_numbers++;}
pow\({FLOAT},{HEXADECIMAL}\) {pow_ops=process_pattern(pow_ops,"Power operator (float,hexa) detected."); float_numbers++; hexadecimal_numbers++;}
pow\({HEXADECIMAL},{HEXADECIMAL}\) {pow_ops=process_pattern(pow_ops,"Power operator (hexa,hexa) detected."); hexadecimal_numbers++; hexadecimal_numbers++;}
\(          {br_left=process_pattern(br_left,"Opening bracket detected.");}
\)          {br_right=process_pattern(br_right,"Closing bracket detected.");} 
\|          {multipleexpressions=process_pattern(multipleexpressions,"Multipleexpressions detected.");}
{HEXADECIMAL}    {hexadecimal_numbers=process_pattern(hexadecimal_numbers,"Hexadecimal number detected.");}
{FLOAT} {float_numbers=process_pattern(float_numbers,"Float number detected.");}
{INTEGER}     {integer_numbers=process_pattern(integer_numbers,"Integer number detected.");}
^\n         {void_lines_done++;printf("Void line detected.\n");}
^\r\n         {void_lines_done++;printf("Void line detected.\n");}
\n          {lines_done++;printf("Line detected.\n");}
\r\n          {lines_done++;printf("Line detected.\n");}
.           {errors_detected=process_pattern(errors_detected,"An error detected.\n");}
%%
/* Main part */
int yywrap(){};
int main()
    {
        yylex();
        printf("%d of total errors detected in input file.\n",errors_detected);

        printf("***Datatypes***\n");
        printf("%d of integer numbers detected.\n",integer_numbers);
        printf("%d of hexadecimal numbers detected.\n",hexadecimal_numbers);
        printf("%d of float numbers detected.\n",float_numbers);

        printf("***Operators***\n");
        printf("%d of add operators detected.\n",add_ops);
        printf("%d of power operators detected.\n",pow_ops);
        printf("%d of multiplication operators detected.\n",mpy_ops);

        printf("***Others***\n");
        printf("%d of left bracket operators detected.\n",br_left);
        printf("%d of right bracket operators detected.\n",br_right);
        printf("%d of multipleexpression operators detected.\n",multipleexpressions);

        printf("***Summary***\n");
        printf("%d of comment lines canceled.\n",lines_comment);
        printf("%d of void lines ignored.\nFile processed sucessfully.\n",void_lines_done);
        printf("Totally %d of valid code lines in file processed.\nFile processed sucessfully.\n",lines_done);
    }

/* Function declaration */

int process_pattern(int number,char* Message) {
    #ifdef VERBOSE 
        printf("%s",Message);
    #endif
    number++;
    return number;
}
