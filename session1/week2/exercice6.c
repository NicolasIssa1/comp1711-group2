#include <stdio.h>

int main(){
    int number;
    printf("give me a number and i will tell you if it is even or odd:");
    scanf("%d", &number);
    if(number%2 == 0){
        printf("the number is even\n"); }
    else  {
         printf("the number is odd\n");}

     
return 0;
     
    
}