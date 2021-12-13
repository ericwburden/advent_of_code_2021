# Read in the input data file, parsing it into a matrix of numbers
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
