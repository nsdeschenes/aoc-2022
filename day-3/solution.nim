import strutils
import std/strformat

const LOWER_CASE = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']

const UPPER_CASE = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']

proc findValue(input_char: char): int =
    var score = 0
    if isUpperAscii(input_char):
        score = 26
        for value in UPPER_CASE:
            score += 1
            if input_char == value:
                return score
    elif isLowerAscii(input_char):
        for value in LOWER_CASE:
            score += 1
            if input_char == value:
                return score

proc loadInput(file: string): seq[string] =
    let raw_input = readFile(file)
    return raw_input.split("\n")

proc partOne(file: string): string =
    let input_seq = loadInput(file)

    var output_seq: seq[seq[string]]

    for input in input_seq:
        let input_length = int(len(input) / 2)

        let input_1 = input[0..input_length-1]
        let input_2 = input[input_length..len(input)-1]

        output_seq.add(@[input_1, input_2])

    var total_score = 0

    for input in output_seq:
        var found_char: char
        for character in input[0]:
            if input[1].contains(character) and character != found_char:
                found_char = character
        total_score += findValue(found_char)
    return &"Part one: {total_score}"

proc partTwo(file: string): string =
    let input_seq = loadInput(file)

    var setup_seq: seq[seq[string]]
    var temp_seq: seq[string]
    var counter = 0
    var total_score = 0

    for input in input_seq:
        counter += 1
        temp_seq.add(input)

        if counter == 3:
            setup_seq.add(temp_seq)
            temp_seq = newSeq[string]()
            counter = 0

    for lists in setup_seq:
        var found_char: char
        for character in lists[0]:
            if lists[1].contains(character) and lists[2].contains(character) and character != found_char:
                found_char = character
        total_score += findValue(foundChar)

    return &"Part two: {total_score}"

echo partOne("actual_input")
echo partTwo("actual_input")
