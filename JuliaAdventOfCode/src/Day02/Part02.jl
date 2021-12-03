# Strategy 1 ------------------------------------------------------------------
mutable struct Position2
    horizontal::Integer
    depth::Integer
    aim::Integer
end
Position2(x) = Position2(x, x, x)

function move!(p::Position2, d::Forward)
    p.horizontal += d.mag
    p.depth += (p.aim * d.mag)
end

function move!(p::Position2, d::Down)
    p.aim += d.mag
end

function move!(p::Position2, d::Up)
    p.aim -= d.mag
end


function part2_strategy1(input)
    position = Position2(0)
    foreach(x -> move!(position, x), input)
    position.horizontal * position.depth
end


# Strategy 2 ------------------------------------------------------------------

# (horizontal, depth, aim)
const PositionTriple = Tuple{Int64, Int64, Int64}

function move(p::PositionTriple, d::Forward)::PositionTriple
    (p[1] + d.mag, p[2] + (p[3] * d.mag), p[3])
end

function move(p::PositionTriple, d::Down)::PositionTriple
    (p[1], p[2], p[3] + d.mag)
end

function move(p::PositionTriple, d::Up)::PositionTriple
    (p[1], p[2], p[3] - d.mag)
end


function part2_strategy2(input)
    position = foldl(move, input, init = (0, 0, 0))
    position[1] * position[2]
end


# Strategy 3 ------------------------------------------------------------------

function part2_strategy3(input)
    (horizontal, depth, aim) = (0, 0, 0)
    for direction in input
        if typeof(direction) == Forward
            horizontal += direction.mag
            depth += (aim * direction.mag)
        end
        if typeof(direction) == Down
            aim += direction.mag
        end
        if typeof(direction) == Up
            aim -= direction.mag
        end
    end
    horizontal*depth
end