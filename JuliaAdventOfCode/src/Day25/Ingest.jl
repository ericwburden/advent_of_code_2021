# Data Structures --------------------------------------------------------------


# Ingest the Data -------------------------------------------------------------

# No fancy data structures this time, just two `BitMatrix`, one representing the
# locations of east-bound cucumbers, and one representing the locations of
# sounth-bound cucumbers, on a 2D grid.
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

