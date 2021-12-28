# Data Structures --------------------------------------------------------------


# Ingest the Data -------------------------------------------------------------

function ingest(path)
    eastlines = []
    southlines = []
    open(path) do f
        for line in readlines(f)
            chars = collect(line)
            push!(eastlines,  chars .== '>')
            push!(southlines, chars .== 'v')
        end
    end
    eastmatrix  = reduce(hcat, eastlines)  |> transpose |> BitMatrix
    southmatrix = reduce(hcat, southlines) |> transpose |> BitMatrix
    return (eastmatrix, southmatrix)
end

