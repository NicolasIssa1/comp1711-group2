#include <stdio.h>
int main(){
int temperature;
printf("give me a temperature in *Celsuis and i will tel you if it is between -10 and 40 degree celsius: ");
scanf("%d", &temperature);
if(temperature >=-10 && temperature <=40){
    printf("yes it is\n");
}
else {
    printf("no it is not\n");
}
return 0;
}