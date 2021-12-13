# Iteration for a `Paper` Struct ----------------------------------------------
struct PaperFoldState
    dots::BitMatrix
    lastfold::Int
end

# Initial iterator, returns the first fold
function Base.iterate(paper::Paper)
    fold = paper.folds[1]
    folded = foldit(paper.dots, fold)
    state = PaperFoldState(folded, 1)
    return (folded, state)
end

# Subsequent iterator, given the last state, return tne next state
function Base.iterate(paper::Paper, state::PaperFoldState)
    (dots, lastfold) = (state.dots, state.lastfold)
    lastfold >= length(paper.folds) && return nothing
    fold = paper.folds[lastfold + 1]
    folded = foldit(dots, fold)
    state = PaperFoldState(folded, lastfold + 1)
    return (folded, state)
end

# Needed to be able to get a specific fold state of the `Paper`
function Base.getindex(paper::Paper, i::Int)
    for (iteration, dots) in enumerate(paper)
        iteration > i && return dots
    end
    throw(BoundsError(paper, i))
end

# Some more necessary implementations so I can use the `paper[end]` syntax
# in our solution function.
Base.length(paper::Paper)    = length(paper.folds) - 1
Base.lastindex(paper::Paper) = lastindex(paper.folds) - 1
Base.eltype(::Type{Paper})   = BitMatrix

# Pretty prints a BitMatrix to make the solution to Part Two more
# readable, because reading the block characters from the default
# 1/0 display of the BitMatrix is difficult.
function prettyprint(matrix::BitMatrix)
    for line in eachrow(matrix)
        for bit in line
            if bit; print('█'); else; print(' '); end
        end
        println()
    end
end


# Solve for Part Two ----------------------------------------------------------

# Fold the paper until all the folds are used up. The commented out print
# statement is there for solving the puzzle. The rest of it is there for 
# comparing in my test suite.
function part2(input)
    final_paper = input[end]
    # prettyprint(final_paper)
    rowsums = mapslices(sum, final_paper, dims = 2)
    colsums = mapslices(sum, final_paper, dims = 1)
    return (vec(rowsums), vec(colsums))
end