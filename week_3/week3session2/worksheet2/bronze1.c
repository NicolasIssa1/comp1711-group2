#include <stdio.h>

float circleArea( float radius){
    float answer;
    float pi = 3.14;
    answer = pi * (radius * radius);
    return answer;
}


int main()
{
int radius = 3;
float z = circleArea(radius);

printf("The circle area is %.2f\n", z);

}