function ingest(path)
    outvectors = open(path) do f
        [split(line, "") for line in readlines(f)]
    end
    toint(x) = parse(Int, x)
    (outmatrix
     =  outvectors
     |> (x -> reduce(hcat, x))
     |> (x -> map(toint, x))
     |> transpose
     |> collect)
    return outmatrix
end
