#include <stdio.h>

int main(){
int number;
int factorial =1;
int i;
printf("give me a number and i will give you the factorial of it ");
scanf("%d", &number); 
for (int i= 1 ; i<= number ; i++) { 
        factorial = factorial * i;}
        /*here , factorial became 1 and will go back to the
         begginning of the for loop to multiply itself by the new value of i which
         is i + 1 so 1 + 1 so 2 now. then factorial will become 2 and come back beginning of for 
         loop to multiply itself by the new value of i which is 3 so 2 x 3 = 6. The cycle stops when
         i = 4 so factoriel 6 x i 4 = 24. done. */

        
printf("Factorial of %d is %d\n", number, factorial);
return 0;
   
}