#include <stdio.h>
int main(){
int mark;

printf("Your mark : ");
scanf("%d", &mark);

if(mark<50){
    printf("your mark of %d is a fail\n", mark);
}
else if( mark >=50 && mark <70 ){
    printf("your mark of %d is a pass\n", mark );
}
else if( mark>70){
    printf("your mark of %d is a distinction mark\n", mark);
}
return 0; 
}