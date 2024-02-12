#My goal is to create a maze with the middle with walls on the sides
size = 7
maze = []

#the top wall:
top_bottom_wall = '#'*size
maze.append(top_bottom_wall)

#Middle of the maze with the walls on the side
for i in range(size -2):
    middle_row = '#' + ' ' * (size-2) + '#'
    maze.append(middle_row)

#Bottom wall:
maze.append(top_bottom_wall)

for row in maze:
    print(row)
