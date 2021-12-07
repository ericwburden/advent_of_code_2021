# Fill out a `Matrix` by indicating the number of lines that 
# cross each `Point`/index. Skip the diagonal lines. Once filled out,
# count the indices containing a value greater than 1, indicating
# an overlap.
function part1_strategy1(input)
    pointsmap = zeros(Int64, 1000, 1000)
    for line in input
        (isvertical(line) || ishorizontal(line)) || continue
        points = collect(line)
        for (x, y) in points
            pointsmap[x + 1, y + 1] += 1
        end
    end

    count(x -> x > 1, pointsmap)
end


# Keep track of visited points using two sets, instead of an
# Int64 Matrix
function part1_strategy2(input)
    knownset = Set{Int64}()
    countedset = Set{Int64}()
    sizehint!(knownset, 100000)
    sizehint!(countedset, 100000)
    for line in input
        (isvertical(line) || ishorizontal(line)) || continue
        points = collect(line)
        for (x, y) in points
            flatidx = x + (1000 * y)
            if flatidx in knownset
                push!(countedset, flatidx)
            else
                push!(knownset, flatidx)
            end
        end
    end

    return length(countedset)
end


# Instead of initializing a Matrix full of zeros, start with
# an un-initialized Matrix of the appropriate size. Using a 
# `Matrix{Bool} for the smaller size
function part1_strategy3(input)
    pointsmap = zeros(Int8, 1000, 1000)
    for line in input
        (isvertical(line) || ishorizontal(line)) || continue
        points = collect(line)
        for (x, y) in points
            if pointsmap[x + 1, y + 1] > 0
                pointsmap[x + 1, y + 1] = 2
            else
                pointsmap[x + 1, y + 1] = 1
            end
        end
    end

    count(x -> x == 2, pointsmap)
end