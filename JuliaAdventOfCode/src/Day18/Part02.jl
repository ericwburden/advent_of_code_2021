# Multiple Dispatch! -----------------------------------------------------------

# Solve Part Two ---------------------------------------------------------------

function part2(input)
    input = deepcopy(input)
    maxmagnitude = 0
    for (a, b) in Iterators.product(input, input)
        mag1 = magnitude!(deepcopy(a) + deepcopy(b))
        mag2 = magnitude!(deepcopy(b) + deepcopy(a))
        maxmagnitude = max(maxmagnitude, mag1, mag2)
    end
    return maxmagnitude
end