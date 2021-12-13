# Some Useful Helper Functions and Types ---------------------------------------
issmall(C::Cave) = isa(C, SmallCave)
islarge(C::Cave) = isa(C, LargeCave)
isstart(C::Cave) = C.name == "start"
isend(C::Cave) = C.name == "end"

const Visited = Set{Cave}
const CaveMap = Dict{Cave, Vector{Cave}}
const ExploreQueue = Vector{Tuple{Visited,Cave}}

function getstart(map::CaveMap)
    for cave in keys(map)
        isstart(cave) && return cave
    end
    error("Could not find starting cave")
end

# We only need to keep track of the small caves. If moving into a large
# cave, we only need to pass back the set of visited Caves.
nextpath(visited::Visited, ::LargeCave) = visited
nextpath(visited::Visited, nextcave::SmallCave) = Visited([visited..., nextcave])


# Solve Part One ---------------------------------------------------------------

# Yes, I realize we're not using the `cave.index`, that's for Part Two. For Part
# One, we'll keep track of which caves we've visited so far in a Set. This was
# my first approach for Part Two, as well, but it ended up being *painfully*
# slow (nearly 10 seconds!). This is a pretty standard implementation of a 
# depth-first search, with a bit of a twist.
function part1(input)
    # Start by creating a "stack" and initializing it with the "start" cave
    startcave = getstart(input)
    stack = ExploreQueue([(Visited([startcave]), startcave)])
    paths = 0

    # While there are still caves to explore...
    while !isempty(stack)
        # Pop the last cave and the list of visited caves off the stack...
        (visitedsofar, cave) = pop!(stack)

        # If we've reached the end, just add one to our count of paths
        # and move on to the next item in the stack
        if isend(cave)
            paths += 1
            continue
        end
        
        # Otherwise, get the list of all the caves the current cave is
        # connected to, and add them to the stack to be visited next
        for nextcave in get(input, cave, [])
            # If we found the start, or if our next cave is in our list of
            # visited caves, don't go there.
            isstart(nextcave) && continue
            nextcave in visitedsofar && continue

            # We only need to keep track of the small caves we've visited
            visited = nextpath(visitedsofar, nextcave)
            push!(stack, (visited, nextcave))
        end
    end
    return paths
end