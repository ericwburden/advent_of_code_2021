# Now, we advance the octopuses until we reach a state where all octopuses
# have been reset at the same time, meaning they all flashed simultaneously.
function part2(input)
    octopuses = deepcopy(input)
    rounds = 0
    while any(octopuses .> 0)
        advance!(octopuses)
        rounds += 1
    end
    return rounds
end