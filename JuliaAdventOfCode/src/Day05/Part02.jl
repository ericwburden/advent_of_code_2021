# Exactly the same as Part 1, just without skipping the 
# diagonal `Line`s.
function part2(input)
    pointsmap = zeros(Int64, 1000, 1000)
    for line in input
        points = collect(line)
        for (x, y) in points
            pointsmap[x, y] += 1
        end
    end

    count(x -> x > 1, pointsmap)
end