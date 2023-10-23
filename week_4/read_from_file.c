#include <stdio.h>
#include <stdlib.h>
int main() {
    char* filename = "data.txt";
    FILE *file = fopen(filename, "r");
    if (file == NULL) {
        printf("Error opening file\n");
        return 1;
    }
    //read up to 100 characters onto the line 
    //(or) numbers or characters whih will be read per line
    int buffer_size = 100;
    //making a string which will hold each line as it's read in
    char line_buffer[buffer_size];

    //creating an array of integersd called number which is a 1000 long 
    //an arbitrry large number
    int numbers[1000];

    //to count number of lines
    int line_number_counting =0 ;

    //"while there is still data/stuff  in the file, "
    //gonna read 100 characters into line buffer
    //the fgets reads a line from of a text from a file and store them into 'buffer...'
    while (fgets(line_buffer, buffer_size, file) != NULL) 
    {
        printf("%s\n", line_buffer);
        //store them into an array
        line_number_counting++;
    }
    //to count the number of lines
    printf("There were %d lines\n", line_number_something);

    fclose(file);
    return 0;
}