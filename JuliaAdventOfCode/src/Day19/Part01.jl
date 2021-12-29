# Some Useful Data Structures --------------------------------------------------

# The cosines for each 90° rotation: 0° => 1, 90° => 0, 180° => -1, 270° => 0
const COS = Dict{Int,Int}([(0,1), (90,0), (180,-1), (270, 0)])

# The sines for each 90° rotation: 0° => 0, 90° => 1, 180° => 0, 270° => -1
const SIN = Dict{Int,Int}([(0,0), (90,1), (180, 0), (270,-1)])

# These are all the rotations that can place a scanner into any of the 24
# orientations described in the puzzle input, starting with no rotation.
const ROTATIONS = [
    (0,   0,   0), (90,   0,   0), (180,   0,   0), (270,   0,   0),
    (0,  90,   0), (90,  90,   0), (180,  90,   0), (270,  90,   0),
    (0, 180,   0), (90, 180,   0), (180, 180,   0), (270, 180,   0),
    (0, 270,   0), (90, 270,   0), (180, 270,   0), (270, 270,   0),
    (0,   0,  90), (90,   0,  90), (180,   0,  90), (270,   0,  90),
    (0,   0, 270), (90,   0, 270), (180,   0, 270), (270,   0, 270)
]

# Describes the unit vector for a 3D system
const Basis = NTuple{3, NTuple{3,Int}}


# Helper Functions -------------------------------------------------------------

# The formula to rotate a vector about the x axis in 3 dimensions:
# - x′ = x
# - y′ = y × cos(θ) - z × sin(θ)
# - z′ = y × sin(θ) + z × cos(θ)
rotabout_x(x, y, z, θ) = (x, y*COS[θ] - z*SIN[θ], y*SIN[θ] + z*COS[θ])

# The formula to rotate a vector about the y axis in 3 dimensions:
# - x′ = x × cos(θ) + z × sin(θ)
# - y′ = y
# - z′ = z × cos(θ) - x × sin(θ)
rotabout_y(x, y, z, θ) = (x*COS[θ] + z*SIN[θ], y, z*COS[θ] - x*SIN[θ])

# The formula to rotate a vector about the z axis in 3 dimensions:
# - x′ = x × cos(θ) - y × sin(θ)
# - y′ = x × sin(θ) + y × cos(θ)
# - z′ = z
rotabout_z(x, y, z, θ) = (x*COS[θ] - y*SIN[θ], x*SIN[θ] + y*COS[θ], z)

# Rotate a vector about the x, y, and z axes in sequence
function rotabout_xyz(x, y, z, xθ, yθ, zθ)
    (x, y, z) = rotabout_x(x, y, z, xθ)
    (x, y, z) = rotabout_y(x, y, z, yθ)
    return rotabout_z(x, y, z, zθ)
end

# Pre-calculate the rotation matrices for each of the 24 possible Scanner
# facings. The unit vector for 'no rotation' is `standard` below. Each rotation
# matrix can be used to translate points from one scanner facing to another
# scanner facing.
const BASES = begin
    standard = ((1,0,0), (0,1,0), (0,0,1))
    (sx, sy, sz) = standard
    unitvectors = []

    for rotation in ROTATIONS
        unitvector = (
            rotabout_xyz(sx..., rotation...),
            rotabout_xyz(sy..., rotation...),
            rotabout_xyz(sz..., rotation...),
        )
        push!(unitvectors, unitvector)
    end
    unitvectors
end

# Translate the location of a given beacon using another basis vector. This is
# basically just a matrix right multiply:
# https://cseweb.ucsd.edu/classes/wi18/cse167-a/lec3.pdf
function translate(beacon::Beacon, basis::Basis)
    (bx1, by1, bz1) = basis[1]
    (bx2, by2, bz2) = basis[2]
    (bx3, by3, bz3) = basis[3]
    (x, y, z) = beacon

    newx = x*bx1 + y*by1 + z*bz1
    newy = x*bx2 + y*by2 + z*bz2
    newz = x*bx3 + y*by3 + z*bz3

	return (newx, newy, newz)
end

# Translate all the beacon locations for one scanner to what their locations
# would be if the scanner had a different facing.
function translate(scanner::Scanner, basis::Basis) 
    return Set(translate(beacon, basis) for beacon in scanner)
end

# Identify the beacons detected in common between two scanners. This is a pretty
# intensive process:
# - For each possible scanner facing...
#   - Translate all the `Beacon`s for Scanner `b` to the given facing
#   - For each combination of a `Beacon` detected by Scanner `a` and a `Beacon`
#     detected by Scanner `b`...
#     - Calculate the distance between the `Beacon` from `a` and the `Beacon`
#       from `b`, called `offset`
#     - Add the `offset` to all the `Beacon` locations from Scanner `b`
#     - Check how many of the offset Beacons from Scanner `b` are matched by a 
#       Beacon detected by Scanner `a`
#     - If 12 or more beacon locations match, then we have determined the
#       relative location of Scanner `b` from Scanner `a`
function incommon(a::Scanner, b::Scanner)
    for basis in BASES
        translated_b = translate(b, basis)
        for (a_beacon, b_beacon) in Iterators.product(a, translated_b)
            offset = a_beacon .- b_beacon
            shifted_b = Set(beacon .+ offset for beacon in translated_b)
            length(a ∩ shifted_b) >= 12 && return (shifted_b, offset)
        end
    end
    return Iterators.repeated(nothing)
end


# To map all the Scanners, we check each Scanner against every other Scanner, 
# adding scanners to `mapped` when we identify (and apply) the appropriate
# offset of between the two scanners.
function mapscanners(scanners)
    mapped = Dict(0 => scanners[0])
    offsets = [(0,0,0)]
    searched = Set()

    while length(setdiff(keys(scanners), keys(mapped))) > 0
        for id1 in keys(scanners)
            (id1 ∈ searched || id1 ∉ keys(mapped)) && continue

            for (id2, scanner2) in scanners
                (id2 ∈ keys(mapped) || id1 == id2) && continue
                (common, offset) = incommon(mapped[id1], scanner2)

                if !isnothing(common)
                    mapped[id2] = common
                    push!(offsets, offset)
                end
            end

            push!(searched, id1)
        end
    end
    return (mapped, offsets)
end


# Solve Part One ---------------------------------------------------------------

# Given the mapping of scanners from `mapscanners()`, count the total number of
# beacons. Since they've all been translated and offset relative to the initial
# scanner, this just means union-reducing the sets of beacons.
function part1(mapped)
    allbeacons = reduce(∪, values(mapped))
    return length(allbeacons)
end