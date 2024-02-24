#!/bin/bash

# Define the maze executable and temporary file
EXECUTABLE="./maze"
TMP_FILE="tmp"

# Start to compile the maze program
echo "Compiling maze.c..."
if ! gcc maze.c -o "$EXECUTABLE"; then
    echo "Compilation failed."
    exit 1
fi

echo -e "\n\n~~ Maze Tests ~~"

# Test 1:  for simple maze
echo -n "Test 1: Testing simple maze - "
$EXECUTABLE simple_maze.txt < simple_path_input.txt > "$TMP_FILE" 2>&1
# Assuming "Player reached the end" indicates a successful navigation
if grep -q "Player reached the end" "$TMP_FILE"; then
    echo "Test 1 :PASS"
else
    echo "Test 1:FAIL"
fi

# Test 2:  for non-rectangular maze
echo -n "Test 2 : Testing non-rectangular maze - "
$EXECUTABLE non_rectangular_maze.txt < non_rectangular_input.txt > "$TMP_FILE" 2>&1
# Assuming "Error: Maze is not rectangular" as expected output
if grep -q "Error: Maze is not rectangular" "$TMP_FILE"; then
    echo "Test 2: PASS"
else
    echo "Test 2: FAIL"
fi

# Test 3: for no start maze
echo -n "Test 3: Testing no start maze - "
$EXECUTABLE no_start_maze.txt < no_start_input.txt > "$TMP_FILE" 2>&1
# Assuming "Error: No start point found" as expected output
if grep -q "Error: No start point S found" "$TMP_FILE"; then
    echo "Test 3: PASS"
else
    echo "Test 3: FAIL"
fi

# Test 4: for no end maze
echo -n "Test 4: Testing no end maze - "
$EXECUTABLE no_end_maze.txt < no_end_input.txt > "$TMP_FILE" 2>&1
# Add here the condition you expect when no end point is in the maze
if grep -q "Maze has no end" "$TMP_FILE"; then
    echo "Test 4: PASS"
else
    echo "Test 4: FAIL"
fi

# Test 5: for complex maze
echo -n "Test 5: Testing complex maze - "
$EXECUTABLE complex_maze.txt < complex_path_input.txt > "$TMP_FILE" 2>&1
# Assuming specific conditions for complex maze navigation success
if grep -q "Player can't reach the end" "$TMP_FILE"; then
    echo "Test 5: PASS"
else
    echo "Test 5: FAIL"
fi

# Test 6: Testing player starts at 'S'
echo -n "Test 6: Testing player starts at 'S' - "
$EXECUTABLE valid_maze.txt < valid_path_input.txt > "$TMP_FILE" 2>&1
if grep -q "PLayer X starts at position S" "$TMP_FILE"; then
    echo "Test 6: PASS"
else
    echo "Test 6: FAIL"
fi

# Test 7: Testing player can move correctly (e.g., move right)
echo -n "Test 7: Testing player move right - "
$EXECUTABLE valid_maze.txt < valid_path_input.txt > "$TMP_FILE" 2>&1
if grep -q "Player moves right using D command" "$TMP_FILE"; then
    echo "Test 7: PASS"
else
    echo "Test 7: FAIL"
fi

# Test 8: Testing maze with incorrect characters
echo -n "Test 8: Testing maze with incorrect characters - "
$EXECUTABLE incorrect_characters_maze.txt > "$TMP_FILE" 2>&1
if grep -q "Error: Incorrect characters in maze" "$TMP_FILE"; then
    echo "Test 8: PASS"
else
    echo "Test 8: FAIL"
fi

# Test 9: Testing maze with multiple 'S' or 'E'
echo -n "Test 9: Testing maze with multiple 'S' or 'E' - "
$EXECUTABLE multiple_maze.txt > "$TMP_FILE" 2>&1
if grep -q "Error: Multiple start or end points" "$TMP_FILE"; then
    echo "Test 9: PASS"
else
    echo "Test 9: FAIL"
fi

# Test 10: Testing movement commands from file
echo -n "Test 10: Testing movement commands from file - "
$EXECUTABLE valid_maze.txt < invalid_input.txt > "$TMP_FILE" 2>&1
if grep -q "Expected final position message" "$TMP_FILE"; then
    echo "Test 10: PASS"
else
    echo "Test 10: FAIL"
fi

# Test 11: Testing wall boundaries are solid
echo -n "Test 11: Testing wall boundaries are solid - "
if grep -q "Error: Wall boundaries are not solid" "$TMP_FILE"; then
    echo "Test 11: PASS"
else
    echo "Test 11: FAIL"
fi

# Test 12: Testing invalid movement (e.g., through a wall)
echo -n "Test 12: Testing invalid movement through a wall - "
$EXECUTABLE valid_maze.txt < invalid_movement_input.txt > "$TMP_FILE" 2>&1
if grep -q "Error: Cannot move through walls" "$TMP_FILE"; then
    echo "Test 12: PASS"
else
    echo "Test 12: FAIL"
fi

