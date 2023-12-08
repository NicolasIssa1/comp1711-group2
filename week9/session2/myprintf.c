#include <stdio.h>
#include <stdarg.h>

int pseudo_printf(const char *specifier, ...)
{

    // Essential parts of code. These are needed by the program to iterate over the variable list of arguments.

    // va_list is Macro provided in stdarg.h. A special list that can hold the parameters.
    
    va_list args; 

    //Initilisation of the list to hold all parameters passed after "specifier". 
    va_start(args, specifier);

    
    int character_count = 0;
    // Create an output array

    // Process untill the end of the format specifier string
    while (*specifier != '\0')
    {
        if (*specifier != '%') // Remember, we use % in printf. This is why.
        {
            putchar(*specifier);
            character_count = character_count + 1;
        }
        else
        {
            // Handle specifier specifiers
            switch (*++specifier) // Remember how switch case works.  
            {
            case 'd':
                character_count += fprintf(stdout, "%d", va_arg(args, int)); 

                // fprintf writes to file. stdout is your "terminal". Printing to stdout, means printing to your screen.
                // Again using fprintf() above. 
                // You might say this is cheating, and you are correct.
                // We can use write() function for this cause as well.  
                // Look at the platinum level problem in worksheet.
                break;
            case 'c':
                //Special care needs to be taken here. Look at platinum level worksheet.
                break;
            case 's':
                break;
            case 'f':
                character_count += fprintf(stdout, "%f", va_arg(args, double));
                break;
            default:
                // Handle unknown specifier specifiers
                putchar('%');
                putchar(*specifier);
                character_count += 2;
                break;
            }
        }
        specifier++;
    }

    va_end(args);
    return character_count;
}


int main()
{
    int t=50;
    double x=89.5;

    int count= pseudo_printf("Emulating printf. t = %d, x= %f",t,x);

    printf ("\n \n");

    count = pseudo_printf("Three parameters this time. %d, %d, %f, %f", 56, 65, 66.5, 76.6);

    printf ("\n \n");

}