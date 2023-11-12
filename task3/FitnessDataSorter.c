#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Define the struct for the fitness data
typedef struct {
    char date[11];
    char time[6];
    int steps;
} FitnessData;

// Function to tokenize a record
void tokeniseRecord(char *record, char delimiter, char *date, char *time, int *steps) {
    char *ptr = strtok(record, &delimiter);
    if (ptr != NULL) {
        strcpy(date, ptr);
        ptr = strtok(NULL, &delimiter);
        if (ptr != NULL) {
            strcpy(time, ptr);
            ptr = strtok(NULL, &delimiter);
            if (ptr != NULL) {
                *steps = atoi(ptr);
            }
        }
    }
}


int main() {
    char filename[100];
    char out_filename[150];
    FILE *file, *outfile;
    //I assume we will not have more than 500 records ( maximum assumption) 
    FitnessData data[500];
    //Keep track of number of records till the end
    int count = 0;

    //Ask for user to etner a filename 
    printf("Enter a filename: ");
    scanf("%s", filename);

    //open file in read mode first (attempt)
    file = fopen(filename, "r");
    if (file == NULL)
    {
        printf("Error: invalid file\n");
        //so we return 1 and exit 
        return 1;
    }

    //I then check if the file is in the correct format ( 12-15...)

    char buffer[700];
    while (fgets(buffer, 700, file)!= NULL)
    {
        //i make sur that the string buffer will not have a newline character at the end 
        buffer[strcspn(buffer, "\n")] = 0;

        //then store data (like we did in task 1 , splitting lines...)
        tokeniseRecord(buffer, ',', data[count].date, data[count].time, &data[count].steps);
        count++;
    }

    fclose(file);

    //sort the data in descedning order of steps 
    for ( int i = 0 ; i < count -1; i++)
    {
        for (int j = 0; j < count -i -1; j++)
        {
            if(data[j].steps < data[j+1].steps)
            {
                //then swap the fitnessdata records
                FitnessData temp = data[j];
                data[j] = data[j+1];
                data[j+1] = temp;
            }
        }
    }
    
    //(arrived here sunday 12 november )
    //now we create an output filename and append .tsv to the input one
    strcpy(out_filename, filename);
    //to append i used a new function called strcat
    strcat(out_filename, ".tsv");

    //then open the output file in write mode 
    outfile = fopen(out_filename, "w");
    if(outfile == NULL)
    {
        printf("Error: could not create output file\n");
        return 1;
    }
    //then wrrite the sorted data into the output file
    for (int i = 0; i< count; i++)
    {
        //i  usef \t because the spaces in the output file are \t characters 
        fprintf(outfile, "%s\t%s\t%d\n", data[i].date, data[i].time, data[i].steps);
    }

    //finally close the output file and return 0 to exist successfully
    fclose(outfile);
    printf("Data sorted and written to %s\n", out_filename);

    return 0;
}   
