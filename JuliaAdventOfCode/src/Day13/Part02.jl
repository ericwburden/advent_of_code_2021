struct PaperFoldState
    dots::BitMatrix
    lastfold::Int
end

function Base.iterate(paper::Paper)
    fold = paper.folds[1]
    folded = foldit(paper.dots, fold)
    state = PaperFoldState(folded, 1)
    return (folded, state)
end

function Base.iterate(paper::Paper, state::PaperFoldState)
    (dots, lastfold) = (state.dots, state.lastfold)
    lastfold >= length(paper.folds) && return nothing
    fold = paper.folds[lastfold + 1]
    folded = foldit(dots, fold)
    state = PaperFoldState(folded, lastfold + 1)
    return (folded, state)
end

function Base.getindex(paper::Paper, i::Int)
    for (iteration, dots) in enumerate(paper)
        iteration > i && return dots
    end
    throw(BoundsError(paper, i))
end

Base.length(paper::Paper)    = length(paper.folds) - 1
Base.lastindex(paper::Paper) = lastindex(paper.folds) - 1
Base.eltype(::Type{Paper})   = BitMatrix

function prettyprint(matrix::BitMatrix)
    for line in eachrow(matrix)
        for bit in line
            if bit; print('█'); else; print(' '); end
        end
        println()
    end
end

function part2(input)
    final_paper = input[end]
    # prettyprint(final_paper)
    rowsums = mapslices(sum, final_paper, dims = 2)
    colsums = mapslices(sum, final_paper, dims = 1)
    return (vec(rowsums), vec(colsums))
end