#include <stdio.h>
float sum (int a, int b)
{
    float answer;
    answer = a + b;
    return answer;
}

int main()
{
    int y =2;
    float z = sum(5,y);
    printf("The sum of 5 and %d is %.2f\n", y, z);
}