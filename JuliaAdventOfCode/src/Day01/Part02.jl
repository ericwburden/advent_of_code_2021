function part2(input)
    # Creates an array of views into a sliding window of `x` of length `w`
    windows(x, w) = [view(x, i:i+w) for i in 1:length(x)-w]

    # Returns an array of `1`s and `0`s, where a `1` indicates an increase
    increases(x) = diff(x) .> 0

    (windows(input, 3)
    |> x -> map(sum, x)
    |> increases
    |> sum)
end

