import strutils
import std/strformat

proc partOne(file: string): string =
    let raw_input = readFile(file)

    var counter = 0

    for n in countup(0, len(raw_input) - 1):
        let first = raw_input[n]
        let second = raw_input[n + 1]
        let third = raw_input[n + 2]
        let fourth = raw_input[n + 3]

        if first != second and first != third and first != fourth:
            if second != first and second != third and second != fourth:
                if third != first and third != second and third != fourth:
                    if fourth != first and fourth != second and fourth != third:
                        counter = n + 4
                        break

    return &"Part one: {counter}"

proc partTwo(file: string): string =
    let raw_input = readFile(file)

    var marker_index = 0
    var end_index = 13
    for n in countup(0, len(raw_input) - 1):
        let sub_string = substr(raw_input, n, end_index)

        var repeating_chars: seq[char]
        for character in sub_string:
            if count(sub_string, character) >= 2:
                repeating_chars.add(character)

        end_index += 1

        if len(repeating_chars) == 0:
            marker_index = end_index
            break

    return &"Part two: {marker_index}"

echo partOne("actual_input")
echo partTwo("actual_input")
