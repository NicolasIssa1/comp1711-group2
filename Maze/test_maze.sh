#!/bin/bash

# Define the maze executable and file names
EXECUTABLE="./maze"
MAZE_FILE="maze.tsv"

# Compiling the maze program
echo "Compiling maze.c..."
gcc maze.c -o maze
compile_status=$?

# 1st test: Check if the program compiled successfully
if [ $compile_status -ne 0 ]; then
    echo "Test 1 (Compilation Test): Failed to compile maze.c"
    exit 1
else
    echo "Test 1 (Compilation Test): Passed"
fi

# Provide input for the maze program from a file, if required
# echo "Providing input from simple_path_input.txt..."
# $EXECUTABLE < simple_path_input.txt

# ... (you would add any other automated input here)

# 2nd test: Check if the maze file was created by the program
if [ ! -f "$MAZE_FILE" ]; then
    echo "Test 2 (Maze File Creation Test): Failed to create maze file"
    exit 1
else
    echo "Test 2 (Maze File Creation Test): Passed"
fi

# 3rd test: Validate the contents of the maze
# Check for the correct number of 'S' and 'E'
start_count=$(grep -o "S" "$MAZE_FILE" | wc -l)
end_count=$(grep -o "E" "$MAZE_FILE" | wc -l)

if [ "$start_count" -ne 1 ]; then
    echo "Test 3.1 (Start Point Test): Invalid number of start points"
    exit 1
else
    echo "Test 3.1 (Start Point Test): Passed"
fi

if [ "$end_count" -ne 1 ]; then
    echo "Test 3.2 (End Point Test): Invalid number of end points"
    exit 1
else
    echo "Test 3.2 (End Point Test): Passed"
fi

# Additional tests to validate the path, check for errors, etc., can be added here

# Clean up
echo "Cleaning up..."
rm "$MAZE_FILE"

echo "All tests completed successfully."
