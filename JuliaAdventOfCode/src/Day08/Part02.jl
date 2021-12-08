function getfivecharmatches(patterns, one, four, seven)::Vector{Tuple{String, Int}}
    matches = []
    fournotseven = setdiff(four, seven)
    istwo(x)   = one ⊈ x  && fournotseven ⊈ x
    isthree(x) = one ⊆ x
    isfive(x)  = fournotseven ⊆ x
    
    for pattern in patterns
        match = istwo(pattern)   ? (pattern, 2) :
                isthree(pattern) ? (pattern, 3) :
                isfive(pattern)  ? (pattern, 5) : missing
        ismissing(match) && error("Could not match pattern $pattern")  
        push!(matches, match)
    end
    return matches
end

function getsixcharmatches(patterns, four, seven)::Vector{Tuple{String, Int}}
    matches = []
    iszero(x) = four ⊈ x && seven ⊆ x
    issix(x)  = four ⊈ x && seven ⊈ x
    isnine(x) = four ⊆ x && seven ⊆ x

    for pattern in patterns
        match = iszero(pattern) ? (pattern, 0) :
                issix(pattern)  ? (pattern, 6) :
                isnine(pattern) ? (pattern, 9) : missing
        ismissing(match) && error("Could not match pattern $pattern")
        push!(matches, match)
    end
    return matches
end

function decode(rawinput::RawInput)::Int
    (patterns, outputs) = rawinput

    # Sort the patterns such that the unique patterns are placed in the front
    # by length, and the non-unique patterns are sorted to the back.
    sortpatternsby(x) = length(x) in [5, 6] ? length(x) + 5 : length(x)
    sortedpatterns = sort(collect(patterns), by = sortpatternsby)

    # These are the easy matches, sorted to the front of 
    # sortedpatterns by our sorting function
    patternmatches = [
        (sortedpatterns[1], 1),
        (sortedpatterns[2], 7),
        (sortedpatterns[3], 4),
        (sortedpatterns[4], 8)
    ]

    # Match the 5- and 6-length patterns
    (one, seven, four) = sortedpatterns[1:3]
    fivecharmatches = getfivecharmatches(sortedpatterns[5:7], one, four, seven)
    sixcharmatches = getsixcharmatches(sortedpatterns[8:10], four, seven)
    append!(patternmatches, fivecharmatches, sixcharmatches)

    # Now with all the patterns deciphered, let's get the 
    # values in our outputs
    patterndict = Dict(patternmatches)
    numbers = reverse([patterndict[output] for output in outputs])
    return sum(numbers[i] * 10^(i-1) for i in 1:length(numbers))
end
function part2(input)
    decodeeach(x) = map(decode, x)
    (input
        |> decodeeach
        |> sum)
end