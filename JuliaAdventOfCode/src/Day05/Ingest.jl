# Types and Structs -----------------------------------------------------------

# Type alias for `Point`
const Point = NamedTuple{(:x, :y), Tuple{Int, Int}}
topoint(x, y) = (x = x, y = y)

# Type alias and constructors for `Slope`
const Slope = NamedTuple{(:dx, :dy), Tuple{Int, Int}}
toslope(dx, dy) = (dx = dx, dy = dy)

function getslope(a::Point, b::Point)::Slope
    (xdiff, ydiff) = (b.x - a.x, b.y - a.y)
    xygcd = gcd(xdiff, ydiff)
    (dx, dy) = (xdiff ÷ xygcd, ydiff ÷ xygcd)
    toslope(dx, dy)
end

# Represents a line from point `a` to point `b`
struct Line
    a::Point
    b::Point
    slope::Slope
end

Line(a::Point, b::Point) = Line(a, b, getslope(a, b))

function Line(s::AbstractString)::Line
    re = r"(\d+),(\d+) -> (\d+),(\d+)"
    rematch = match(re, s)
    (x1, y1, x2, y2) = parse.(Int, rematch.captures)
    pointa = topoint(x1, y1)
    pointb = topoint(x2, y2)
    Line(pointa, pointb)
end

# Check if a line is horizontal
function ishorizontal(line::Line)::Bool
    line.a.y == line.b.y
end

# Check if a line is vertical
function isvertical(line::Line)::Bool
    line.a.x == line.b.x
end


# Iterator Implementation -----------------------------------------------------

# Iterator interface implementations for `Line`
Base.iterate(line::Line) = (line.a, line.a)
Base.eltype(::Type{Line}) = Point

function Base.iterate(line::Line, lastpoint::Point)
    lastpoint == line.b && return nothing
    nextpoint = lastpoint + line.slope
    (nextpoint, nextpoint)
end

function Base.length(line::Line) 
    (a, b) = (line.a, line.b)
    return max(abs(b.x - a.x), abs(b.y - a.y)) + 1
end


# Operator Overloads ----------------------------------------------------------

# Operator overloading for adding a `Slope` to a `Point`
function Base.:+(point::Point, slope::Slope)::Point
    (x, y) = (point.x + slope.dx, point.y + slope.dy)
    topoint(x, y)
end

# Operator overloading for comparing `Points`
function Base.:(==)(a::Point, b::Point)
    a.x == b.x && a.y == b.y
end


# Ingestion -------------------------------------------------------------------

# Read input from a file path
function ingest(path)
    open(inputpath) do f
        [Line(s) for s in readlines(f)]
    end
end
