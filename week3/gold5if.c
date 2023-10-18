#include <stdio.h>
int main(){
int a;
printf("chose an option from 1 to 5 : ");
scanf("%d", &a);

switch(a)
{
    case 1 :
    printf("you selected the first option\n");
    break;

    case 2:
    printf("you selected the second option\n");
    break;

    case 3 :
    printf("you selected the third option\n");
    break;

    case 4:
    printf("you selected the fourth option\n");
    break;

    case 5:
    printf("you selected the fifth option\n");
    break;

    default :
    printf("error error error\n");
}

return 0;
}