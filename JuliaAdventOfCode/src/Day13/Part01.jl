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

function foldit(dots::BitMatrix, fold::Fold)::BitMatrix
    (rows, cols) = size(dots)

    toprows  = bottomrows = 1:rows
    leftcols = rightcols  = 1:cols
    if isa(fold.axis, XAxis)
        leftcols   = 1:(fold.index-1)
        rightcols  = (fold.index+1):cols
    else
        toprows    = 1:(fold.index-1)
        bottomrows = (fold.index+1):rows
    end

    folddim = isa(fold.axis, XAxis) ? 2 : 1
    still   = view(dots, toprows,    leftcols) # Stationary!
    tofold  = view(dots, bottomrows, rightcols)
    folded  = reverse(tofold, dims = folddim)

    return (still .| folded)
end

function fold!(paper::Paper)
    isnothing(paper.nextfold) && error("Can't fold again!")

    fold = paper.folds[paper.nextfold]
    (rows, cols) = size(paper.dots)

    paper.nextfold += 1
    if paper.nextfold > length(paper.folds)
        paper.nextfold = nothing
    end

    toprows  = bottomrows = 1:rows
    leftcols = rightcols  = 1:cols
    flipon = 1
    if isa(fold.axis, Day13.XAxis)
        flipon = 2
        leftcols   = 1:(fold.index-1)
        rightcols  = (fold.index+1):cols
    else
        toprows    = 1:(fold.index-1)
        bottomrows = (fold.index+1):rows
    end

    still = view(paper.dots, toprows, leftcols)
    moved = reverse(view(paper.dots, bottomrows, rightcols), dims = flipon)
    paper.dots = still .| moved
end

function part1(input)
    dots = input.dots
    fold = input.folds[1]
    folded = foldit(dots, fold)
    return sum(folded)
end