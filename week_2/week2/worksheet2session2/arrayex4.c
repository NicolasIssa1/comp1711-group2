#include <stdio.h>
int main(){
    int a[5] = {1,2,3,4,5};
    int last = a[4];
    for (int i = 4; i>0 ;i-- ){
        a[i] = a[i-1];
    }
    a[0] = last;
    //Print rotated array
    for(int i = 0; i<5; i++){
        printf("%d\n", a[i]);

    }
return 0;
}