# Helper Functions -------------------------------------------------------------

function nextposition(pos::Int64, roll::Int64)
    pos += roll
    pos > 10 && pos % 10 == 0 && return 10
    pos > 10 && return pos % 10
    return pos
end

function move(player::Player, roll::Int64)
    position = nextposition(player.position, roll)
    points = player.points + position
    return Player(position, points)
end

function move(game::Game, roll::Int64, player1 = true)
    if player1
        player1 = move(game.player1, roll)
        return Game(player1, game.player2)
    else
        player2 = move(game.player2, roll)
        return Game(game.player1, player2)
    end
end

highscore(game::Game) = max(game.player1.points, game.player2.points)
lowscore(game::Game)  = min(game.player1.points, game.player2.points)

# Some Useful Data Structures --------------------------------------------------

struct Die end

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