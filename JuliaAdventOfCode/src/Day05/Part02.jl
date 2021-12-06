function part2(input)
    pointsmap = zeros(Int64, 1000, 1000)
    for line in input
        points = getpointsin(line)
        for (x, y) in points
            pointsmap[x, y] += 1
        end
    end

    count(x -> x > 1, pointsmap)
end