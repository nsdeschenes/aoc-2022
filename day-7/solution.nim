import strutils
import std/strformat

const MAX_SIZE = 100000
const NEEDED_FREE_SPACE = 30000000
const MAX_DISC_SPACE = 70000000

type
    Directory = ref object
        children: seq[Directory]
        parent: Directory
        size: int
        path: string

# forward procedures
proc createFileTree(raw_input: seq[string]): Directory
proc calculateDirectorySizes(node: Directory): int
proc totalOfAllSmallDirs(node: Directory): int
proc findSmallestDir(
    node: Directory,
    current_size: int,
    space_needed: int
): int

proc createFileTree(raw_input: seq[string]): Directory =
    var root_dir: Directory = nil
    var current_dir: Directory = nil
    
    for line in raw_input:
        if line.contains("$"):
            let cleaned_line = replace(line, "$ ", "").split(" ")
            if cleaned_line[0] == "cd":
                if cleaned_line[1] == "..":
                    current_dir = current_dir.parent
                else:
                    if isNil(root_dir):
                        root_dir = Directory(
                            path: cleaned_line[1],
                            size: 0,
                            parent: nil,
                            children: newSeq[Directory]()
                        )
                        current_dir = root_dir
                    else:
                        let new_dir = Directory(
                            path: cleaned_line[1],
                            size: 0,
                            parent: current_dir,
                            children: newSeq[Directory]()
                        )
                        current_dir.children.add(new_dir)
                        current_dir = new_dir
        else:
            let split_line = line.split(" ")
            if split_line[0] != "dir":
                current_dir.size += parseInt(split_line[0])

    discard calculateDirectorySizes(root_dir)

    return root_dir

proc calculateDirectorySizes(node: Directory): int =
    if len(node.children) == 0:
        return node.size

    for child in node.children:
        node.size += calculateDirectorySizes(child)

    return node.size

proc totalOfAllSmallDirs(node: Directory): int =
    if len(node.children) == 0:
        if node.size <= MAX_SIZE:
            return node.size
        return 0

    var node_total_size = 0
    if node.size <= MAX_SIZE:
        node_total_size = node.size

    for child in node.children:
        node_total_size += totalOfAllSmallDirs(child)

    return node_total_size

proc findSmallestDir(
    node: Directory,
    current_size: int,
    space_needed: int
): int =
    # final state no more children
    if len(node.children) == 0:
        if node.size >= space_needed and node.size < current_size:
            return node.size
        return current_size

    var new_current = current_size
    var found_small_node = new_current
    
    # check the current node
    if node.size >= space_needed and node.size < new_current:
        new_current = node.size
        found_small_node = node.size

    # check the children node
    for child in node.children:
        let child_node_size = findSmallestDir(child, new_current, space_needed)
        if child_node_size >= space_needed and child_node_size < new_current:
            new_current = child_node_size
            found_small_node = child_node_size

    return found_small_node

proc partOne(file: string): string =
    let raw_input = readFile(file).split("\n")
    let root_dir = createFileTree(raw_input)

    let answer = totalOfAllSmallDirs(root_dir)

    return &"Part one: {answer}"

proc partTwo(file: string): string =
    let raw_input = readFile(file).split("\n")
    let root_dir = createFileTree(raw_input)

    let current_free_space = MAX_DISC_SPACE - root_dir.size
    let current_space_needed = NEEDED_FREE_SPACE - current_free_space

    let answer = findSmallestDir(root_dir, root_dir.size, current_space_needed)

    return &"Part two: {answer}"

echo partOne("actual_input")
echo partTwo("actual_input")
