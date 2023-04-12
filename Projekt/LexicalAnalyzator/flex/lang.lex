%{
#include <stdio.h>
%}

digit       [0-9]
hexaextend  [a-f]
number      (0x[0-9a-fA-F]+)|([0-9]+(\.[0-9]+)?)
sum         ({product}(\+{product})*) 
product     ({factor}(\*{factor})*) 
factor      ({number}|(\({sum}\))|(pow\({sum},{sum}\)))
multipleexpressions  ({sum}(\|{sum})*) 

%%

{number}                printf("NUMBER: %s\n", yytext);
{sum}                   printf("SUM: %s\n", yytext);
{product}               printf("PRODUCT: %s\n", yytext);
{factor}                printf("FACTOR: %s\n", yytext);
{multipleexpressions}   printf("MULTIPLE EXPRESSIONS: %s\n", yytext);
\n                      /* ignore newline */
.                       /* ignore any other character */

%%

int main(void) {
    yylex();
    return 0;
}
