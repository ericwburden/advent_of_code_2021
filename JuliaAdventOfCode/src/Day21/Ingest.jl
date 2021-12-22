# Data Structures --------------------------------------------------------------

struct Player
	position::Int64
	points::Int64
end
Player(pos::Int64) = Player(pos, 0)

struct Game
	player1::Player
	player2::Player
end


# Helper Functions -------------------------------------------------------------

playerpos(s) = Player(parse(Int, s[end]))


# Ingest the Data -------------------------------------------------------------

function ingest(path)
    return open(path) do f
		player1 = playerpos(readline(f))
		player2 = playerpos(readline(f))
		Game(player1, player2)
    end
end

