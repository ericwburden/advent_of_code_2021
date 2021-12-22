# Constants --------------------------------------------------------------------

const FREQUENCIES = Dict(3 => 1, 4 => 3, 5 => 6, 6 => 7, 7 => 6, 8 => 3, 9 => 1)


# Data Structures --------------------------------------------------------------

const GameFreqMap = Dict{Game,Int64}


# Helper Functions -------------------------------------------------------------

# Shorthand function for convenience
function set!(dict, key, value)
    dict[key] = value
end

# For each round of the game, the active player "moves" 27 time in 27 alternate
# realities. We simulate this by keeping track of the number of games in each
# particular 'state' (a `Game` struct) and creating a new `GameFreqMap` where
# each previous game state is advanced by a roll of 3, 4, 5, 6, 7, 8, or 9 (the 
# possible values from three rolls from 1-3) the number of times those values
# can be made by rolling three three-sided dice. If, say, a particular game
# state existed in 10 alternate realities, then after moving there would exist
# 10 realities where that player rolled 3, 30 realities where that player rolled
# 4, 60 realities where that player rolled 5, etc.
function move(games::GameFreqMap, player1 = true)
    nextgames = GameFreqMap()
    victories = 0
    for (game, count) in games
        for (roll, frequency) in FREQUENCIES
            newstate = move(game, roll, player1)
            newcount = count * frequency
            if newstate.player1.points >= 21 || newstate.player2.points >= 21
                # If either player won, there's no need to continue this game
                # state forward, just count the number of realities where that
                # player won.
                victories += newcount
            else
                # Otherwise, check the next games frequency map for this new
                # state, initialize its count to 0 if it doesn't exist, then
                # add the number of new realities where this new state exists.
                newstate ∈ keys(nextgames) || set!(nextgames, newstate, 0)
                nextgames[newstate] += newcount
            end
        end
    end

    return (nextgames, victories)
end


# Solve Part Two ---------------------------------------------------------------

function part2(input)
    games = GameFreqMap(input => 1)
    victoryarray = [0, 0]
    player1turn = true

    while !isempty(games)
        (games, victories) = move(games, player1turn)
        if player1turn
            victoryarray[1] += victories
        else
            victoryarray[2] += victories
        end
        player1turn = !player1turn
    end

    return maximum(victoryarray)

end