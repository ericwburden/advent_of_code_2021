# Given a boolean vector, return true if more values are true
# Breaks ties in favor of true
function mostcommon(arr)::Bool
    trues = count(arr)
    trues >= (length(arr) - trues)
end

# Convert a Boolean vector into a decimal number
function toint(arr::BitVector)
    # Generate a vector of the powers of 2 represented in
    # the BitVector.
    (powers
        = (length(arr)-1:-1:0)
        |> collect
        |> (x -> x[arr]))

    # Raise 2 to each of the powers and sum the result
    sum(2 .^ powers)
end

function part1(input)
    # For each column in the input, identify the most common value and
    # collect these most common values into a BitVector
    (gamma
        = eachcol(input)
        |> (x -> map(mostcommon, x))
        |> BitVector)

    # Since `gamma` is the most common values in each column, `epsilon`
    # is the least common values, and there are only two values, `epsilon`
    # is just the inverse of `gamma`.
    epsilon = .!gamma

    toint(gamma) * toint(epsilon)
end