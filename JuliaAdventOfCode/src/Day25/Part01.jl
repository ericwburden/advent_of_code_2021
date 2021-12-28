
# Helper Functions -------------------------------------------------------------

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

function moveeast(east::BitMatrix, south::BitMatrix)
    occupied = east .| south
    nextstate = falses(size(east))
    ncols = size(east, 2)
    colindices = collect(1:ncols)

    for (currcol, nextcol) in zip(colindices, circshift(colindices, -1))
        moved = east[:,currcol]  .& .!occupied[:,nextcol]
        nextstate[:,nextcol] .|= moved

        stayed = east[:,currcol] .& occupied[:,nextcol]
        nextstate[:,currcol] .|= stayed
    end

    return nextstate
end

function movesouth(east::BitMatrix, south::BitMatrix)
    occupied = east .| south
    nextstate = falses(size(south))
    nrows = size(south, 1)
    rowindices = collect(1:nrows)

    for (currrow, nextrow) in zip(rowindices, circshift(rowindices, -1))
        moved = south[currrow,:] .& .!occupied[nextrow,:]
        nextstate[nextrow,:] .|= moved

        stayed = south[currrow,:] .& occupied[nextrow,:]
        nextstate[currrow,:] .|= stayed
    end

    return nextstate
end

function move(east::BitMatrix, south::BitMatrix)
    nexteast  = moveeast(east, south)
    nextsouth = movesouth(nexteast, south)

    eastchanged  = east  .⊻ nexteast
    southchanged = south .⊻ nextsouth
    anychanged = any(eastchanged .| southchanged)

    return (anychanged, nexteast, nextsouth)
end


# Solve Part One ---------------------------------------------------------------

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