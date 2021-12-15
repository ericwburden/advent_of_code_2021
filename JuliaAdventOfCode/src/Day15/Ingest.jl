# Ingest the Data -------------------------------------------------------------
function ingest(path)
    return open(path) do f
        outvectors = open(path) do f
            [collect(line) for line in readlines(f)]
        end
        toint(x) = parse(UInt8, x)

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
end

