//#define VERBOSE 1 
#undef VERBOSE 



/* Define constants for patterns - used in process_pattern function */

#define PATT_NO 0 /* No pattern will be sent to parser */

#define PATT_INTEGER 11
#define PATT_FLOAT 12
#define PATT_HEXADECIMAL 13

#define PATT_PLUS 21 /* Plus operator */
#define PATT_MPY 22  /* Multiplication operator */
#define PATT_POWER 23
#define PATT_MULTIEXPRESSION 24

#define PATT_L_BR 31 /* Left bracket */
#define PATT_R_BR 32 /* Close bracket */

#define PATT_ERR 100 /* Error in patterns: exit on errors! */


#define ERR_PATTERN 1 /* Lexer: an error pattern detected. */

char *ErrMsgMain = "Error detected with code:";

char Err_Messages[][255] = {"No Error","Lexer: Wrong character detected. Exiting."};
    