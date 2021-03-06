# Today's input is essentially a big block of numbers (0-9).
# Ingest it by reading each line, breaking it into characters,
# storing all the character vectors in a big vector, then 
# converting the 2D vector into a Matrix{Int}
function ingest(path)
    outvectors = open(path) do f
        [collect(line) for line in readlines(f)]
    end
    toint(x) = parse(Int8, x)

    # I transposed the matrix to make debugging easier, since 
    # otherwise it won't print in the same orientation as the input.
    (outmatrix
     =  outvectors
     |> (x -> reduce(hcat, x))
     |> (x -> map(toint, x))
     |> transpose
     |> collect)
    return outmatrix
end
