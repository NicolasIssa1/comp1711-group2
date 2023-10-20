#include <stdio.h>

float SphereVolume( float radius){
    float answer;
    float pi = 3.14;
    answer = (4/3)* pi * (radius * radius * radius);
    return answer;
}


int main()
{
int radius = 3;
float z = SphereVolume(radius);

printf("The SphereVolume of a sphere with a radius of %d is %.2f\n", radius, z);

}