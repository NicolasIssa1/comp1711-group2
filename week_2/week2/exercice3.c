#include <stdio.h>

int main(){
float area;
float radius;


printf("Give me the radius so i calculate the area of your circle : ");
scanf("%f", &radius);

area = 3.14 * radius ;
printf("The area of the circle is %.2f square meters\n", area);
return 0;

}
