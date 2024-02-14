#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// Define the maze size
#define rows 13
#define cols 13

//I implement a function to check if a move is within the maze bounds
int is_within_bounds(int x, int y)
{
    return x>= 0 && x< rows && y >= 0 && y < cols;
}

int main() {
    //start by initializing the maze array
    char maze[rows][cols]; 

    for (int row = 0; row < rows; row++){
        for (int col = 0; col < cols; col++){
            maze[row][col] = '#';
        }
    }

    // Seed the random number generator
    srand(time(NULL));

    // Randomly select a start position along the top row
    int start = rand() % cols;
    maze[0][start] = 'S';

    //Random route genereated from S to the bottom row
    int current_row = 0;
    int current_col = start;

    while(current_row < rows -1)
    {
        int next_row = current_row;
        int next_col = current_col;

        // Move down every time, but sometimes also move left or right to create obstacles and a path
        next_row++;
    

    // Randomly decide if we should move left or right
        if (rand() % 3) {
            int direction = (rand() % 2) * 2 - 1;
            next_col += direction;
        }

        // Make sure the next_col is within bounds
        if (next_col < 0) {
            next_col = 0;
        } else if (next_col >= cols) {
            next_col = cols - 1;
        }

        // Carve the path if the next position is within bounds and if itis a wall
        if (is_within_bounds(next_row, next_col) && maze[next_row][next_col] == '#') {
            maze[next_row][next_col] = ' ';
            current_row = next_row;
            current_col = next_col;
        }
    }

    // Set the end point 'E'
    maze[rows - 1][current_col] = 'E';

    char filename [] = "maze.tsv";
    FILE *file = fopen(filename, "w");
    if (file == NULL) {
        perror("Error opening file");
        return 1;
    }

    for (int row = 0; row < rows; row++){
        for (int col = 0; col < cols; col++){
            fprintf(file, "%c", maze[row][col]);
        }
        fprintf(file, "\n");
    }

    fclose(file);
    return 0;
}
