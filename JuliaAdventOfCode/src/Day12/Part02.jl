# Some More Useful Structs and Methods -----------------------------------------

# This time, we'll represent the `Path` taken as a struct, keeping track of 
# which caves have been visited, our current cave, and whether we've already
# visited a small cave twice.
struct Path
    visited::BitVector
    current::Cave
    beentwice::Bool
end

# Constructor for a `Path` , takes the starting cave and an integer indicating
# the size of the `visited` BitVector. Each `Cave` index corresponds to an index
# in `visited`. These BitVectors are much cheaper to copy about than a Set{Cave}.
function Path(C::Cave, I::Int) 
    visited = falses(I)
    Path(visited, C, false)
end

# Given a `Path` and a `Cave`, create a new `Path`  by adding the given `Cave` to the
# end. This function also does the checking to ensure that only `Paths` are
# returned when the criteria are met, aka, only advance to a small cave if 
# you've never been there or you've never been to any small cave twice.
function advanceto(path::Path, cave::SmallCave)::Union{Path,Nothing}
    cave isa StartCave && return nothing
    path.visited[cave.index] && path.beentwice && return nothing
    
    visited = deepcopy(path.visited)
    visited[cave.index] = true
    beentwice = path.visited[cave.index] || path.beentwice
    return Path(visited, cave, beentwice)
end

function advanceto(path::Path, cave::LargeCave)::Union{Path,Nothing}
    return Path(path.visited, cave, path.beentwice)
end

function advanceto(::Path, cave::EndCave)::Path
    return Path(BitVector(), cave, false)
end

function advanceto(::Path, cave::StartCave)::Nothing
    return nothing
end


# Solve Part Two ---------------------------------------------------------------

# Essentially the same as before. Now we've embedded our logic regarding whether
# or not we can move to a cave into the `advanceto()` function.
function part2(input)
    startcave = getstart(input)
    stack = [Path(startcave, length(input))]
    sizehint!(stack, length(input)^2)
    pathcount = 0

    while !isempty(stack)
        path = pop!(stack)

        if path.current isa EndCave
            pathcount += 1
            continue
        end

        for nextcave in get(input, path.current, [])
            nextpath = advanceto(path, nextcave)
            isnothing(nextpath) && continue
            push!(stack, nextpath)
        end
    end
    return pathcount
end