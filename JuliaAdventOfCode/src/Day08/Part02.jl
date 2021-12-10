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
    fivecharmatches = getfivecharmatches(sortedpatterns[5:7], four, seven)
    sixcharmatches  = getsixcharmatches(sortedpatterns[8:10], four, seven)
    append!(patternmatches, fivecharmatches, sixcharmatches)

    # Now with all the patterns deciphered, let's get the 
    # values in our outputs
    patterndict = Dict(patternmatches)
    numbers = reverse([patterndict[output] for output in outputs])
    return sum(numbers[i] * 10^(i - 1) for i = 1:length(numbers))
end

function getfivecharmatches(patterns, four, seven)::Vector{Tuple{String,Int}}
    matches = []

    # Use a set of letters representing the segments left if you "subtract"
    # the segments in seven from the segments in four to help find the 
    # length 5 displays
    fournotseven = setdiff(four, seven)

    # Rules to identify two, three, and five
    istwo(x)   = seven ⊈ x && fournotseven ⊈ x
    isthree(x) = seven ⊆ x
    isfive(x)  = fournotseven ⊆ x

    # Check each length 5 set of segments and identify two, three, and five
    for pattern in patterns
        match = istwo(pattern)   ? (pattern, 2) :
                isthree(pattern) ? (pattern, 3) :
                isfive(pattern)  ? (pattern, 5) : missing
        ismissing(match) && error("Could not match pattern $pattern")
        push!(matches, match)
    end
    return matches
end

function getsixcharmatches(patterns, four, seven)::Vector{Tuple{String,Int}}
    matches = []

    # Rules to identify zero, six, and nine based on known displays
    iszero(x) = four ⊈ x && seven ⊆ x
    issix(x)  = four ⊈ x && seven ⊈ x
    isnine(x) = four ⊆ x && seven ⊆ x

    # Check each length 6 set of segments and identify zero, six, and nine
    for pattern in patterns
        match = iszero(pattern) ? (pattern, 0) :
                issix(pattern)  ? (pattern, 6) :
                isnine(pattern) ? (pattern, 9) : missing
        ismissing(match) && error("Could not match pattern $pattern")
        push!(matches, match)
    end
    return matches
end

function part2(input)
    decodeeach(x) = map(decode, x)
    (input
     |> decodeeach
     |> sum)
end