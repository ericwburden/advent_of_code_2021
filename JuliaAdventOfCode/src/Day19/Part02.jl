# Solve Part Two ---------------------------------------------------------------

# Calculate the manhattan distance between two beacons
distance(a::Beacon, b::Beacon) = mapreduce(abs, +, a .- b)

# Given the offsets from `mapbeacons()`, calculate the manhattan distance between
# all pairs of offsets and return the largest value.
function part2(offsets)
    maxdistance = 0
    for (offset1, offset2) in Iterators.product(offsets, offsets)
        distance = mapreduce(abs, +, offset1 .- offset2)
        maxdistance = max(maxdistance, distance)
    end
    return maxdistance
end