#include <stdio.h>
#include "utils.h"

int main()
{
    char *filename = "squares.dat";
    FILE *file = open_file (filename , "w") ;

    int number;
    int squarenumber;
    printf("give me an integer n so i give you the square of the positives integers from 1 to n: ");
    scanf("%d\n", &number);
  
    for ( int i = 0 ; i<= number ; i++)
    {
    
        squarenumber = i*i ;
        fprintf(file, "the square of the number %d is %d\n", i, squarenumber);
    }

    fclose(file);
    return 0;
}