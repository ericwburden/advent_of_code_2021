# Given a matrix and an index, return the indices of the positions
# above, below, to the left, and to the right of the given index,
# accouting for edges.
function neighborindices(matrix::AbstractMatrix, idx::CartesianIndex)::Vector{CartesianIndex}
    out = []; sizehint!(out, 4)
    (rows, cols) = size(matrix)
    if idx[1] > 1;    push!(out, idx - CartesianIndex(1, 0)); end
    if idx[1] < rows; push!(out, idx + CartesianIndex(1, 0)); end
    if idx[2] > 1;    push!(out, idx - CartesianIndex(0, 1)); end
    if idx[2] < cols; push!(out, idx + CartesianIndex(0, 1)); end
    return out
end

# Given a BitMatrix were a `1` indicates a part of a basin and a `0` 
# indicates a part of a ridge and an index to start search from,
# perform a breadth-first search of `heightmap`, to find all adjacent
# 'basin' points that can be reached from the starting point.
function basinsizeat(heightmap::BitMatrix, idx::CartesianIndex)::Int
    queue = [idx]           # Points to check
    visited = Set(queue)    # Points we've already checked
    cells = 1               # Number of points that have been checked

    # As long as there are still more points to check...
    while !isempty(queue)
        # Take an index from the top of the queue 
        location = pop!(queue)

        # For all of that index's neighbors...
        for neighbor in neighborindices(heightmap, location)
            # If it's already been checked, skip it
            neighbor in visited && continue

            # Mark it as checked
            push!(visited, neighbor)

            # If that neighboring index is part of the basin, add that
            # index to the front of the queue and increment our count
            if heightmap[neighbor]
                pushfirst!(queue, neighbor)
                cells += 1
            end
        end
    end

    return cells
end

# Transform our input into a BitMatrix, where `1`'s indicate basins,
# positions where the value is less than 9. For each lowpoint, in
# the input, perform a breadth-first search for neighboring basin 
# cells and return the count. Once all the basins have been measured,
# get the sizes (by number of included indices) of the three largest
# and return the product of all three.
function part2(input)
    basins = input .< 9
    lowpoints = findlowpoints(input)
    basinsizes = []; sizehint!(basinsizes, sum(lowpoints))
    for index in findall(lowpoints)
        push!(basinsizes, basinsizeat(basins, index))
    end
    sort!(basinsizes, rev = true)
    return prod(basinsizes[1:3])
end