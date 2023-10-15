#include <stdio.h>
int main(){
int a [5] = {5,1,3,7,0} ;
int count;
int maxcount = a[0] ; 
for(count = 0 ; count <=4 ; count ++){
    if(a[count] > maxcount){
        maxcount = a[count];
        
        }
     
    }
printf("the maximum element is %d\n", maxcount);
return 0;

}