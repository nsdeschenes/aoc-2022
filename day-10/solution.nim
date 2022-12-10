import strutils
import std/strformat

proc partOne(file: string): string =
    let lines = readFile("actual_input").split("\n")

    var cycles = 0
    var register = 1
    var check_register = 20
    var total = 0

    block execution_loop:
        for line in lines:
            let instruction = line.split(" ")
            let operation = instruction[0]

            if operation == "noop":
                cycles += 1

                if cycles == check_register:
                    total += register * check_register
                    check_register += 40

                if cycles == 220:
                    break execution_loop


            elif operation == "addx":
                let value = parseInt(instruction[1])
                for x in 1..2:
                    cycles += 1

                    if cycles == check_register:
                        total += register * check_register
                        check_register += 40

                    if cycles == 220:
                        break execution_loop

                    if x == 2:
                        register += value

    return &"Part One: total"

proc partTwo(file: string) =
    let lines = readFile(file).split("\n")

    var cycles = 0
    var register = 1
    var break_line_index = 40
    var crt: seq[seq[string]]
    var row: seq[string]

    for line in lines:
        let instruction = line.split(" ")
        let operation = instruction[0]

        if operation == "noop":
            cycles += 1

            if len(row) - 1 <= register and register <= len(row) + 1:
                row.add("#")
            else:
                row.add(".")

            if cycles == break_line_index:
                crt.add(row)
                row = newSeq[string]()
                break_line_index += 40

        elif operation == "addx":
            let value = parseInt(instruction[1])
            for x in 1..2:
                cycles += 1

                if len(row) - 1 <= register and register <= len(row) + 1:
                    row.add("#")
                else:
                    row.add(".")

                if cycles == break_line_index:
                    crt.add(row)
                    row = newSeq[string]()
                    break_line_index += 40

                if x == 2:
                    register += value

    echo "Part two:"
    for line in crt:
        echo line.join("")

echo partOne("actual_input")
partTwo("actual_input")
