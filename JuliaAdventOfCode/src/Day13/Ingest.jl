# Useful Data Structures ------------------------------------------------------

# Basically just an enum for `Axis` types
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


# Ingest the Data -------------------------------------------------------------

function ingest(path)
    return open(path) do f

        # Start by reading all the lines from the top section of the input file
        # and parsing each one into a `CartesianIndex`.
        coordinateslist = []
        for coordinatestring in split(readuntil(f, "\n\n"))
            (col, row) = [parse(Int, s) for s in split(coordinatestring, ",")]
            push!(coordinateslist, CartesianIndex(row+1, col+1))
        end

        # Next read in the lines from the bottom section and parse each
        # one into a `Fold` struct.
        folds = []
        foldre = r"(x|y)=(\d+)"
        for foldstring in split(readchomp(f), "\n")
            m = match(foldre, foldstring)
            axis = m[1] == "x" ? XAxis() : YAxis()
            index = parse(Int, m[2]) + 1
            fold = Fold(axis, index)
            push!(folds, fold)
        end

        # Figure out how many rows/columns the `dots` Matrix should be. We
        # assume that it must be tall and wide enough to accommodate the
        # largest horizontal and vertical fold.
        rows = cols = 0
        for fold in folds
            if isa(fold.axis, XAxis)
                cols = max(cols, (fold.index * 2) - 1) 
            else
                rows = max(rows, (fold.index * 2) - 1) 
            end
        end

        # Make a large enough BitMatrix to accommodate all the 'dots' and
        # and set each coordinate found above to `true`.
        dots = falses(rows, cols)
        for coordinate in coordinateslist
            dots[coordinate] = true
        end

        Paper(dots, folds)
    end
end

