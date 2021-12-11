function part2(input)
    octopuses = deepcopy(input)
    rounds = 0
    while any(octopuses .> 0)
        advance!(octopuses)
        rounds += 1
    end
    return rounds
end