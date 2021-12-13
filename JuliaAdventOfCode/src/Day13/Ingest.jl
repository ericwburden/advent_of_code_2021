abstract type Axis end
struct XAxis <: Axis end
struct YAxis <: Axis end

struct Fold
    axis::Axis
    index::Int
end

mutable struct Paper
    dots::BitMatrix
    folds::Vector{Fold}
end

function ingest(path)
    return open(path) do f
        coordinateslist = []
        for coordinatestring in split(readuntil(f, "\n\n"))
            (col, row) = [parse(Int, s) for s in split(coordinatestring, ",")]
            push!(coordinateslist, CartesianIndex(row+1, col+1))
        end

        folds = []
        foldre = r"(x|y)=(\d+)"
        for foldstring in split(readchomp(f), "\n")
            m = match(foldre, foldstring)
            axis = m[1] == "x" ? XAxis() : YAxis()
            index = parse(Int, m[2]) + 1
            fold = Fold(axis, index)
            push!(folds, fold)
        end

        rows = cols = 0
        for fold in folds
            if isa(fold.axis, XAxis)
                cols = max(cols, (fold.index * 2) - 1) 
            else
                rows = max(rows, (fold.index * 2) - 1) 
            end
        end

        dots = falses(rows, cols)
        for coordinate in coordinateslist
            dots[coordinate] = true
        end

        Paper(dots, folds)
    end
end

