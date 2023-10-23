#include <stdio.h>
//ask user to give 10 numbers, then store them in an array and 
//give the mean




int main()
{
    //declare an array
    int numbers[10];
    int i=0;
    int total = 0;
    float mean;

    for ( i = 0 ; i<10 ; i++)
    {
    printf("\n enter a number: ");
    scanf("%d\n", &numbers[i]);
    total += numbers[i];  
    }
    mean = total/10;
    printf("\n");
    for(i = 0 ; i<10 ; i++)
    {
        printf("%d\n", numbers[i]);
    }
    printf("The average is %.3f\n", mean);
return 0;
}