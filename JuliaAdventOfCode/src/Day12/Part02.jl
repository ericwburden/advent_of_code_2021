struct Path
    visited::BitVector
    current::Cave
    beentwice::Bool
end

function Path(C::Cave, I::Int) 
    visited = falses(I)
    visited[C.index] = true
    Path(visited, C, false)
end

function advanceto(path::Path, cave::Cave)::Union{Path,Nothing}
    isstart(cave) && return nothing

    smallandvisited = issmall(cave) && path.visited[cave.index]
    smallandvisited && path.beentwice && return nothing
    
    visited = deepcopy(path.visited)
    visited[cave.index] = true
    return Path(visited, cave, smallandvisited || path.beentwice)
end

function countvisited(map::CaveMap)::Int
    startcave = getstart(map)
    stack = [Path(startcave, length(map))]
    sizehint!(stack, length(map)^2)
    pathcount = 0

    while !isempty(stack)
        path = pop!(stack)

        if isend(path.current)
            pathcount += 1
            continue
        end

        for nextcave in get(map, path.current, [])
            nextpath = advanceto(path, nextcave)
            isnothing(nextpath) && continue
            push!(stack, nextpath)
        end
    end
    return pathcount
end


function part2(input)
    return countvisited(input)
end