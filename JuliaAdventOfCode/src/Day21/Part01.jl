# Helper Functions -------------------------------------------------------------

# Given a board position and a roll, return the next position that results from
# that roll. The only tricky bit here is that 10 + 1 wraps around to 1 instead
# of zero.
function nextposition(pos::Int64, roll::Int64)
    pos += roll
    pos > 10 && pos % 10 == 0 && return 10
    pos > 10 && return pos % 10
    return pos
end

# Given a player and a roll, return a `Player` at the next position that will 
# result from the given roll with their score updated to reflect the move.
function move(player::Player, roll::Int64)
    position = nextposition(player.position, roll)
    points = player.points + position
    return Player(position, points)
end

# Given a game board, a roll, and an optional boolean value indicating whether
# or not it is Player 1's turn, return a `Game` reflecting the state that would
# be achieved if the indicated player moves by the amount given by `roll`
function move(game::Game, roll::Int64, player1 = true)
    if player1
        player1 = move(game.player1, roll)
        return Game(player1, game.player2)
    else
        player2 = move(game.player2, roll)
        return Game(game.player1, player2)
    end
end

# Take a `Game` an return either the current high score or the current low score
highscore(game::Game) = max(game.player1.points, game.player2.points)
lowscore(game::Game)  = min(game.player1.points, game.player2.points)

# Some Useful Data Structures --------------------------------------------------

# Literally an empty struct for the purposes of creating an iterator over the
# possible die rolls
struct Die end

# On the first roll, the die returns `6` (1 + 2 + 3) and the next starting number
# of `4`. On subsequent rolls, return the sum of the next three numbers and the
# fourth number in sequence as a tuple, to keep the iterator going. The `if`
# statements are there for wrapping around 100 if need be (I don't think it
# actually happens).
Base.iterate(::Die) = (6, 4)
function Base.iterate(::Die, start::Int64)
    (nextvalue, nextstart) = if start < 98
        (sum(start:start+2), start + 3)
    elseif start == 98
        (297, 1)
    elseif start == 99
        (200, 2)
    elseif start == 100
        (103, 3)
    end

    return (nextvalue, nextstart)
end


# Solve Part One ---------------------------------------------------------------

# Play the game as described! Roll the die, move the players, check the score. 
# Whenever a winner is found, return the number of rolls (3 * the number of
# rounds) multiplied by the lowest player score
function part1(game)
    die = Die()
    player1turn = true
    round = 0
    for roll in die
        game = move(game, roll, player1turn)
        round += 1
        highscore(game) >= 1000 && break
        player1turn = !player1turn
    end
    rolls = round * 3
    return rolls * lowscore(game)
end