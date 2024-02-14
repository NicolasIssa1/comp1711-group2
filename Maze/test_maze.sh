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

# 2nd test: Run the maze program and check if it exits with a success status
echo "Running the maze program..."
$EXECUTABLE
run_status=$?

if [ $run_status -ne 0 ]; then
    echo "Test 2 (Run Test): Maze program did not run successfully"
    exit 1
else
    echo "Test 2 (Run Test): Passed"
fi

# 3rd test: Check if the maze file was created by the program
if [ ! -f "$MAZE_FILE" ]; then
    echo "Test 3 (Maze File Creation Test): Failed to create maze file"
    exit 1
else
    echo "Test 3 (Maze File Creation Test): Passed"
fi

# 4th test: Validate the contents of the maze
# Check for the correct number of 'S' and 'E'
start_count=$(grep -o "S" "$MAZE_FILE" | wc -l)
end_count=$(grep -o "E" "$MAZE_FILE" | wc -l)

if [ "$start_count" -ne 1 ]; then
    echo "Test 4.1 (Start Point Test): Invalid number of start points"
    exit 1
else
    echo "Test 4.1 (Start Point Test): Passed"
fi

if [ "$end_count" -ne 1 ]; then
    echo "Test 4.2 (End Point Test): Invalid number of end points"
    exit 1
else
    echo "Test 4.2 (End Point Test): Passed"
fi

echo "All tests completed successfully."
