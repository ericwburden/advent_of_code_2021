using Statistics

# The position that will be optimally close to each crab is
# the median of all the crab positions.
function part1(input)
    position = convert(Int, median(input))
    crabdistance = abs.(position .- input)  # Broadcasting!
    return sum(crabdistance)
end
