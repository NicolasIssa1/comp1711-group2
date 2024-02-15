Maze Game Test Data Repository

Welcome to the Maze Game Test Data repository. This collection is a comprehensive suite of test mazes designed to validate and challenge the functionality of maze-solving programs. The repository contains various maze files, each created to test different aspects of the game logic, ensuring robustness and proper error handling.

Contents:

simple_maze.txt: A basic maze with a clear path from start ('S') to end ('E').

complex_maze.txt: A more intricate maze with multiple twists and turns.

no_start_maze.txt: A maze deliberately missing a start point to test program's error handling.

no_end_maze.txt: A maze without an end point to validate the program's end-of-path detection.

non_rectangular_maze.txt: A maze that does not conform to the standard rectangular shape, testing the program's flexibility in handling different shapes and sizes.

Each maze file is accompanied by detailed documentation of the scenario it represents and the expected outcomes when processed by a maze-solving program.

Test Script:

test_maze.sh: A shell script to compile, execute, and validate the maze-solving program against the provided maze files.

For further details on each test file and the scenarios they cover, please refer to the comments within the individual files.

References:

Test Plan: The test plan outlines the strategy for testing the maze-solving program, including the creation of test data, execution of tests, and validation of results. It serves as a blueprint for ensuring comprehensive test coverage and verifying the correctness of the program's functionality.

Test Script: The test script (test_maze.sh) automates the process of compiling, executing, and validating the maze-solving program against the provided test mazes. It references the maze program and maze files mentioned above and serves as a convenient tool for executing tests and verifying the program's behavior.