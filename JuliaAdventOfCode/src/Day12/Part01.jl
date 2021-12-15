# Some Useful Helper Functions and Types ---------------------------------------

# Just some handy type aliases for clarity
const CaveMap = Dict{Cave, Vector{Cave}}
const ExploreStack = Vector{Tuple{BitVector,Cave}}


# We only need to keep track of the small caves. If moving into a large
# cave, we only need to pass back the set of visited Caves. If we're moving
# into the end cave, then we don't need to know about the visited caves 
# anymore, we can just use an empty BitVector.
nextpath(visited::BitVector, ::LargeCave) = visited
nextpath(::BitVector, ::EndCave) = BitVector()
function nextpath(visited::BitVector, nextcave::SmallCave) 
    visited = deepcopy(visited)
    visited[nextcave.index] = true
    return visited
end

# Determines whether we should skip entering a cave. We should always enter a 
# Large cave (don't skip it) or the end cave, never re-enter the start cave,
# and only enter a small cave if we've never been inside it before (meaning
# it's corresponding index in the visited vector will be false).
shouldskip(::BitVector, ::LargeCave) = false
shouldskip(::BitVector, ::EndCave) = false
shouldskip(::BitVector, ::StartCave) = true
shouldskip(visited::BitVector, cave::SmallCave) = visited[cave.index]


# Solve Part One ---------------------------------------------------------------

# This is a pretty standard implementation of a depth-first search, with a bit
# of a twist. Most of the twist is handled by the different helper functions
# and types implemented above.
function part1(input)
    # Start by creating a "stack" and initializing it with the "start" cave 
    # and a BitVector large enough to hold the indices of all the small caves
    smallcavecount = mapreduce(C -> C isa SmallCave, +, keys(input))
    stack = ExploreStack([(falses(smallcavecount), StartCave())])
    paths = 0

    # While there are still caves to explore...
    while !isempty(stack)
        # Pop the last cave and the list of visited caves off the stack...
        (visitedsofar, cave) = pop!(stack)

        # If we've reached the end, just add one to our count of paths
        # and move on to the next item in the stack
        if cave isa EndCave
            paths += 1
            continue
        end
        
        # Otherwise, get the list of all the caves the current cave is
        # connected to, and add them to the stack to be visited next
        for nextcave in get(input, cave, [])
            # If we found the start, or if our next cave is in our list of
            # visited caves, don't go there.
            shouldskip(visitedsofar, nextcave) && continue

            # We only need to keep track of the small caves we've visited
            visited = nextpath(visitedsofar, nextcave)
            push!(stack, (visited, nextcave))
        end
    end
    return paths
end