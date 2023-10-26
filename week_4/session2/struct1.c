#include <stdio.h>

struct student {
    char name [200];
    char student_id [11]; // Assuming 10 digits.
    unsigned mark; 
};

int main () {
    struct student new_student = {"Nicolas Issa", "28932123", 100};
    printf("Student name: %s\n", new_student.name);
    printf("Student ID:   %s\n", new_student.student_id);
    printf("Final mark:   %u\n", new_student.mark);
    return 0;
}