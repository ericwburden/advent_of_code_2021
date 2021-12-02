function part2(input)
    # Compare each number to the number 4 indices prior and return a
    # boolean array. This works because two overlapping three-wide 
    # windows into an array only differ by a single value, the first
    # number of the first window and the last value of the second
    # window.
    increases(x) = x[4:end] .> x[1:(end-3)]

    (input
    |> increases
    |> sum)
end
