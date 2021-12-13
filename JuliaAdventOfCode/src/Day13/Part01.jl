function foldit(dots::BitMatrix, fold::Fold)::BitMatrix
    (rows, cols) = size(dots)

    toprows  = bottomrows = 1:rows
    leftcols = rightcols  = 1:cols
    if isa(fold.axis, XAxis)
        leftcols   = 1:(fold.index-1)
        rightcols = cols:-1:(fold.index+1)
    else
        toprows    = 1:(fold.index-1)
        bottomrows = rows:-1:(fold.index+1)
    end

    still  = view(dots, toprows,    leftcols) # Stationary!
    folded = view(dots, bottomrows, rightcols)

    return (still .| folded)
end

function part1(input)
    dots = input.dots
    fold = input.folds[1]
    folded = foldit(dots, fold)
    return sum(folded)
end