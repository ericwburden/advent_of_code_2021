
# Helper Functions -------------------------------------------------------------

# For checking on the total state of cucumber migration.
function pprint(east::BitMatrix, south::BitMatrix)
    template = fill('.', size(east))
    template[east]  .= '>'
    template[south] .= 'v'
    for row in eachrow(template)
        for char in row
            print(char)
        end
        println()
    end
end

# Move all the east-bound cucumbers that can be moved
function moveeast(east::BitMatrix, south::BitMatrix)
    occupied   = east .| south      # Spaces occupied by any type of cucumber
    nextstate  = falses(size(east)) # An empty BitMatrix, same size as `east`
    ncols      = size(east, 2)      # Number of columns in the grid
    colindices = collect(1:ncols)   # Vector of column indices

    # For each pair of column index and column index + 1 (wrapped around due
    # to space-defying ocean currents)...
    for (currcol, nextcol) in zip(colindices, circshift(colindices, -1))
        # Identify the cucumbers who moved in `currcol` by the empty spaces
        # in `nextcol`
        moved = east[:,currcol]  .& .!occupied[:,nextcol]

        # Identify the cucumbers who waited in `currcol` by the occupied
        # spaces in `nextcol`
        stayed = east[:,currcol] .& occupied[:,nextcol]

        # Place the updated cucumber positions into `nextstate`
        nextstate[:,nextcol] .|= moved
        nextstate[:,currcol] .|= stayed
    end

    return nextstate
end

# Move all the south-bound cucumbers than can be moved
function movesouth(east::BitMatrix, south::BitMatrix)
    occupied   = east .| south       # Spaces occupied by any type of cucumber
    nextstate  = falses(size(south)) # An empty BitMatrix, same size as `south`
    nrows      = size(south, 1)      # Number of rows in the grid
    rowindices = collect(1:nrows)    # Vector of row indices

    # For each pair of row index and row index + 1 (wrapped around due to
    # intradimensional currents)...
    for (currrow, nextrow) in zip(rowindices, circshift(rowindices, -1))
        # Identify the cucumbers who moved in `currrow` by the empty spaces
        # in `nextrow`
        moved = south[currrow,:] .& .!occupied[nextrow,:]

        # Identify the cucumbers who waited in `currrow` by the occupied
        # spaces in `nextrow`
        stayed = south[currrow,:] .& occupied[nextrow,:]

        # Place the updated cucumber positions into `nextstate`
        nextstate[nextrow,:] .|= moved
        nextstate[currrow,:] .|= stayed
    end

    return nextstate
end

# Move the herd(s)! Get the next state for east-bound and south-bound cucumbers,
# check to see if any of their positions changed, and return the results
function move(east::BitMatrix, south::BitMatrix)
    nexteast  = moveeast(east, south)
    nextsouth = movesouth(nexteast, south)

    eastchanged  = east  .⊻ nexteast
    southchanged = south .⊻ nextsouth
    anychanged = any(eastchanged .| southchanged)

    return (anychanged, nexteast, nextsouth)
end


# Solve Part One ---------------------------------------------------------------

# Solve it! Just keep updating the cucumber positions in a loop until they don't
# change, then report the number of rounds that took.
function part1(input)
    (east, south) = input
    rounds = 0
    anychanged = true
    while anychanged
        (anychanged, east, south) = move(east, south)
        rounds += 1
    end
    return rounds
end
