import strutils
import std/sets
import std/strformat

proc loadFile(file: string): seq[string] =
    return readFile(file).split("\n")

proc partOne(file: string): string =
    let lines = loadFile(file)

    var head_pos = (0, 0)
    var tail_pos = (0, 0)

    var positions: HashSet[(int, int)]

    for line in lines:
        let split_line = line.split(" ")
        let direction = split_line[0]
        let amount = parseInt(split_line[1])

        # if direction is up
        if direction == "U":
            for y in 1..amount:
                head_pos[1] += 1

                if abs(head_pos[1] - tail_pos[1]) >= 2 and head_pos[0] == tail_pos[0]:
                    tail_pos[1] += 1

                elif abs(head_pos[1] - tail_pos[1]) >= 2 and head_pos[0] > tail_pos[0]:
                    tail_pos[1] += 1
                    tail_pos[0] += 1

                elif abs(head_pos[1] - tail_pos[1]) >= 2 and head_pos[0] < tail_pos[0]:
                    tail_pos[1] += 1
                    tail_pos[0] -= 1

                positions.incl(tail_pos)

        # if direction is down
        elif direction == "D":
            for y in 1..amount:
                head_pos[1] -= 1

                if abs(head_pos[1] - tail_pos[1]) >= 2 and head_pos[0] == tail_pos[0]:
                    tail_pos[1] -= 1
                
                if abs(head_pos[1] - tail_pos[1]) >= 2 and head_pos[0] > tail_pos[0]:
                    tail_pos[1] -= 1
                    tail_pos[0] += 1
                
                if abs(head_pos[1] - tail_pos[1]) >= 2 and head_pos[0] < tail_pos[0]:
                    tail_pos[1] -= 1
                    tail_pos[0] -= 1

                positions.incl(tail_pos)

        # if direction is left
        elif direction == "L":
            for x in 1..amount:
                head_pos[0] -= 1

                if abs(head_pos[0] - tail_pos[0]) >= 2 and head_pos[1] == tail_pos[1]:
                    tail_pos[0] -= 1
                
                if abs(head_pos[0] - tail_pos[0]) >= 2 and head_pos[1] > tail_pos[1]:
                    tail_pos[0] -= 1
                    tail_pos[1] += 1
                
                if abs(head_pos[0] - tail_pos[0]) >= 2 and head_pos[1] < tail_pos[1]:
                    tail_pos[0] -= 1
                    tail_pos[1] -= 1

                positions.incl(tail_pos)

        # if direction is right
        elif direction == "R":
            for x in 1..amount:
                head_pos[0] += 1

                if abs(head_pos[0] - tail_pos[0]) >= 2 and head_pos[1] == tail_pos[1]:
                    tail_pos[0] += 1
                
                elif abs(head_pos[0] - tail_pos[0]) >= 2 and head_pos[1] > tail_pos[1]:
                    tail_pos[0] += 1
                    tail_pos[1] += 1
                
                elif abs(head_pos[0] - tail_pos[0]) >= 2 and head_pos[1] < tail_pos[1]:
                    tail_pos[0] += 1
                    tail_pos[1] -= 1

                positions.incl(tail_pos)

    let position_length = len(positions)
    return &"Part one: {position_length}"

proc move(point: (int, int), x: int, y: int): (int, int) =
    return (point[0] + x, point[1] + y)

proc moveHead(point: (int, int), direction: string): (int, int) =
    var dX = 0
    var dY = 0

    if direction == "U":
        dY += 1
    elif direction == "D":
        dY -= 1
    elif direction == "L":
        dX -= 1
    elif direction == "R":
        dX += 1

    return move(point, dX, dY)

proc partTwo(file: string): string =
    let lines = loadFile(file)

    var knots: seq[(int, int)]
    for x in 1..10:
        knots.add((0, 0))

    var tail_positions: HashSet[(int, int)]

    for line in lines:
        let split_line = line.split(" ")
        let direction = split_line[0]
        let amount = parseInt(split_line[1])

        for y in 1..amount:
            knots[0] = moveHead(knots[0], direction)

            for z in 1..len(knots) - 1:
                let dX = knots[z][0] - knots[z-1][0]
                let dY = knots[z][1] - knots[z-1][1]

                if not (abs(dX) <= 1 and abs(dY) <= 1):
                    if (dX > 0):
                        knots[z] = move(knots[z], -1, 0)
                    elif (dX < 0):
                        knots[z] = move(knots[z], 1, 0)

                    if (dY > 0):
                        knots[z] = move(knots[z], 0, -1)
                    elif (dY < 0):
                        knots[z] = move(knots[z], 0, 1)

            tail_positions.incl(knots[len(knots) - 1])

    let visited = len(tail_positions)
    return &"Part two: {visited}"

echo partOne("actual_input")
echo partTwo("actual_input")