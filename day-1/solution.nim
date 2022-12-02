import strutils
import std/strformat
from std/sequtils import map

proc partOne(file: string): string =
    let rawInput = readFile(file)
    let elfs = rawInput.split("\n\n")

    var max: int

    for elf in elfs:
        let caliores = elf.split("\n").map(parseInt)
        var min = 0
        for caliore in caliores:
            min += caliore
        if min > max:
            max = min

    return &"Part one: {max}"

proc partTwo(file: string): string =
    let rawInput = readFile(file)
    let elfs = rawInput.split("\n\n")

    var max1: int
    var max2: int
    var max3: int

    for elf in elfs:
        let caliores = elf.split("\n").map(parseInt)
        var min = 0
        for caliore in caliores:
            min += caliore
        if min > max1:
            max1 = min
        elif min > max2:
            max2 = min
        elif min > max3:
            max3 = min

    return &"Part two: {max1 + max2 + max3}"

echo partOne("actual_input")
echo partTwo("actual_input")
