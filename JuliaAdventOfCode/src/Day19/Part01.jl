# Some Useful Data Structures --------------------------------------------------

const COS = Dict{Int,Int}([(0,1), (90,0), (180,-1), (270, 0)])
const SIN = Dict{Int,Int}([(0,0), (90,1), (180, 0), (270,-1)])
const ROTATIONS = [
    (0,   0,   0), (90,   0,   0), (180,   0,   0), (270,   0,   0),
    (0,  90,   0), (90,  90,   0), (180,  90,   0), (270,  90,   0),
    (0, 180,   0), (90, 180,   0), (180, 180,   0), (270, 180,   0),
    (0, 270,   0), (90, 270,   0), (180, 270,   0), (270, 270,   0),
    (0,   0,  90), (90,   0,  90), (180,   0,  90), (270,   0,  90),
    (0,   0, 270), (90,   0, 270), (180,   0, 270), (270,   0, 270)
]

const Basis = NTuple{3, NTuple{3,Int}}


# Helper Functions -------------------------------------------------------------

rotabout_x(x, y, z, θ) = (x, y*COS[θ] - z*SIN[θ], y*SIN[θ] + z*COS[θ])
rotabout_y(x, y, z, θ) = (x*COS[θ] + z*SIN[θ], y, z*COS[θ] - x*SIN[θ])
rotabout_z(x, y, z, θ) = (x*COS[θ] - y*SIN[θ], x*SIN[θ] + y*COS[θ], z)

function rotabout_xyz(x, y, z, xθ, yθ, zθ)
    (x, y, z) = rotabout_x(x, y, z, xθ)
    (x, y, z) = rotabout_y(x, y, z, yθ)
    return rotabout_z(x, y, z, zθ)
end

const BASES = begin
    vbase = ((1,0,0), (0,1,0), (0,0,1))
    (vx, vy, vz) = vbase
    bases = []

    for rotation in ROTATIONS
        basis = (
            rotabout_xyz(vx..., rotation...),
            rotabout_xyz(vy..., rotation...),
            rotabout_xyz(vz..., rotation...),
        )
        push!(bases, basis)
    end
    bases
end

# Translate the location of a given beacon using another basis vector
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

function translate(scanner::Scanner, basis::Basis) 
    return Set(translate(beacon, basis) for beacon in scanner)
end

# Calculate the manhattan distance between two beacons
distance(a::Beacon, b::Beacon) = mapreduce(abs, +, a .- b)

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

function part1(mapped)
    allbeacons = reduce(∪, values(mapped))
    return length(allbeacons)
end