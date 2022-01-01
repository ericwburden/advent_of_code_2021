# Data Structures --------------------------------------------------------------

# We'll represent each of the cubes of lights as a set of x, y, and z-ranges
# that encompass all the points of the cube
struct Cube
    x::UnitRange{Int64}
    y::UnitRange{Int64}
    z::UnitRange{Int64}
end

# Constructor that ensures that the first number in the x, y, or z-range is 
# the smaller number.
function Cube(x1, x2, y1, y2, z1, z2) 
    if x1 > x2; (x1, x2) = (x2, x1); end
    if y1 > y2; (y1, y2) = (y2, y1); end
    if z1 > z2; (z1, z2) = (z2, z1); end
    Cube(x1:x2, y1:y2, z1:z2)
end

# Constructor that takes a line from the input and produces a `Cube`
function Cube(s::AbstractString)
    re = r".*x=(-?\d+)\.\.(-?\d+),y=(-?\d+)\.\.(-?\d+),z=(-?\d+)\.\.(-?\d+)"
    bounds = parse.(Int, match(re, s).captures)
    return Cube(bounds...)
end

# An `Instruction` encompasses a `Cube` and whether the instruction is to turn
# 'on' all the lights in that cube (state == True) or to turn the lights 'off'
struct Instruction
    state::Bool
    cube::Cube
end

# Constructor that takes a line from the input and returns an `Instruction`
function Instruction(s::AbstractString)
    re = r"^(on|off) (.*)$"
    (statestr, cubestr) = match(re, s).captures
    state = statestr == "on"
    cube = Cube(cubestr)
    return Instruction(state, cube)
end


# Ingest the Data -------------------------------------------------------------

# Parse the input file into a list of `Instruction`s
function ingest(path)
    return open(path) do f
        [Instruction(l) for l in readlines(f)]
    end
end