# Test 13: Testing game over condition
echo -n "Test 13: Testing game over condition - "
$EXECUTABLE valid_maze.txt > "$TMP_FILE" 2>&1
if grep -q "Game over message" "$TMP_FILE"; then
    echo "Test 13: PASS"
else
    echo "Test 13: FAIL"
fi

# Test 14: Testing maze with no paths from 'S' to 'E'
echo -n "Test 14: Testing maze with no paths from 'S' to 'E' - "
$EXECUTABLE complex_maze.txt > "$TMP_FILE" 2>&1
if grep -q "Error: No path from start S to end E" "$TMP_FILE"; then
    echo "Test 14: PASS"
else
    echo "Test 14: FAIL"
fi

# Test 15: Testing player ends at 'E'
echo -n "Test 15: Testing player ends at 'E' - "
$EXECUTABLE valid_maze.txt < valid_movement_input.txt > "$TMP_FILE" 2>&1
if grep -q "PLayer X ends at position E" "$TMP_FILE"; then
    echo "Test 15: PASS"
else
    echo "Test 15: FAIL"
fi

# Test 16: Counting Rows
echo -n "Test 16: Counting Rows - "
$EXECUTABLE valid_maze.txt > "$TMP_FILE" 2>&1
#i implement my expected rows and check if the actual rows are equal to the expected ones
EXPECTED_ROWS=13
actual_rows=$(grep -c . "valid_maze.txt")
if [ "$actual_rows" -eq "$EXPECTED_ROWS" ]; then
    echo "Test 16: PASS"
else
    echo "Test 16: FAIL"
fi

# Test 17: Counting Columns
echo -n "Test 17: Counting Columns - "
$EXECUTABLE valid_maze.txt > "$TMP_FILE" 2>&1
# same implementation for the colunmss and the condition. 
EXPECTED_COLS=13
actual_cols=$(head -1 "valid_maze.txt" | awk '{print length}')
if [ "$actual_cols" -eq "$EXPECTED_COLS" ]; then
    echo "Test 17: PASS"
else
    echo "Test 17: FAIL"
fi

# Test 18: Check Top and Bottom Boundaries
echo -n "Test 18: Check Top and Bottom Boundaries - "
$EXECUTABLE valid_maze.txt > "$TMP_FILE" 2>&1
top_boundary=$(head -1 "valid_maze.txt")
bottom_boundary=$(tail -1 "valid_maze.txt")
if [[ "$top_boundary" == '#S########' ]] && [[ "$bottom_boundary" == '#E########' ]]; then
    echo "Test 18: PASS"
else
    echo "Test 18: FAIL"
fi

# Test 19: Check Left and Right Boundaries
echo -n "Test 19: Check Left and Right Boundaries - "
$EXECUTABLE valid_maze.txt > "$TMP_FILE" 2>&1
# This assumes that the maze uses '#' for walls
if ! grep -qv '^\#.*\#$' "valid_maze.txt"; then
    echo "Test 19: PASS"
else
    echo "Test 19: FAIL"
fi

# Test 20: Player Move Up Test
echo -n "Test 20: Player Move Up Test - "
$EXECUTABLE valid_maze.txt < move_up_input.txt  > "$TMP_FILE" 2>&1
if echo "$output" | grep -q "Moved up"; then
    echo "Test 20: PASS"
else
    echo "Test 20: FAIL"
fi

# Test 21: Player Move Down Test
echo -n "Test 21: Player Move Down Test - "
$EXECUTABLE valid_maze.txt < move_down_input.txt  > "$TMP_FILE" 2>&1
if echo "$output" | grep -q "Moved down"; then
    echo "Test 21: PASS"
else
    echo "Test 21: FAIL"
fi

# Test 22: Valid Maze Navigation Test ( from the start S to the end E)
echo -n "Test 22: Valid Maze Navigation Test - "
$EXECUTABLE valid_maze.txt < valid_movement_input.txt > "$TMP_FILE" 2>&1
if echo "$output" | grep -q "Player reached the end"; then
    echo "Test 22: PASS"
else
    echo "Test 22: FAIL"
fi

# Test 23: Bad User Input Test
echo -n "Test 23: Bad User Input Test - "
# I simulate a bad input command 'B'
echo "B" | $EXECUTABLE valid_maze.txt < bad_user_input.txt > "$TMP_FILE" 2>&1
# Assuming "Invalid command" message indicates incorrect input
if grep -q "Invalid command" "$TMP_FILE"; then
    echo "Test 23: PASS"
else
    echo "Test 23: FAIL"
fi

# Test 24: System Error Handling Test
echo -n "Test 24: System Error Handling Test - "
# Attempt to run the program with a non-existent file
$EXECUTABLE non_existent_file.txt > "$TMP_FILE" 2>&1
# Assuming "Error: Cannot open file" message indicates a file access issue
if grep -q "Error: Cannot open file" "$TMP_FILE"; then
    echo "Test 24: PASS"
else
    echo "Test 24: FAIL"
fi

# Cleaning up the temporary file
rm -f "$TMP_FILE"

echo "All tests completed."
