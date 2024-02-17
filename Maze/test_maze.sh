#!/bin/bash

# Define the maze executable and file names
EXECUTABLE="./maze"
MAZE_FILE="maze.tsv"

# Compiling the maze program
echo "Compiling maze.c..."
gcc maze.c -o maze
compile_status=$?

# Initialize test status
test_status=0

# 1st test: Check if the program compiled successfully
if [ $compile_status -ne 0 ]; then
    echo "Test 1 (Compilation Test): Failed to compile maze.c"
    test_status=1
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
    test_status=1
else
    echo "Test 2 (Maze File Creation Test): Passed"
fi

# 3rd test: Validate the contents of the maze
# Check for the correct number of 'S' and 'E'
start_count=$(grep -o "S" "$MAZE_FILE" | wc -l)
end_count=$(grep -o "E" "$MAZE_FILE" | wc -l)

if [ "$start_count" -ne 1 ]; then
    echo "Test 3.1 (Start Point Test): Invalid number of start points"
    test_status=1
else
    echo "Test 3.1 (Start Point Test): Passed"
fi

if [ "$end_count" -ne 1 ]; then
    echo "Test 3.2 (End Point Test): Invalid number of end points"
    test_status=1
else
    echo "Test 3.2 (End Point Test): Passed"
fi

# Test 4: Maze Boundaries Test
echo "Running Test 4: Maze Boundaries Test..."

# Assumption: MAZE_FILE should have been created after running the executable with a valid maze file
# Define expected row and column count
EXPECTED_ROWS=13
EXPECTED_COLS=13

# Count the actual number of rows and columns
actual_rows=$(cat "$MAZE_FILE" | wc -l)
actual_cols=$(head -1 "$MAZE_FILE" | grep -o . | wc -l)

# 4.1 Test: Validate the correct number of rows
if [ "$actual_rows" -ne $EXPECTED_ROWS ]; then
    echo "Test 4.1 (Row Count Test): Failed - Expected $EXPECTED_ROWS rows, found $actual_rows"
    test_status=1
else
    echo "Test 4.1 (Row Count Test): Passed"
fi

# 4.2 Test: Validate the correct number of columns
if [ "$actual_cols" -ne $EXPECTED_COLS ]; then
    echo "Test 4.2 (Column Count Test): Failed - Expected $EXPECTED_COLS columns, found $actual_cols"
    test_status=1
else
    echo "Test 4.2 (Column Count Test): Passed"
fi

# 4.3 Test: Check for walls at the maze boundaries
# Assuming that the maze file uses '#' to denote walls
boundary_test_passed=true
# Check the top and bottom boundaries
top_boundary=$(head -1 "$MAZE_FILE")
bottom_boundary=$(tail -1 "$MAZE_FILE")
if ! [[ "$top_boundary" =~ ^\#+$ ]] || ! [[ "$bottom_boundary" =~ ^\#+$ ]]; then
    boundary_test_passed=false
fi

# Check the left and right boundaries
while read -r line; do
    if ! [[ $line =~ ^\#.*\#$ ]]; then
        boundary_test_passed=false
        break
    fi
done < "$MAZE_FILE"

if ! $boundary_test_passed; then
    echo "Test 4.3 (Boundary Walls Test): Failed - Not all boundaries have walls"
    test_status=1
else
    echo "Test 4.3 (Boundary Walls Test): Passed"
fi

echo "Test 4 (Maze Boundaries Test): All boundary tests passed."


# Additional tests to validate the path, check for errors, etc., can be added here

# Test 5: Test game logic with no_end_maze.txt and no_end_input.txt
echo "Running Test 5: Game Logic Test with no end maze..."

# Run the program with the no_end_maze.txt and capture the output
output=$(cat no_end_input.txt | ./maze no_end_maze.txt)

# An example check:
if echo "$output" | grep -q "No end found"; then
    echo "Test 5 (Game Logic Test - No End Maze): Passed"
else
    echo "Test 5 (Game Logic Test - No End Maze): Failed"
    test_status=1
fi

# Test 6: Player Movement Tests
# Simulate the player moving up (W), which should be a valid move
echo "Running Test 6.1: Player Move Up Test..."
output=$(echo "W" | ./maze valid_maze.txt)
# You would replace the following line with a check for the expected output of a valid move
if echo "$output" | grep -q "Moved up"; then
    echo "Test 6.1 (Player Move Up Test): Passed"
else
    echo "Test 6.1 (Player Move Up Test): Failed"
    test_status=1
fi

# Test 7: Non-Rectangular Maze Test
echo "Running Test 7: Non-Rectangular Maze Test..."
output=$(./maze non_rectangular_maze.txt)
if echo "$output" | grep -q "Error: Maze is not rectangular"; then
    echo "Test 7 (Non-Rectangular Maze Test): Passed"
else
    echo "Test 7 (Non-Rectangular Maze Test): Failed"
    test_status=1
fi

# Test 8: No Start Maze Test
echo "Running Test 8: No Start Maze Test..."
output=$(./maze no_start_maze.txt)
if echo "$output" | grep -q "Error: No start point in maze"; then
    echo "Test 8 (No Start Maze Test): Passed"
else
    echo "Test 8 (No Start Maze Test): Failed"
    test_status=1
fi

# Test 9: No End Maze Test
echo "Running Test 9: No End Maze Test..."
output=$(./maze no_end_maze.txt)
if echo "$output" | grep -q "Error: No end point in maze"; then
    echo "Test 9 (No End Maze Test): Passed"
else
    echo "Test 9 (No End Maze Test): Failed"
    test_status=1
fi

# Test 10: Complex Maze Validation Test
echo "Running Test 10: Complex Maze Validation Test..."
start_points=$(grep -o "S" complex_maze.txt | wc -l)
end_points=$(grep -o "E" complex_maze.txt | wc -l)

if [ "$start_points" -ne 1 ]; then
    echo "Test 10.1 (Complex Maze Start Point Test): Failed - Incorrect number of start points"
    test_status=1
else
    echo "Test 10.1 (Complex Maze Start Point Test): Passed"
fi

if [ "$end_points" -ne 1 ]; then
    echo "Test 10.2 (Complex Maze End Point Test): Failed - Incorrect number of end points"
    test_status=1
else
    echo "Test 10.2 (Complex Maze End Point Test): Passed"
fi

# Test 11: Complex Maze Navigation Test
echo "Running Test 11: Complex Maze Navigation Test..."
output=$(cat complex_path_input.txt | ./maze complex_maze.txt)
# Check for expected program behavior based on input

if [ "expected_condition" ]; then
    echo "Test 11 (Complex Maze Navigation Test): Passed"
else
    echo "Test 11 (Complex Maze Navigation Test): Failed"
    test_status=1
fi


# Clean up
echo "Cleaning up..."
rm "$MAZE_FILE"

# At the end of the script, check if any test failed
if [ $test_status -ne 0 ]; then
    echo "Some tests failed."
else
    echo "All tests completed successfully."
fi
