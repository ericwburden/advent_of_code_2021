function part1(input)
    # Returns an array of `1`s and `0`s, where a `1` indicates an increase
    increases(x) = diff(x) .> 0

    (input
    |> increases
    |> sum)
end
