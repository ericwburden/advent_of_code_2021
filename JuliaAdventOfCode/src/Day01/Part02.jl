function part2(input)
    windows(x, w) = [view(x, i:i+w) for i in 1:length(x)-w]
    increases(x) = diff(x) .> 0

    (windows(input, 3)
    |> x -> map(sum, x)
    |> increases
    |> sum)
end

