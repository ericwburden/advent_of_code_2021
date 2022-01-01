# Data Structures --------------------------------------------------------------

# Represents a player's current "state", their current board position and score
struct Player
	position::Int64
	points::Int64
end
Player(pos::Int64) = Player(pos, 0)

# Represents the current state of the game, both players' board position and
# current score
struct Game
	player1::Player
	player2::Player
end


# Helper Functions -------------------------------------------------------------

# Given a string, return a Player whose position is the number at the end of
# the string.
playerpos(s) = Player(parse(Int, s[end]))


# Ingest the Data -------------------------------------------------------------

# There's only two lines, the first line for player one and the second line for
# player two, both of which end with a single digit representing that
# player's starting space
function ingest(path)
    return open(path) do f
		player1 = playerpos(readline(f))
		player2 = playerpos(readline(f))
		Game(player1, player2)
    end
end

