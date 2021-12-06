function part1(input)
    pointsmap = zeros(Int64, 1000, 1000)
    for line in input
        (isvertical(line) || ishorizontal(line)) || continue
        points = getpointsin(line)
        for (x, y) in points
            pointsmap[x, y] += 1
        end
    end


    count(x -> x > 1, pointsmap)
end
