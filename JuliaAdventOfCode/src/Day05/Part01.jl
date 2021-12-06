# Fill out a `Matrix` by indicating the number of lines that 
# cross each `Point`/index. Skip the diagonal lines. Once filled out,
# count the indices containing a value greater than 1, indicating
# an overlap.
function part1(input)
    pointsmap = zeros(Int64, 1000, 1000)
    for line in input
        (isvertical(line) || ishorizontal(line)) || continue
        points = collect(line)
        for (x, y) in points
            pointsmap[x, y] += 1
        end
    end


    count(x -> x > 1, pointsmap)
end
