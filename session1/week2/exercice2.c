#include <stdio.h>

int main(){
    int number ; 
    int number2 ;
    int c;
   printf("Hello world\n") ;
   printf(" Give me the first integer: ");
   scanf("%d" , &number ) ;
   printf("Give me your second integer : ");
   scanf("%d", &number2) ;
    c = number + number2 ;
   printf("The sum of the two integers you gave me is %d\n", c);



return 0;

} 