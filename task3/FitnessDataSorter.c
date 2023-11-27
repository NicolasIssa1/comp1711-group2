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
    if (ptr != NULL)
     {
        strcpy(date, ptr);
        ptr = strtok(NULL, &delimiter);
        if (ptr != NULL) 
        {
            strcpy(time, ptr);
            ptr = strtok(NULL, &delimiter);
            if (ptr != NULL)
             {
                // i added also an additional check to ensure that atoi has not failed when the input is not '0'
                *steps = atoi(ptr);
                if (*steps == 0 && ptr[0] != '0') 
                {
                    //but if concersion fails, so invalidate steps
                    *steps = -1;
                }
            }
        }
    }
}

//i create a function to validate the date to avoid bad data error ( and return 1)
int isValidDate(const char *date)
{
    //check for the lenght and format 
    if(strlen(date) != 10)
    {
        return 0;
    }
    if(date[4] != '-' || date[7] != '-')
    {
        return 0;
    }
    for(int i = 0; i<10; i++)
    {
        if(i == 4 || i == 7)
        {
            continue;
        }
        if(date[i] < '0' || date[i] > '9')
        {
            return 0;
        }
    }
    return 1;
    
}
//now i create the function to validate the time format
int isValidTime(const char *time)
{
    //check for lenght and format
    if(strlen(time)!= 5)
    {
        return 0;
    }
    if(time[2] != ':')
    {
        return 0;
    }
    for(int i = 0; i < 5; i++)
    {
        if(i == 2)
        {
            continue;
        }
        if(time[i] < '0' || time[i] > '9')
        {
            return 0;
        }
    }
    return 1;
}

//to sort the data , 
void sortData(FitnessData data[], int count)
{
    int i, j;
    for (i = 0; i < count -1; i++)
    {
        for (j = 0; j < count -i -1; j++)
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
}

int main() {
    char filename[100];
    FILE *file, *outfile;
    //I assume we will not have more than 500 records ( maximum assumption) 
    FitnessData data[500];
    //Keep track of number of records till the end
    int count = 0;
    char buffer [700];

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
    while (fgets(buffer, sizeof(buffer), file)!= NULL)
    {
        //i make sur that the string buffer will not have a newline character at the end 
        buffer[strcspn(buffer, "\n")] = 0;

        //i need to check for two commas , validate the format
        int comma_count = 0;
        for (int i = 0; buffer[i]; i++)
        {
            if(buffer[i] == ',')
            {
                comma_count++;
            }
        }
        if (comma_count != 2)
        {
            printf("Error: invalid file format - incorrect number of fields\n");
            fclose(file);
            return 1;
        }

        // i initialize steps to an invalid value to detect different parsing errors
        data[count].steps = -1;
        //parse the line into date time and steps
        tokeniseRecord(buffer, ',', data[count].date, data[count].time, &data[count].steps);

        //checking if the steps are valid after tokenization
        if(data[count].steps == -1)
        {
            printf("Error: Invalid step count format\n");
            fclose(file);
            return 1;
        }

        //now i validate tje date and time, if not valid, print an erorr messgae and close file and return 1
        if(!isValidDate(data[count].date) || !isValidTime(data[count].time))
        {
            printf("Error: Invalid data format\n");
            fclose(file);
            return 1;
        }

        count++;
    }

    fclose(file);

    //sort the data in descedning order of steps 
    sortData(data, count);

    char out_filename[150];
    //(arrived here sunday 26 november )
    //now we create an output filename and append .tsv to the input one
    snprintf(out_filename, sizeof(out_filename), "%s.tsv", filename);
    outfile = fopen(out_filename, "w");
    if(outfile == NULL)
    {
        printf("Error: could not create output file\n");
        return 1;
    }

    //now write the sorted data into the output file
    for(int i = 0; i < count; i++)
    {
        fprintf(outfile, "%s\t%s\t%d\n", data[i].date, data[i].time, data[i].steps);
    }
    fclose(outfile);
    printf("Data sorted and written to %s\n", out_filename);
    return 0;
}