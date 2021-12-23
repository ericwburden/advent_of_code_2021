# Helper Functions -------------------------------------------------------------

# Break apart a `Cube` into its coordinates
function bounds(cube::Cube)
    (x1, x2) = (cube.x.start, cube.x.stop)
    (y1, y2) = (cube.y.start, cube.y.stop)
    (z1, z2) = (cube.z.start, cube.z.stop)
    return (x1, x2, y1, y2, z1, z2)
end

# Check whether a `Cube` overlaps the region being considered for the 
# initialization sequence.
function overlap(lights::BitArray, cube::Cube)
    (x1, x2, y1, y2, z1, z2) = bounds(cube)
    (lightx, lighty, lightz) = size(lights)
    return (x1 <= lightx && x2 >= 1
            && y1 <= lighty && y2 >= 1
            && z1 <= lightz && z2 >= 1)
end

# Shift a cube so that all its dimensions are positive and have at least a
# a value of 1, so that the coordinates map cleanly to an `Array`.
function displace(cube::Cube, offset::Int64)
    cubebounds = map(c -> c + offset, bounds(cube))
    return Cube(cubebounds...)
end

# Apply an instruction (turning lights on or off) to the lighted region. Just
# sets positions in `lignts` bounded by the coordinates of the instruction's
# `Cube` to either 1 or 0, depending on the type of instruction. Displaces
# the `Cube` before making this change.
function apply!(lights::BitArray, instruction::Instruction, offset = 51)
    (lightx, lighty, lightz) = size(lights)
    cube = displace(instruction.cube, offset)
    overlap(lights, cube) || return
    xrange = intersect(1:lightx, cube.x)
    yrange = intersect(1:lighty, cube.y)
    zrange = intersect(1:lightz, cube.z)
    lights[xrange, yrange, zrange] .= instruction.state
end


# Solve Part One ---------------------------------------------------------------

# Simple, straightforward; represent the target region as a 3D `BitArray` and 
# turn on/off the lights according to the instructions, in order.
function part1(input)
    lights = falses(101, 101, 101)
    foreach(cube -> apply!(lights, cube), input)
    return count(lights)
end