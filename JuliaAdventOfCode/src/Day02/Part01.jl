# Strategy 1 ------------------------------------------------------------------
mutable struct Position1
    horizontal::Integer
    depth::Integer
end
Position1(x) = Position1(x, x)

function move!(p::Position1, d::Forward)
    p.horizontal += d.mag
end

function move!(p::Position1, d::Down)
    p.depth += d.mag
end

function move!(p::Position1, d::Up)
    p.depth -= d.mag
end


function part1_strategy1(input)
    position = Position1(0, 0)
    foreach(x -> move!(position, x), input)
    position.horizontal * position.depth
end

# Strategy 2 ------------------------------------------------------------------

const PositionTuple = Tuple{Int64, Int64}

function move(p::PositionTuple , d::Forward)::PositionTuple
    (p[1] + d.mag, p[2])
end

function move(p::PositionTuple, d::Down)::PositionTuple
    (p[1], p[2] + d.mag)
end

function move(p::PositionTuple, d::Up)::PositionTuple
    (p[1], p[2] - d.mag)
end


function part1_strategy2(input)
    position = foldl(move, input, init = (0, 0))
    position[1] * position[2]
end


# Strategy 3 ------------------------------------------------------------------

function part1_strategy3(input)
    (horizontal, depth) = (0, 0)
    for direction in input
        if typeof(direction) == Forward
            horizontal += direction.mag
        end
        if typeof(direction) == Down
            depth += direction.mag
        end
        if typeof(direction) == Up
            depth -= direction.mag
        end
    end
    horizontal * depth
end