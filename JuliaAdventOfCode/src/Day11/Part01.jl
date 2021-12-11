function neighborhoodof(idx::CartesianIndex, M::AbstractMatrix)
    (rows, cols) = size(M)
    (row, col) = Tuple(idx)

    top    = row > 1    ? row - 1 : row
    left   = col > 1    ? col - 1 : col
    bottom = row < rows ? row + 1 : row
    right  = col < cols ? col + 1 : col

    return view(M, top:bottom, left:right)
end

function advance!(octopuses::Matrix{Int8})::Int
    octopuses .+= 1
    flashed = justflashed = octopuses .> 9
    getneighborhood(idx) = neighborhoodof(idx, octopuses)

    while any(justflashed)
        neighborhoods = map(getneighborhood, findall(justflashed))
        foreach(N -> N .+= 1, neighborhoods)
        justflashed = (octopuses .> 9) .& .!flashed
        flashed .|= justflashed
    end

    octopuses[flashed] .= 0
    return sum(flashed)
end


function part1(input)
    flashes = 0
    octopuses = deepcopy(input)
    for _ in 1:100
        flashes += advance!(octopuses)
    end
    return flashes
end
