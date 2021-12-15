# Solve Part Two ---------------------------------------------------------------

# Given a matrix `M`, return a matrix expanded by `amt`  "tiles" horizontally
# and vertically, where each "tile" is a copy of the `M` matrix with values
# increased by the total row/column offset from the top left corner, as 
# described in the puzzle description.
function expandby(M::Matrix{T}, amt::Int64) where T <: Unsigned
    # Initialize a matrix large enough to hold the output
    expandeddims = size(M) .* (amt + 1)
    expanded = zeros(Int64, expandeddims)
    (rows, cols) = size(M)

    # Loop over each combination of row/column offset from the top
    # left corner
    for (rowoffset, coloffset) in Iterators.product(0:amt, 0:amt)
        # Calculate which portion of the `expanded` matrix to replace with
        # the values of the tile indicated by the row/col offset
        rowindices = collect(1:rows) .+ (rowoffset * rows)
        colindices = collect(1:cols) .+ (coloffset * cols)

        # Replace the zeros in `expanded` with the values from `M` and increase
        # those values by the total offset, wrapping all values greater than 9
        expanded[rowindices, colindices] = M
        expanded[rowindices, colindices] .+= (rowoffset + coloffset)
        expanded[expanded .> 9] .%= 9
    end
    return expanded    
end

# Expand the input map and find the shortest path through it
function part2(input)
    expandedmap = expandby(input, 4)
    start  = CartesianIndex(1,1)
    finish = CartesianIndex(size(expandedmap))
    return minpath(start, finish, expandedmap)
end