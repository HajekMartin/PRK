/* A simple C++ code to demontrate the optimization switches for gcc */
/* The output should be copied using the attached Makefile. */
/* Maintainer: Lenka Koskova Triskova, lenka.koskova.triskova@tul.cz */
/* License: MIT */

//#include <stdio.h>

//void condition1(int i){
//  printf ("The value of i is %d - condition was false and you see this.\n",i);
//}

int main (void)
{
  printf("The Condition 1 is always true so the if is removed at opt level 1 and only this message should be present in the output code.\n");

  //condition1(1); /* Internal condition true */
  printf ("The value of i is 1 - condition was false and you see this.\n");
  //condition1(-10); /* Internal condition false */
  printf ("The value of i is -10 - condition was false and you see this.\n");

  for (int i=0;i<3;i++) {
    printf("This is for, %dth iteration.",i);
  }
  return 0;
}

