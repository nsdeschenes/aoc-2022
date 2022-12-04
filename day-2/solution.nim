import strutils
import std/strformat

const ROCK_SCORE = 1
const PAPER_SCORE = 2
const SCISSORS_SCORE = 3
const LOST_SCORE = 0
const DRAW_SCORE = 3
const WIN_SCORE = 6
const COMPUTER_ROCK = "A"
const COMPUTER_PAPER = "B"
const COMPUTER_SCISSORS = "C"
const PLAYER_ROCK = "X"
const PLAYER_PAPER = "Y"
const PLAYER_SCISSORS = "Z"
const OUTCOME_LOSE = "X"
const OUTCOME_DRAW = "Y"
const OUTCOME_WIN = "Z"

proc loadGame(file: string): seq[seq[string]] =
    let rawInput = readFile(file)
    let rawGames = rawInput.split("\n")

    var games: seq[seq[string]]
    for game in rawGames:
        games.add(game.split(" "))

    return games

proc partOne(file: string): string =
    let games = loadGame(file)

    var total_score = 0

    for game in games:
        let player_1_move = game[0]
        let player_2_move = game[1]

        if player_1_move == COMPUTER_ROCK:
            if player_2_move == PLAYER_ROCK:
                total_score += DRAW_SCORE
                total_score += ROCK_SCORE
            elif player_2_move == PLAYER_PAPER:
                total_score += WIN_SCORE
                total_score += PAPER_SCORE
            elif player_2_move == PLAYER_SCISSORS:
                total_score += LOST_SCORE
                total_score += SCISSORS_SCORE
        if player_1_move == COMPUTER_PAPER:
            if player_2_move == PLAYER_ROCK:
                total_score += LOST_SCORE
                total_score += ROCK_SCORE
            elif player_2_move == PLAYER_PAPER:
                total_score += DRAW_SCORE
                total_score += PAPER_SCORE
            elif player_2_move == PLAYER_SCISSORS:
                total_score += WIN_SCORE
                total_score += SCISSORS_SCORE
        if player_1_move == COMPUTER_SCISSORS:
            if player_2_move == PLAYER_ROCK:
                total_score += WIN_SCORE
                total_score += ROCK_SCORE
            elif player_2_move == PLAYER_PAPER:
                total_score += LOST_SCORE
                total_score += PAPER_SCORE
            elif player_2_move == PLAYER_SCISSORS:
                total_score += DRAW_SCORE
                total_score += SCISSORS_SCORE


    return &"Part one: {total_score}"

proc partTwo(file: string): string =
    let games = loadGame(file)

    var total_score = 0

    for game in games:
        let computer_shape = game[0]
        let player_outcome = game[1]

        if player_outcome == OUTCOME_LOSE:
            total_score += LOST_SCORE
            if computer_shape == COMPUTER_ROCK:
                total_score += SCISSORS_SCORE
            elif computer_shape == COMPUTER_PAPER:
                total_score += ROCK_SCORE
            elif computer_shape == COMPUTER_SCISSORS:
                total_score += PAPER_SCORE
        elif player_outcome == OUTCOME_DRAW:
            total_score += DRAW_SCORE
            if computer_shape == COMPUTER_ROCK:
                total_score += ROCK_SCORE
            elif computer_shape == COMPUTER_PAPER:
                total_score += PAPER_SCORE
            elif computer_shape == COMPUTER_SCISSORS:
                total_score += SCISSORS_SCORE
        elif player_outcome == OUTCOME_WIN:
            total_score += WIN_SCORE
            if computer_shape == COMPUTER_ROCK:
                total_score += PAPER_SCORE
            elif computer_shape == COMPUTER_PAPER:
                total_score += SCISSORS_SCORE
            elif computer_shape == COMPUTER_SCISSORS:
                total_score += ROCK_SCORE

    return &"Part two: {total_score}"

echo partOne("actual_input")
echo partTwo("actual_input")
