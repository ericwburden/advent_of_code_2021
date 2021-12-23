# Data Structures --------------------------------------------------------------

struct Cube
    x::UnitRange{Int64}
    y::UnitRange{Int64}
    z::UnitRange{Int64}
end

function Cube(x1, x2, y1, y2, z1, z2) 
    if x1 > x2; (x1, x2) = (x2, x1); end
    if y1 > y2; (y1, y2) = (y2, y1); end
    if z1 > z2; (z1, z2) = (z2, z1); end
    Cube(x1:x2, y1:y2, z1:z2)
end

function Cube(s::AbstractString)
    re = r".*x=(-?\d+)\.\.(-?\d+),y=(-?\d+)\.\.(-?\d+),z=(-?\d+)\.\.(-?\d+)"
    bounds = parse.(Int, match(re, s).captures)
    return Cube(bounds...)
end

struct Instruction
    state::Bool
    cube::Cube
end

function Instruction(s::AbstractString)
    re = r"^(on|off) (.*)$"
    (statestr, cubestr) = match(re, s).captures
    state = statestr == "on"
    cube = Cube(cubestr)
    return Instruction(state, cube)
end


# Ingest the Data -------------------------------------------------------------

function ingest(path)
    return open(path) do f
        [Instruction(l) for l in readlines(f)]
    end
end

