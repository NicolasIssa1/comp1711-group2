// change the program so that the user enters string instead of numbers
#include <stdio.h>
#include <stdlib.h>
int main()
{
    char *filename = "data.txt";

    FILE *file = fopen(filename, "w"); // or "a", "w+", "a+"
    if (file == NULL)
    {
        printf("Error opening file\n");
        return 1;
    }
    char str[10];
    scanf("%s", str1);
    //to convert number to string
    num_lines = atoi(str1);
    int total =0;
    float mean;

    char string[100];

    printf("Type %d numbers: ", num_lines);
    
    for (int i = 0; i < num_lines; i++)
    {
        scanf("%s", string);
        fprintf(file, "%s\n", string);
    }

    fclose(file);
    return 0;
}