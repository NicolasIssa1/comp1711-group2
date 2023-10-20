#include <stdio.h>
int main() {
    int a;
    
    printf("give me an integer: ");
    scanf("%d", &a);

    if(a ==0){
        printf("The number is equal to zero \n");
    }
    else if(a>0){
        printf("The number is positive \n ") ;
    }
    else if(a<0){
        printf("The number is negative \n") ;
    }
return 0;
}