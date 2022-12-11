import strutils
import std/algorithm
import std/deques
import std/strformat
from math import floor, pow, lcm

type
    Monkey = ref object
        items: Deque[uint64]
        operation_left: string
        operation_right: string
        operation_proc: string
        test_divsor: int
        if_true: int
        if_false: int
        inspected_items: int

proc loadMonkeys(file: string): seq[Monkey] =
    # read in input file
    let raw_input = readFile(file).replace(",", "").split("\n")

    var monkey_seq: seq[Monkey]
    var counter = 0;
    var items: Deque[uint64]
    var operation_left: string
    var operation_right: string
    var operation_proc: string
    var test_divsor: int
    var if_true: int
    var if_false: int

    for line in raw_input:
        block setup_loop:
            let split_line = line.split(" ")

            # if empty new line just "continue" the loop
            if len(split_line) == 1 and split_line[0] == "":
                break setup_loop

            # load in list of monkey's items
            if counter == 1:
                let temp = split_line[4..len(split_line) - 1]
                var new_items: Deque[uint64]
                for x in temp:
                    new_items.addFirst(uint64(parseUInt(x)))
                items = new_items

            # load in operation
            if counter == 2:
                operation_left = split_line[5]
                operation_proc = split_line[6]
                operation_right = split_line[7]

            # load in test divsor
            if counter == 3:
                test_divsor = parseInt(split_line[len(split_line) - 1])

            # load in true case
            if counter == 4:
                if_true = parseInt(split_line[len(split_line) - 1])

            # load in false case
            if counter == 5:
                if_false = parseInt(split_line[len(split_line) - 1])

                # create new monkey
                let new_monkey = Monkey(
                    items: items,
                    operation_left: operation_left,
                    operation_right: operation_right,
                    operation_proc: operation_proc,
                    test_divsor: test_divsor,
                    if_true: if_true,
                    if_false: if_false,
                    inspected_items: 0
                )

                # add monkey to seq
                monkey_seq.add(new_monkey)

            # increment counter
            counter += 1

            # reset counter
            if counter == 6:
                counter = 0

    return monkey_seq

proc monkeyToss(monkeys: seq[Monkey], rounds: int, relief: int): int =
    var worry_level: uint64
    var value_left: uint64
    var value_right: uint64

    # get the lcm to later mod by to handle the big ints
    var divisors: seq[int]
    for m in monkeys:
        divisors.add(m.test_divsor)
    var modulus = uint64(lcm(divisors))

    for x in 1..rounds:
        for monkey_entry in monkeys:
            # increase monkey inspected count
            monkey_entry.inspected_items += len(monkey_entry.items)

            for x in 0..len(monkey_entry.items) - 1:
                # get operation left side
                if monkey_entry.operation_left == "old":
                    value_left = monkey_entry.items[0]
                else:
                    value_left = parseUInt(monkey_entry.operation_left)

                # get operation right side
                if monkey_entry.operation_right == "old":
                    value_right = monkey_entry.items[0]
                else:
                    value_right = parseUInt(monkey_entry.operation_right)

                # execute operation
                if monkey_entry.operation_proc == "+":
                    worry_level = value_left + value_right
                elif monkey_entry.operation_proc == "*":
                    worry_level = value_left * value_right

                # divide worry level by relief level
                worry_level = uint64(floor(float(worry_level) / float(relief)).toInt())

                # use lcm to handle the large ints
                worry_level = worry_level mod modulus

                # remove first entry in queue
                monkey_entry.items.popFirst()

                # check to see if current worry level is divisible
                let divisible = worry_level mod uint64(monkey_entry.test_divsor)

                # add item to corresponding monkey
                if divisible == 0:
                    monkeys[monkey_entry.if_true].items.addLast(worry_level)
                else:
                    monkeys[monkey_entry.if_false].items.addLast(worry_level)

    # add all inspected count numbers into one seq
    var inspected_seq: seq[int]
    for i, m in monkeys:
        inspected_seq.add(m.inspected_items)

    # sort inspected count in descending order
    sort(inspected_seq, cmp, SortOrder.Descending)

    # return the top two counts and multiple
    return inspected_seq[0] * inspected_seq[1]

proc partOne(file: string): string =
    let monkey_seq = loadMonkeys(file)
    let total = monkeyToss(monkey_seq, 20, 3)
    return &"Part one: {total}"

proc partTwo(file: string): string =
    let monkey_seq = loadMonkeys(file)
    let total = monkeyToss(monkey_seq, 10000, 1)
    return &"Part two: {total}"

echo partOne("actual_input")
echo partTwo("actual_input")
