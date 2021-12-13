# Given a BitMatrix representing the current arrangement of dots on a page
# and a fold indicating where/how to fold that paper, fold the paper and
# return the result.
function foldit(dots::BitMatrix, fold::Fold)::BitMatrix
    (rows, cols) = size(dots)

    # Need to define two views into the `dots` BitMatrix, one for the 
    # half of the paper that will stay in place, and one for the half
    # of the paper to be 'folded over'. The 'folded' view will have
    # its rows/columns reversed as appropriate.
    toprows  = bottomrows = 1:rows
    leftcols = rightcols  = 1:cols
    if isa(fold.axis, XAxis)
        leftcols   = 1:(fold.index-1)
        rightcols = cols:-1:(fold.index+1)
    else
        toprows    = 1:(fold.index-1)
        bottomrows = rows:-1:(fold.index+1)
    end

    # Take the two views, overlay them, then return the result
    still  = view(dots, toprows,    leftcols) # Stationary!
    folded = view(dots, bottomrows, rightcols)
    return (still .| folded)
end

# Take the input, fold it once, then return the number of 'dots' from
# that single fold.
function part1(input)
    dots = input.dots
    fold = input.folds[1]
    folded = foldit(dots, fold)
    return count(folded)
end