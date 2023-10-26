#include <stdio.h>
#include <stdlib.h>
int main()
{
    char *filename = "squares.dat";
    FILE *file = fopen(filename, "r");
    
    float average;
    int buffer_size = 100;
    char line_buffer[buffer_size];
    int sum = 0;
    int count = 0;
    while(fgets(line_buffer, buffer_size, file) != NULL)
    {
        //convert each line of text into an integer
        int num = atoi(line_buffer);
        printf("%i\n", num);
        sum += num;
        count++;
        //check if there are numbers left in the file
        if (count > 0) 
        {
            float average = (float)sum / count;
            printf("Average: %.2f\n", average);
        }
    
    }
    fclose(file);
    return 0;
}

