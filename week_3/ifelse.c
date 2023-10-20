#include <stdio.h>
int main() {
    int mark;
    //Add in:
    //Checking that the value is over 60 for 2:1
    //Check the value is over 70 for a first 
    //Check that the value is a valid mark (between 0 and 100, inclusive)
    
    printf ("Enter the mark: \n");
    scanf ("%d", &mark);
    // || means or not and 
    if (mark < 0 || mark > 100)
    {
         printf ("The mark of %d is invalid\n", mark);
     }

    else if(mark>=70 && mark<=100)
    {
        printf ("The mark of %d is a first\n", mark);
    }
    else if (mark >= 60)
    { 
        printf ("The mark of %d is a 2:1 mark\n", mark);
        }
    else if(mark >=40)
    {
        printf ("The mark of %d is a pass\n", mark);
    }
    else if(mark <40)
    {
        printf ("The mark of %d is a fail\n", mark);
    }
    
    else
    { 
        printf ("The mark of %d is not a pass\n", mark);
    }
    return 0;
    }