# Helper Functions -------------------------------------------------------------

# Return a view of the matrix `M` centered on the index `idx` and encompassing
# the eight surrounding indices. Accounts for corners and edges.
function neighborhoodof(idx::CartesianIndex, M::AbstractMatrix)
    (rows, cols) = size(M)
    (row, col) = Tuple(idx)

    top    = row > 1    ? row - 1 : row
    left   = col > 1    ? col - 1 : col
    bottom = row < rows ? row + 1 : row
    right  = col < cols ? col + 1 : col

    return view(M, top:bottom, left:right)
end

# Given a matrix representing our octopuses, advance the state of the 
# school of octopuses, mutating the input and returning the number of
# octopuses who flashed this round.
function advance!(octopuses::Matrix{Int8})::Int
    # Increase the value of all octopuses
    octopuses .+= 1

    # Identify the octopuses who have flashed
    flashed = justflashed = octopuses .> 9

    # Shorthand to fetch octopuses surrounding an index. There's no need to
    # exclude the central octopus, since they've already flashed.
    getneighborhood(idx) = neighborhoodof(idx, octopuses)

    # So long as any octopus just crossed the threshold...
    while any(justflashed)
        # Get all the neighborhoods of the octopuses who just flashed
        neighborhoods = map(getneighborhood, findall(justflashed))

        # For each neighborhood, increase the energy level of all
        # octopuses by 1
        foreach(N -> N .+= 1, neighborhoods)

        # Identify the octopuses who just crossed the threshold
        justflashed = (octopuses .> 9) .& .!flashed

        # Update the listing of all octopuses who have flashed this round
        flashed .|= justflashed
    end

    # Reset all the octopuses who have flashed and return the count
    octopuses[flashed] .= 0
    return count(flashed)
end


# Advance the school of octopuses 100 times, counting the number of octopuses
# who flash each round and returning the count of all octopuses flashing over
# 100 rounds
function part1(input)
    flashes = 0
    octopuses = deepcopy(input)
    for _ in 1:100
        flashes += advance!(octopuses)
    end
    return flashes
end
