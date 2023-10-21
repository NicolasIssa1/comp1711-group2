#include <stdio.h>
int main(){
int a [5] = {2,5,7,3,1} ;
int count;
int sum =0 ;
for ( count = 0 ; count <5 ; count ++){
    sum = sum + a[count];
}
printf("the sum is %d\n", sum);


}