# Takes an integer matrix and adds a "ring" of `9`'s to the outside
# of it, essentially "padding" the matrix with the number `9`
function pad(M::Matrix{T}) where T <: Integer
    (rows, cols) = size(M)
    rowpadding = fill(9, (1, cols))
    colpadding = fill(9, (rows + 2, 1))
    
    (vcat(rowpadding, M, rowpadding)
     |> (x -> hcat(colpadding, x, colpadding)))
end

# Find the points in a numeric matrix where the value in that
# position is smaller than the values in the four cardinal 
# directions, if viewed as a map. 
function findlowpoints(heightmap::Matrix{T}) where T <: Integer
    # Create a copy of the heightmap padded with `9`'s
    (rows, cols) = size(heightmap)
    padded = pad(heightmap)

    # Take views of the heightmap that are the same size but
    # shifted either up, down, left, or right. The padding ensures
    # that the `upshift` has a bottom row of all `9`. This ensures
    # that values in  the bottom row of `heightmap` will identify
    # as a 'lowest point' if the values above, to the left, and to
    # the right are also larger. This similarly holds true for values
    # on all four edges of `heightmap`.
    upshift    = view(padded, 1:rows,     2:(cols+1))
    downshift  = view(padded, 3:(rows+2), 2:(cols+1))
    leftshift  = view(padded, 2:(rows+1), 3:(cols+2))
    rightshift = view(padded, 2:(rows+1), 1:cols)

    # Check `heightmap` against all four views. For any point where the
    # value at the corresponding position in all four `shifts` is greater
    # than the value at that point in `heightmap`, that position in the
    # returned BitMatrix will be `1`, otherwise it will be `0`.
    shifts = [rightshift, leftshift, upshift, downshift]
    return mapreduce(S -> S .> heightmap, .&, shifts)
end

# Identify each position in the input that represents a 'low point', 
# and return the sum of the values at those positions.
function part1(input)
    lowpoints = findlowpoints(input)
    return sum(input[lowpoints] .+ 1)
end
