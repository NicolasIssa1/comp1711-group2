#My goal is to create a maze with the middle with walls on the sides
size = 10
maze = []

#the top wall:
top_bottom_wall = '#'*size
maze.append(top_bottom_wall)

#Middle of the maze with the walls on the side
for i in range(size -2):
    middle_row = ['#'] * size
    if i == 0:
        middle_row[1] = 'S'
    elif i == size -3:
          # Place the 'E' at the second-to-last position
        middle_row[-2] = 'E'
    else:
        #now for the path,
        middle_row[1] = ' ' 
    maze.append(''.join(middle_row)) 


#Bottom wall:
maze.append(top_bottom_wall)

#now for the start and end points
maze[1] = list(maze[1])
maze[-2] = list(maze[-2])

for row in maze:
    print(''.join(row))

filename = "Maze/maze.txt"
with open(filename, 'w') as f:
    for row in maze:
        #checking if the row is a list
        if isinstance(row, list):
            # Convert the list to a string and write to the file
             f.write(''.join(row) + '\n') 
        #but if it is already a string , just write it to the fike
        else:
            f.write(row + '\n')