def partOne(file):
    file = open(file)

    moves = []
    temp = []
    number_line = []
    crates = []

    for input_line in file.readlines():
        line = input_line.replace("\n", "")
        if "[" in input_line:
            temp.append(line)
        elif "move" in input_line:
            moves.append(input_line.replace("\n", ""))
        elif "1" in input_line:
            number_line = line.split()

    file.close()

    for line in temp:
        counter = 1
        x = []
        for num in number_line:
            x.append(line[counter])
            counter += 4
        crates.append(x)

    rotated = list(zip(*crates[::-1]))

    for x, line in enumerate(rotated):
        rotated[x] = list(rotated[x])

    for x, x_value in enumerate(rotated):
        rotated[x] = [y for y in x_value if y != " "]

    for move in moves:
        move = move.split(" ")
        amount = int(move[1])
        move_from = int(move[3]) - 1
        move_to = int(move[5]) - 1

        for n in range(0, amount):
            x = rotated[move_from].pop()
            rotated[move_to].append(x)

    output_string = ""

    for row in rotated:
        output_string += row.pop()
    print("Part one:", output_string)


def partTwo(file):
    file = open(file)

    moves = []
    temp = []
    number_line = []
    crates = []

    for input_line in file.readlines():
        line = input_line.replace("\n", "")
        if "[" in input_line:
            temp.append(line)
        elif "move" in input_line:
            moves.append(input_line.replace("\n", ""))
        elif "1" in input_line:
            number_line = line.split()
    file.close()

    for line in temp:
        counter = 1
        x = []
        for num in number_line:
            x.append(line[counter])
            counter += 4
        crates.append(x)

    rotated = list(zip(*crates[::-1]))

    for x, line in enumerate(rotated):
        rotated[x] = list(rotated[x])

    for x, x_value in enumerate(rotated):
        rotated[x] = [y for y in x_value if y != " "]

    for move in moves:
        move = move.split(" ")
        amount = int(move[1])
        move_from = int(move[3]) - 1
        move_to = int(move[5]) - 1

        things = []
        for n in range(0, amount):
            things.append(rotated[move_from].pop())

        things.reverse()

        for thing in things:
            rotated[move_to].append(thing)

    output_string = ""
    for row in rotated:
        output_string += row.pop()

    print("Part two:", output_string)


partOne("actual_input")
partTwo("actual_input")
