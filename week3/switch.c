#include <stdio.h>
int main() {
    int a;
    a = -2;

    while( a<0 || a>3)
    {
    printf("give me an integer : ");
    scanf("%d", &a);
    }

    //Challenges
    //Add a case for 2
    //Add a case for 3
    //Make a take in an input from the user
    //Validate the input from the user so it is always between 0 and 3 (inclusive)

    //Switching based on the value of a
    switch (a)
    {
         case 0: 
            printf ("Option 0 has been selected\n");
            break;
         
         case 1: 
            printf ("Option 1 has been selected\n");
            break;

         case 2:
            printf("Option 2 has been selected\n");
            break;

         case 3:
            printf("Option 3 has been selected \n");
            break;

         default:
         printf ("A different option has been selected\n");
    }
    
    }
    
