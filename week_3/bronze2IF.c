#include <stdio.h>
int main() {
    int a;
    
    printf("give me an integer: ");
    scanf("%d", &a);

    if(a%4 == 0 && a%5 == 0){
        printf("The number is divisible by both 4 and 5  \n");
    }
    else {
        printf("The number is not divisble by 4 or by 5  \n ") ;
    }
    
return 0;
}