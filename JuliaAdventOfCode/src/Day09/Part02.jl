function neighborindices(matrix::AbstractMatrix, idx::CartesianIndex)::Vector{CartesianIndex}
    out = []
    (rows, cols) = size(matrix)
    if idx[1] > 1;    push!(out, idx - CartesianIndex(1, 0)); end
    if idx[1] < rows; push!(out, idx + CartesianIndex(1, 0)); end
    if idx[2] > 1;    push!(out, idx - CartesianIndex(0, 1)); end
    if idx[2] < cols; push!(out, idx + CartesianIndex(0, 1)); end
    return out
end

function basinsizeat(pointmap::BitMatrix, idx::CartesianIndex)::Int
    queue = [idx]
    visited = Set(queue)
    cells = 1
    while !isempty(queue)
        location = pop!(queue)
        for neighbor in neighborindices(pointmap, location)
            neighbor in visited && continue
            push!(visited, neighbor)
            if pointmap[neighbor]
                pushfirst!(queue, neighbor)
                cells += 1
            end
        end
    end
    return cells
end

function part2(input)
    lowpoints = findlowpoints(input)
    basins = input .< 9
    basinsizes = []; sizehint!(basinsizes, sum(lowpoints))
    for index in findall(lowpoints)
        push!(basinsizes, basinsizeat(basins, index))
    end
    sort!(basinsizes, rev = true)
    return prod(basinsizes[1:3])
end