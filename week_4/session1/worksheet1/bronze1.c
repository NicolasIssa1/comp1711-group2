#include <stdio.h>

int main()
{
    char *filename = "squares.dat";
    FILE *file = fopen(filename , "w") ;

    int number;
    int squarenumber;
    printf("give me an integer n so i give you the square of the positives integers from 1 to n: ");
    scanf("%d", &number);
  
    for ( int i = 0 ; i<= number ; i++)
    {
    
        squarenumber = i*i ;
        fprintf(file, "%d\n", squarenumber);
    }

    fclose(file);
    return 0;
}