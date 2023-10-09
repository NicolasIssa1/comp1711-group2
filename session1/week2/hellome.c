#include <stdio.h>

int main (){
// setting up 15 slots of memory for a string
char name[15];

// prompting the user
printf("Helo, please enter your name:");

//Take the user input and storing in name
scanf("%s", name);

//printing out user's name
printf("Your name is %s\n", name);

return 0;
}