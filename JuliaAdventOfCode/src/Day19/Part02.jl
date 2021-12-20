
# Solve Part Two ---------------------------------------------------------------

function part2(offsets)
    maxdistance = 0
    for (offset1, offset2) in Iterators.product(offsets, offsets)
        distance = mapreduce(abs, +, offset1 .- offset2)
        maxdistance = max(maxdistance, distance)
    end
    return maxdistance
end