const Point = NamedTuple{(:x, :y), Tuple{Int, Int}}
topoint(x, y) = (x = x, y = y)

const Line = NamedTuple{(:a, :b), Tuple{Point, Point}}
toline(a, b) = (a = a, b = b)

function toline(s::AbstractString)::Line
    re = r"(\d+),(\d+) -> (\d+),(\d+)"
    rematch = match(re, s)
    (x1, y1, x2, y2) = parse.(Int, rematch.captures)
    pointa = topoint(x1, y1)
    pointb = topoint(x2, y2)
    toline(pointa, pointb)
end

const Slope = NamedTuple{(:dx, :dy), Tuple{Int, Int}}
toslope(dx, dy) = (dx = dx, dy = dy)

function ishorizontal(line::Line)::Bool
    line.a.y == line.b.y
end

function isvertical(line::Line)::Bool
    line.a.x == line.b.x
end

function getslope(line::Line)::Slope
    (xdiff, ydiff) = (line.b.x - line.a.x, line.b.y - line.a.y)
    xygcd = gcd(xdiff, ydiff)
    (dx, dy) = (xdiff ÷ xygcd, ydiff ÷ xygcd)
    toslope(dx, dy)
end

function Base.:+(point::Point, slope::Slope)::Point
    (x, y) = (point.x + slope.dx, point.y + slope.dy)
    topoint(x, y)
end

function Base.:(==)(a::Point, b::Point)
    a.x == b.x && a.y == b.y
end

function getpointsin(line::Line)::Vector{Point}
    slope = getslope(line)
    points = []
    nextpoint = line.a
    while true
        push!(points, nextpoint)
        nextpoint == line.b && break
        nextpoint += slope
    end
    return points
end

function ingest(path)
    open(inputpath) do f
        [toline(s) for s in readlines(f)]
    end
end
