import strutils
import std/strformat
import std/sequtils

proc loadInput(file: string): seq[seq[string]] =
    let raw_input = readFile(file).split("\n")

    var sequence: seq[seq[string]]
    for input in raw_input:
        sequence.add(input.split(","))

    return sequence

proc partOne(file: string): string =
    let input = loadInput(file)

    var pairs = 0
    for items in input:
        var counter = 0
        var a, b, c, d: int

        for item in items:
            if counter == 0:
                a = parseInt(item.split("-")[0])
                b = parseInt(item.split("-")[1])
            else:
                c = parseInt(item.split("-")[0])
                d = parseInt(item.split("-")[1])

            counter += 1
            if counter == 2:
                counter = 0

        if a >= c and b <= d:
            pairs += 1
        elif c >= a and d <= b:
            pairs += 1

    return &"Part one: {pairs}"

proc partTwo(file: string): string =
    let input = loadInput(file)

    var pairs = 0
    for items in input:
        var counter = 0
        var a, b, c, d: int

        for item in items:
            if counter == 0:
                a = parseInt(item.split("-")[0])
                b = parseInt(item.split("-")[1])
            else:
                c = parseInt(item.split("-")[0])
                d = parseInt(item.split("-")[1])

            counter += 1
            if counter == 2:
                counter = 0

        if toSeq(c..d).contains(a) or toSeq(c..d).contains(b):
            pairs += 1
        elif toSeq(a..b).contains(c) or toSeq(a..b).contains(d):
            pairs += 1

    return &"Part one: {pairs}"


echo partOne("actual_input")
echo partTwo("actual_input")
