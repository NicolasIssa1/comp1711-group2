#!/bin/bash

# Define the maze executable and file names
EXECUTABLE="./maze"
MAZE_FILE="maze.tsv"

# Compiling the maze program
#This test checks if the maze program compiles without errors
echo "Compiling maze.c..."
gcc maze.c -o maze
compile_status=$?

# Initialize test status
test_status=0

# Test 1: Check if the program compiled successfully
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

# Test 2: Maze File Creation test
# This test checks if the maze file maze.tsv was created by the program
if [ ! -f "$MAZE_FILE" ]; then
    echo "Test 2 (Maze File Creation Test): Failed to create maze file"
    test_status=1
else
    echo "Test 2 (Maze File Creation Test): Passed"
fi

# Test 3: Validate the contents of the maze
# Check for the correct number of 'S' and 'E'
start_count=$(grep -o "S" "$MAZE_FILE" | wc -l)
end_count=$(grep -o "E" "$MAZE_FILE" | wc -l)

#Test 3.1 : Start point test
# This test checks if the maze file contains exactly one start point "S"
if [ "$start_count" -ne 1 ]; then
    echo "Test 3.1 (Start Point Test): Invalid number of start points"
    test_status=1
else
    echo "Test 3.1 (Start Point Test): Passed"
fi

#Test 3.2: End point test
#This one checs if the maze file contrains exactly one end point 'E'
if [ "$end_count" -ne 1 ]; then
    echo "Test 3.2 (End Point Test): Invalid number of end points"
    test_status=1
else
    echo "Test 3.2 (End Point Test): Passed"
fi

# Test 4: Maze Boundaries Test
echo "Running Test 4: Maze Boundaries Test..."

#We made an assumption: MAZE_FILE should have been created after running the executable with a valid maze file
# Define expected row and column count
EXPECTED_ROWS=13
EXPECTED_COLS=13

# Count the actual number of rows and columns
actual_rows=$(cat "$MAZE_FILE" | wc -l)
actual_cols=$(head -1 "$MAZE_FILE" | grep -o . | wc -l)

# Test 4.1: Row count test
# to validate the correct number of rows
if [ "$actual_rows" -ne $EXPECTED_ROWS ]; then
    echo "Test 4.1 (Row Count Test): Failed - Expected $EXPECTED_ROWS rows, found $actual_rows"
    test_status=1
else
    echo "Test 4.1 (Row Count Test): Passed"
fi

# Test 4.2: Column count test
#Validate the correct number of columns
if [ "$actual_cols" -ne $EXPECTED_COLS ]; then
    echo "Test 4.2 (Column Count Test): Failed - Expected $EXPECTED_COLS columns, found $actual_cols"
    test_status=1
else
    echo "Test 4.2 (Column Count Test): Passed"
fi

# Test 4.3: Boundary walls test
#Check for walls at the maze boundaries ( the # denotes the walls)
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


# Test 5: Game logic test:
#Test game logic with no_end_maze.txt ( no end maze)
echo "Running Test 5: Game Logic Test with no end maze..."

# Run the program with the no_end_maze.txt and capture the output
#This test checks the game's response when provided a maze without an end point. 
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
# Test 6.1: Player Move up test
# This test simulates a player moving up to validate if movement is handled correctly. 
if echo "$output" | grep -q "Moved up"; then
    echo "Test 6.1 (Player Move Up Test): Passed"
else
    echo "Test 6.1 (Player Move Up Test): Failed"
    test_status=1
fi

# Test 6.2: Player move down test
# This test simulates a player moving down (S) to validate if the movement is handled correctly.
echo "Running Test 6.2: Player Move Down Test..."
output=$(echo "S" | $EXECUTABLE valid_maze.txt)
# Check for the expected output indicating the player has moved down
if echo "$output" | grep -q "Moved down"; then
    echo "Test 6.2 (Player Move Down Test): Passed"
else
    echo "Test 6.2 (Player Move Down Test): Failed"
    test_status=1
fi

# Test 7: Non-Rectangular Maze Test
#This test checks the game's response when provided a non-rectangular maze.
echo "Running Test 7: Non-Rectangular Maze Test..."
output=$(./maze non_rectangular_maze.txt)
if echo "$output" | grep -q "Error: Maze is not rectangular"; then
    echo "Test 7 (Non-Rectangular Maze Test): Passed"
else
    echo "Test 7 (Non-Rectangular Maze Test): Failed"
    test_status=1
fi

# Test 8: No Start Maze Test
#This test checks the game's response when provided with a maze with no start point 
echo "Running Test 8: No Start Maze Test..."
output=$(./maze no_start_maze.txt)
if echo "$output" | grep -q "Error: No start point in maze"; then
    echo "Test 8 (No Start Maze Test): Passed"
else
    echo "Test 8 (No Start Maze Test): Failed"
    test_status=1
fi

# Test 9: No End Maze Test
# This one checks the game's response when provided a maze with no end point
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

#Test 10.1: Complex Maze Start point test
#This test checks if the complex maze has the correct start point 
if [ "$start_points" -ne 1 ]; then
    echo "Test 10.1 (Complex Maze Start Point Test): Failed - Incorrect number of start points"
    test_status=1
else
    echo "Test 10.1 (Complex Maze Start Point Test): Passed"
fi

# Test 10.2: Complex maze end point test
# This test checks if the complex maze has the correct end point
if [ "$end_points" -ne 1 ]; then
    echo "Test 10.2 (Complex Maze End Point Test): Failed - Incorrect number of end points"
    test_status=1
else
    echo "Test 10.2 (Complex Maze End Point Test): Passed"
fi

# Test 11: Complex Maze Navigation Test
#This test checks if the player can navigate through a complex maze according to te given input commands.
echo "Running Test 11: Complex Maze Navigation Test..."
output=$(cat complex_path_input.txt | ./maze complex_maze.txt)

if echo "$output" | grep -q "Player reached the end"; then
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
