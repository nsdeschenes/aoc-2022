import strutils
import std/strformat

proc loadFile(file: string): seq[seq[int]] =
    let raw_input = readFile(file)
    let lines = raw_input.split("\n")

    var grid: seq[seq[int]]

    for line in lines:
        var current_line: seq[int]
        for num in line:
            let casted_num = int(num) - int('0')
            current_line.add(casted_num)
        grid.add(current_line)
    return grid

proc partOne(file: string): string =
    let grid = loadFile(file)

    var total_visible = 0

    total_visible += len(grid) * 2
    total_visible += len(grid[0]) * 2 - 4

    for x in 1..len(grid) - 2:
        for y in 1..len(grid[x]) - 2:
            let current_tree = grid[x][y]

            var visible_left = true
            var visible_right = true
            var visible_top = true
            var visible_bottom = true

            # check left path
            for left_path in countdown(y - 1, 0):
                let left = grid[x][left_path]
                if left >= current_tree:
                    visible_left = false
                    break

            # check right path
            for right_path in countup(y + 1, len(grid) - 1):
                let right = grid[x][right_path]
                if right >= current_tree:
                    visible_right = false
                    break

            # check top path
            for top_path in countdown(x - 1, 0):
                let top = grid[top_path][y]
                if top >= current_tree:
                    visible_top = false
                    break

            # check bottom path
            for bottom_path in countup(x + 1, len(grid) - 1):
                let bottom = grid[bottom_path][y]
                if bottom >= current_tree:
                    visible_bottom = false
                    break

            if visible_left or visible_right or visible_top or visible_bottom:
                total_visible += 1

    return &"Part one: {total_visible}"

proc partTwo(file: string): string =
    let grid = loadFile(file)
    var best_scenic_score = 0

    for x in 1..len(grid) - 2:
        for y in 1..len(grid[x]) - 2:
            var scenic_score = 0
            let current_tree = grid[x][y]

            var visible_left = 0
            var visible_right = 0
            var visible_top = 0
            var visible_bottom = 0

            # check left path
            for left_path in countdown(y - 1, 0):
                let left = grid[x][left_path]
                visible_left += 1
                if left >= current_tree:
                    break

            # check right path
            for right_path in countup(y + 1, len(grid) - 1):
                let right = grid[x][right_path]
                visible_right += 1
                if right >= current_tree:
                    break

            # check top path
            for top_path in countdown(x - 1, 0):
                let top = grid[top_path][y]
                visible_top += 1
                if top >= current_tree:
                    break

            # check bottom path
            for bottom_path in countup(x + 1, len(grid) - 1):
                let bottom = grid[bottom_path][y]
                visible_bottom += 1
                if bottom >= current_tree:
                    break

            scenic_score = visible_left * visible_right * visible_top * visible_bottom

            if best_scenic_score < scenic_score:
                best_scenic_score = scenic_score

    return &"Part two: {best_scenic_score}"

echo partOne("actual_input")
echo partTwo("actual_input")