// challenge 1: ask the user to pick how many numbers to enter
//then calculate the mean of the numbers and write this as the final line of the file
#include <stdio.h>

int main()
{
    char *filename = "data.txt";

    FILE *file = fopen(filename, "w"); // or "a", "w+", "a+"
    if (file == NULL)
    {
        printf("Error opening file\n");
        return 1;
    }

    int number;
    int total;
    int mean;
    printf("how many numbers do you want to wirte?\n");
    int num_lines = 10;
    scanf("%d", &num_lines);

    printf("Type %d numbers:\n", num_lines);
    
    for (int i = 0; i < num_lines; i++)
    {
        scanf("%d", &number);
        total += number;
        //to write to a file, it is fprintf
        fprintf(file, "%d\n", number);
    }
    fclose(file);
    return 0;
}