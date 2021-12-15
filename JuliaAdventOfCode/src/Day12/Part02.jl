# Some More Useful Structs and Methods -----------------------------------------

# We need to change the types of our list of visited caves and exploration 
# stack to take advantage of the new methods for identifying the next path
# and whether we should skip the next cave.
const Path = Tuple{BitVector,Bool}
const ExploreStackTwo = Vector{Tuple{Path,Cave}}

# The logic is the same for large caves and end caves, but now we need to
# account for whether we've visited a single small cave twice when 
# updating our `Path`
nextpath(path::Path, ::LargeCave)= path
nextpath(::Path, ::EndCave) = (BitVector(), false)
function nextpath(path::Path, nextcave::SmallCave)
    (visited, twovisits) = path
    twovisits = twovisits || visited[nextcave.index]
    visited = deepcopy(visited)
    visited[nextcave.index] = true
    return (visited, twovisits)
end

# The logic for large caves, end caves, and start caves remains unchanged, but
# we needed to define them again because our first version was too specialized.
# These versions using `::Any` would work for part one and part two. The big
# change is the logic for determining whether to skip a small cave.
shouldskip(::Any, ::LargeCave) = false
shouldskip(::Any, ::EndCave) = false
shouldskip(::Any, ::StartCave) = true
function shouldskip(path::Path, cave::SmallCave) 
    (visited, twovisits) = path
    return visited[cave.index] && twovisits
end


# Solve Part Two ---------------------------------------------------------------

# This bit is *exactly* the same as part one. Well, except for the first few
# lines. Here, we've changed the types of the arguments in our stack to use
# the new logic methods from above. Otherwise, the algorithm is exactly the
# same.
function part2(input)
    # Start by creating a "stack" and initializing it with the "start" cave , 
    # a BitVector large enough to hold the indices of all the small caves, and
    # a boolean value to indicate whether we've seen a small cave twice.
    smallcavecount = mapreduce(C -> C isa SmallCave, +, keys(input))
    initialpath = (falses(smallcavecount), false)
    stack = ExploreStackTwo([(initialpath, StartCave())])
    paths = 0

    # While there are still caves to explore...
    while !isempty(stack)
        # Pop the last cave and the `Path` off the stack...
        (pathsofar, cave) = pop!(stack)

        # If we've reached the end, just add one to our count of paths
        # and move on to the next item in the stack
        if cave isa EndCave
            paths += 1
            continue
        end
        
        # Otherwise, get the list of all the caves the current cave is
        # connected to, and add them to the stack to be visited next
        for nextcave in get(input, cave, [])
            # If we found the start, or if our puzzle logic tells us to skip
            # the next cave, don't go there.
            shouldskip(pathsofar, nextcave) && continue

            # We only need to keep track of the small caves we've visited, still
            path = nextpath(pathsofar, nextcave)
            push!(stack, (path, nextcave))
        end
    end
    return paths
end