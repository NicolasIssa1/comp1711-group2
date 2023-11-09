#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "FitnessDataStruct.h"

// Struct moved to header file

// Define any additional variables here
// Global variables for filename and FITNESS_DATA array to store the data
FITNESS_DATA FitnessDataArray[100];
int count_record = 0;

// This is your helper function. Do not change it in any way.
// Inputs: character array representing a row; the delimiter character
// Outputs: date character array; time character array; steps character array
void tokeniseRecord(const char *input, const char *delimiter,
                    char *date, char *time, char *steps) {
    // Create a copy of the input string as strtok modifies the string
    char *inputCopy = strdup(input);
    
    // Tokenize the copied string
    char *token = strtok(inputCopy, delimiter);
    if (token != NULL) {
        strcpy(date, token);
    }
    
    token = strtok(NULL, delimiter);
    if (token != NULL) {
        strcpy(time, token);
    }
    
    token = strtok(NULL, delimiter);
    if (token != NULL) {
        strcpy(steps, token);
    }
    
    // Free the duplicated string
    free(inputCopy);
}

//This is a function to read data from the file and populate FitnessDataArray ( task 1)
void readFitnessData(const char* filename, FITNESS_DATA* FitnessDataArray, int* count_record)
{
    FILE* file = fopen(filename, "r");
    if (file == NULL)
    {
        printf("Error: Could not find or open the file. \n");
        //The program returns 1 and exist as said in the note ( because the file cannot be opened succesfully):
        exit(1);
    }

    char line_buffer[150];
    while (fgets(line_buffer, sizeof(line_buffer), file) != NULL)
     {
        printf("Reading line: %s", line_buffer);
        char date[11];
        char time[6];
        char steps_str[15];

        //Then i use the helper function from the header file to tokenise the record
        tokeniseRecord(line_buffer, ",", date, time, steps_str);

        int steps = atoi(steps_str);
        strcpy(FitnessDataArray[*count_record].date, date);
        strcpy(FitnessDataArray[*count_record].time, time);
        FitnessDataArray[*count_record].steps = steps;

        (*count_record)++;
     }
     fclose(file);
     printf("File successfully loaded \n");
}

void displayTotalRecords(int count_record)
{
    printf("Total records: %d\n", count_record);
}
// Complete the main function
int main()
{
    FITNESS_DATA FitnessDataArray[100];
    int count_record = 0;
    char choice;
    char filename[256];

    do
    {
        printf("\nMenu Options: \n");
        printf("A: Specify the filename to be imported\n");
        printf("B: Display the total number of records in file\n");
        printf("Q: Quit \n");
        printf("Enter choice: ");
        //i used a space before %c to avoid any whitespace 
        scanf(" %c", &choice);

        switch(choice)
        {
            case 'A':
                printf("Input filename: ");
                scanf("%s", filename);
                readFitnessData(filename, FitnessDataArray, &count_record);
                break;
            case 'B':
                displayTotalRecords(count_record);
                break;
            case 'Q':
                printf("Program will exit. \n");
                break;
            default:
                printf("Invalid choice. Try again.\n");
                break;
        }
    }
    while(choice != 'Q');
    return 0;  
}