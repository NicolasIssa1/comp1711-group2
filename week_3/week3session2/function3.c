#include <stdio.h>

float sum(float a, float b)
{
    float answer;
    answer = a + b;
    //return the value of 'answer' as the result of the function
    return answer;
}

int main()
{
    float y = 2.1 ;
     //calling the 'sum' function with the arguments
     //'5' and 'y'. This means it is passing 5 as a and the value of y as b. 
     //The result of the sum function is stored in the z variable
    float z = sum(5,y);
    printf("The sum of 5 and %f is %.2f\n", y, z);
    return 0;
}

