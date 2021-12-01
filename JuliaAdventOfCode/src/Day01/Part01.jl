function part1(input)
    increases(x) = diff(x) .> 0

    (input
    |> increases
    |> sum)
end
